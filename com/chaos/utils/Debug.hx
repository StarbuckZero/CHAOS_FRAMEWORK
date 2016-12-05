package com.chaos.utils;

import openfl.errors.Error;
import openfl.utils.Object;


/**
 * ...
 * @author Erick Feiling
 */


import openfl.system.Capabilities;
import openfl.system.System;
import openfl.external.ExternalInterface;

class Debug
{
    public static inline var LOCAL_CONNECTION : String = "chaos_local_connection";
    
    public function new()
    {
        
    }
    
    
    /**
	 *
	 * Outputs to the flash trace window and send to console if connected
	 *
	 * @param	text
	 * @param	color
	 */
    
    public static function print(text : String, color : Int = 0xFFFFFF) : Void
    {
		// For normal console
        trace(text);
        
		#if flash
		// For any outside source
        if (ExternalInterface.available) 
            ExternalInterface.call(LOCAL_CONNECTION, text);
		#end
    }
    
    /**
	 * System status
	 */
    
    public static function systemStats() : Void
    {
        print("Manufacturer: " + Capabilities.manufacturer);
        print("OS: " + Capabilities.os);
        print("Version: " + Capabilities.version);
        print("Screen Res: " + Capabilities.screenResolutionX + "x" + Capabilities.screenResolutionY);
    }
    
    

}

