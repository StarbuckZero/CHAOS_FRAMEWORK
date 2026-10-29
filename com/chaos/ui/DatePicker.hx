package com.chaos.ui;

import openfl.display.Sprite;
import openfl.display.Shape;
import com.chaos.drawing.icon.ArrowLeftIcon;
import com.chaos.drawing.icon.ArrowRightIcon;
import com.chaos.drawing.icon.ArrowDownIcon;
import openfl.display.BitmapData;
import openfl.geom.Matrix;
import com.chaos.ui.UIBitmapManager.UIBitmapType;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.events.KeyboardEvent;
import openfl.geom.Point;
import openfl.ui.Keyboard;

/** Date-only calendar input. Values and limits use YYYY-MM-DD; empty means unset. */
class DatePicker extends BaseUI {
    public var selectedDate(get, set):String;
    public var minDate(get, set):String;
    public var maxDate(get, set):String;
    public var firstDayOfWeek:Int = 0;
    /** Shape of day cells and their selection outline: circle or square. */
    public var dayShape(get, set):String;
    private var explicitDayShape:String;
    private var skinImages:Map<String, BitmapData> = [];
    public var placeholder:String = "Select date";
    private var value:String = "";
    private var minimum:String = "";
    private var maximum:String = "";
    private var trigger:Button;
    private var triggerIcon:ArrowDownIcon;
    private var calendar:Sprite;
    private var month:Date;
    private var focusedDate:String;
    private var popupStage:openfl.display.Stage;
    private static var months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];

    public function new(data:Dynamic = null) { super(data); }

    public static function parseDate(text:String):Date {
        if (text == null || !~/^[0-9]{4}-[0-9]{2}-[0-9]{2}$/.match(text)) return null;
        var y = Std.parseInt(text.substr(0, 4));
        var m = Std.parseInt(text.substr(5, 2));
        var d = Std.parseInt(text.substr(8, 2));
        if (y < 100 || m < 1 || m > 12 || d < 1 || d > 31) return null;
        var date = new Date(y, m - 1, d, 12, 0, 0);
        return date.getFullYear() == y && date.getMonth() == m - 1 && date.getDate() == d ? date : null;
    }
    public static function formatDate(date:Date):String {
        return StringTools.lpad(Std.string(date.getFullYear()), "0", 4) + "-" + StringTools.lpad(Std.string(date.getMonth() + 1), "0", 2) + "-" + StringTools.lpad(Std.string(date.getDate()), "0", 2);
    }
    /** Calendar overrides this to render the shared view inline. */
    private function isInline():Bool return false;
    private function resetMonth():Void {
        var date = value == "" ? Date.now() : parseDate(value);
        var text = formatDate(date);
        if (minimum != "" && text < minimum) date = parseDate(minimum);
        if (maximum != "" && text > maximum) date = parseDate(maximum);
        focusedDate = formatDate(date);
        month = new Date(date.getFullYear(), date.getMonth(), 1, 12, 0, 0);
    }
    private function style(key:String, fallback:Dynamic):Dynamic {
        return hasResolvedStyle(key) ? getResolvedStyle(key) : fallback;
    }
    private function get_dayShape():String {
        return explicitDayShape != null ? explicitDayShape : (style(UIStyleManager.DATEPICKER_DAY_SHAPE, "circle") == "square" ? "square" : "circle");
    }
    private function set_dayShape(shape:String):String {
        if (shape == "theme" || shape == null) explicitDayShape = null;
        else if (shape == "circle" || shape == "square") explicitDayShape = shape;
        if (calendar != null) renderCalendar();
        return get_dayShape();
    }
    private function skin(key:String):BitmapData {
        if (!hasResolvedBitmap(UIBitmapType.DatePicker, key)) return null;
        if (!skinImages.exists(key)) skinImages.set(key, getResolvedBitmap(UIBitmapType.DatePicker, key));
        return skinImages.get(key);
    }
    private function disposeSkins():Void {
        for (image in skinImages) if (image != null) image.dispose();
        skinImages.clear();
    }
    private function skinButton(button:Button, prefix:String, selected:Bool = false):Void {
        var normal = selected && skin(UIBitmapManager.DATEPICKER_DAY_SELECTED) != null
            ? skin(UIBitmapManager.DATEPICKER_DAY_SELECTED) : skin(prefix + "normal");
        button.setDefaultStateImage(normal);
        button.setOverStateImage(skin(prefix + "over"));
        button.setDownStateImage(skin(prefix + "down"));
        button.setDisableStateImage(skin(prefix + "disable"));
        button.draw();
        // Center the text area explicitly; TextField adds a two-pixel gutter.
        button.label.textField.autoSize = openfl.text.TextFieldAutoSize.NONE;
        button.label.width = button.width;
        button.label.align = "center";
        button.label.draw();
        button.label.displayObject.x = 0;
        button.label.displayObject.y = (button.height - button.label.textField.textHeight) / 2 - 2;
    }
    override public function reskin():Void {
        super.reskin();
        disposeSkins();
        if (trigger != null || calendar != null) draw();
    }
    private function allowed(text:String):Bool {
        return parseDate(text) != null && (minimum == "" || text >= minimum) && (maximum == "" || text <= maximum);
    }
    private function get_selectedDate():String return value;
    private function set_selectedDate(text:String):String {
        if (text == "" || allowed(text)) { value = text; if (isInline()) resetMonth(); }
        if (trigger != null || calendar != null) draw();
        return value;
    }
    private function get_minDate():String return minimum;
    private function set_minDate(text:String):String {
        if (text == "" || (parseDate(text) != null && (maximum == "" || text <= maximum))) minimum = text;
        if (value != "" && !allowed(value)) value = "";
        if (trigger != null || calendar != null) draw();
        return minimum;
    }
    private function get_maxDate():String return maximum;
    private function set_maxDate(text:String):String {
        if (text == "" || (parseDate(text) != null && (minimum == "" || text >= minimum))) maximum = text;
        if (value != "" && !allowed(value)) value = "";
        if (trigger != null || calendar != null) draw();
        return maximum;
    }
    override public function setComponentData(data:Dynamic):Void {
        super.setComponentData(data);
        if (data == null) return;
        var nextMin:String = Reflect.hasField(data, "minDate") ? data.minDate : minimum;
        var nextMax:String = Reflect.hasField(data, "maxDate") ? data.maxDate : maximum;
        if ((nextMin == "" || parseDate(nextMin) != null) && (nextMax == "" || parseDate(nextMax) != null)
            && (nextMin == "" || nextMax == "" || nextMin <= nextMax)) {
            minimum = nextMin;
            maximum = nextMax;
            if (value != "" && !allowed(value)) value = "";
        }
        if (Reflect.hasField(data, "selectedDate")) selectedDate = data.selectedDate;
        if (Reflect.hasField(data, "dayShape")) dayShape = data.dayShape;
        if (Reflect.hasField(data, "placeholder")) placeholder = data.placeholder;
        if (Reflect.hasField(data, "firstDayOfWeek")) firstDayOfWeek = data.firstDayOfWeek == 1 ? 1 : 0;
    }
    override public function initialize():Void {
        super.initialize();
        if (isInline()) {
            if (_width <= 0) _width = 360;
            if (_height <= 0) _height = 496;
            resetMonth();
            calendar = new Sprite();
            addChild(calendar);
            calendar.addEventListener(KeyboardEvent.KEY_DOWN, escape);
            drawOnResize = true;
            return;
        }
        if (_width <= 0) _width = 200;
        if (_height <= 0) _height = 30;
        trigger = new Button({text: placeholder, showIcon: false, Label: {size: 14, font: "Arial", textColor: 0x222222}});
        triggerIcon = new ArrowDownIcon({width: 10, height: 6});
        triggerIcon.mouseEnabled = triggerIcon.mouseChildren = false;
        trigger.addChild(triggerIcon);
        addChild(trigger);
        trigger.addEventListener(MouseEvent.CLICK, toggle);
        addEventListener(Event.REMOVED_FROM_STAGE, removed);
        addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
        tabEnabled = true;
        drawOnResize = true;
    }
    override public function draw():Void {
        super.draw();
        if (isInline()) {
            if (calendar == null) return;
            calendar.mouseEnabled = calendar.mouseChildren = enabled;
            renderCalendar();
            return;
        }
        if (trigger == null) return;
        trigger.setComponentData({width: _width, height: _height, text: value == "" ? placeholder : value, enabled: enabled});
        trigger.setComponentData({defaultColor: style(UIStyleManager.DATEPICKER_NORMAL_COLOR, 0xEAE8ED),
            overColor: style(UIStyleManager.DATEPICKER_OVER_COLOR, 0xDDD9E2), downColor: style(UIStyleManager.DATEPICKER_DOWN_COLOR, 0xD3D1D8),
            disableColor: style(UIStyleManager.DATEPICKER_DISABLE_COLOR, 0xEAE8ED),
            Label: {textColor: style(UIStyleManager.DATEPICKER_TEXT_COLOR, 0x242428), size: style(UIStyleManager.DATEPICKER_FONT_SIZE, 16), font: style(UIStyleManager.DATEPICKER_FONT, "Arial")}});
        skinButton(trigger, "datepicker_trigger_");
        trigger.label.width = Math.max(0, _width - 28);
        trigger.label.draw();
        triggerIcon.setComponentData({x: _width - 20, y: (_height - 6) / 2, baseColor: style(UIStyleManager.DATEPICKER_HEADER_COLOR, 0x484950)});
        triggerIcon.draw();
        if (!enabled) close();
        else if (calendar != null) renderCalendar();
    }
    private function toggle(event:MouseEvent):Void { if (calendar == null) open(); else close(); }
    public function open():Void {
        if (isInline()) return;
        if (!enabled || stage == null || calendar != null) return;
        resetMonth();
        calendar = new Sprite();
        popupStage = stage;
        popupStage.addChild(calendar);
        popupStage.addEventListener(MouseEvent.MOUSE_DOWN, outside);
        popupStage.addEventListener(KeyboardEvent.KEY_DOWN, escape);
        renderCalendar();
    }
    public function close():Void {
        if (isInline()) return;
        if (popupStage != null) {
            popupStage.removeEventListener(MouseEvent.MOUSE_DOWN, outside);
            popupStage.removeEventListener(KeyboardEvent.KEY_DOWN, escape);
            popupStage = null;
        }
        if (calendar != null) {
            clearCalendar();
            if (calendar.parent != null) calendar.parent.removeChild(calendar);
        }
        calendar = null;
    }
    private function removed(event:Event):Void close();
    private function outside(event:MouseEvent):Void {
        var target:openfl.display.DisplayObject = cast event.target;
        if (calendar != null && !calendar.contains(target) && !contains(target)) close();
    }
    private function escape(event:KeyboardEvent):Void {
        if (!enabled) return;
        if (!isInline() && event.keyCode == Keyboard.ESCAPE) { close(); if (stage != null) stage.focus = this; return; }
        var focusStage = isInline() ? stage : popupStage;
        if (focusStage == null) return;
        var focus = focusStage.focus;
        if (focus == null || !calendar.contains(focus)) return;
        var date = parseDate(focus.name);
        if (date == null) return;
        var delta = switch (event.keyCode) {
            case Keyboard.LEFT: -1;
            case Keyboard.RIGHT: 1;
            case Keyboard.UP: -7;
            case Keyboard.DOWN: 7;
            default: 0;
        };
        if (delta == 0) return;
        event.preventDefault();
        var next = new Date(date.getFullYear(), date.getMonth(), date.getDate() + delta, 12, 0, 0);
        var text = formatDate(next);
        if (!allowed(text)) return;
        focusedDate = text;
        month = new Date(next.getFullYear(), next.getMonth(), 1, 12, 0, 0);
        renderCalendar();
    }
    private function keyDown(event:KeyboardEvent):Void {
        if (event.keyCode == Keyboard.ENTER || event.keyCode == Keyboard.SPACE) { event.preventDefault(); open(); }
    }
    private function button(text:String, x:Float, y:Float, w:Float, action:Void->Void, active:Bool = true, selected:Bool = false, h:Float = 40):Button {
        var b = new Button({text: text, x: x, y: y, width: w, height: h, showIcon: false, enabled: active, selected: false, roundEdge: dayShape == "square" ? 0 : Std.int(Math.min(w, h)), border: false, normalBorderColor: 0x1967D2, overBorderColor: 0x1967D2, downBorderColor: 0x1967D2, defaultColor: selected ? style(UIStyleManager.DATEPICKER_SELECTED_COLOR, 0xD3D1D8) : style(UIStyleManager.DATEPICKER_NORMAL_COLOR, 0xEAE8ED), overColor: style(UIStyleManager.DATEPICKER_OVER_COLOR, 0xDDD9E2), downColor: style(UIStyleManager.DATEPICKER_DOWN_COLOR, 0xD3D1D8), disableColor: style(UIStyleManager.DATEPICKER_DISABLE_COLOR, 0xEAE8ED), Label: {size: style(UIStyleManager.DATEPICKER_FONT_SIZE, 16), font: style(UIStyleManager.DATEPICKER_FONT, "Arial"), textColor: style(UIStyleManager.DATEPICKER_TEXT_COLOR, 0x242428)}});
        skinButton(b, "datepicker_day_", selected);
        b.tabEnabled = active;
        b.focusRect = false;
        b.addEventListener(MouseEvent.CLICK, function(_) { if (enabled && active) action(); });
        b.addEventListener(KeyboardEvent.KEY_DOWN, function(e:KeyboardEvent) {
            if (enabled && active && (e.keyCode == Keyboard.ENTER || e.keyCode == Keyboard.SPACE)) { e.stopPropagation(); e.preventDefault(); action(); }
        });
        calendar.addChild(b);
        if (selected) {
            var ring = new Shape();
            ring.graphics.lineStyle(1, style(UIStyleManager.DATEPICKER_SELECTION_BORDER_COLOR, 0x1967D2));
            if (dayShape == "square") ring.graphics.drawRect(x + 1, y + 1, w - 2, h - 2);
            else ring.graphics.drawCircle(x + w / 2, y + h / 2, Math.min(w, h) / 2 - 1);
            calendar.addChild(ring);
        }
        return b;
    }
    private function choose(text:String):Void {
        if (!enabled || (text != "" && !allowed(text))) return;
        var changed = value != text;
        selectedDate = text;
        close();
        if (changed) dispatchEvent(new Event(Event.CHANGE));
        if (!isInline() && stage != null) stage.focus = this;
    }
    private function moveMonth(delta:Int):Void {
        var next = new Date(month.getFullYear(), month.getMonth() + delta, 1, 12, 0, 0);
        if (next.getFullYear() < 100 || next.getFullYear() > 9999) return;
        month = next;
        focusedDate = formatDate(next);
        renderCalendar();
    }
    private function clearCalendar():Void {
        while (calendar.numChildren > 0) {
            var child = calendar.removeChildAt(0);
            if (Std.isOfType(child, BaseUI)) cast(child, BaseUI).destroy();
        }
    }
    private function renderCalendar():Void {
        var restoreFocus = isInline() && stage != null && stage.focus != null && calendar.contains(stage.focus);
        clearCalendar();
        var w:Float = Math.max(360, _width);
        var padding:Float = 16;
        var cell = (w - padding * 2) / 7;
        var daySize = Math.min(44, cell - 4);
        var first = firstDayOfWeek == 1 ? 1 : 0;
        var offset = (month.getDay() - first + 7) % 7;
        var count = new Date(month.getFullYear(), month.getMonth() + 1, 0, 12, 0, 0).getDate();
        var rows = isInline() ? 6 : Std.int(Math.ceil((offset + count) / 7));
        var footerY = 136 + rows * 48 + 16;
        var panelHeight = footerY + 56;
        calendar.graphics.clear();
        var background = skin(UIBitmapManager.DATEPICKER_BACKGROUND);
        if (background == null) calendar.graphics.beginFill(style(UIStyleManager.DATEPICKER_BACKGROUND_COLOR, 0xEAE8ED));
        else {
            var matrix = new Matrix();
            matrix.scale(w / background.width, panelHeight / background.height);
            calendar.graphics.beginBitmapFill(background, matrix, false, true);
        }
        calendar.graphics.drawRoundRect(0, 0, w, panelHeight, style(UIStyleManager.DATEPICKER_PANEL_ROUNDED, 40), style(UIStyleManager.DATEPICKER_PANEL_ROUNDED, 40));
        calendar.graphics.endFill();
        var previous = button("", w - 104, 28, 40, function() moveMonth(-1));
        var next = button("", w - 56, 28, 40, function() moveMonth(1));
        var iconData:Dynamic = {x: 16, y: 13, width: 8, height: 14, baseColor: style(UIStyleManager.DATEPICKER_HEADER_COLOR, 0x484950)};
        var previousIcon = new ArrowLeftIcon(iconData);
        var nextIcon = new ArrowRightIcon(iconData);
        previousIcon.mouseEnabled = nextIcon.mouseEnabled = false;
        previousIcon.mouseChildren = nextIcon.mouseChildren = false;
        previous.addChild(previousIcon);
        next.addChild(nextIcon);
        calendar.addChild(new Label({text: months[month.getMonth()].substr(0, 3).toUpperCase() + " " + month.getFullYear(), x: 28, y: 38, width: w - 148, height: 28, align: "left", size: style(UIStyleManager.DATEPICKER_FONT_SIZE, 16), bold: true, textColor: style(UIStyleManager.DATEPICKER_HEADER_COLOR, 0x484950), font: style(UIStyleManager.DATEPICKER_FONT, "Arial")}));
        var days = ["S", "M", "T", "W", "T", "F", "S"];
        for (i in 0...7) calendar.addChild(new Label({text: days[(i + first) % 7], x: padding + i * cell, y: 90, width: cell, height: 28, align: "center", size: style(UIStyleManager.DATEPICKER_FONT_SIZE, 16), bold: true, textColor: style(UIStyleManager.DATEPICKER_HEADER_COLOR, 0x484950), font: style(UIStyleManager.DATEPICKER_FONT, "Arial")}));
        if (offset > 0) calendar.addChild(new Label({text: months[month.getMonth()].substr(0, 3).toUpperCase(), x: padding + 4, y: 146, width: offset * cell - 8, height: 28, align: "left", size: style(UIStyleManager.DATEPICKER_FONT_SIZE, 16), textColor: style(UIStyleManager.DATEPICKER_TEXT_COLOR, 0x242428), font: style(UIStyleManager.DATEPICKER_FONT, "Arial")}));
        var today = formatDate(Date.now());
        for (d in 1...count + 1) {
            var date = formatDate(new Date(month.getFullYear(), month.getMonth(), d, 12, 0, 0));
            var slot = offset + d - 1;
            var dayButton = button(Std.string(d), padding + (slot % 7) * cell + (cell - daySize) / 2, 136 + Std.int(slot / 7) * 48, daySize, function() choose(date), allowed(date), date == value || (value == "" && date == today), daySize);
            dayButton.name = date;
            var focusStage = isInline() ? stage : popupStage;
            if (focusStage != null && date == focusedDate && allowed(date) && (!isInline() || restoreFocus)) focusStage.focus = dayButton;
        }
        button("Today", 20, footerY, 76, function() choose(formatDate(Date.now())), allowed(today));
        button("Clear", w - 96, footerY, 76, function() choose(""));
        if (isInline()) {
            calendar.x = calendar.y = 0;
            calendar.scaleX = _width / w;
            calendar.scaleY = _height / panelHeight;
            return;
        }
        var point = localToGlobal(new Point(0, _height));
        calendar.x = Math.max(0, Math.min(point.x, popupStage.stageWidth - w));
        calendar.y = point.y + panelHeight > popupStage.stageHeight ? Math.max(0, point.y - _height - panelHeight) : point.y;

    }
    override public function destroy():Void {
        if (isInline() && calendar != null) {
            calendar.removeEventListener(KeyboardEvent.KEY_DOWN, escape);
            clearCalendar();
            removeChild(calendar);
            calendar = null;
        }
        close();
        removeEventListener(Event.REMOVED_FROM_STAGE, removed);
        removeEventListener(KeyboardEvent.KEY_DOWN, keyDown);
        if (triggerIcon != null) triggerIcon.destroy();
        if (trigger != null) { trigger.removeEventListener(MouseEvent.CLICK, toggle); trigger.destroy(); }
        disposeSkins();
        super.destroy();
    }
}
