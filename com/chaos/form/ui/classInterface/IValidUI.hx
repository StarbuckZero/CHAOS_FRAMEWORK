package com.chaos.form.ui.classInterface;



/**
 * Interface is for making sure data is valid
 * @author Erick Feiling
 */

interface IValidUI
{

    /**
	 * Check to see if info stored is correct
	 * @return True if it's correct and false if not
	 */
    
    function isValid() : Bool;
    
    /**
	 * This will check to see if TextInput is empty
	 *
	 * @return True if there is nothing in the TextInput and False if not
	 */
    
    function isEmpty() : Bool;
}

