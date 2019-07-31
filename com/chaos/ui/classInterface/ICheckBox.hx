package com.chaos.ui.classInterface;


interface ICheckBox extends ISelectToggle
{
	/**
	 * Set the style to "checkmark" or "x"
	 */
	
	var style(get, set) : String;
}