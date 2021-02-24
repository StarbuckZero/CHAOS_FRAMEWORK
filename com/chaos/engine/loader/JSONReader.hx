package com.chaos.engine.loader;

import com.chaos.engine.CommandDispatch;
import com.chaos.engine.EngineTypes;
import com.chaos.engine.event.CoreEngineEvent;
import com.chaos.engine.loader.classInterface.IReader;
import com.chaos.utils.Debug;
import com.chaos.engine.Global;

import openfl.errors.Error;
import openfl.display.Stage;
import openfl.net.URLLoader;
import openfl.net.URLRequest;
import openfl.events.Event;
import openfl.events.IOErrorEvent;
import openfl.events.EventDispatcher;

import haxe.Json;

/**
* This will take data in the JSON format and pass it to the engine layer to figure out what to do with it.
* @author Erick Feiling
*/

class JSONReader extends Reader implements IReader
{
    private var loaded : Bool = false;
    private var urlLoader : URLLoader = new URLLoader();
    
    private var counter : Int = 0;
    private var layerCounter : Int = 0;
    
    private var _eventDispatcher : EventDispatcher = new EventDispatcher();
    
    public function new(mainStage : Stage)
    {
        super(mainStage);
    }
    
    override public function load(fileURL : String) : Void
    {
        var request : URLRequest = new URLRequest(fileURL);
        
        counter = 0;
        layerCounter = 0;
        
        urlLoader.addEventListener(Event.COMPLETE, onDataComplete, false, 0, true);
        urlLoader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler, false, 0, true);
        
        urlLoader.load(request);
        
        _eventDispatcher.dispatchEvent(new CoreEngineEvent(CoreEngineEvent.LOADING));
        CommandDispatch.dispatch("Reader", CoreEngineEvent.LOADING, {});
        Global.status = CoreEngineEvent.LOADING;
    }
    
    override public function setData(data : Dynamic) : Void
    {
        _eventDispatcher.dispatchEvent(new CoreEngineEvent(CoreEngineEvent.LOADING));
        CommandDispatch.dispatch("Reader", CoreEngineEvent.LOADING, {});
        
        counter = 0;
        layerCounter = 0;
        
        var dataObj : Dynamic = Std.is(data, String) ? Json.parse(Std.string(data)) : data;
        
        if (Std.is(dataObj, Dynamic) && Reflect.hasField(dataObj,"imges"))
            list = list.concat( Reflect.field(dataObj,"items"));
        
        loaded = true;
        
        Global.status = CoreEngineEvent.LOADED;
        _eventDispatcher.dispatchEvent(new CoreEngineEvent(CoreEngineEvent.LOADED));
        CommandDispatch.dispatch("Reader", CoreEngineEvent.LOADED, {});
    }
    
    
    override public function thread(value:Dynamic) : Void
    {
        if (!loaded || lock || Global.pause)
            return;
        

        if (counter < list.length)
        {
            var dataObj:Dynamic = list[counter];

            if (Global.status != CoreEngineEvent.READING)
            {
                Global.status = CoreEngineEvent.READING;
                _eventDispatcher.dispatchEvent(new CoreEngineEvent(CoreEngineEvent.READING));
                CommandDispatch.dispatch("Reader", CoreEngineEvent.READING, {});
            }
            
            

            if (Reflect.hasField(dataObj, EngineTypes.LAYER))
            {
                var layerData:Dynamic = Reflect.field(dataObj, EngineTypes.LAYER);
                var layerList : Array<Dynamic> = Reflect.hasField(layerData, "items") ? Reflect.field(layerData, "items") : new Array<Dynamic>();
                
                // Let the engine know that this is a layer
                if (layerCounter == 0)
                    onDataParse(list[counter]);
                
                // There can't be a layer in a layer
                if (layerCounter == layerList.length)
                {
                    layerCounter = 0;
                    counter++;
                }
                else
                {
                    
                    if (layerList[layerCounter] != EngineTypes.LAYER)
                        onDataParse(layerList[layerCounter]);
                    
                    layerCounter++;
                }
            }
            else
            {
                onDataParse(dataObj);
                counter++;
            }
        }
        else if (Global.status != CoreEngineEvent.DONE)
        {
            Global.status = CoreEngineEvent.DONE;
            _eventDispatcher.dispatchEvent(new CoreEngineEvent(CoreEngineEvent.DONE));
            
            reset();
            
            CommandDispatch.dispatch("Reader", CoreEngineEvent.DONE, {});
        }
    }
    
    private function ioErrorHandler(event : IOErrorEvent) : Void
    {
        Debug.print("[JSONReader::ioErrorHandler] Fail to load file");
        
        Global.status = CoreEngineEvent.LOAD_FAIL;

        _eventDispatcher.dispatchEvent(new CoreEngineEvent(CoreEngineEvent.LOAD_FAIL));
        CommandDispatch.dispatch("Reader", CoreEngineEvent.LOAD_FAIL, {});

    }
    
    
    
    
    private function onDataComplete(event : Event) : Void
    {
        try
        {
            setData(Std.string(urlLoader.data));
        }
        catch (error : Error)
        {
            Debug.print("[JSONReader::onDataComplete] Fail to parse file");
            
            Global.status = CoreEngineEvent.LOAD_FAIL;
            _eventDispatcher.dispatchEvent(new CoreEngineEvent(CoreEngineEvent.LOAD_FAIL));
            CommandDispatch.dispatch("Reader", CoreEngineEvent.LOAD_FAIL, {});
        }
    }
    
    private function reset() : Void
    {
        list = new Array<Dynamic>();
        layerCounter = 0;
        counter = 0;
    }
}

