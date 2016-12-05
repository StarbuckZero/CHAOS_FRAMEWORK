package com.chaos.utils.data;



/**
 * ...
 * @author Erick Feiling
 */

import com.chaos.utils.Debug;
import com.chaos.utils.classInterface.ITask;
import haxe.Constraints.Function;
import openfl.errors.Error;

class TaskDataObject implements ITask
{
    public var id(get, set) : String;
    public var start(get, never) : Int;
    public var end(get, never) : Int;
    public var index(get, set) : Int;

    public static var SAFE_MODE : Bool = true;
    
    private var _id : String = "";
    private var _start : Int;
    private var _index : Int;
    private var _end : Int;
    private var _func : Function;
    private var _callBack : Function;
    private var _args : Array<Dynamic> = new Array<Dynamic>();
    
    /**
	 *
	 * This is a task that can be put inside a TaskMangaer or ThreadManager. This will run the function with all the values pass.
	 * If a start and end value was set then this object will be passed as the first argument.
	 *
	 * @param	id The task id
	 * @param	start Starting point for sub task
	 * @param	end End point for sub task
	 * @param	func The function to call when running a task. This will also pass back a TaskDataObject and not a event.
	 * @param	callBack Function to call once the task is done
	 * @param	args The paramers to pass with the function. If a start and end value was set then this task object will be passed first.
	 *
	 */
    
    public function new(id : String = "default", start : Int = 0, end : Int = 0, func : Function = null, callBack : Function = null, args:Array<Dynamic> = null)
    {
        _id = id;
        _start = _index = start;
        _end = end;
        _callBack = callBack;
        _func = func;
        
        _args = args;
		
        
		
        if (_start != _end) 
            _args.unshift(this);
    }
    
    private function set_id(value : String) : String
    {
        _id = value;
        return value;
    }
    
    private function get_id() : String
    {
        return _id;
    }
    
    private function get_start() : Int
    {
        return _start;
    }
    
    private function get_end() : Int
    {
        return _end;
    }
    
    private function set_index(value : Int) : Int
    {
        _index = value;
        return value;
    }
    
    private function get_index() : Int
    {
        return _index;
    }
    
    public function clear() : Void
    {
        _id = "cleared";
        _start = 0;
        _index = 0;
        _end = 0;
        _callBack = null;
        _func = null;
        _args = new Array<Dynamic>();
    }
    
    public function run() : Void
    {
        if (null != _func) 
        {
            if (SAFE_MODE) 
            {
                try
                {
					
					Reflect.callMethod(this, _func, _args);
                }
                catch (error : Error)
                {
                    Debug.print("[TaskDataObject] " + error);
                }
            }
            else 
            {
                Reflect.callMethod(this, _func, _args);
            }
        }
        
        if (null != _callBack && _index == _end) 
        {
            if (SAFE_MODE) 
            {
                try
                {
                    _callBack(this);
                }
                catch (error : Error)
                {
                    Debug.print("[TaskDataObject]" + error);
                }
            }
            else 
            {
                _callBack(this);
            }
        }
    }
}

