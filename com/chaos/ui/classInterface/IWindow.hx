package com.chaos.ui.classInterface;

import openfl.display.Bitmap;
import openfl.display.DisplayObject;
import openfl.display.Sprite;
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
	
	var textLabel(get, never):Label;
	
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
	 * Set the close button unfocus state color.
	 */
	
	var closeButtonUnFocusColor(get, set):Int;
	
	
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
	 * Set the minimize button unfocus state color.
	 */
	
	var minButtonUnFocusColor(get, set):Int;
	
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
	 * Set the maximize button unfocus state color.
	 */
	
	var maxButtonUnFocusColor(get, set):Int;
	
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
	
	var windowTitleFocusColor(get, set):Int;
	
	
	/**
	 * Set the color of the window title area once it is unfocused
	 */
	
	var windowTitleUnFocusColor(get, set):Int;

	
	/**
	 * Set the color of the window
	 */
	
	var windowFocusColor(get, set):Int;
	
	/**
	 * Set the color of the window once it is unfocused which is everywhere but the title area
	 */
	
	var windowUnFocusColor(get, set):Int;

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
	 * Anything that is added to this sprite goes in back of the window. All objects start at top left hand side of the window.
	 */
	
	var windowBackDrop(get, never):Sprite;
	
	/**
	 * Anything that is added to this sprite goes in front of the window. All objects start at top left hand side of the window.
	 */
	
	var windowFrontOverlay(get, never):Sprite;
	
	/**
	 * This is for setting an image to the close button default state. It is best to set an image that can be tiled.
	 *
	 * @param value Set the image based on a URL file path.
	 *
	 */
	
	function setCloseButtonImage(value:String):Void;
	
	/**
	 * This is for setting an image to the close button default state. It is best to set an image that can be tiled.
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	
	function setCloseButtonBitmap(value:Bitmap):Void;
	
	/**
	 * This is for setting an image to the close button roll over state. It is best to set an image that can be tiled.
	 *
	 * @param value Set the image based on a URL file path.
	 *
	 */
	
	function setCloseOverButtonImage(value:String):Void;
	
	/**
	 * This is for setting an image to the close button roll over state. It is best to set an image that can be tiled.
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	
	function setCloseOverButtonBitmap(value:Bitmap):Void;
	
	/**
	 * This is for setting an image to the close button press down state. It is best to set an image that can be tiled.
	 *
	 * @param value Set the image based on a URL file path.
	 *
	 */
	
	function setCloseDownButtonImage(value:String):Void;
	
	/**
	 * This is for setting an image to the close button roll press state. It is best to set an image that can be tiled.
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	
	function setCloseDownButtonBitmap(value:Bitmap):Void;
	
	/**
	 * This is for setting an image to the close button disable state. It is best to set an image that can be tiled.
	 *
	 * @param value Set the image based on a URL file path.
	 *
	 */
	
	function setCloseDisableButtonImage(value:String):Void;
	
	/**
	 * This is for setting an image to the button disable state. It is best to set an image that can be tiled.
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	
	function setCloseDisableButtonBitmap(value:Bitmap):Void;
	
	/**
	 * This is for setting an image to the minimize button default state. It is best to set an image that can be tiled.
	 *
	 * @param value Set the image based on a URL file path.
	 *
	 */
	
	function setMinButtonImage(value:String):Void;
	
	/**
	 * This is for setting an image to the minimize button default state. It is best to set an image that can be tiled.
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	
	function setMinButtonBitmap(value:Bitmap):Void;
	
	/**
	 * This is for setting an image to the minimize button roll over state. It is best to set an image that can be tiled.
	 *
	 * @param value Set the image based on a URL file path.
	 *
	 */
	
	function setMinOverButtonImage(value:String):Void;
	
	/**
	 * This is for setting an image to the minimize button roll over state. It is best to set an image that can be tiled.
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	
	function setMinOverButtonBitmap(value:Bitmap):Void;
	
	/**
	 * This is for setting an image to the minimize button press down state. It is best to set an image that can be tiled.
	 *
	 * @param value Set the image based on a URL file path.
	 *
	 */
	
	function setMinDownButtonImage(value:String):Void;
	
	/**
	 * This is for setting an image to the minimize button roll press state. It is best to set an image that can be tiled.
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	
	function setMinDownButtonBitmap(value:Bitmap):Void;
	
	/**
	 * This is for setting an image to the minimize button disable state. It is best to set an image that can be tiled.
	 *
	 * @param value Set the image based on a URL file path.
	 *
	 */
	
	function setMinDisableButtonImage(value:String):Void;
	
	/**
	 * This is for setting an image to the minimize button roll press state. It is best to set an image that can be tiled.
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	
	function setMinDisableButtonBitmap(value:Bitmap):Void;
	
	/**
	 * This is for setting an image to the maximize button default state. It is best to set an image that can be tiled.
	 *
	 * @param value Set the image based on a URL file path.
	 *
	 */
	
	function setMaxButtonImage(value:String):Void;
	
	/**
	 * This is for setting an image to the maximize button default state. It is best to set an image that can be tiled.
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	
	function setMaxButtonBitmap(value:Bitmap):Void;
	
	/**
	 * This is for setting an image to the maximize button roll over state. It is best to set an image that can be tiled.
	 *
	 * @param value Set the image based on a URL file path.
	 *
	 */
	
	function setMaxOverButtonImage(value:String):Void;
	
	/**
	 * This is for setting an image to the maximize button roll over state. It is best to set an image that can be tiled.
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	
	function setMaxOverButtonBitmap(value:Bitmap):Void;
	
	/**
	 * This is for setting an image to the maximize button press down state. It is best to set an image that can be tiled.
	 *
	 * @param value Set the image based on a URL file path.
	 *
	 */
	
	function setMaxDownButtonImage(value:String):Void;
	
	/**
	 * This is for setting an image to the maximize button roll press state. It is best to set an image that can be tiled.
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	
	function setMaxDownButtonBitmap(value:Bitmap):Void;
	
	/**
	 * This is for setting an image to the maximize button disable state. It is best to set an image that can be tiled.
	 *
	 * @param value Set the image based on a URL file path.
	 *
	 */
	
	function setMaxDisableButtonImage(value:String):Void;
	
	/**
	 * This is for setting an image to the maximize button disable state. It is best to set an image that can be tiled.
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	
	function setMaxDisableButtonBitmap(value:Bitmap):Void;	
	
	/**
	 * Sets the title of the window
	 *
	 * @param value The name of what you want to set the window to
	 *
	 * @example myWindow.setTitle("My Window");
	 *
	 */
	
	function setWindowTitle(value:String):Void;
	
	/**
	 * Return the Window title
	 *
	 * @return Return the text that inside the label
	 *
	 */
	
	function getWindowTitle():String;
	
	/**
	 * Set the window icon by using an image based on a URL
	 *
	 * @param value The bitmap you want to use for the icon
	 *
	 * @example myWindow.setIconBitmap("myIcon", "left");
	 *
	 */
	
	function setIcon(value:String, location:String = "left"):Void;
	
	/**
	 * Set the window icon by using an image based on a bitmap
	 *
	 * @param value The URL to the image you want to use for the icon
	 *
	 * @example myWindow.setIcon("myIcon", "left");
	 *
	 */
	function setIconBitmap(displayBitmap:Bitmap, location:String = "left"):Void;
	
	/**
	 * This set an image to the middle of the window based on a URL
	 *
	 * @param value The URL path to the image you want to use
	 *
	 */
	
	function setWindowTopMiddle(value:String):Void;
	
	/**
	 * This set an image to the upper top right corner of the window based on a URL
	 *
	 * @param value The URL path to the image you want to use
	 *
	 */
	
	function setWindowTopRight(value:String):Void;
	
	/**
	 * This set an image to the upper top left corner of the window based on a URL
	 *
	 * @param value The URL path to the image you want to use
	 *
	 */
	
	function setWindowTopLeft(value:String):Void;
	
	/**
	 * This set an image to the upper top left corner of the window based on a bitmap
	 *
	 * @param value The bitmap image you want to use
	 *
	 */
	
	function setWindowTopLeftImage(value:Bitmap):Void;
	
	/**
	 * This set an image to the middle of the window based on a bitmap
	 *
	 * @param value The bitmap image you want to use
	 *
	 */
	
	function setWindowTopMiddleImage(value:Bitmap):Void;
	
	/**
	 * This set an image to the upper top right corner of the window based on a bitmap
	 *
	 * @param value The bitmap image you want to use
	 *
	 */
	
	function setWindowTopRightImage(value:Bitmap):Void;
	
	/**
	 * This set an image to the right side of the window based on a URL
	 *
	 * @param value The URL path to the image you want to use
	 *
	 */
	
	function setWindowMiddleRight(value:String):Void;
	
	/**
	 * This set an image to the left side of the window based on a URL
	 *
	 * @param value The URL path to the image you want to use
	 *
	 */
	
	function setWindowMiddleLeft(value:String):Void;
	
	/**
	 * This set an image to the right side of the window based on a bitmap
	 *
	 * @param value The bitmap image you want to use
	 */
	
	function setWindowMiddleRightImage(value:Bitmap):Void;
	
	/**
	 * This set an image to the left side of the window based on a bitmap
	 *
	 * @param value The bitmap image you want to use
	 */
	
	function setWindowMiddleLeftImage(value:Bitmap):Void;
	
	/**
	 * This set an image to the bottom lower left corner of the window based on a URL
	 *
	 * @param value The URL path to the image you want to use
	 *
	 */
	
	function setWindowBottomLeft(value:String):Void;
	
	/**
	 * This set an image to the bottom mid area of the window based on a URL
	 *
	 * @param value The URL path to the image you want to use
	 *
	 */
	
	function setWindowBottomMiddle(value:String):Void;
	
	/**
	 * This set an image to the bottom lower right corner of the window based on a URL
	 *
	 * @param value The URL path to the image you want to use
	 *
	 */
	
	function setWindowBottomRight(value:String):Void;
	
	/**
	 * This set an image to the bottom lower left corner of the window based on a bitmap
	 *
	 * @param value The bitmap image you want to use
	 *
	 */
	
	function setWindowBottomLeftImage(displayBitmap:Bitmap):Void;
	
	/**
	 * This set an image to the bottom mid area of the window based on a bitmap
	 *
	 * @param value The bitmap image you want to use
	 *
	 */
	
	function setWindowBottomMiddleImage(value:Bitmap):Void;
	
	/**
	 * This set an image to the bottom lower right corner of the window based on a bitmap
	 *
	 * @param value The bitmap image you want to use
	 *
	 */
	
	function setWindowBottomRightImage(value:Bitmap):Void;
	
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
	

	
	/**
	 * Set the icon on a button
	 *
	 * @param	buttonName The button you want to apply the setting to min, max or close
	 * @param	displayObj The icon you want to set
	 */
	
	function setButtonIcon(buttonName:String, displayObj:DisplayObject):Void;	
	
	/**
	 * Set the icon on a button
	 *
	 * @param	buttonName The button you want to apply the setting to min, max or close
	 * @param	displayObj The bitmap that will be used for the icon
	 */
	
	function setButtonIconBitmap(buttonName:String, bitmap:Bitmap):Void;
	
	/**
	 * Set the icon on a button
	 *
	 * @param	buttonName The button you want to apply the setting to min, max or close
	 * @param	displayObj The url location of the image file
	 */
	
	function setButtonIconURL(buttonName:String, fileURL:String):Void;	
}