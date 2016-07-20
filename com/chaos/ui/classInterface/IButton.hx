package com.chaos.ui.classInterface;

import openfl.display.DisplayObject;
import openfl.display.Bitmap;
import openfl.filters.DropShadowFilter;

interface IButton extends IOverlay
{
    /**
	 * The offset of the image icon location on the X axis
	 */ 
	
	var imageOffSetX(get, set) : Int;      
	/**
	 * The offset of the image icon location on the Y axis
	 */
	var imageOffSetY(get, set) : Int;     
		/**
		 * Set the text on the button
		 */
		var label(get, set) : String;     
		/**
		 * Show or hide the label on button
		 */
		
		 var showLabel(never, set) : Bool;      
		 /**
		 * Return the label that is being used in the button
		 */
		 var textLabel(get, never) : ILabel;     
		 /**
		 * Set or return the font being used
		 */
		 var textFont(get, set) : String;     
		 /**
		 * Set to true if you want to boldface the text and false if not.
		 */ 
		 var textBold(get, set) : Bool;     
		 /**
		 * Set to true if you want to italicize  the text and false if not.
		 */ 
		 var textItalic(get, set) : Bool;     
		 /**
		 * Set the font size of the button
		 */
		 
		 var textSize(get, set) : Int;      
		 /**
		 * Set the label color
		 */
		 
		 var textColor(get, set) : Int;      
		 /**
		 * Set the label text alignment, use the Adobe TextFormatAlign class to set the label.
		 *
		 * @see openfl.text.TextFormatAlign
		 */
		 
		 var textAlign(get, set) : String;      
		 /**
		 * The button normal state color
		 */ 
		 var buttonColor(get, set) : Int;  
		 /**
		 * The button over state color
		 */   
		 
		 var buttonOverColor(get, set) : Int;    
		 /**
		 * The button down state color
		 */ 
		 
		 var buttonDownColor(get, set) : Int;   
		 /**
		 * The button disable state color
		 */   
		 var buttonDisableColor(get, set) : Int; 
		 /**
		 * Set how rounded the button is
		 */ 
		 var roundEdge(get, set) : Int;     
		 /**
		 * The alpha of the button roll over and down state. Use this if you only set the default bitmap image, this will tint the button.
		 */
		 
		 var bitmapAlpha(get, set) : Float;   
		 /**
		 * Set this if you want to display the icon
		 */    
		 var iconDisplay(get, set) : Bool;  
		 
		 /**
		 * Set this if you want to have a drop shadow on the label. The detail settings must be set to "high" in other for it to work.
		 */
		 var shadowFilter(get, set) : Bool;      
		 /**
		 * Return true if using filterMode
		 */
		 
		 var filterMode(get, set) : Bool;     
		 
		 /**
		 * Set the normal state text shadow filter
		 */
		 var shadowTextFilterDefault(get, set) : DropShadowFilter;      
		 /**
		 * Set the down state text shadow filter
		 */   
		 var shadowTextFilterDown(get, set) : DropShadowFilter;     
		 /**
		 * Set the over state text shadow filter
		 */    
		 var shadowTextFilterOver(get, set) : DropShadowFilter;   
		 /**
		 * The bevel filter that is used for the button.
		 */   
		 //var buttonBevelFilter(get, set) : BevelFilter;
		/**
		 * Set the icon that will be used on the button
		 *
		 * @param	displayObj The display object that will be used for an icon
		 */
		function setIcon(displayObj : DisplayObject) : Void;  
		/**
		 * The DisplayObject being used as the icon for the button
		 *
		 * @return A DisplayObject if there is one if not then return null
		 */
		function getIcon() : DisplayObject;
		/**
		 * Set the icon used on the button based on a URL location
		 *
		 * @param value A URL path as a string to the image. Make sure this is one of the formats the version of the Flash player your using supports.
		 *
		 */ 
		
		/**
		 * Set the icon used on the button based on a Bitmap image
		 *
		 * @param value Make sure this is one of the formats the version of the Flash player your using supports.
		 *
		 */
		
		function setIconBitmap(value : Bitmap) : Void; 
		/**
		 * This is for setting an image to the button default state. It is best to set an image that can be tile.
		 *
		 * @param value Set the image based on a URL file path.
		 *
		 */
		
		function setBackgroundImage(value : String) : Void;  
		/**
		 * This is for setting an image to the button default state. It is best to set an image that can be tiled.
		 *
		 * @param value Set the image based on a Bitmap being pass
		 *
		 */
		
		function setBackgroundBitmap(value : Bitmap) : Void;  
		/**
		 * This is for setting an image to the button roll over state. It is best to set an image that can be tiled.
		 *
		 * @param value Set the image based on a URL file path.
		 *
		 */ 
		
		function setOverBackgroundImage(value : String) : Void;  
		
		/**
		 * This is for setting an image to the button roll over state. It is best to set an image that can be tiled.
		 *
		 * @param value Set the image based on a Bitmap being pass
		 *
		 */
		
		function setOverBackgroundBitmap(value : Bitmap) : Void;  
		/**
		 * This is for setting an image to the button roll down state. It is best to set an image that can be tile.
		 *
		 * @param value Set the image based on a URL file path.
		 *
		 */
		
		function setDownBackgroundImage(value : String) : Void;  
		
		 /**
		 * This is for setting an image to the button press down state. It is best to set an image that can be tiled.
		 *
		 * @param value Set the image based on a Bitmap being pass
		 *
		 */
		 
		function setDownBackgroundBitmap(value : Bitmap) : Void;  
		/**
		 * This is for setting an image to the button disable state. It is best to set an image that can be tiled.
		 *
		 * @param value Set the image based on a URL file path.
		 *
		 */
		
		function setDisableBackgroundImage(value : String) : Void;  
		
		 /**
		 * This is for setting an image to the button disable state. It is best to set an image that can be tiled.
		 *
		 * @param value Set the image based on a Bitmap being pass
		 *
		 */ 
		 function setDisableBackgroundBitmap(value : Bitmap) : Void;
}