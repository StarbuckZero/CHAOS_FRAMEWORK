package com.chaos.ui.classInterface;


import openfl.display.BitmapData;
import openfl.utils.Object;

/**
 * @author Erick Feiling
 */

interface IWindow extends IBaseUI
{
	
	/**
	 * The scroll pane being used
	 */
	
	var scrollPane(get, never):IScrollPane;
	
	
	/**
	 * Return the text label being used
	 */
	
	var textLabel(get, never):ILabel;
	
	/**
	 * Set the minimize width of the of the Window over all size
	 */
	
	var windowMinWidth(get, set):Int;
	
	
	/**
	 * Set the minimize height of the of the Window over all size
	 */
	
	var windowMinHeight(get, set):Int;
	
	/**
	 * Set if the window is resizable or not.
	 */
	
	var resize(get, set):Bool;
	
	
	/**
	 * Set the close button default color
	 */
	
	var closeButtonNormalColor(get, set):Int;
	
	
	/**
	 * Set the close button over state color
	 */
	
	var closeButtonOverColor(get, set):Int;
	
	
	/**
	 * Set the close button down state color
	 */
	
	var closeButtonDownColor(get, set):Int;
	
	
	/**
	 * Set the close button disable state color on the button
	 */
	
	var closeButtonDisableColor(get, set):Int;
	
	
	/**
	 * Set the minimize button default color
	 */
	
	var minButtonNormalColor(get, set):Int;

	/**
	 * Set the minimize button over state color
	 */
	
	var minButtonOverColor(get, set):Int;
	
	/**
	 * Set the minimize button down state color
	 */
	
	var minButtonDownColor(get, set):Int;
	
	/**
	 * Set the minimize button disable state color
	 */
	
	var minButtonDisableColor(get, set):Int;

	
	/**
	 * Set the maximize button default color
	 */
	
	var maxButtonNormalColor(get, set):Int;
	
	/**
	 * Set the maximize button over state color
	 */
	
	var maxButtonOverColor(get, set):Int;
	
	
	/**
	 * Set the maximize button down state color
	 */
	
	var maxButtonDownColor(get, set):Int;

	
	/**
	 * Set the maximize button disable state color
	 */
	
	var maxButtonDisableColor(get, set):Int;

	
	/**
	 * Hide or Show the close button on the window
	 */
	
	var showCloseButton(get, set):Bool;
	
	/**
	 * Hide or Show the minimize button on the window
	 */
	
	var showMinButton(get, set):Bool;
	
	/**
	 * Hide or Show the maximize button on the window
	 */
	
	var showMaxButton(get, set):Bool;
	
	/**
	 * Enable or disable the close button on the window
	 */
	
	var enabledCloseButton(get, set):Bool;
	
	/**
	 * Enable or disable the minimize button on the window
	 */
	
	var enabledMinButton(get, set):Bool;
	
	/**
	 * Enable or disable the maximize button on the window
	 */
	
	var enabledMaxButton(get, set):Bool;
	
	/**
	 * Set the color of the window title area once the user select
	 */
	
	var windowTitleColor(get, set):Int;
	

	
	/**
	 * Set the color of the window
	 */
	
	var windowColor(get, set):Int;


	/**
	 * Set the size of the top right area of the window
	 */
	
	var windowTopRightSize(get, set):Int;

	
	/**
	 * Set the top center block on the window.
	 */
	
	var windowTopMiddleSize(get, set):Int;
	
	/**
	 * Set the size of the top left area of the window
	 */
	
	var windowTopLeftSize(get, set):Int;
	
	/**
	 * Set the center block on the left and right side of the window
	 */
	
	var windowMiddleSize(get, set):Int;

	
	/**
	 * Set the size of the bottom right area of the window
	 */
	
	var windowBottomRightSize(get, set):Int;
	
	
	/**
	 * Set the size of the bottom middle area of the window
	 */
	
	var windowBottomMiddleSize(get, set):Int;
	
	/**
	 * Set the size of the bottom left area of the window
	 */
	
	var windowBottomLeftSize(get, set):Int;

	
	/**
	 * Set where the window icon will be placed. The icon can only be placed on the left or right side. If there are buttons on the side selected they'll be shift to the other side of the window.
	 * For example if you set the window icon to the left side the buttons will be displayed on the right side.
	 */
	
	var iconLocation(get, set):String;

	
	/**
	 * Set where to place the label on the window. The default is center but can be placed left or right as well.
	 */
	
	var labelLocation(get, set):String;
	
	
	/**
	 * Set where the buttons will be placed. The button(s) can only be placed on the left or right side. If there is a icon on the side selected it will be shift to the other side of the window.
	 * For example if you set the window icon to the left side the buttons will be displayed on the right side. Can only passed "left" or "right" as a value.
	 */
	
	var buttonLocation(get, set):String;
	
	
	
	
	/**
	 * Set the window icon by using an image based on a bitmap
	 *
	 * @param value The URL to the image you want to use for the icon
	 *
	 * @example myWindow.setIcon("myIcon", "left");
	 *
	 */
	function setIcon(displayBitmap:BitmapData, location:String = "left"):Void;
	
	
	
	/**
	 * This set an image to the upper top left corner of the window based on a bitmap
	 *
	 * @param value The bitmap image you want to use
	 *
	 */
	
	function setWindowTopLeftImage(value:BitmapData):Void;
	
	/**
	 * This set an image to the middle of the window based on a bitmap
	 *
	 * @param value The bitmap image you want to use
	 *
	 */
	
	function setWindowTopMiddleImage(value:BitmapData):Void;
	
	/**
	 * This set an image to the upper top right corner of the window based on a bitmap
	 *
	 * @param value The bitmap image you want to use
	 *
	 */
	
	function setWindowTopRightImage(value:BitmapData):Void;
	
	
	/**
	 * This set an image to the right side of the window based on a bitmap
	 *
	 * @param value The bitmap image you want to use
	 */
	
	function setWindowMiddleRightImage(value:BitmapData):Void;
	
	/**
	 * This set an image to the left side of the window based on a bitmap
	 *
	 * @param value The bitmap image you want to use
	 */
	
	function setWindowMiddleLeftImage(value:BitmapData):Void;
	
	
	/**
	 * This set an image to the bottom lower left corner of the window based on a bitmap
	 *
	 * @param value The bitmap image you want to use
	 *
	 */
	
	function setWindowBottomLeftImage(displayBitmap:BitmapData):Void;
	
	/**
	 * This set an image to the bottom mid area of the window based on a bitmap
	 *
	 * @param value The bitmap image you want to use
	 *
	 */
	
	function setWindowBottomMiddleImage(value:BitmapData):Void;
	
	/**
	 * This set an image to the bottom lower right corner of the window based on a bitmap
	 *
	 * @param value The bitmap image you want to use
	 *
	 */
	
	function setWindowBottomRightImage(value:BitmapData):Void;
	
	/* Scales and sizes the window
	 *
	 * @param inWidth The width of the window
	 * @param inHeight The height of the window
	 *
	 * @param minWidth The smallest the user can resize the window to when it comes to the width
	 * @param minHeight The smallest the user can resize the window to when it comes to the height
	 *
	 * @example myWindow.setWindowSize(myWidth, myHeight);
	 *
	 */
	
	function setWindowSize(inWidth:Int, inHeight:Int, minWidth:Int = 0, minHeight:Int = 0):Void;
		
	/*
	 * Returns the size of the window's interior width and height
	 *
	 * @return An object with the width and height
	 */
	
	function getInsideWindowSize():Object;
	

}