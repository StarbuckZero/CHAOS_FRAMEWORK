package com.chaos.form.ui.classInterface;


/**
 * Interface for Form elements
 * @author Erick Feiling
 */

interface IFormUI 
{
	
	/**
	 * Data 
	 */
	
	 
	function data():Dynamic;

    /**
	 * Clear values
	 */
    function clear() : Void;
    
    /**
	 * Get the type of form object
	 *
	 * @return The type of form object as a string
	 */
    function getElementType() : String;
    
    /**
	 * Get the id
	 *
	 * @return A int value
	 */
    function getId() : Int;
    
    /**
	 * Set the id of the element
	 *
	 * @param	value The id number
	 */
    function setId(value : Int) : Void;
    
    /**
	 * Return the value that has been stored
	 *
	 * @return A string value from object
	 */
    function getValue() : String;
    
    /**
	 * Set the value being used
	 *
	 * @param	value What you want to set the value to
	 */
    function setValue(value : String) : Void;
    
    /**
	 * Return the name
	 *
	 * @return The name that is used
	 */
    
    function getName() : String;
    
    /**
	 * Set the name
	 *
	 * @param	value The name
	 */
    function setName(value : String) : Void;
	
}

