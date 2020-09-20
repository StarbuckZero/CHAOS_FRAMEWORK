package com.chaos.ui.classInterface;


/**
 * @author Erick Feiling
 */

interface IBorder extends IBaseUI
{

	/**
	 * Border color 
	 */
	 
	var lineColor(get, set):Int;

    /**
    * Border thinkness
    */
	
	 var lineThinkness(get, set):Float;

    /**
    * Border alpha
	*/
		 
	 var lineAlpha(get, set):Float;
    
}
  