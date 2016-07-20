package com.chaos.ui.classInterface;

//import com.chaos.ui.Interface.ISlider;


/**
 * Interface for slider
 * @author Erick Feiling
 */

interface IProgressSlider extends com.chaos.ui.classInterface.IProgressBar
{
    
    
    /**
	 * Return the slider
	 */
    
    var slider(get, never) : com.chaos.ui.classInterface.ISlider;

}

