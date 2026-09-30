package com.chaos.form.ui;


import com.chaos.form.ui.classInterface.IFormUI;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.classInterface.IListBox;
import com.chaos.ui.ListBox;

/**
 * A selected box is pretty much a list but with support for forms
 */

class Select extends ListBox implements IListBox implements IBaseUI implements IFormUI
{
    
    private var id : Int = 0;
    
    /** Creates a select field with optional component data. */
    public function new(data:Dynamic = null)
    {
        super(data);
    }
	
	/** Applies select field settings and options. */
	override public function setComponentData(data:Dynamic):Void 
	{
		super.setComponentData(data);
		
		if (Reflect.hasField(data, "id"))
			id = Reflect.field(data, "id");
		
	}
	
	/** Returns the select field name, ID, value, and type. */
	public function data():Dynamic
	{
		return {"name":name, "id":id, "value":getValue(), "type":"label"};
	
	}
    
    /**
	 * Get the type of form object
	 *
	 * @return The type of form object as a string
	 */
	
    public function getElementType() : String
    {
        return "select";
    }
    
    /**
	 * Get the id
	 *
	 * @return A int value
	 */
	
    public function getId() : Int
    {
        return id;
    }
    
    /**
	 * Set the id of the selected item
	 *
	 * @param	value The id number
	 */
	
    public function setId(value : Int) : Void
    {
        id = value;
    }
    
    /**
	 * Return the value that has been stored
	 *
	 * @return A string value from object
	 */
    
    public function getValue() : Dynamic
    {
        var selected = getSelectedList();
        return allowMultipleSelection ? [for (item in selected) item.value]
            : selected.length == 0 ? null : selected[0].value;
    }
    
    /**
	 * Set the value being used
	 *
	 * @param	value What you want to see the value to
	 */
	
    public function setValue(value : Dynamic) : Void
    {
        var values:Array<Dynamic> = Std.isOfType(value, Array) ? cast value : [value];
        _selectIndex = -1;
        for (i in 0...dataProvider.length) {
            var item = dataProvider.getItemAt(i);
            item.selected = values.indexOf(item.value) >= 0 && (allowMultipleSelection || _selectIndex == -1);
            if (item.selected) _selectIndex = i;
        }
        draw();
    }
    
    /**
	 * Return the name
	 *
	 * @return The name that is used
	 */
    
    public function getName() : String
    {
        return name;
    }
    
    /**
	 * Set the name
	 *
	 * @param	value The name
	 */
	
    public function setName(value : String) : Void
    {
        name = value;
    }
}

