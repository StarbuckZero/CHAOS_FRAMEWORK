package com.chaos.ui.classInterface;


interface IRadioButton extends ISelectToggle
{
	/**
	 * Name of group radio buttons are linked to
	 */
	var groupName(get, set) : String;
	
	/**
	 * Size of dot
	 */
	var dotSize(get, set) : Int;
	
}