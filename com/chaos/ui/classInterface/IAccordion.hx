package com.chaos.ui.classInterface;
import com.chaos.ui.data.AccordionObjectData;
import com.chaos.ui.layout.classInterface.IBaseContainer;
import openfl.display.BitmapData;
import openfl.display.DisplayObject;

/**
 * @author Erick Feiling
 */

interface IAccordion extends IBaseContainer
{
	/**
	 * The current selected item
	 */
	
	var selectedSectionName(get, never) : String;	
  
	/**
	 * Default state color
	 */
	
	var buttonNormalColor(get, set) : Int;	
	
	/**
	 * Over state color
	 */
	
	var buttonOverColor(get, set ) : Int;	
	
	/**
	 * Selected state color
	 */
	
	var buttonSelectedColor(get, set) : Int;	
	
	/**
	 * Disable state color
	 */
	
	var buttonDisableColor(get, set) : Int;	
	
	
	/**
	 * Default state text color
	 */
	
	var buttonTextColor(get, set) : Int;	
	
	/**
	 * Selected state text color
	 */
	
	var buttonTextSelectedColor(get, set) : Int;	
	
	/**
	 * Adjust the height of the button
	 */
	
	var buttonSize(get, set) : Int;	
	
	/**
	 * This set the image for the over state
	 *
	 * @param value The image you want to use
	 *
	 */ 
	
	function setDefaultStateImage(value : BitmapData) : Void;
	
	/**
	 * This set the image for the over state
	 * @param	value The image you want to use
	 */
	
	function setOverStateImage(value : BitmapData) : Void;
	
	/**
	 * This set the image for the down state
	 * @param	value The image you want to use
	 */
	
	function setDownStateImage(value : BitmapData ) : Void;
	
	/**
	 * This set the image for the disable state
	 * @param	value The image you want to use
	 */
	
	function setDisableStateImage(value : BitmapData ) : Void;
	
	/**
	 * Add section
	 * @param	sectionName The name of the section
	 * @param	title The text that will show up on the button for the section
	 * @param	content The DisplayObject you want to use
	 * @param	icon The icon that will be displayed on the button
	 */
	
	function addSection(sectionName:String, title:String, content:DisplayObject, icon:BitmapData = null):Void;
	
	/**
	 * Get section data object for adjusting 
	 * @param	value Name of the section
	 * @return object that gives access to button, container and content for section
	 */
	
	function getSection( sectionName:String ) : AccordionObjectData;
	
	/**
	 * Close all menus
	 */
	function closeAll(): Void;
	
	/**
	 * Close all other sections and open one given
	 * @param	sectionName The name of the section
	 */
	
	function open( sectionName:String ) : Void;	
}