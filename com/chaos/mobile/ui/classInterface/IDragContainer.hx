package com.chaos.mobile.ui.classInterface;

import com.chaos.ui.layout.classInterface.IBaseContainer;

/**
 * @author Erick Feiling
 */

 interface IDragContainer extends IBaseContainer
 {
    
	/**
	* Let you know if the user is moving
    **/
        
    var isMoving(get, never):Bool;

	/**
	* Has ever moved
    **/
        
    var hasMoved(get, never):Bool;    
    
 }