package com.chaos.mobile.ui.classInterface;

import com.chaos.ui.layout.classInterface.IBaseContainer;
import openfl.display.BitmapData;

/**
 * @author Erick Feiling
 */

 interface IBreadcrumb extends IBaseContainer
 {
    /**
    * Space between next label and separator
    **/

    var labelSpacing(get, set):Int;

    /**
    * Add another level        
    * @param	levelName Name of level
    * @param	icon The image being used
    **/    

    function addLevel(levelName:String, icon:BitmapData = null):Void;

    /**
    * Jump to level
    **/
    
    function jumpToLevel( level:Int ):Void;    
    
 }