package com.chaos.mobile.ui;

import motion.actuators.GenericActuator;
import openfl.events.Event;
import openfl.display.DisplayObject;
import openfl.display.Sprite;
import com.chaos.mobile.ui.data.MobileMenuObjectData;
import openfl.events.MouseEvent;
import openfl.display.BitmapData;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.layout.classInterface.IBaseContainer;
import com.chaos.ui.layout.HorizontalContainer;
import com.chaos.mobile.ui.layout.DragContainer;
import com.chaos.ui.layout.BaseContainer;
import com.chaos.data.DataProvider;
import com.chaos.mobile.ui.data.NavigationMenuObjectData;
import com.chaos.mobile.ui.classInterface.INavigationMenu;
import com.chaos.mobile.ui.classInterface.IDragContainer;
import com.chaos.ui.BaseUI;
import com.chaos.mobile.ui.event.NavigationMenuEvent;



/**
 * A Multi level menu
 *
 * @author Erick Feiling
 */

class NavigationMenu extends BaseContainer implements INavigationMenu implements IBaseContainer implements IBaseUI   {

	/**
	* Replace the current data provider
	*/ 
	
	public var dataProvider(get, set) : DataProvider<NavigationMenuObjectData>;

	/**
	* Shows Icon if menu button has child object
	**/

	public var alwaysDisplaySubMenuIcon(get, set):Bool;

	/**
	* Adjust the sliding animation of the buttons in menu
	**/

	public var menuAnimationSpeed(get, set) : Float;

	/**
	 * Border color for normal button state
	 */
	 public var buttonBorderColor(get, set) : Int;	

	/**
	 * Set the border menu button alpha
	 */
	 public var buttonBorderAlpha(get, set) : Float;

	 /**
	  * Border thinkness on menu buttons
	  */

	public var buttonBorderThinkness(get, set) : Float;

	/**
	* Border menu
	*/

	public var buttonBorder(get, set) : Bool;

	/**
	 * The button normal state color
	 */
	public var defaultColor(get, set):Int;

	/**
	 * The button over state color
	 */
	public var overColor(get, set):Int;

	/**
	 * The button down state color
	 */
	public var downColor(get, set):Int;

	/**
	 * The button disable state color
	 */
	public var disableColor(get, set):Int;	

	private var _alwaysDisplaySubMenuIcon : Bool = false;
	
	private var _list : DataProvider<NavigationMenuObjectData> = new DataProvider<NavigationMenuObjectData>();
	private var _animationPlaying : Bool = false;
	private var _menuAnimationSpeed : Float = .5;
	private var _mask : Sprite;

	private var _defaultColor:Int = -1;
	private var _overColor:Int = -1;
	private var _downColor:Int = -1;
	private var _disableColor:Int = -1;
		
	private var _buttonHeight : Int = 40;	
	private var _buttonBorder : Bool = true;
	private var _buttonBorderAlpha : Float = 1;
	private var _buttonBorderThinkness : Float = 1;	
	private var _buttonBorderColor : Int = 0;

	/**
	 * UI Component
	 * @param	data The proprieties that you want to set on component.
	 */

	public function new( data : Dynamic = null ) {
		super(data);
	}

	
	override function setComponentData( data : Dynamic ) {
		super.setComponentData(data);
		
		if (Reflect.hasField(data, "menuAnimationSpeed"))
			_menuAnimationSpeed = Reflect.field(data, "menuAnimationSpeed");

		if (Reflect.hasField(data, "buttonBorder"))
			_buttonBorder = Reflect.field(data, "buttonBorder");

		if (Reflect.hasField(data, "buttonBorderAlpha"))
			_buttonBorderAlpha = Reflect.field(data, "buttonBorderAlpha");

		if (Reflect.hasField(data, "buttonBorderThinkness"))
			_buttonBorderThinkness = Reflect.field(data, "buttonBorderThinkness");

		if (Reflect.hasField(data, "buttonBorderColor"))
			_buttonBorderColor = Reflect.field(data, "buttonBorderColor");

		if (Reflect.hasField(data, "buttonHeight"))
			_buttonHeight = Reflect.field(data, "buttonHeight");

		// Base Colors
		if (Reflect.hasField(data, "defaultColor"))
			_defaultColor = Reflect.field(data, "defaultColor");

		if (Reflect.hasField(data, "overColor"))
			_overColor = Reflect.field(data, "overColor");

		if (Reflect.hasField(data, "downColor"))
			_downColor = Reflect.field(data, "downColor");

		if (Reflect.hasField(data, "disableColor"))
			_disableColor = Reflect.field(data, "disableColor");		

		if (Reflect.hasField(data, "data"))
		{
			var dataMenu:Array<Dynamic> = Reflect.field(data, "data");
			_list =  createDataList(dataMenu);
		}
	}

	private function createDataList( dataArray : Array<Dynamic> ) : DataProvider<NavigationMenuObjectData> {

		var newList:DataProvider<NavigationMenuObjectData> = new DataProvider<NavigationMenuObjectData>();

		for (i in 0 ... dataArray.length)
		{
			var dataObj:Dynamic = dataArray[i];
			var icon:BitmapData = null;
			var childList:DataProvider<NavigationMenuObjectData> = null;

			if(Reflect.hasField(dataObj,"icon"))
				icon = Reflect.field(dataObj,"icon");

			if(Reflect.hasField(dataObj, "children"))
				childList = createDataList(Reflect.field(dataObj, "children"));

			newList.addItem(new NavigationMenuObjectData( Reflect.field(dataObj, "text"), Reflect.field(dataObj, "value"), childList, icon ));
		}

		return newList;

	}

	override function initialize() : Void {
		super.initialize();

		_mask = new Sprite();

		mask = _mask;
		addChild(_mask);

		if(_list != null && _list.length > 0)
			buildMenu(_list);
	}

	/**
	 * Unload Component
	 */
	
    override public function destroy() : Void 
    {
		super.destroy();
		
		//TODO: Might want to destory the buttons in this menu later tbh
    }  	

    /**
    * Let Nav Menu know that a menu button was clicked.
    * @param	navButton The button that was clicked
    */

	public function menuButtonClicked( navButton : NavigationMenuItem ) : Void {

		dispatchEvent(new NavigationMenuEvent(NavigationMenuEvent.SELECTED, navButton));
	}

    /**
    * Go to the sub menu
    * @param	data The buttons that will be created for the new sub menu being created
	*/
	
	public function goToSubMenu( data : DataProvider<NavigationMenuObjectData> ) : Void
	{
		
		if(!_animationPlaying)
		{
			// Build Sub Menu
			buildMenu(data);
			
			// Shift forward after build there
			shiftButtonsForward();
		}

	}

	public function goToPrevious() : Void
	{
		if(!_animationPlaying)
			shiftButtonsBack();		
	}
	
	override function draw() : Void {
		super.draw();

		_mask.graphics.clear();
		_mask.graphics.beginFill(0);
		_mask.graphics.drawRect(0,0,_width,_height);
		_mask.graphics.endFill();

		//TODO: Rebuild list again if need be
	}
	/**
	 * The button normal state color
	 */
	 private function set_defaultColor(value:Int):Int {
		_defaultColor = value;

		return value;
	}

	/**
	 * Return the normal state button color
	 */
	private function get_defaultColor():Int {
		return _defaultColor;
	}

	/**
	 * The button over state color
	 */
	private function set_overColor(value:Int):Int {
		_overColor = value;

		return value;
	}

	/**
	 * Return the button over state color
	 */
	private function get_overColor():Int {
		return _overColor;
	}

	/**
	 * The button down state color
	 */
	private function set_downColor(value:Int):Int {
		_downColor = value;

		return value;
	}

	/**
	 * Return the button down state color
	 */
	private function get_downColor():Int {
		return _downColor;
	}

	/**
	 * The button disable state color
	 */
	private function set_disableColor(value:Int):Int {
		_disableColor = value;

		return value;
	}

	/**
	 * Return the button disable state color
	 */
	private function get_disableColor():Int {
		return _disableColor;
	}

	/**
	 * Show or hide border around button
	 */
	 private function set_buttonBorder( value : Bool ) : Bool {
		_buttonBorder = value;

		return value;
	}

	/**
	 * Return true if border is being shown and false if not
	 */
	private function get_buttonBorder() : Bool {
		return _buttonBorder;
	}

	/**
	 * Border color for menu button
	 */
	 private function set_butonBorderColor( value : Int ) : Int {
		_buttonBorderColor = value;

		return value;
	}

	/**
	 * Return the color
	 */
	private function get_buttonBorderColor() : Int {
		return _buttonBorderColor;
	}	

	/**
	 * Border thinkness
	 */
	 private function set_buttonBorderThinkness( value : Float ) : Float {
		_buttonBorderThinkness = value;
		return value;
	}

	/**
	 * Return thinkness
	 */
	private function get_buttonBorderThinkness() : Float {
		return _buttonBorderThinkness;
	}

	private function set_buttonBorderAlpha( value : Float ) : Float {
		_buttonBorderAlpha = value;
		return value;
	}

	private function get_buttonBorderAlpha() : Float {
		return _buttonBorderAlpha;
	}	

	/**
	 * The button normal state color
	 */
	 private function set_buttonBorderColor( value : Int ) : Int {
		_buttonBorderColor = value;

		return value;
	}

	private function get_menuAnimationSpeed() : Float {
		
		return _menuAnimationSpeed;
	}
	
	private function set_menuAnimationSpeed( value : Float ):Float 
	{	
		_menuAnimationSpeed = value;

		return value;
	}

	private function set_alwaysDisplaySubMenuIcon( value : Bool ) : Bool 
	{
		_alwaysDisplaySubMenuIcon = value;

		return _alwaysDisplaySubMenuIcon;
	}
	
	private function get_alwaysDisplaySubMenuIcon() : Bool 
	{
		return _alwaysDisplaySubMenuIcon;
	}
	
	private function set_dataProvider(value:DataProvider<NavigationMenuObjectData>) : DataProvider<NavigationMenuObjectData> {

		_list = value;
		return _list;	
	}

	private function get_dataProvider() : DataProvider<NavigationMenuObjectData> {
		return _list;
	}
	

	private function shiftButtonsForward () : Void
	{		
		if(!_animationPlaying)
		{
			_animationPlaying = true;

			var nextMenu:DragContainer = cast(_content.getChildByName("menu_" + (_content.numChildren - 1)), DragContainer); // Newly added menu
			var currentMenu:DragContainer = cast(_content.getChildByName("menu_" + (_content.numChildren - 2)), DragContainer); // The current menu
			
			currentMenu.animateTo({"x": (currentMenu.x - _width),"duration":_menuAnimationSpeed});
			nextMenu.animateTo({"x": (nextMenu.x - _width),"duration":_menuAnimationSpeed,"onComplete":onForwardAnimationComplete});	
		}

	}

	private function shiftButtonsBack() : Void
	{
		if(_content.numChildren >= 2 && !_animationPlaying)
		{
			_animationPlaying = true;

			var currentMenu:BaseUI = cast(_content.getChildByName("menu_" + (_content.numChildren - 1)), BaseUI); // The current menu
			currentMenu.animateTo({"x": (currentMenu.x + _width),"duration":_menuAnimationSpeed});
	
			var prevMenu:BaseUI = cast(_content.getChildByName("menu_" + (_content.numChildren - 2)), BaseUI); // Newly added menu
			prevMenu.animateTo({"x": (prevMenu.x + _width),"duration":_menuAnimationSpeed, "onComplete":onBackAnimationComplete});			
		}
		
	}

	private function onForwardAnimationComplete() : Void 
	{
		_animationPlaying = false;
	}

	private function onBackAnimationComplete() : Void
	{
		_animationPlaying = false;
		clearRemove(_content.numChildren -1);		
	}

	private function buildMenu( list : DataProvider<NavigationMenuObjectData> ) : Void {

		var buttonHolder:Sprite = new Sprite();
		buttonHolder.name = "buttonHolder";

		var menuLevelContainer:DragContainer = new DragContainer({"name":"menu_" + _content.numChildren,"content":buttonHolder,"lockX":true,"x": (_content.numChildren > 0) ? _width : 0,"width": _width, "height": _height});
				
		// Build Menu for list
		for(i in 0 ... list.length) {
			
			var data:NavigationMenuObjectData = list.getItemAt(i);
			
			var dataObj:Dynamic = {"name":"button_" + i + "_" + _content.numChildren,"text": data.text,"width": _width, "height": _buttonHeight,
			 					  "DragContainer": menuLevelContainer,"NavigationMenu": this,"border":_buttonBorder,"borderColor":_buttonBorderColor,"borderAlpha":_borderAlpha};

			// Set defaults
			if(_defaultColor != -1)
				Reflect.setField(dataObj, "defaultColor", _defaultColor);

			if(_overColor != -1)
				Reflect.setField(dataObj, "overColor", _overColor);

			if(_downColor != -1)
				Reflect.setField(dataObj, "downColor", _downColor);

			if(_disableColor != -1)
				Reflect.setField(dataObj, "disableColor", _disableColor);

			// Base Colors
			if (Reflect.hasField(data, "defaultColor"))
				Reflect.setField(dataObj, "defaultColor", Reflect.field(data,"defaultColor"));

			if (Reflect.hasField(data, "overColor"))
				Reflect.setField(dataObj, "overColor", Reflect.field(data,"overColor"));

			if (Reflect.hasField(data, "downColor"))
				Reflect.setField(dataObj, "downColor", Reflect.field(data,"downColor"));

			if (Reflect.hasField(data, "disableColor"))
				Reflect.setField(dataObj, "disableColor", Reflect.field(data,"disableColor"));	

			// Add sub menu
			if(data.childObject != null)
				Reflect.setField(dataObj, "children", data.childObject );

			var navItem:NavigationMenuItem = new NavigationMenuItem(dataObj);
			navItem.y = _buttonHeight * i;

			buttonHolder.addChild(navItem);
		}

		_content.addChild(menuLevelContainer);
		
	}
	
	private function clearRemove( menuLevel : Int ) : Void {

		var menuLevelContainer:DragContainer = cast(_content.getChildByName("menu_" + menuLevel), DragContainer);
		var buttonHolder:Sprite = cast(menuLevelContainer.content, Sprite);
		
		if(buttonHolder != null)
		{
			for(i in 0 ... buttonHolder.numChildren - 1)
			{
				var navItem:NavigationMenuItem = cast(buttonHolder.getChildByName("button_" + i + "_" + menuLevel),NavigationMenuItem);
				navItem.destroy();
			}

			_content.removeChild(menuLevelContainer);

		}
		
	}
	
}
 