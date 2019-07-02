package com.chaos.ui.data;

import com.chaos.ui.classInterface.IButton;
import com.chaos.ui.classInterface.IWindow;
import haxe.Constraints.Function;

/**
 * Keeps track of AlertBoxes
 * @author Erick Feiling
 */

class AlertObjectData 
{
	public var window(get, never) : IWindow;
	public var buttonList(get, never) : Array<IButton>;
	public var callBack(get, never) : Dynamic;
	
	
	private var _window:IWindow = null;
	private var _buttonList:Array<IButton> = null;
	private var _callBack:Dynamic = null;
	
	public function new( newWindow:IWindow, newButton:Array<IButton>, callBackFunc:Function = null )
	{
		_window = newWindow;
		_buttonList = newButton;
		_callBack = callBackFunc;
	}
	
	
	private function get_window():IWindow
	{
		return _window;
	}
	
	private function get_buttonList():Array<IButton>
	{
		return _buttonList;
	}
	
	private function get_callBack():Function
	{
		return _callBack;
	}
	
}