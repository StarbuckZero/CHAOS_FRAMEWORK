package com.chaos.engine.loader;

import com.chaos.engine.loader.classInterface.IReader;
import com.chaos.utils.ThreadManager;
import openfl.display.Stage;

/**
* Reader for running and dispatching commands
* @author Erick Feiling
*/

class Reader implements IReader
{
    public var lock(get, set) : Bool;
    public var onDataParse(get, set) : Dynamic->Void;
    public var onError(get, set) : Dynamic->Void;

    public var list : Array<Dynamic> = new Array<Dynamic>();
    
    private var _lock : Bool = false;
    
    private var _onDataParse : Dynamic->Void;
    private var _onError : Dynamic->Void;
    
    
    
    /**
    * Runs a timer so data can be processed
    * @param	mainStage main flash stage
    */
    
    public function new(mainStage : Stage)
    {
        ThreadManager.stage = mainStage;
        ThreadManager.addEventTimer(thread);
    }
    
    /**
    * Loads data from a given source
    * 
    * @param	fileURL The URL path to the file that will be loaded
    */
    
    public function load(fileURL : String) : Void
    {
    }
    
    /**
    * Set the data being used for the reader
    * @param	data The raw data format for the reader
    */
    
    public function setData(data : Dynamic) : Void
    {
    }
    
    
    
    /**
    * If true will not run anything in thread
    */
    private function set_lock(value : Bool) : Bool
    {
        _lock = value;
        return value;
    }
    
    /**
    * If true main thread is locked and false if not
    */
    private function get_lock() : Bool
    {
        return _lock;
    }
    
    /**
    * The function called once data is parsed
    */
    private function set_onDataParse(value : Dynamic->Void) : Dynamic->Void
    {
        _onDataParse = value;
        return value;
    }
    
    /**
    * What is going to be used to parse the data read in by the file
    */
    private function get_onDataParse() : Dynamic->Void
    {
        return _onDataParse;
    }
    
    /**
    * If there is something wrong the item being created
    */
    
    private function set_onError(value : Dynamic->Void) : Dynamic->Void
    {
        _onError = value;
        return value;
    }
    
    /**
    * The function that is being used
    */
    private function get_onError() : Dynamic->Void
    {
        return _onError;
    }
    
    /**
    * The main thread for reading data
    */
    
    public function thread(value:Dynamic) : Void
    {

    }
}

