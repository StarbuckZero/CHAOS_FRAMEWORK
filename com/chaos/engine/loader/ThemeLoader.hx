package com.chaos.engine.loader;

import haxe.Json;
import com.chaos.engine.ThemeSystem;
import com.chaos.utils.data.TaskDataObject;
import com.chaos.utils.classInterface.ITask;
import com.chaos.utils.ThreadManager;
import com.chaos.utils.Debug;
import com.chaos.engine.Global;
import com.chaos.engine.CommandDispatch;
import openfl.net.URLLoader;
import openfl.net.URLRequest;
import openfl.events.Event;
import openfl.events.IOErrorEvent;

/**
* ...
* @author Erick Feiling
*/

class ThemeLoader
{
    private static var urlLoader : URLLoader;
    private static var loading : Bool = false;
    
    private static var styleLoaded : Bool = false;
    private static var bitmapLoaded : Bool = false;
    
    public function new()
    {
    }
    
    public static function load(fileURL : String) : Void
    {
        if (null == urlLoader)
        {
            urlLoader = new URLLoader();
        }
        
        var request : URLRequest = new URLRequest(fileURL);
        
        urlLoader.addEventListener(Event.COMPLETE, onDataComplete);
        urlLoader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
        
        urlLoader.load(request);
    }
    
    public static function setTheme(data : Dynamic) : Void
    {
        var dataObj : Dynamic = {};

        if(Std.is(data, String))
            dataObj = Json.parse(Std.string(data));
        else
            dataObj = data;
        
        // Pause everything while trying to load data
        Global.pause = true;
        
        ThreadManager.createTaskManager("ThemeLoader");
        
        
        if (Reflect.hasField(dataObj, "style"))
        {
            var styleArray : Array<Dynamic> = new Array<Dynamic>();
            var styles : Dynamic = Reflect.field(dataObj,"style");
            
            for (indexStyle in Reflect.fields(styles))
            {
                var newStyle : Dynamic = {};
                Reflect.setField(newStyle, indexStyle, Reflect.field(styles,indexStyle));
                styleArray.push(newStyle);
            }
            
            
            if (styleArray.length > 0)
            {
                for (i in 0 ... styleArray.length) {

                    var item : Dynamic = styleArray[i];
        
                    for (index in Reflect.fields(item))
                        ThemeSystem.setStyle(index, Reflect.field(item, index));
                }

                styleLoaded = true;
            }
            else
            {
                styleLoaded = true;
            }
        }
        else
        {
            styleLoaded = true;
        }
        
        
        if (Reflect.hasField(dataObj, "bitmap"))
        {
            var bitmapArray : Array<Dynamic> = new Array<Dynamic>();
            var bitmaps : Dynamic = Reflect.field(dataObj,"bitmap");
            
            for (indexBitmap in Reflect.fields(bitmaps))
            {
                var newBitmap : Dynamic = {};
                Reflect.setField(newBitmap, indexBitmap, Reflect.field(bitmaps, indexBitmap));
                
                bitmapArray.push(newBitmap);
            }
            
            
            if (bitmapArray.length > 0)
            {
                for (i in 0 ... bitmapArray.length) {
                    var item : Dynamic = bitmapArray[i];

                    for (index in Reflect.fields(item))
                        ThemeSystem.setBitmap(index, Reflect.field(item, index));    
                }

                bitmapLoaded = true;
            }
            else
            {
                bitmapLoaded = true;
            }
        }
        else
        {
            bitmapLoaded = true;
        }
        
        
        CommandDispatch.dispatch("ThemeLoader", "parsing", {});
        
        if (styleLoaded && bitmapLoaded)
        {
            CommandDispatch.dispatch("ThemeLoader", "done", {});
            Global.pause = false;
        }
    }
    
    private static function ioErrorHandler(event : IOErrorEvent) : Void
    {
        Debug.print("[ThemeLoader::ioErrorHandler] Error wasn't able to load file for ");
        CommandDispatch.dispatch("ThemeLoader", "fail", {});
        
        urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
    }
    
    private static function onDataComplete(event : Event) : Void
    {
        CommandDispatch.dispatch("ThemeLoader", "loaded", {});
        
        if(Reflect.hasField(event.target,"data"))
            setTheme(Reflect.field(event.target,"data"));
        
        urlLoader.removeEventListener(Event.COMPLETE, onDataComplete);
    }
    
    private static function updateStyle(task : ITask, list : Array<Dynamic>) : Void
    {
        var item : Dynamic = list[task.index - 1];
        
        for (index in Reflect.fields(item))
            ThemeSystem.setStyle(index, Reflect.field(item, index));
        
        if (task.index == task.end)
            styleLoaded = true;
    }
    
    private static function updateBitmap(task : ITask, list : Array<Dynamic>) : Void
    {
        var item : Dynamic = list[task.index - 1];
        
        
        for (index in Reflect.fields(item))
            ThemeSystem.setBitmap(index, Reflect.field(item, index));
        
        if (task.index == task.end)
            bitmapLoaded = true;
    }
    
    private static function onThemeComplete(task : ITask) : Void
    {
        if (styleLoaded && bitmapLoaded)
        {
            CommandDispatch.dispatch("ThemeLoader", "done", {});
            Global.pause = false;
        }
    }
}

