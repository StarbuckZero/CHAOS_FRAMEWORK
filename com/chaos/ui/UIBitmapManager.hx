package com.chaos.ui;


import openfl.errors.Error;
import openfl.utils.Object;
import openfl.display.Bitmap;
import openfl.display.DisplayObject;

import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.data.DataProvider;
import com.chaos.utils.Debug;

/**
 * Setting to texture class files
 *
 * @author Erick Feiling
 */

class UIBitmapManager
{
    
    public static inline var ALERT_BACKGROUND : String = "alert_background";
    
    public static inline var ALERT_TOP_LEFT : String = "alert_top_left";
    public static inline var ALERT_TOP_MIDDLE : String = "alert_top_middle";
    public static inline var ALERT_TOP_RIGHT : String = "alert_top_right";
    
    public static inline var ALERT_MIDDLE_LEFT : String = "alert_middle_left";
    public static inline var ALERT_MIDDLE_RIGHT : String = "alert_middle_right";
    
    public static inline var ALERT_BOTTOM_LEFT : String = "alert_bottom_left";
    public static inline var ALERT_BOTTOM_MIDDLE : String = "alert_bottom_middle";
    public static inline var ALERT_BOTTOM_RIGHT : String = "alert_bottom_right";
    
    public static inline var ALERT_TOP_PATTERN_OVERLAY : String = "alert_top_pattern_overlay";
    public static inline var ALERT_MIDDLE_PATTERN_OVERLAY : String = "alert_middle_pattern_overlay";
    public static inline var ALERT_BOTTOM_PATTERN_OVERLAY : String = "alert_bottom_pattern_overlay";
    
    /** This doesn't have to be a bitmap, it can be any form of a DisplayObject */
    public static inline var ALERT_TOP_PATTERN_LEFT_MASK : String = "alert_top_pattern_left_mask";
    
    /** This doesn't have to be a bitmap, it can be any form of a DisplayObject */
    public static inline var ALERT_TOP_PATTERN_CENTER_MASK : String = "alert_top_pattern_left_mask";
    
    /** This doesn't have to be a bitmap, it can be any form of a DisplayObject */
    public static inline var ALERT_TOP_PATTERN_RIGHT_MASK : String = "alert_top_pattern_right_mask";
    
    /** This doesn't have to be a bitmap, it can be any form of a DisplayObject */
    public static inline var ALERT_MIDDLE_PATTERN_LEFT_MASK : String = "alert_middle_pattern_left_mask";
    
    /** This doesn't have to be a bitmap, it can be any form of a DisplayObject */
    public static inline var ALERT_MIDDLE_PATTERN_CENTER_MASK : String = "alert_middle_pattern_center_mask";
    
    /** This doesn't have to be a bitmap, it can be any form of a DisplayObject */
    public static inline var ALERT_MIDDLE_PATTERN_RIGHT_MASK : String = "alert_middle_pattern_right_mask";
    
    /** This doesn't have to be a bitmap, it can be any form of a DisplayObject */
    public static inline var ALERT_BOTTOM_PATTERN_LEFT_MASK : String = "alert_bottom_pattern_left_mask";
    
    /** This doesn't have to be a bitmap, it can be any form of a DisplayObject */
    public static inline var ALERT_BOTTOM_PATTERN_CENTER_MASK : String = "alert_bottom_pattern_center_mask";
    
    /** This doesn't have to be a bitmap, it can be any form of a DisplayObject */
    public static inline var ALERT_BOTTOM_PATTERN_RIGHT_MASK : String = "alert_bottom_pattern_right_mask";
    
    public static inline var ALERT_CLOSE_BUTTON_NORMAL : String = "alert_close_button_normal";
    public static inline var ALERT_CLOSE_BUTTON_OVER : String = "alert_close_button_over";
    public static inline var ALERT_CLOSE_BUTTON_DOWN : String = "alert_close_button_down";
    public static inline var ALERT_CLOSE_BUTTON_DISABLE : String = "alert_close_button_disable";
    
    public static inline var ALERT_POSITIVE_BUTTON_NORMAL : String = "alert_positive_button_normal";
    public static inline var ALERT_POSITIVE_BUTTON_OVER : String = "alert_positive_button_over";
    public static inline var ALERT_POSITIVE_BUTTON_DOWN : String = "alert_positive_button_down";
    
    public static inline var ALERT_NEGATIVE_BUTTON_NORMAL : String = "alert_negative_button_normal";
    public static inline var ALERT_NEGATIVE_BUTTON_OVER : String = "alert_negative_button_over";
    public static inline var ALERT_NEGATIVE_BUTTON_DOWN : String = "alert_negative_button_down";
    
    public static inline var ALERT_NEUTRAL_BUTTON_NORMAL : String = "alert_neutral_button_normal";
    public static inline var ALERT_NEUTRAL_BUTTON_OVER : String = "alert_neutral_button_over";
    public static inline var ALERT_NEUTRAL_BUTTON_DOWN : String = "alert_neutral_button_down";
    
    public static inline var BUBBLE_OVERLAY_TOP_LEFT : String = "bubble_overlay_top_left";
    public static inline var BUBBLE_OVERLAY_TOP_MIDDLE : String = "bubble_overlay_top_middle";
    public static inline var BUBBLE_OVERLAY_TOP_RIGHT : String = "bubble_overlay_top_right";
    
    public static inline var BUBBLE_OVERLAY_MIDDLE_LEFT : String = "bubble_overlay_middle_left";
    public static inline var BUBBLE_OVERLAY_MIDDLE_RIGHT : String = "bubble_overlay_middle_right";
    
    public static inline var BUBBLE_OVERLAY_BOTTOM_LEFT : String = "bubble_overlay_bottom_left";
    public static inline var BUBBLE_OVERLAY_BOTTOM_MIDDLE : String = "bubble_overlay_bottom_middle";
    public static inline var BUBBLE_OVERLAY_BOTTOM_RIGHT : String = "bubble_overlay_bottom_right";
    
    public static inline var BUBBLE_BACKGROUND : String = "bubble_background";
    
    public static inline var BUTTON_NORMAL : String = "button_normal";
    public static inline var BUTTON_OVER : String = "button_over";
    public static inline var BUTTON_DOWN : String = "button_down";
    public static inline var BUTTON_DISABLE : String = "button_disable";
    
    public static inline var CHECKBOX_NORMAL : String = "checkbox_normal";
    public static inline var CHECKBOX_OVER : String = "checkbox_over";
    public static inline var CHECKBOX_DOWN : String = "checkbox_down";
    public static inline var CHECKBOX_DISABLE : String = "checkbox_disable";
    
    public static inline var RADIOBUTTON_NORMAL : String = "radiobutton_normal";
    public static inline var RADIOBUTTON_OVER : String = "radiobutton_over";
    public static inline var RADIOBUTTON_DOWN : String = "radiobutton_down";
    public static inline var RADIOBUTTON_DISABLE : String = "radiobutton_disable";
    
    public static inline var COMBO_BUTTON_NORMAL : String = "combo_button_normal";
    public static inline var COMBO_BUTTON_OVER : String = "combo_button_over";
    public static inline var COMBO_BUTTON_DOWN : String = "combo_button_down";
    public static inline var COMBO_BUTTON_DISABLE : String = "combo_button_disable";
    
    public static inline var COMBO_BUTTON_DROPDOWN_ICON : String = "combo_button_icon";
    
    public static inline var COMBO_BACKGROUND : String = "combo_background";
    public static inline var COMBO_DROPDOWN_BACKGROUND : String = "combo_dropdown_background";
    
    public static inline var LIST_BACKGROUND : String = "list_background";
    
    public static inline var GRIDPANE_BACKGROUND : String = "grid_panel_background";
    
    public static inline var GRIDPANE_BUTTON_NORMAL : String = "grid_button_normal";
    public static inline var GRIDPANE_BUTTON_OVER : String = "grid_button_over";
    public static inline var GRIDPANE_BUTTON_DOWN : String = "grid_button_down";
    
    public static inline var GRIDPANE_CELL_BACKGROUND : String = "grid_cell_background";
    
    public static inline var ITEMPANE_BACKGROUND : String = "itempane_background";
    
    public static inline var ITEMPANE_ITEM_NORMAL : String = "itempane_item_normal";
    public static inline var ITEMPANE_ITEM_OVER : String = "itempane_item_over";
    public static inline var ITEMPANE_ITEM_SELECTED : String = "itempane_item_selected";
    public static inline var ITEMPANE_ITEM_DISABLE : String = "itempane_item_disable";
    
    public static inline var ITEMPANE_NOT_LOADED : String = "item_pane_item_not_loaded";
    
    public static inline var PROGRESSBAR_BACKGROUND : String = "progress_background";
    public static inline var PROGRESSBAR_LOADED_BACKGROUND : String = "progress_loaded_background";
    
    public static inline var PROGRESS_SLIDER_BACKGROUND : String = "progress_slider_background";
    public static inline var PROGRESS_SLIDER_LOADED_BACKGROUND : String = "progress_slider_loaded_background";
    
    public static inline var PROGRESS_SLIDER_BUTTON_NORMAL : String = "progress_slider_button_normal";
    public static inline var PROGRESS_SLIDER_BUTTON_OVER : String = "progress_slider_button_over";
    public static inline var PROGRESS_SLIDER_BUTTON_DOWN : String = "progress_slider_button_down";
    public static inline var PROGRESS_SLIDER_BUTTON_DISABLE : String = "progress_slider_button_disable";
    
    public static inline var SCROLLBAR_UP_ICON : String = "scrollbar_up_icon";
    public static inline var SCROLLBAR_DOWN_ICON : String = "scrollbar_down_icon";
    
    public static inline var SCROLLBAR_SLIDER_BUTTON_NORMAL : String = "scrollbar_slider_button_normal";
    public static inline var SCROLLBAR_SLIDER_BUTTON_OVER : String = "scrollbar_slider_button_over";
    public static inline var SCROLLBAR_SLIDER_BUTTON_DOWN : String = "scrollbar_slider_button_down";
    public static inline var SCROLLBAR_SLIDER_BUTTON_DISABLE : String = "scrollbar_slider_button_disable";
    
    public static inline var SCROLLBAR_BUTTON_NORMAL : String = "scrollbar_button_normal";
    public static inline var SCROLLBAR_BUTTON_OVER : String = "scrollbar_button_over";
    public static inline var SCROLLBAR_BUTTON_DOWN : String = "scrollbar_button_down";
    public static inline var SCROLLBAR_BUTTON_DISABLE : String = "scrollbar_button_disable";
    
    public static inline var SCROLLBAR_TRACK : String = "scrollbar_track";
    
    public static inline var SCROLLPANE_BACKGROUND : String = "scrollpane_background";
    
    public static inline var SLIDER_BUTTON_NORMAL : String = "slider_button_normal";
    public static inline var SLIDER_BUTTON_OVER : String = "slider_button_over";
    public static inline var SLIDER_BUTTON_DOWN : String = "slider_button_down";
    public static inline var SLIDER_BUTTON_DISABLE : String = "slider_button_disable";
    
    public static inline var SLIDER_TRACK : String = "slider_track";
    
    public static inline var TABPANE_BACKGROUND : String = "tabpane_background";
    
    public static inline var TABPANE_BUTTON_NORMAL : String = "tabpane_button_normal";
    public static inline var TABPANE_BUTTON_OVER : String = "tabpane_button_over";
    public static inline var TABPANE_BUTTON_DISABLE : String = "tabpane_button_disable";
    public static inline var TABPANE_BUTTON_SELECTED : String = "tabpane_button_selected";
    
    public static inline var TEXTINPUT_NORMAL : String = "textinput_normal";
    public static inline var TEXTINPUT_OVER : String = "textinput_over";
    public static inline var TEXTINPUT_SELECTED : String = "textinput_selected";
    public static inline var TEXTINPUT_DISABLE : String = "textinput_disable";
    
    public static inline var TOOLTIP_BACKGROUND : String = "tooltip_background";
    
    public static inline var TOOLTIP_OVERLAY_TOP_LEFT : String = "tooltip_overlay_top_left";
    public static inline var TOOLTIP_OVERLAY_TOP_MIDDLE : String = "tooltip_overlay_top_middle";
    public static inline var TOOLTIP_OVERLAY_TOP_RIGHT : String = "tooltip_overlay_top_right";
    
    public static inline var TOOLTIP_OVERLAY_MIDDLE_LEFT : String = "tooltip_overlay_middle_left";
    public static inline var TOOLTIP_OVERLAY_MIDDLE_RIGHT : String = "tooltip_overlay_middle_right";
    
    public static inline var TOOLTIP_OVERLAY_BOTTOM_LEFT : String = "tooltip_overlay_bottom_left";
    public static inline var TOOLTIP_OVERLAY_BOTTOM_MIDDLE : String = "tooltip_overlay_bottom_middle";
    public static inline var TOOLTIP_OVERLAY_BOTTOM_RIGHT : String = "tooltip_overlay_bottom_right";
    
    public static inline var MENU_BACKGROUND : String = "menu_background";
    
    public static inline var MENU_BUTTON_NORMAL : String = "menu_button_normal";
    public static inline var MENU_BUTTON_OVER : String = "menu_button_over";
    public static inline var MENU_BUTTON_DOWN : String = "menu_button_down";
    public static inline var MENU_BUTTON_DISABLE : String = "menu_button_disable";
    
    public static inline var MENU_BUTTON_ICON : String = "menu_button_icon";
    public static inline var MENU_BUTTON_SUB_MENU_DROPDOWN : String = "menu_button_sub_menu_dropdown";
    
    public static inline var MENU_SUB_BUTTON_NORMAL : String = "menu_sub_button_normal";
    public static inline var MENU_SUB_BUTTON_OVER : String = "menu_sub_button_over";
    public static inline var MENU_SUB_BUTTON_DOWN : String = "menu_sub_button_down";
    public static inline var MENU_SUB_BUTTON_DISABLE : String = "menu_sub_button_disable";
    
    public static inline var MENU_SUB_BUTTON_ICON : String = "menu_sub_button_icon";
    
    public static inline var WINDOW_BACKGROUND : String = "window_background";
    
    public static inline var WINDOW_CLOSE_BUTTON_NORMAL : String = "window_close_button_normal";
    public static inline var WINDOW_CLOSE_BUTTON_OVER : String = "window_close_button_over";
    public static inline var WINDOW_CLOSE_BUTTON_DOWN : String = "window_close_button_down";
    public static inline var WINDOW_CLOSE_BUTTON_DISABLE : String = "window_close_button_disable";
    
    public static inline var WINDOW_MIN_BUTTON_NORMAL : String = "window_min_button_normal";
    public static inline var WINDOW_MIN_BUTTON_OVER : String = "window_min_button_over";
    public static inline var WINDOW_MIN_BUTTON_DOWN : String = "window_min_button_down";
    public static inline var WINDOW_MIN_BUTTON_DISABLE : String = "window_min_button_disable";
    
    public static inline var WINDOW_MAX_BUTTON_NORMAL : String = "window_max_button_normal";
    public static inline var WINDOW_MAX_BUTTON_OVER : String = "window_max_button_over";
    public static inline var WINDOW_MAX_BUTTON_DOWN : String = "window_max_button_down";
    public static inline var WINDOW_MAX_BUTTON_DISABLE : String = "window_max_button_disable";
    
    public static inline var WINDOW_TOP_LEFT : String = "window_top_left";
    public static inline var WINDOW_TOP_MIDDLE : String = "window_top_middle";
    public static inline var WINDOW_TOP_RIGHT : String = "window_top_right";
    
    public static inline var WINDOW_MIDDLE_LEFT : String = "window_middle_left";
    public static inline var WINDOW_MIDDLE_RIGHT : String = "window_middle_right";
    
    public static inline var WINDOW_BOTTOM_LEFT : String = "window_bottom_left";
    public static inline var WINDOW_BOTTOM_MIDDLE : String = "window_bottom_middle";
    public static inline var WINDOW_BOTTOM_RIGHT : String = "window_bottom_right";
    
    public static inline var WINDOW_UNFOCUS_TOP_LEFT : String = "window_unfocus_top_left";
    public static inline var WINDOW_UNFOCUS_TOP_MIDDLE : String = "window_unfocus_top_middle";
    public static inline var WINDOW_UNFOCUS_TOP_RIGHT : String = "window_unfocus_top_right";
    
    public static inline var WINDOW_UNFOCUS_MIDDLE_LEFT : String = "window_unfocus_middle_left";
    public static inline var WINDOW_UNFOCUS_MIDDLE_RIGHT : String = "window_unfocus_middle_right";
    
    public static inline var WINDOW_UNFOCUS_BOTTOM_LEFT : String = "window_unfocus_bottom_left";
    public static inline var WINDOW_UNFOCUS_BOTTOM_MIDDLE : String = "window_unfocus_bottom_middle";
    public static inline var WINDOW_UNFOCUS_BOTTOM_RIGHT : String = "window_unfocus_bottom_right";
    
    public static inline var WINDOW_TOP_PATTERN_OVERLAY : String = "window_top_pattern_overlay";
    public static inline var WINDOW_MIDDLE_PATTERN_OVERLAY : String = "window_middle_pattern_overlay";
    public static inline var WINDOW_BOTTOM_PATTERN_OVERLAY : String = "window_bottom_pattern_overlay";
    
    /** This doesn't have to be a bitmap, it can be any form of a DisplayObject */
    public static inline var WINDOW_TOP_PATTERN_LEFT_MASK : String = "window_top_pattern_left_mask";
    
    /** This doesn't have to be a bitmap, it can be any form of a DisplayObject */
    public static inline var WINDOW_TOP_PATTERN_CENTER_MASK : String = "window_top_pattern_center_mask";
    
    /** This doesn't have to be a bitmap, it can be any form of a DisplayObject */
    public static inline var WINDOW_TOP_PATTERN_RIGHT_MASK : String = "window_top_pattern_right_mask";
    
    /** This doesn't have to be a bitmap, it can be any form of a DisplayObject */
    public static inline var WINDOW_MIDDLE_PATTERN_LEFT_MASK : String = "window_middle_pattern_left_mask";
    
    /** This doesn't have to be a bitmap, it can be any form of a DisplayObject */
    public static inline var WINDOW_MIDDLE_PATTERN_CENTER_MASK : String = "window_middle_pattern_center_mask";
    
    /** This doesn't have to be a bitmap, it can be any form of a DisplayObject */
    public static inline var WINDOW_MIDDLE_PATTERN_RIGHT_MASK : String = "window_middle_pattern_right_mask";
    
    /** This doesn't have to be a bitmap, it can be any form of a DisplayObject */
    public static inline var WINDOW_BOTTOM_PATTERN_LEFT_MASK : String = "window_bottom_pattern_left_mask";
    
    /** This doesn't have to be a bitmap, it can be any form of a DisplayObject */
    public static inline var WINDOW_BOTTOM_PATTERN_CENTER_MASK : String = "window_bottom_pattern_center_mask";
    
    /** This doesn't have to be a bitmap, it can be any form of a DisplayObject */
    public static inline var WINDOW_BOTTOM_PATTERN_RIGHT_MASK : String = "window_bottom_pattern_right_mask";
    
    private static var initialize : Bool = false;
    private static var skinTheme : Dynamic;
    
    private static var watchList : Dynamic; 
    
    public function new()
    {
        
    }
    
    private static function init() : Void
    {
        skinTheme = { };
		Reflect.setField(skinTheme, Alert.TYPE, { } );
        Reflect.setField(skinTheme, Bubble.TYPE, { } );
        Reflect.setField(skinTheme, Button.TYPE, { } );
        Reflect.setField(skinTheme, ToggleButtonLite.TYPE, { } );
        Reflect.setField(skinTheme, CheckBox.TYPE, { } );
        Reflect.setField(skinTheme, ComboBox.TYPE, { } );
        Reflect.setField(skinTheme, Label.TYPE, { } );
        Reflect.setField(skinTheme, ListBox.TYPE, { } );
        Reflect.setField(skinTheme, ProgressBar.TYPE, { } );
        Reflect.setField(skinTheme, RadioButton.TYPE, { } );
        Reflect.setField(skinTheme, ScrollBar.TYPE, { } );
        Reflect.setField(skinTheme, ScrollPane.TYPE, { } );
        Reflect.setField(skinTheme, Slider.TYPE, { } );
        Reflect.setField(skinTheme, TabPane.TYPE, { } );
        Reflect.setField(skinTheme, TextInput.TYPE, { } );
        Reflect.setField(skinTheme, Window.TYPE, { } );
        Reflect.setField(skinTheme, ItemPane.TYPE, { } );
        Reflect.setField(skinTheme, GridPane.TYPE, { } );
        Reflect.setField(skinTheme, ProgressSlider.TYPE, { } );
        Reflect.setField(skinTheme, Menu.TYPE, { } );
		
		
        
		watchList = { };
		Reflect.setField(watchList, Alert.TYPE, new DataProvider() );
        Reflect.setField(watchList, Bubble.TYPE, new DataProvider() );
        Reflect.setField(watchList, Button.TYPE, new DataProvider() );
        Reflect.setField(watchList, ToggleButtonLite.TYPE, new DataProvider() );
        Reflect.setField(watchList, CheckBox.TYPE, new DataProvider() );
        Reflect.setField(watchList, ComboBox.TYPE, new DataProvider() );
        Reflect.setField(watchList, Label.TYPE, new DataProvider() );
        Reflect.setField(watchList, ListBox.TYPE, new DataProvider() );
        Reflect.setField(watchList, ProgressBar.TYPE, new DataProvider() );
        Reflect.setField(watchList, RadioButton.TYPE, new DataProvider() );
        Reflect.setField(watchList, ScrollBar.TYPE, new DataProvider() );
        Reflect.setField(watchList, ScrollPane.TYPE, new DataProvider() );
        Reflect.setField(watchList, Slider.TYPE, new DataProvider() );
        Reflect.setField(watchList, TabPane.TYPE, new DataProvider() );
        Reflect.setField(watchList, TextInput.TYPE, new DataProvider() );
        Reflect.setField(watchList, Window.TYPE, new DataProvider() );
        Reflect.setField(watchList, ItemPane.TYPE, new DataProvider() );
        Reflect.setField(watchList, GridPane.TYPE, new DataProvider() );
        Reflect.setField(watchList, ProgressSlider.TYPE,new DataProvider() );
        Reflect.setField(watchList, Menu.TYPE, new DataProvider() );		

        
        initialize = true;
    }
    
    /**
	 * When ever ui bitmap object has been change it will be updated
	 *
	 * @param 	UITypeElement The UI class type
	 * @param	displayObj The UI class that will be watched
	 */
    
    public static function watchElement(UITypeElement : String, displayObj : DisplayObject) : Void
    {
        // Make sure everything is setup
        if (!initialize) 
            init();
        
        try
        {
            Reflect.field(watchList, UITypeElement).addItem(displayObj);
        }
		catch (error : Error)
        {
            Debug.print("[UIBitmapManager::watchElement] Fail to add object type " + UITypeElement + " to watch list.");
        }
    }
    
    /**
	 * Stop watching the UI element
	 *
	 * @param	UITypeElement The UI class type
	 * @param	displayObj The UI class that will be watched
	 */
    
    public static function stopWatchElement(UITypeElement : String, displayObj : DisplayObject) : Void
    {
        // Make sure everything is setup
        if (!initialize) 
            init();
        
        try
        {
            Reflect.field(watchList, UITypeElement).removeItem(displayObj);
        } 
		catch (error : Error)
        {
            Debug.print("[UIBitmapManager::stopWatchElement] Fail to remove object type " + UITypeElement + " to watch list.");
        }
    }
    
    /**
	 * This will reskin all the elements in a given list
	 *
	 * @param	UITypeElement
	 */
    
    public static function updateUIElement(UITypeElement : String) : Void
    {
        var uiList : DataProvider = Reflect.field(watchList, UITypeElement);
        
        for (i in 0...uiList.length)
		{
            cast(uiList.getItemAt(i), IBaseUI).reskin();
            cast(uiList.getItemAt(i), IBaseUI).draw();
        }
    }
    
    /**
	 * This is to set a apply an element skin type
	 *
	 * @param	UITypeElement The type of UI Element
	 * @param	style The part of the UI Element you want to skin
	 * @param	bitmap The Image you want to apply to the object
	 * @param	updateElement If true it will update all UI elements of given type
	 *
	 * @example UIBitmapManager.setUIElement(Button.TYPE, UIBitmapManager.BUTTON_NORMAL, btnNormalImageBitmap );
	 */
    
    public static function setUIElement(UITypeElement : String, style : String, bitmap : Bitmap, updateElement : Bool = true) : Void
    {
        
        // Make sure everything is setup
        if (!initialize) 
            init();
        
        Reflect.setField(Reflect.field(skinTheme, UITypeElement), style, bitmap);
        
        // Update UI Elements based on type
        if (updateElement) 
            updateUIElement(UITypeElement);
    }
    
    /**
	 * This is for applying overlay mask to the ui classes.
	 *
	 * @param	UITypeElement The type of UI Element
	 * @param	style The part of the UI Element you want to skin
	 * @param	mask Any form of a DisplayObject you want to use for a mask
	 */
    
    public static function setUIElementMask(UITypeElement : String, style : String, mask : DisplayObject) : Void
    {
        // Make sure everything is setup
        if (!initialize) 
            init();
        
        Reflect.setField(Reflect.field(skinTheme, UITypeElement), style, mask);
    }
    
    /**
	 * Gets the bitmap that is being used for skinning a UI element
	 *
	 * @param	UITypeElement The type of UI Element
	 * @param	style The part of the UI Element you want
	 *
	 * @return Returns a bitmap object or null
	 *
	 * @example UIBitmapManager.getUIElement(CheckBox.TYPE, UIBitmapManager.CHECK_BUTTON_NORMAL );
	 */
    
    public static function getUIElement(UITypeElement : String, style : String) : Bitmap
    {
        
        // Make sure everything is setup
        if (!initialize) 
            init();
        
        return ((null == Reflect.field(Reflect.field(skinTheme, UITypeElement), style))) ? null : Reflect.field(Reflect.field(skinTheme, UITypeElement), style);
    }
    
    /**
	 * Gets the mask that is being used for skinning a UI element
	 *
	 * @param	UITypeElement The type of UI Element
	 * @param	style The part of the UI Element you want
	 *
	 * @return Returns a DisplayObject or null
	 *
	 * @example UIBitmapManager.getUIElement(CheckBox.TYPE, UIBitmapManager.CHECK_BUTTON_NORMAL );
	 */
    
    public static function getUIElementMask(UITypeElement : String, style : String) : DisplayObject
    {
        
        // Make sure everything is setup
        if (!initialize) 
            init();
        
        return ((null == Reflect.field(Reflect.field(skinTheme, UITypeElement), style))) ? null : Reflect.field(Reflect.field(skinTheme, UITypeElement), style);
    }
    
    /**
	 *
	 * Remove the bitmap or mask objects that was being used to skin UI Elements
	 *
	 * @param	UIElement The type of UI Element
	 * @param	type The part of the UI Element you want to remove
	 *
	 * @example UIBitmapManager.removeUIElement(CheckBox.TYPE, UIBitmapManager.CHECK_BUTTON_NORMAL );
	 */
    
    public static function removeUIElement(UIElement : String, type : String) : Void
    {
        // Make sure everything is setup
        if (!initialize) 
            init();
    }
    
    /**
	 * Gets a list of all the UI elements that use by the bitmap manager
	 *
	 * @return an array filled with names
	 */
    
    public static function getUIElementNameList() : Array<String>
    {
        
        // Make sure everything is setup
        if (!initialize) 
            init();
        
        var nameList : Array<String> = new Array<String>();
        
        for (index in Reflect.fields(skinTheme))
        {
            nameList.push(index);
        }
        
        return nameList;
    }
}