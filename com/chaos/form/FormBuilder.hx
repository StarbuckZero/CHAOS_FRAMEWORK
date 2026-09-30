package com.chaos.form;

import com.chaos.form.classInterface.IFormBuilder;
import com.chaos.form.ui.TextLabel;
import com.chaos.form.ui.classInterface.IFormUI;
import com.chaos.ui.Label;
import com.chaos.ui.RadioButton;
import com.chaos.ui.Slider;
import com.chaos.ui.ToggleButton;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.layout.GridCellLayout;
import com.chaos.ui.layout.GridContainer;

/** A labelled grid of existing CHAOS controls. Field names are the data keys. */
class FormBuilder extends GridContainer implements IFormBuilder {
    /** Type identifier for form builders. */
    public static inline var TYPE:String = "FormBuilder";
    /** Horizontal inset of controls within each form cell. */
    public var vSpacing(get, set):Int;
    /** Vertical inset of controls within each form cell. */
    public var hSpacing(get, set):Int;
    private var _vSpacing:Int = 8;
    private var _hSpacing:Int = 8;
    private function get_vSpacing():Int return _vSpacing;
    private function set_vSpacing(value:Int):Int return _vSpacing = value;
    private function get_hSpacing():Int return _hSpacing;
    private function set_hSpacing(value:Int):Int return _hSpacing = value;
    private var _defaultCellHeight:Int = 30;

    /** Creates a labeled form grid with optional component data. */
    public function new(data:Dynamic = null) { super(data == null ? {} : data); }

    /** Applies grid sizing and form cell spacing defaults. */
    override public function setComponentData(data:Dynamic):Void {
        if (data == null) data = {};
        if (!Reflect.hasField(data, "column") || data.column < 2) data.column = 2;
        super.setComponentData(data);
        if (Reflect.hasField(data, "vSpacing")) vSpacing = data.vSpacing;
        if (Reflect.hasField(data, "hSpacing")) hSpacing = data.hSpacing;
        if (Reflect.hasField(data, "defaultCellHeight")) _defaultCellHeight = data.defaultCellHeight;
    }

    /** Adds a labeled row containing a newly created form control. */
    public function addFormElement(labelName:String, elementName:String, elementClass:Class<Dynamic>,
        elementParams:Dynamic = null, layoutClass:Class<Dynamic> = null, layoutParams:Dynamic = null):Void {
        var params:Dynamic = elementParams == null ? {} : Reflect.copy(elementParams);
        if (!Reflect.hasField(params, "width")) params.width = Std.int(width / getColumnCount());
        if (!Reflect.hasField(params, "height")) params.height = _defaultCellHeight;
        var element:IBaseUI = Type.createInstance(elementClass, [params]);
        element.displayObject.name = elementName;
        if (Std.isOfType(element, IFormUI)) cast(element, IFormUI).setName(elementName);
        addRow(getRowCount());
        var labelCell = getCell(getRowCount() - 1, 0);
        var inputCell = getCell(getRowCount() - 1, 1);
        labelCell.setLayout(GridCellLayout.HORIZONTAL, layoutParams);
        inputCell.setLayout(layoutClass == null ? GridCellLayout.FIT : layoutClass, layoutParams);
        labelCell.container.clipping = inputCell.container.clipping = false;
        labelCell.container.addElement(new TextLabel({text:labelName, width:labelCell.width, height:labelCell.height}));
        inputCell.container.addElement(element);
        if (Std.isOfType(element, Slider) && elementParams != null && Reflect.hasField(elementParams, "percent"))
            cast(element, Slider).percent = elementParams.percent;
        draw();
    }

    /** Sizes and positions each form cell and its control. */
    override public function draw():Void {
        super.draw();
        if (_list == null) return;
        for (row in 0...getRowCount()) {
            for (col in 0...getColumnCount()) {
                var cell = getCell(row, col);
                cell.height = _defaultCellHeight;
                cell.y = row * _defaultCellHeight;
                cell.draw();
                if (cell.container.length > 0) {
                    var item = cell.container.getElementAtIndex(0);
                    item.width = Math.max(0, cell.width - (vSpacing * 2));
                    item.height = Math.max(0, cell.height - (hSpacing * 2));
                    item.x = vSpacing;
                    item.y = hSpacing;
                    item.draw();
                }
            }
        }
    }

    /** Sets the width of a column across all rows. */
    public function setColumnWidthAt(index:Int, value:Int):Void {
        for (row in 0...getRowCount()) if (validCell(row, index)) setCellWidth(row, index, value);
    }

    /** Sets the height of a column across all rows. */
    public function setColumnHeightAt(index:Int, value:Int):Void {
        for (row in 0...getRowCount()) if (validCell(row, index)) setCellHeight(row, index, value);
    }

    /** Remove the controls as well as their grid rows when replacing a form. */
    public function clearFormElements():Void {
        while (getRowCount() > 0) {
            var row = getRowCount() - 1;
            for (col in 0...getColumnCount()) {
                var cell = getCell(row, col);
                cell.container.destroy();
                cell.destroy();
            }
            removeRow(row);
        }
    }

    /** Destroys form controls and grid resources. */
    override public function destroy():Void {
        clearFormElements();
        super.destroy();
    }

    private function fields():Array<IBaseUI> {
        var result:Array<IBaseUI> = [];
        for (row in 0...getRowCount()) {
            var container = getCell(row, 1).container;
            if (container.length > 0) result.push(cast container.getElementAtIndex(0));
        }
        return result;
    }

    /** Clears or resets every form control. */
    public function reset():Void {
        for (item in fields()) {
            if (Std.isOfType(item, IFormUI)) cast(item, IFormUI).clear();
            else setFieldValue(item, null);
        }
    }

    /** Sets matching form controls from fields in a data object. */
    public function setFormData(formObj:Dynamic):Void {
        if (formObj == null) return;
        for (item in fields()) {
            var name = Std.isOfType(item, IFormUI) ? cast(item, IFormUI).getName() : item.displayObject.name;
            if (Reflect.hasField(formObj, name)) setFieldValue(item, Reflect.field(formObj, name));
        }
    }

    private function setFieldValue(item:IBaseUI, value:Dynamic):Void {
        if (Std.isOfType(item, IFormUI)) cast(item, IFormUI).setValue(value);
        else if (Std.isOfType(item, ToggleButton)) {
            cast(item, ToggleButton).selected = value == true || value == item.displayObject.name;
            item.draw();
        }
        else if (Std.isOfType(item, Slider)) cast(item, Slider).percent = value == null ? 0 : value;
        else if (Std.isOfType(item, Label)) {
            cast(item, Label).text = value == null ? "" : Std.string(value);
            item.draw();
        }
    }

    /** Read the controls now; never cache their original/default values. */
    public function getFormData():Dynamic {
        var values:Dynamic = {};
        for (item in fields()) {
            var value:Dynamic = null;
            if (Std.isOfType(item, IFormUI)) value = cast(item, IFormUI).getValue();
            else if (Std.isOfType(item, RadioButton)) value = cast(item, RadioButton).selected ? item.displayObject.name : null;
            else if (Std.isOfType(item, ToggleButton)) value = cast(item, ToggleButton).selected;
            else if (Std.isOfType(item, Slider)) value = cast(item, Slider).percent;
            else if (Std.isOfType(item, Label)) value = cast(item, Label).text;
            var name = Std.isOfType(item, IFormUI) ? cast(item, IFormUI).getName() : item.displayObject.name;
            Reflect.setField(values, name, value);
        }
        return values;
    }
}
