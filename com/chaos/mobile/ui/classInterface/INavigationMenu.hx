package com.chaos.mobile.ui.classInterface;

import com.chaos.mobile.ui.data.NavigationMenuObjectData;
import com.chaos.data.DataProvider;

/**
 * @author Erick Feiling
 */

 interface INavigationMenu 
 {

    /**
    * Replace the current data provider
    */ 
	
    var dataProvider(get, set) : DataProvider<NavigationMenuObjectData>;
    
	/**
	* Always show sub menu icon if true else only show if there is sub menu
    **/
        
    var alwaysDisplaySubMenuIcon(get, set) : Bool;

	/**
	* Adjust the sliding animation of the buttons in menu
	**/

	var menuAnimationSpeed(get, set):Float;


    /**
    * Go to the sub menu
    * @param	data The buttons that will be created for the new sub menu being created
    */
    
    function goToSubMenu(data:DataProvider<NavigationMenuObjectData>) : Void;

    /**
    * Let Nav Menu know that a menu button was clicked.
    * @param	navButton The button that was clicked
    */
    function menuButtonClicked( navButton:NavigationMenuItem ) : Void;

    
 }