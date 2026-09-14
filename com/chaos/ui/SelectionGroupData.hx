package com.chaos.ui;

import com.chaos.ui.classInterface.IBaseUI;

/** Reconciles selection-group rows without destroying controls on property updates. */
class SelectionGroupData {
    private var defaults:Dynamic = {};
    private var rows:Array<Dynamic> = [];
    public function new() {}

    public function update<T:IBaseUI>(data:Dynamic, list:Array<T>, create:Dynamic->T, remove:T->Void):Array<T> {
        for (key in ["Style", "Bitmap", "enabled", "useCustomRender", "align", "bold", "italic", "size", "textColor",
            "buttonSize", "dotSize", "style", "lineAlpha", "lineSize", "border", "defaultColor", "overColor",
            "downColor", "disableColor", "normalBorderColor", "overBorderColor", "downBorderColor", "disableBorderColor",
            "backgroundAlpha", "roundEdge", "stateFadeSpeed", "fadeToDownState", "rotateImage", "tileImage"])
            if (Reflect.hasField(data, key)) Reflect.setField(defaults, key, Reflect.field(data, key));

        var replaceRows = Reflect.hasField(data, "data") || Reflect.hasField(data, "items");
        if (replaceRows) {
            var incoming:Dynamic = Reflect.hasField(data, "data") ? Reflect.field(data, "data") : Reflect.field(data, "items");
            if (!Std.isOfType(incoming, Array)) return list;
            rows = cast incoming;
        }
        var next:Array<T> = [];
        var activeRows = rows;
        if (!replaceRows) {
            activeRows = [];
            for (item in list) {
                var row:Dynamic = { name: item.displayObject.name };
                for (saved in rows) if (Reflect.field(saved, "name") == item.displayObject.name) { row = saved; break; }
                activeRows.push(row);
            }
        }
        for (index in 0...activeRows.length) {
            var row = activeRows[index];
            if (row == null) continue;
            var name:String = Reflect.field(row, "name");
            if (name == null || name == "") {
                name = Std.string(Reflect.field(data, "name")) + "_item" + (index + 1);
                Reflect.setField(row, "name", name);
            }
            var item:T = null;
            for (candidate in list) if (candidate.displayObject.name == name) { item = candidate; break; }
            var values:Dynamic = Reflect.copy(defaults);
            for (key in Reflect.fields(row)) {
                if (!replaceRows && key == "selected") continue;
                if ((key == "Style" || key == "Bitmap") && Reflect.field(row, key) != null) {
                    var merged:Dynamic = Reflect.field(defaults, key) == null ? {} : Reflect.copy(Reflect.field(defaults, key));
                    for (styleKey in Reflect.fields(Reflect.field(row, key)))
                        Reflect.setField(merged, styleKey, Reflect.field(Reflect.field(row, key), styleKey));
                    Reflect.setField(values, key, merged);
                } else Reflect.setField(values, key, Reflect.field(row, key));
            }
            if (item == null) item = create(row);
            item.setComponentData(values);
            item.draw();
            next.push(item);
        }
        for (item in list.copy()) if (next.indexOf(item) < 0) remove(item);
        return next;
    }
}
