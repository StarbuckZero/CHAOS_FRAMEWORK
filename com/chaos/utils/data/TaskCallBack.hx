package com.chaos.utils.data;

/**
 * Calls a function 
 * @author Erick Feiling
 */
class TaskCallBack
{
    public var functionName(get, never) : String;
    public var mainClass(get, never) : Dynamic;
	
	private var _funcName:String;
	private var _mainClass:Dynamic;
	
	public function new( mainClassObj:Dynamic, funcName:String ) 
	{
		_mainClass = mainClassObj;
		_funcName = funcName;
	}
	
	function get_functionName():String 
	{
		return _funcName;
	}
	
	
	
	function get_mainClass():Dynamic
	{
		return _mainClass;
	}
	
}