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
    
    public function new(data:Dynamic = null)
    {
        super(data);
    }
	
	override public function setComponentData(data:Dynamic):Void 
	{
		super.setComponentData(data);
		
		if (Reflect.hasField(data, "id"))
			id = Reflect.field(data, "id");
		
	}
	
	public function data():Dynamic
	{
		return return {"name":name, "id":id, "value":getValue(), "type":"label"};
	
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
    
    public function getValue() : String
    {
        return ((dataProvider.length > 0)) ? getSelected().text : "";
    }
    
    /**
	 * Set the value being used
	 *
	 * @param	value What you want to see the value to
	 */
	
    public function setValue(value : String) : Void
    {
        if (dataProvider.length > 0) 
            getSelected().text = value;
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

