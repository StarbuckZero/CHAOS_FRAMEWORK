package com.chaos.mobile.ui.classInterface;

import com.chaos.mobile.ui.data.NavigationMenuObjectData;
import com.chaos.data.DataProvider;

/**
 * @author Erick Feiling
 */

 interface INavigationMenu extends IDragContainer
 {

    /**
    * Replace the current data provider
    */ 
	
    var dataProvider(get, set) : DataProvider<NavigationMenuObjectData>;
    
	/**
	* Always show sub menu icon if true else only show if there is sub menu
    **/
        
    var alwaysDisplaySubMenuIcon(get, set):Bool;

    
 }