package com.chaos.engine;

import openfl.display.Sprite;

/**
* Engine global settings
* 
* @author Erick Feiling
*/
class Global
{
    /** The current layer the reading is creating **/
    public static var currentLayer : Sprite;
    
    /** The display area for the engine content **/
    public static var mainDisplyArea : Sprite;
    
    /** The current status of engine **/
    public static var status : String;
    
    /** Only applies when reading a file **/
    public static var pause : Bool = false;
    
    public function new()
    {
    }
}

