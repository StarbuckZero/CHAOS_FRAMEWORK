package com.chaos.engine;


import com.chaos.engine.event.EngineDispatchEvent;
import com.chaos.engine.loader.JSONReader;
import com.chaos.engine.loader.classInterface.IReader;
import com.chaos.utils.Debug;
import com.chaos.engine.event.CoreEngineEvent;
import com.chaos.engine.plugin.CoreFrameworkPlugin;
import com.chaos.engine.plugin.CoreMediaPlugin;
import com.chaos.engine.plugin.CoreUIFrameworkPlugin;

import openfl.errors.Error;
import openfl.display.DisplayObject;
import openfl.display.Sprite;

/**
* This is the core or base for the engine.
* @author Erick Feiling
*/

class CoreEngine extends Sprite
{
    public var reader(get, never) : IReader;

    private var _reader : IReader;
    
    /**
    * Where all UI objects are displayed
    */
    
    public var displayArea : Sprite;
    
    private var _currentLayer : Sprite;
    
    
    public function new()
    {
        super();
        
        // Loading required plugins
        CoreFrameworkPlugin.initialize();
        CoreUIFrameworkPlugin.initialize();
        CoreMediaPlugin.initialize();
        //CoreTweenPlugin.initialize();
        
        
        if (null != stage)
            _reader = new JSONReader(stage);
        
        _reader.onDataParse = onDataPaser;
        _reader.onError = onPaserError;
        
        Global.mainDisplyArea = displayArea = cast(this, Sprite);
        
        Global.status = CoreEngineEvent.READY;
        dispatchEvent(new CoreEngineEvent(CoreEngineEvent.READY));
        
        // For all UI events
        CommandDispatch.addEngineListener(onEngineEvent);
    }
    
    /**
    * Get the reader that is being used
    */
    private function get_reader() : IReader
    {
        return _reader;
    }
    
    
    
    /**
    * The data that is coming back from reader. Override if need be.
    * @param	dataObj A normal object
    */
    public function onDataPaser(dataObj : Dynamic) : Void
    {
        var object : Dynamic;
        
        for (index in Reflect.fields(dataObj))
        {
            try
            {
                object = CommandCentral.runCommand(index, Reflect.field(dataObj, index), ((null != _currentLayer)) ? _currentLayer : displayArea);

                CommandDispatch.dispatch("CoreEngine", CoreEngineEvent.ITEM_CREATED, {type : index, item : object});
                
                if (index == EngineTypes.LAYER && null != object)
                    Global.currentLayer = _currentLayer = cast(object, Sprite);
            }
            catch (error : Error)
            {
                onPaserError(Reflect.field(dataObj, index));
            }
        }
    }
    
    /**
    * The data that is cause an error
    * @param	dataObj A normal object
    */
    
    public function onPaserError(dataObj : Dynamic) : Void
    {
        Debug.print("[CoreEngine::onPaserError] Was unable to run command: ");
        //TODO: Write detail output
        
        Global.status = CoreEngineEvent.PASER_FAIL;
        dispatchEvent(new CoreEngineEvent(CoreEngineEvent.PASER_FAIL));
    }
    
    public function onEngineEvent(event : EngineDispatchEvent) : Void
    {
        Debug.print("[CoreEngine::onEngineEvent] Event: " + event.eventType + " Element: " + event.elementName);
        Debug.print("----------------------- eventData -----------------------");
        
        for (key in Reflect.fields(event.eventData))
        {
           
            Debug.print("key: " + key + " value: " + Reflect.field(event.eventData, key ));
        }
        
        Debug.print("----------------------------------------------------------");
    }
}

