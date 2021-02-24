package com.chaos.engine;

import openfl.display.Sprite;

/**
* CommandCentral calls a function based on the key value that was passed in.
* @author Erick Feiling
*/
class CommandCentral
{
    private static var list : Dynamic = {};
    
    
    /**
    * Adds a function to be called
    * @param	key This is a name that will be used to call the function.
    * @param	func Calls a function with the data object and display area. This is so things can be added to it.
    */
    public static function addCommand(key : String, func : Dynamic->Dynamic) : Void
    {
        Reflect.setField(list, key, func);
    }
    
    /**
    * Remove function call from list
    * @param	key The name of the call that will be removed
    */
    public static function removeCommand(key : String) : Void
    {
        if (Reflect.hasField(list,key))
            Reflect.deleteField(list, key);
    }
    
    /**
    * Run command based on key name
    * 
    * @param	key The name of the command in list
    * @param	dataObj The data object that is used to help run the command
    * @param	displayArea The display area the command can update
    * @return	The command output in most cases a display object of some kind
    */
    public static function runCommand(key : String, dataObj : Dynamic, displayArea:Sprite = null) : Dynamic
    {
        if (Reflect.hasField(list,key))
        {
            var func:Dynamic->Dynamic = Reflect.field(list, key);

            if(displayArea != null)
                Reflect.setField(dataObj, "displayArea", displayArea);

            return func(dataObj);
        }

        return null;
    }
}

