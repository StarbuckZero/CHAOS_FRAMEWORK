package com.chaos.mobile.ui;

import com.chaos.mobile.ui.data.MobileMenuObjectData;
import openfl.events.MouseEvent;
import openfl.display.BitmapData;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.layout.classInterface.IBaseContainer;
import com.chaos.ui.layout.HorizontalContainer;
import com.chaos.mobile.ui.layout.DragContainer;
import com.chaos.data.DataProvider;
import com.chaos.mobile.ui.data.NavigationMenuObjectData;
import com.chaos.mobile.ui.classInterface.INavigationMenu;
import com.chaos.mobile.ui.classInterface.IDragContainer;


/**
 * A Multi level menu
 *
 * @author Erick Feiling
 */

class NavigationMenu extends DragContainer implements INavigationMenu implements IDragContainer implements IBaseContainer implements IBaseUI   {

	/**
	* Replace the current data provider
	*/ 
	
	public var dataProvider(get, set) : DataProvider<NavigationMenuObjectData>;

	/**
	* Shows Icon if menu button has child object
	**/

	public var alwaysDisplaySubMenuIcon(get, set):Bool;

    private var _titleArea:HorizontalContainer;
	private var _showTitleArea:Bool = true;

	private var _alwaysDisplaySubMenuIcon:Bool = false;
	
	private var _list : DataProvider<NavigationMenuObjectData> = new DataProvider<NavigationMenuObjectData>();
	private var _buttonHeight:Int = 40;
	private var _menuButtonList:Array<NavigationMenuItem> = new Array<NavigationMenuItem>();

	/**
	 * UI Component
	 * @param	data The proprieties that you want to set on component.
	 */

	public function new(data:Dynamic = null) {
		super(data);
	}

	
	override function setComponentData(data:Dynamic) {
		super.setComponentData(data);


		if (Reflect.hasField(data, "data"))
		{
			var dataMenu:Array<Dynamic> = Reflect.field(data, "data");
			_list =  createDataList(dataMenu);
		}

		buildMenu(_list);
	}

	private function createDataList( dataArray:Array<Dynamic> ):DataProvider<NavigationMenuObjectData> {

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

		

	override function initialize() {
		super.initialize();

		_lockX = true;

		buildMenu(_list);
	}
	
	private function set_alwaysDisplaySubMenuIcon(value:Bool):Bool 
	{
		_alwaysDisplaySubMenuIcon = value;

		return _alwaysDisplaySubMenuIcon;
	}
	
	private function get_alwaysDisplaySubMenuIcon():Bool 
	{
		return _alwaysDisplaySubMenuIcon;
	}
	
	private function set_dataProvider(value:DataProvider<NavigationMenuObjectData>):DataProvider<NavigationMenuObjectData> {

		_list = value;
		return _list;	
	}

	private function get_dataProvider():DataProvider<NavigationMenuObjectData> {
		return _list;
	}
	
	override function onStartTracking(event:MouseEvent):Void {
		super.onStartTracking(event);
	}

	override function onStopTracking(event:MouseEvent):Void {
		super.onStopTracking(event);
	}

	private function buildMenu( list:DataProvider<NavigationMenuObjectData> ):Void {

		//TODO: Update function to create menu based on object passed in

		// remove old menu
		clearRemove();

		// Build Menu for list
		for(i in 0 ... list.length) {
			
			var data:NavigationMenuObjectData = list.getItemAt(i);
			
			var dataObj:Dynamic = {"text": data.text,"width": _width, "height": _buttonHeight, "NavigationMenu": this};

			// Add sub menu
			if(data.childObject != null)
				Reflect.setField(dataObj, "children", data.childObject );

			var navItem:NavigationMenuItem = new NavigationMenuItem(dataObj);
			navItem.y = _buttonHeight * i;

			_content.addChild(navItem);
			_menuButtonList.push(navItem);
		}
	}

	private function clearRemove():Void {

		//TODO: Update to remove items based on Sprite passed in
		for(i in 0 ... _menuButtonList.length)
		{
			_menuButtonList[i].destroy();
			_content.removeChild(_menuButtonList[i]);
		}

		_menuButtonList = new Array<NavigationMenuItem>();
	}
		

	
}
 