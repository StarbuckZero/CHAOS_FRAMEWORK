package com.chaos.ui;

import openfl.display.BitmapData;
import openfl.errors.Error;
import openfl.display.DisplayObject;
import haxe.ds.StringMap;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.data.DataProvider;
import com.chaos.utils.Debug;

/**
 * Stores bitmap skins and custom renderers for UI components.
 *
 * @author Erick Feiling
 */

class UIBitmapManager {
    /** Bitmap key for the chart background image texture. */
    public static inline var CHART_BACKGROUND_IMAGE:String = "chart_background_image";
	private static inline var CUSTOM_RENDER_CACHE_LIMIT:Int = 256;
	/** Bitmap key for the base container background texture. */
	public static inline var BASE_CONTAINER_BACKGROUND:String = "base_container_background";
	/** Bitmap key for the alignment base container background texture. */
	public static inline var ALIGNMENT_BASE_CONTAINER_BACKGROUND:String = "alignment_base_container_background";
	/** Bitmap key for the breadcrumb background texture. */
	public static inline var BREADCRUMB_BACKGROUND:String = "breadcrumb_background";
	/** Bitmap key for the canvas background texture. */
	public static inline var CANVAS_BACKGROUND:String = "canvas_background";
	/** Bitmap key for the carousel background texture. */
	public static inline var CAROUSEL_BACKGROUND:String = "carousel_background";
	/** Bitmap key for the drag container background texture. */
	public static inline var DRAG_CONTAINER_BACKGROUND:String = "drag_container_background";
	/** Bitmap key for the fit container background texture. */
	public static inline var FIT_CONTAINER_BACKGROUND:String = "fit_container_background";
	/** Bitmap key for the form builder background texture. */
	public static inline var FORM_BUILDER_BACKGROUND:String = "form_builder_background";
	/** Bitmap key for the grid container background texture. */
	public static inline var GRID_CONTAINER_BACKGROUND:String = "grid_container_background";
	/** Bitmap key for the horizontal container background texture. */
	public static inline var HORIZONTAL_CONTAINER_BACKGROUND:String = "horizontal_container_background";
	/** Bitmap key for the mobile button list background texture. */
	public static inline var MOBILE_BUTTON_LIST_BACKGROUND:String = "mobile_button_list_background";
	/** Bitmap key for the navigation menu background texture. */
	public static inline var NAVIGATION_MENU_BACKGROUND:String = "navigation_menu_background";
	/** Bitmap key for the vertical container background texture. */
	public static inline var VERTICAL_CONTAINER_BACKGROUND:String = "vertical_container_background";
	/** Bitmap key for the accordion button normal texture. */
	public static inline var ACCORDION_BUTTON_NORMAL:String = "accordion_button_normal";
	/** Bitmap key for the accordion button hover texture. */
	public static inline var ACCORDION_BUTTON_OVER:String = "accordion_button_over";
	/** Bitmap key for the accordion button pressed texture. */
	public static inline var ACCORDION_BUTTON_SELECTED:String = "accordion_button_down";
	/** Bitmap key for the accordion button disabled texture. */
	public static inline var ACCORDION_BUTTON_DISABLE:String = "accordion_button_disable";

	/** Bitmap key for the accordion background texture. */
	public static inline var ACCORDION_BACKGROUND:String = "accordion_background";

	/** Bitmap key for the alert background texture. */
	public static inline var ALERT_BACKGROUND:String = "alert_background";

	/** Bitmap key for the alert top left texture. */
	public static inline var ALERT_TOP_LEFT:String = "alert_top_left";
	/** Bitmap key for the alert top middle texture. */
	public static inline var ALERT_TOP_MIDDLE:String = "alert_top_middle";
	/** Bitmap key for the alert top right texture. */
	public static inline var ALERT_TOP_RIGHT:String = "alert_top_right";

	/** Bitmap key for the alert middle left texture. */
	public static inline var ALERT_MIDDLE_LEFT:String = "alert_middle_left";
	/** Bitmap key for the alert middle right texture. */
	public static inline var ALERT_MIDDLE_RIGHT:String = "alert_middle_right";

	/** Bitmap key for the alert bottom left texture. */
	public static inline var ALERT_BOTTOM_LEFT:String = "alert_bottom_left";
	/** Bitmap key for the alert bottom middle texture. */
	public static inline var ALERT_BOTTOM_MIDDLE:String = "alert_bottom_middle";
	/** Bitmap key for the alert bottom right texture. */
	public static inline var ALERT_BOTTOM_RIGHT:String = "alert_bottom_right";

	/** Bitmap key for the alert top pattern overlay texture. */
	public static inline var ALERT_TOP_PATTERN_OVERLAY:String = "alert_top_pattern_overlay";
	/** Bitmap key for the alert middle pattern overlay texture. */
	public static inline var ALERT_MIDDLE_PATTERN_OVERLAY:String = "alert_middle_pattern_overlay";
	/** Bitmap key for the alert bottom pattern overlay texture. */
	public static inline var ALERT_BOTTOM_PATTERN_OVERLAY:String = "alert_bottom_pattern_overlay";

	/** Bitmap key for the alert close button normal texture. */
	public static inline var ALERT_CLOSE_BUTTON_NORMAL:String = "alert_close_button_normal";
	/** Bitmap key for the alert close button hover texture. */
	public static inline var ALERT_CLOSE_BUTTON_OVER:String = "alert_close_button_over";
	/** Bitmap key for the alert close button pressed texture. */
	public static inline var ALERT_CLOSE_BUTTON_DOWN:String = "alert_close_button_down";
	/** Bitmap key for the alert close button disabled texture. */
	public static inline var ALERT_CLOSE_BUTTON_DISABLE:String = "alert_close_button_disable";

	/** Bitmap key for the alert positive button normal texture. */
	public static inline var ALERT_POSITIVE_BUTTON_NORMAL:String = "alert_positive_button_normal";
	/** Bitmap key for the alert positive button hover texture. */
	public static inline var ALERT_POSITIVE_BUTTON_OVER:String = "alert_positive_button_over";
	/** Bitmap key for the alert positive button pressed texture. */
	public static inline var ALERT_POSITIVE_BUTTON_DOWN:String = "alert_positive_button_down";

	/** Bitmap key for the alert negative button normal texture. */
	public static inline var ALERT_NEGATIVE_BUTTON_NORMAL:String = "alert_negative_button_normal";
	/** Bitmap key for the alert negative button hover texture. */
	public static inline var ALERT_NEGATIVE_BUTTON_OVER:String = "alert_negative_button_over";
	/** Bitmap key for the alert negative button pressed texture. */
	public static inline var ALERT_NEGATIVE_BUTTON_DOWN:String = "alert_negative_button_down";

	/** Bitmap key for the alert neutral button normal texture. */
	public static inline var ALERT_NEUTRAL_BUTTON_NORMAL:String = "alert_neutral_button_normal";
	/** Bitmap key for the alert neutral button hover texture. */
	public static inline var ALERT_NEUTRAL_BUTTON_OVER:String = "alert_neutral_button_over";
	/** Bitmap key for the alert neutral button pressed texture. */
	public static inline var ALERT_NEUTRAL_BUTTON_DOWN:String = "alert_neutral_button_down";

	/** Bitmap key for the bubble overlay top left texture. */
	public static inline var BUBBLE_OVERLAY_TOP_LEFT:String = "bubble_overlay_top_left";
	/** Bitmap key for the bubble overlay top middle texture. */
	public static inline var BUBBLE_OVERLAY_TOP_MIDDLE:String = "bubble_overlay_top_middle";
	/** Bitmap key for the bubble overlay top right texture. */
	public static inline var BUBBLE_OVERLAY_TOP_RIGHT:String = "bubble_overlay_top_right";

	/** Bitmap key for the bubble overlay middle left texture. */
	public static inline var BUBBLE_OVERLAY_MIDDLE_LEFT:String = "bubble_overlay_middle_left";
	/** Bitmap key for the bubble overlay middle right texture. */
	public static inline var BUBBLE_OVERLAY_MIDDLE_RIGHT:String = "bubble_overlay_middle_right";

	/** Bitmap key for the bubble overlay bottom left texture. */
	public static inline var BUBBLE_OVERLAY_BOTTOM_LEFT:String = "bubble_overlay_bottom_left";
	/** Bitmap key for the bubble overlay bottom middle texture. */
	public static inline var BUBBLE_OVERLAY_BOTTOM_MIDDLE:String = "bubble_overlay_bottom_middle";
	/** Bitmap key for the bubble overlay bottom right texture. */
	public static inline var BUBBLE_OVERLAY_BOTTOM_RIGHT:String = "bubble_overlay_bottom_right";

	/** Bitmap key for the bubble background texture. */
	public static inline var BUBBLE_BACKGROUND:String = "bubble_background";

	/** Bitmap key for the button normal texture. */
	public static inline var BUTTON_NORMAL:String = "button_normal";
	/** Bitmap key for the button hover texture. */
	public static inline var BUTTON_OVER:String = "button_over";
	/** Bitmap key for the button pressed texture. */
	public static inline var BUTTON_DOWN:String = "button_down";
	/** Bitmap key for the button disabled texture. */
	public static inline var BUTTON_DISABLE:String = "button_disable";

	/** Bitmap key for the check box normal texture. */
	public static inline var CHECKBOX_NORMAL:String = "checkbox_normal";
	/** Bitmap key for the check box hover texture. */
	public static inline var CHECKBOX_OVER:String = "checkbox_over";
	/** Bitmap key for the check box pressed texture. */
	public static inline var CHECKBOX_DOWN:String = "checkbox_down";
	/** Bitmap key for the check box disabled texture. */
	public static inline var CHECKBOX_DISABLE:String = "checkbox_disable";

	/** Bitmap key for the check box selected normal texture. */
	public static inline var CHECKBOX_SELECTED_NORMAL:String = "checkbox_selected_normal";
	/** Bitmap key for the check box selected hover texture. */
	public static inline var CHECKBOX_SELECTED_OVER:String = "checkbox_selected_over";
	/** Bitmap key for the check box selected pressed texture. */
	public static inline var CHECKBOX_SELECTED_DOWN:String = "checkbox_selected_down";
	/** Bitmap key for the check box selected disabled texture. */
	public static inline var CHECKBOX_SELECTED_DISABLE:String = "checkbox_selected_disable";	

	/** Bitmap key for the radio button normal texture. */
	public static inline var RADIOBUTTON_NORMAL:String = "radiobutton_normal";
	/** Bitmap key for the radio button hover texture. */
	public static inline var RADIOBUTTON_OVER:String = "radiobutton_over";
	/** Bitmap key for the radio button pressed texture. */
	public static inline var RADIOBUTTON_DOWN:String = "radiobutton_down";
	/** Bitmap key for the radio button disabled texture. */
	public static inline var RADIOBUTTON_DISABLE:String = "radiobutton_disable";

	/** Bitmap key for the radio button selected normal texture. */
	public static inline var RADIOBUTTON_SELECTED_NORMAL:String = "radiobutton_selected_normal";
	/** Bitmap key for the radio button selected hover texture. */
	public static inline var RADIOBUTTON_SELECTED_OVER:String = "radiobutton_selected_over";
	/** Bitmap key for the radio button selected pressed texture. */
	public static inline var RADIOBUTTON_SELECTED_DOWN:String = "radiobutton_selected_down";
	/** Bitmap key for the radio button selected disabled texture. */
	public static inline var RADIOBUTTON_SELECTED_DISABLE:String = "radiobutton_selected_disable";

	/** Bitmap key for the combo button normal texture. */
	public static inline var COMBO_BUTTON_NORMAL:String = "combo_button_normal";
	/** Bitmap key for the combo button hover texture. */
	public static inline var COMBO_BUTTON_OVER:String = "combo_button_over";
	/** Bitmap key for the combo button pressed texture. */
	public static inline var COMBO_BUTTON_DOWN:String = "combo_button_down";
	/** Bitmap key for the combo button disabled texture. */
	public static inline var COMBO_BUTTON_DISABLE:String = "combo_button_disable";

	/** Bitmap key for the combo button icon texture. */
	public static inline var COMBO_BUTTON_ICON:String = "combo_button_icon";

	@:deprecated("Use COMBO_BUTTON_ICON instead")
	/** Alias for the combo box button icon bitmap key. */
	public static inline var COMBO_BUTTON_DROPDOWN_ICON:String = COMBO_BUTTON_ICON;

	/** Bitmap key for the combo background texture. */
	public static inline var COMBO_BACKGROUND:String = "combo_background";
	/** Bitmap key for the combo dropdown background texture. */
	public static inline var COMBO_DROPDOWN_BACKGROUND:String = "combo_dropdown_background";

	/** Bitmap key for the list background texture. */
	public static inline var LIST_BACKGROUND:String = "list_background";

	/** Bitmap key for the grid panel background texture. */
	public static inline var GRIDPANE_BACKGROUND:String = "grid_panel_background";

	/** Bitmap key for the grid button normal texture. */
	public static inline var GRIDPANE_BUTTON_NORMAL:String = "grid_button_normal";
	/** Bitmap key for the grid button hover texture. */
	public static inline var GRIDPANE_BUTTON_OVER:String = "grid_button_over";
	/** Bitmap key for the grid button pressed texture. */
	public static inline var GRIDPANE_BUTTON_DOWN:String = "grid_button_down";

	/** Bitmap key for the grid cell background texture. */
	public static inline var GRIDPANE_CELL_BACKGROUND:String = "grid_cell_background";

	/** Bitmap key for the item pane background texture. */
	public static inline var ITEMPANE_BACKGROUND:String = "itempane_background";

	/** Bitmap key for the item pane item normal texture. */
	public static inline var ITEMPANE_ITEM_NORMAL:String = "itempane_item_normal";
	/** Bitmap key for the item pane item hover texture. */
	public static inline var ITEMPANE_ITEM_OVER:String = "itempane_item_over";
	/** Bitmap key for the item pane item selected texture. */
	public static inline var ITEMPANE_ITEM_SELECTED:String = "itempane_item_selected";
	/** Bitmap key for the item pane item disabled texture. */
	public static inline var ITEMPANE_ITEM_DISABLE:String = "itempane_item_disable";

	/** Bitmap key for the item pane item not loaded texture. */
	public static inline var ITEMPANE_NOT_LOADED:String = "item_pane_item_not_loaded";

	/** Bitmap key for the progress background texture. */
	public static inline var PROGRESSBAR_BACKGROUND:String = "progress_background";
	/** Bitmap key for the progress loaded background texture. */
	public static inline var PROGRESSBAR_LOADED_BACKGROUND:String = "progress_loaded_background";

	/** Bitmap key for the progress slider background texture. */
	public static inline var PROGRESS_SLIDER_BACKGROUND:String = "progress_slider_background";
	/** Bitmap key for the progress slider loaded background texture. */
	public static inline var PROGRESS_SLIDER_LOADED_BACKGROUND:String = "progress_slider_loaded_background";

	/** Bitmap key for the progress slider button normal texture. */
	public static inline var PROGRESS_SLIDER_BUTTON_NORMAL:String = "progress_slider_button_normal";
	/** Bitmap key for the progress slider button hover texture. */
	public static inline var PROGRESS_SLIDER_BUTTON_OVER:String = "progress_slider_button_over";
	/** Bitmap key for the progress slider button pressed texture. */
	public static inline var PROGRESS_SLIDER_BUTTON_DOWN:String = "progress_slider_button_down";
	/** Bitmap key for the progress slider button disabled texture. */
	public static inline var PROGRESS_SLIDER_BUTTON_DISABLE:String = "progress_slider_button_disable";

	/** Bitmap key for the scroll bar up icon texture. */
	public static inline var SCROLLBAR_UP_ICON:String = "scrollbar_up_icon";
	/** Bitmap key for the scroll bar pressed icon texture. */
	public static inline var SCROLLBAR_DOWN_ICON:String = "scrollbar_down_icon";
	/** Bitmap key for the scroll bar right icon texture. */
	public static inline var SCROLLBAR_RIGHT_ICON:String = "scrollbar_right_icon";
	/** Bitmap key for the scroll bar left icon texture. */
	public static inline var SCROLLBAR_LEFT_ICON:String = "scrollbar_left_icon";

	/** Bitmap key for the scroll bar slider button normal texture. */
	public static inline var SCROLLBAR_SLIDER_BUTTON_NORMAL:String = "scrollbar_slider_button_normal";
	/** Bitmap key for the scroll bar slider button hover texture. */
	public static inline var SCROLLBAR_SLIDER_BUTTON_OVER:String = "scrollbar_slider_button_over";
	/** Bitmap key for the scroll bar slider button pressed texture. */
	public static inline var SCROLLBAR_SLIDER_BUTTON_DOWN:String = "scrollbar_slider_button_down";
	/** Bitmap key for the scroll bar slider button disabled texture. */
	public static inline var SCROLLBAR_SLIDER_BUTTON_DISABLE:String = "scrollbar_slider_button_disable";

	/** Bitmap key for the scroll bar button normal texture. */
	public static inline var SCROLLBAR_BUTTON_NORMAL:String = "scrollbar_button_normal";
	/** Bitmap key for the scroll bar button hover texture. */
	public static inline var SCROLLBAR_BUTTON_OVER:String = "scrollbar_button_over";
	/** Bitmap key for the scroll bar button pressed texture. */
	public static inline var SCROLLBAR_BUTTON_DOWN:String = "scrollbar_button_down";
	/** Bitmap key for the scroll bar button disabled texture. */
	public static inline var SCROLLBAR_BUTTON_DISABLE:String = "scrollbar_button_disable";

	/** Bitmap key for the scroll bar track texture. */
	public static inline var SCROLLBAR_TRACK:String = "scrollbar_track";

	/** Bitmap key for the scroll pane background texture. */
	public static inline var SCROLLPANE_BACKGROUND:String = "scrollpane_background";

	/** Bitmap key for the slider button normal texture. */
	public static inline var SLIDER_BUTTON_NORMAL:String = "slider_button_normal";
	/** Bitmap key for the slider button hover texture. */
	public static inline var SLIDER_BUTTON_OVER:String = "slider_button_over";
	/** Bitmap key for the slider button pressed texture. */
	public static inline var SLIDER_BUTTON_DOWN:String = "slider_button_down";
	/** Bitmap key for the slider button disabled texture. */
	public static inline var SLIDER_BUTTON_DISABLE:String = "slider_button_disable";

	/** Bitmap key for the slider track texture. */
	public static inline var SLIDER_TRACK:String = "slider_track";

	/** Bitmap key for the tab pane background texture. */
	public static inline var TABPANE_BACKGROUND:String = "tabpane_background";

	/** Bitmap key for the tab pane button normal texture. */
	public static inline var TABPANE_BUTTON_NORMAL:String = "tabpane_button_normal";
	/** Bitmap key for the tab pane button hover texture. */
	public static inline var TABPANE_BUTTON_OVER:String = "tabpane_button_over";
	/** Bitmap key for the tab pane button disabled texture. */
	public static inline var TABPANE_BUTTON_DISABLE:String = "tabpane_button_disable";
	/** Bitmap key for the tab pane button selected texture. */
	public static inline var TABPANE_BUTTON_SELECTED:String = "tabpane_button_selected";

	/** Bitmap key for the textinput normal texture. */
	public static inline var TEXTINPUT_NORMAL:String = "textinput_normal";
	/** Bitmap key for the textinput hover texture. */
	public static inline var TEXTINPUT_OVER:String = "textinput_over";
	/** Bitmap key for the textinput selected texture. */
	public static inline var TEXTINPUT_SELECTED:String = "textinput_selected";
	/** Bitmap key for the textinput disabled texture. */
	public static inline var TEXTINPUT_DISABLE:String = "textinput_disable";

	/** Bitmap key for the togglebutton normal texture. */
	public static inline var TOGGLE_BUTTON_NORMAL:String = "togglebutton_normal";
	/** Bitmap key for the togglebutton hover texture. */
	public static inline var TOGGLE_BUTTON_OVER:String = "togglebutton_over";
	/** Bitmap key for the togglebutton pressed texture. */
	public static inline var TOGGLE_BUTTON_DOWN:String = "togglebutton_down";
	/** Bitmap key for the togglebutton disabled texture. */
	public static inline var TOGGLE_BUTTON_DISABLE:String = "togglebutton_disable";

	/** Bitmap key for the tooltip background texture. */
	public static inline var TOOLTIP_BACKGROUND:String = "tooltip_background";

	/** Bitmap key for the tooltip overlay top left texture. */
	public static inline var TOOLTIP_OVERLAY_TOP_LEFT:String = "tooltip_overlay_top_left";
	/** Bitmap key for the tooltip overlay top middle texture. */
	public static inline var TOOLTIP_OVERLAY_TOP_MIDDLE:String = "tooltip_overlay_top_middle";
	/** Bitmap key for the tooltip overlay top right texture. */
	public static inline var TOOLTIP_OVERLAY_TOP_RIGHT:String = "tooltip_overlay_top_right";

	/** Bitmap key for the tooltip overlay middle left texture. */
	public static inline var TOOLTIP_OVERLAY_MIDDLE_LEFT:String = "tooltip_overlay_middle_left";
	/** Bitmap key for the tooltip overlay middle right texture. */
	public static inline var TOOLTIP_OVERLAY_MIDDLE_RIGHT:String = "tooltip_overlay_middle_right";

	/** Bitmap key for the tooltip overlay bottom left texture. */
	public static inline var TOOLTIP_OVERLAY_BOTTOM_LEFT:String = "tooltip_overlay_bottom_left";
	/** Bitmap key for the tooltip overlay bottom middle texture. */
	public static inline var TOOLTIP_OVERLAY_BOTTOM_MIDDLE:String = "tooltip_overlay_bottom_middle";
	/** Bitmap key for the tooltip overlay bottom right texture. */
	public static inline var TOOLTIP_OVERLAY_BOTTOM_RIGHT:String = "tooltip_overlay_bottom_right";

	/** Bitmap key for the menu background texture. */
	public static inline var MENU_BACKGROUND:String = "menu_background";

	/** Bitmap key for the menu button normal texture. */
	public static inline var MENU_BUTTON_NORMAL:String = "menu_button_normal";
	/** Bitmap key for the menu button hover texture. */
	public static inline var MENU_BUTTON_OVER:String = "menu_button_over";
	/** Bitmap key for the menu button pressed texture. */
	public static inline var MENU_BUTTON_DOWN:String = "menu_button_down";
	/** Bitmap key for the menu button disabled texture. */
	public static inline var MENU_BUTTON_DISABLE:String = "menu_button_disable";

	/** Bitmap key for the menu button icon texture. */
	public static inline var MENU_BUTTON_ICON:String = "menu_button_icon";
	/** Bitmap key for the menu button sub menu dropdown texture. */
	public static inline var MENU_BUTTON_SUB_MENU_DROPDOWN:String = "menu_button_sub_menu_dropdown";

	/** Bitmap key for the menu sub button normal texture. */
	public static inline var MENU_SUB_BUTTON_NORMAL:String = "menu_sub_button_normal";
	/** Bitmap key for the menu sub button hover texture. */
	public static inline var MENU_SUB_BUTTON_OVER:String = "menu_sub_button_over";
	/** Bitmap key for the menu sub button pressed texture. */
	public static inline var MENU_SUB_BUTTON_DOWN:String = "menu_sub_button_down";
	/** Bitmap key for the menu sub button disabled texture. */
	public static inline var MENU_SUB_BUTTON_DISABLE:String = "menu_sub_button_disable";

	/** Bitmap key for the menu sub button icon texture. */
	public static inline var MENU_SUB_BUTTON_ICON:String = "menu_sub_button_icon";

	/** Bitmap key for the window background texture. */
	public static inline var WINDOW_BACKGROUND:String = "window_background";

	/** Bitmap key for the window close button normal texture. */
	public static inline var WINDOW_CLOSE_BUTTON_NORMAL:String = "window_close_button_normal";
	/** Bitmap key for the window close button hover texture. */
	public static inline var WINDOW_CLOSE_BUTTON_OVER:String = "window_close_button_over";
	/** Bitmap key for the window close button pressed texture. */
	public static inline var WINDOW_CLOSE_BUTTON_DOWN:String = "window_close_button_down";
	/** Bitmap key for the window close button disabled texture. */
	public static inline var WINDOW_CLOSE_BUTTON_DISABLE:String = "window_close_button_disable";

	/** Bitmap key for the window min button normal texture. */
	public static inline var WINDOW_MIN_BUTTON_NORMAL:String = "window_min_button_normal";
	/** Bitmap key for the window min button hover texture. */
	public static inline var WINDOW_MIN_BUTTON_OVER:String = "window_min_button_over";
	/** Bitmap key for the window min button pressed texture. */
	public static inline var WINDOW_MIN_BUTTON_DOWN:String = "window_min_button_down";
	/** Bitmap key for the window min button disabled texture. */
	public static inline var WINDOW_MIN_BUTTON_DISABLE:String = "window_min_button_disable";

	/** Bitmap key for the window max button normal texture. */
	public static inline var WINDOW_MAX_BUTTON_NORMAL:String = "window_max_button_normal";
	/** Bitmap key for the window max button hover texture. */
	public static inline var WINDOW_MAX_BUTTON_OVER:String = "window_max_button_over";
	/** Bitmap key for the window max button pressed texture. */
	public static inline var WINDOW_MAX_BUTTON_DOWN:String = "window_max_button_down";
	/** Bitmap key for the window max button disabled texture. */
	public static inline var WINDOW_MAX_BUTTON_DISABLE:String = "window_max_button_disable";

	/** Bitmap key for the window top left texture. */
	public static inline var WINDOW_TOP_LEFT:String = "window_top_left";
	/** Bitmap key for the window top middle texture. */
	public static inline var WINDOW_TOP_MIDDLE:String = "window_top_middle";
	/** Bitmap key for the window top right texture. */
	public static inline var WINDOW_TOP_RIGHT:String = "window_top_right";

	/** Bitmap key for the window middle left texture. */
	public static inline var WINDOW_MIDDLE_LEFT:String = "window_middle_left";
	/** Bitmap key for the window middle right texture. */
	public static inline var WINDOW_MIDDLE_RIGHT:String = "window_middle_right";

	/** Bitmap key for the window bottom left texture. */
	public static inline var WINDOW_BOTTOM_LEFT:String = "window_bottom_left";
	/** Bitmap key for the window bottom middle texture. */
	public static inline var WINDOW_BOTTOM_MIDDLE:String = "window_bottom_middle";
	/** Bitmap key for the window bottom right texture. */
	public static inline var WINDOW_BOTTOM_RIGHT:String = "window_bottom_right";

	/** Bitmap key for the window unfocused top left texture. */
	public static inline var WINDOW_UNFOCUS_TOP_LEFT:String = "window_unfocus_top_left";
	/** Bitmap key for the window unfocused top middle texture. */
	public static inline var WINDOW_UNFOCUS_TOP_MIDDLE:String = "window_unfocus_top_middle";
	/** Bitmap key for the window unfocused top right texture. */
	public static inline var WINDOW_UNFOCUS_TOP_RIGHT:String = "window_unfocus_top_right";

	/** Bitmap key for the window unfocused middle left texture. */
	public static inline var WINDOW_UNFOCUS_MIDDLE_LEFT:String = "window_unfocus_middle_left";
	/** Bitmap key for the window unfocused middle right texture. */
	public static inline var WINDOW_UNFOCUS_MIDDLE_RIGHT:String = "window_unfocus_middle_right";

	/** Bitmap key for the window unfocused bottom left texture. */
	public static inline var WINDOW_UNFOCUS_BOTTOM_LEFT:String = "window_unfocus_bottom_left";
	/** Bitmap key for the window unfocused bottom middle texture. */
	public static inline var WINDOW_UNFOCUS_BOTTOM_MIDDLE:String = "window_unfocus_bottom_middle";
	/** Bitmap key for the window unfocused bottom right texture. */
	public static inline var WINDOW_UNFOCUS_BOTTOM_RIGHT:String = "window_unfocus_bottom_right";

	/** Bitmap key for the window top pattern overlay texture. */
	public static inline var WINDOW_TOP_PATTERN_OVERLAY:String = "window_top_pattern_overlay";
	/** Bitmap key for the window middle pattern overlay texture. */
	public static inline var WINDOW_MIDDLE_PATTERN_OVERLAY:String = "window_middle_pattern_overlay";
	/** Bitmap key for the window bottom pattern overlay texture. */
	public static inline var WINDOW_BOTTOM_PATTERN_OVERLAY:String = "window_bottom_pattern_overlay";

	private static var initialized:Bool = false;

	private static var skinTheme:Dynamic;
	private static var watchList:Dynamic;
	private static var customRender:Dynamic;
	private static var customRenderCache:StringMap<BitmapData>;
	private static var customRenderCacheOrder:Array<String>;
	private static var customRenderRevision:Int = 0;

	/** Creates a bitmap manager; skin registrations are stored statically. */
	public function new() {}

	private static function initializeManager() : Void {

        skinTheme = {};
         
        // Setting up to store bitmaps for all components
		for( compType in Type.allEnums(UIBitmapType))
			Reflect.setField(skinTheme, compType.getName(), {});

        watchList = {};
        
        // Setting up to store bitmaps for all components
		for( compType in Type.allEnums(UIBitmapType))
			Reflect.setField(watchList, compType.getName(), new DataProvider<IBaseUI>());		

		// Custom bitmap calls
		customRender = {};
		customRenderCache = new StringMap<BitmapData>();
		customRenderCacheOrder = [];
		
		// Flag as inited
		initialized = true;
	}

	/** Removes registered bitmap skins and invalidates cached custom renders. */
	public static function clear() : Void {
		if (!initialized)
			initializeManager();

		invalidateCustomRenderCache();

		for( compType in Type.allEnums(UIBitmapType))
			Reflect.deleteField(skinTheme, compType.getName());

		for( compType in Type.allEnums(UIBitmapType))
			Reflect.setField(skinTheme, compType.getName(), {});		
	}

	/**
	 * Registers a component to be redrawn when its bitmap skin changes.
	 *
	 * @param UIType The component type whose skin is watched.
	 * @param displayObj The component to update.
	 */
	public static function watchElement(UIType:UIBitmapType, displayObj:IBaseUI):Void {
		// Make sure everything is setup
		if (!initialized)
			initializeManager();

		try {
			Reflect.field(watchList, UIType.getName()).addItem(displayObj);
		} catch (error:Error) {
			Debug.print("[UIBitmapManager::watchElement] Fail to add object type " + UIType.getName() + " to watch list.");
		}
	}

	/**
	 * Stops updating a component when its bitmap skin changes.
	 *
	 * @param UIType The component type whose skin was watched.
	 * @param displayObj The component to remove from the watch list.
	 */
	public static function stopWatchElement(UIType:UIBitmapType, displayObj:DisplayObject):Void {
		// Make sure everything is setup
		if (!initialized)
			initializeManager();

		try {
			Reflect.field(watchList, UIType.getName()).removeItem(displayObj);
		} catch (error:Error) {
			Debug.print("[UIBitmapManager::stopWatchElement] Fail to remove object type " + UIType.getName() + " to watch list.");
		}
	}

	/**
	 * Reskins and redraws every watched component of the given type.
	 *
	 * @param UIType The component type to update.
	 */
	public static function updateUIElement(UIType:UIBitmapType):Void {
		
		if(watchList == null)
			return;
		
		var uiList:DataProvider<IBaseUI> = Reflect.field(watchList, UIType.getName());

		for (i in 0...uiList.length) {
			cast(uiList.getItemAt(i), IBaseUI).reskin();
			cast(uiList.getItemAt(i), IBaseUI).draw();
		}
	}

	/**
	 * Reskins and redraws watched components of every UI type.
	 */

	public static function updateAllUIElement() {
		
		// Make sure everything is setup
		if (!initialized)
			initializeManager();

		for( compType in Type.allEnums(UIBitmapType))
			updateUIElement(compType);
	}

	/**
	 * Checks whether a bitmap or mask is registered for a component state.
	 *
	 * @param UIType The component type.
	 * @param style The bitmap or mask key.
	*/
	public static function hasUIElement(UIType:UIBitmapType, style:String) : Bool {

		// Make sure everything is setup
		if (!initialized)
			initializeManager();
				
		return Reflect.hasField(Reflect.field(skinTheme, UIType.getName()), style);
	}

	/**
	 * Registers a bitmap skin and optionally updates watched components.
	 *
	 * @param UIType The component type.
	 * @param style The state key to skin.
	 * @param bitmap The bitmap to register.
	 * @param updateElement Whether to redraw watched components of this type.
	 *
	 * @example UIBitmapManager.setUIElement(Button.TYPE, UIBitmapManager.BUTTON_NORMAL, btnNormalImageBitmap );
	 */
	 
	public static function setUIElement(UIType:UIBitmapType, style:String, bitmap:BitmapData,updateElement:Bool = true):Void {
		
		// Make sure everything is setup
		if (!initialized) {
			initializeManager();
		}

		var uiTypeName:String = UIType.getName();
		var uiTheme:Dynamic = Reflect.field(skinTheme, uiTypeName);

		if (uiTheme == null) {
			uiTheme = {};
			Reflect.setField(skinTheme, uiTypeName, uiTheme);
		}

		Reflect.setField(uiTheme, style, bitmap);
		invalidateCustomRenderCache();

		// Update UI Elements based on type
		if (updateElement) {
			updateUIElement(UIType);
		}
	}

	/**
	 * Registers a display-object mask for a component state.
	 *
	 * @param UIType The component type.
	 * @param style The state key to mask.
	 * @param mask The display object to use as a mask.
	 */
	public static function setUIElementMask(UIType:UIBitmapType, style:String, mask:DisplayObject):Void {
		// Make sure everything is setup
		if (!initialized)
			initializeManager();

		Reflect.setField(Reflect.field(skinTheme, UIType.getName()), style, mask);
	}

	/**
	 * Returns a clone of the registered bitmap, or null when none is set.
	 *
	 * @param UIType The component type.
	 * @param style The bitmap state key.
	 *
	 * @return A cloned bitmap, or null if the key is absent.
	 *
	 * @example UIBitmapManager.getUIElement(CheckBox.TYPE, UIBitmapManager.CHECK_BUTTON_NORMAL );
	 */
	public static function getUIElement(UIType:UIBitmapType, style:String):BitmapData {

		// Make sure everything is setup
		if (!initialized)
			initializeManager();

		var bitmapData:BitmapData = Reflect.hasField(Reflect.field(skinTheme, UIType.getName()), style) ? Reflect.field(Reflect.field(skinTheme, UIType.getName()), style) : null;

		if(null != bitmapData)
			return bitmapData.clone();

		return null;
	}

	/**
	 * Returns the registered mask, or null when none is set.
	 *
	 * @param UIType The component type.
	 * @param style The mask state key.
	 *
	 * @return The registered mask, or null if the key is absent.
	 *
	 * @example UIBitmapManager.getUIElementMask(CheckBox.TYPE, UIBitmapManager.CHECK_BUTTON_NORMAL );
	 */
	public static function getUIElementMask(UIType:UIBitmapType, style:String):DisplayObject {

		// Make sure everything is setup
		if (!initialized)
			initializeManager();

		return Reflect.hasField(Reflect.field(skinTheme, UIType.getName()), style) ? Reflect.field(Reflect.field(skinTheme, UIType.getName()), style) : null;
	}

	/**
	 * Removes a bitmap or mask registration and invalidates cached renders.
	 *
	 * @param UIType The component type.
	 * @param type The bitmap or mask key to remove.
	 *
	 * @example UIBitmapManager.removeUIElement(CheckBox.TYPE, UIBitmapManager.CHECK_BUTTON_NORMAL );
	 */
	public static function removeUIElement(UIType:UIBitmapType, type:String):Void {
		// Make sure everything is setup
		if (!initialized) {
			initializeManager();
		}

		if (UIType == null || type == null || type == "") {
			return;
		}

		var uiTypeName:String = UIType.getName();
		var uiTheme:Dynamic = Reflect.field(skinTheme, uiTypeName);

		if (uiTheme == null) {
			return;
		}

		Reflect.deleteField(uiTheme, type);
		invalidateCustomRenderCache();
	}

	/**
	 * Lists the names of every supported UI bitmap type.
	 *
	 * @return The UI type names.
	 */
	public static function getUIElementNameList():Array<String> {

		var list:Array<String> = new Array<String>();

		for( compType in Type.allEnums(UIBitmapType))
			list.push(compType.getName());

		return list;
	}

	/**
	* Checks whether a custom renderer is registered for a UI type.
	* @param UIElement The UI type to check.
	*
	* @return True when a custom renderer is registered.
	**/
	public static function hasCustomRenderTexture(UIElement:UIBitmapType) : Bool {
		// Make sure everything is setup
		if (!initialized)
			initializeManager();

		return Reflect.hasField(customRender,UIElement.getName());
		
	}

	/**
	* Registers a custom bitmap renderer for the given UI type and clears its cache.
	* @param UIElement The UI type to render.
	* @param cr The callback that creates a bitmap from render data.
	**/

	public static function addCustomRenderTexture(UIElement:UIBitmapType, cr:Dynamic->BitmapData ) : Void {
		
		// Make sure everything is setup
		if (!initialized)
			initializeManager();

		invalidateCustomRenderCache(UIElement);
		Reflect.setField(customRender, UIElement.getName(), cr);
	}

	/**
	* Removes a custom renderer and its cached output for the given UI type.
	* @param UIType The UI type whose renderer is removed.
	**/
	public static function removeCustomRenderTexture(UIType:UIBitmapType) : Void {

		// Make sure everything is setup
		if (!initialized)
			initializeManager();

		invalidateCustomRenderCache(UIType);
		Reflect.deleteField(customRender, UIType.getName());
	}

	/** Clears cached custom-render output, optionally for one UI type. */
	public static function invalidateCustomRenderCache(UIType:UIBitmapType = null):Void {
		if (!initialized)
			initializeManager();

		var typePrefix:String = UIType == null ? null : UIType.getName() + "|";
		var keysToRemove:Array<String> = [];

		for (key in customRenderCache.keys()) {
			if (typePrefix == null || StringTools.startsWith(key, typePrefix))
				keysToRemove.push(key);
		}

		for (key in keysToRemove) {
			var bitmap:BitmapData = customRenderCache.get(key);

			if (bitmap != null)
				bitmap.dispose();

			customRenderCache.remove(key);
			customRenderCacheOrder.remove(key);
		}

		customRenderRevision++;
	}

	/** Stable cache key shared by the manager and component dirty-state checks. */
	public static function getCustomRenderCacheKey(UIElement:UIBitmapType, data:Dynamic):String {
		if (!initialized)
			initializeManager();

		var fields:Array<String> = data == null ? [] : Reflect.fields(data);
		fields.sort(Reflect.compare);

		var values:Array<String> = [];

		for (field in fields)
			values.push(field + "=" + Std.string(Reflect.field(data, field)));

		return UIElement.getName() + "|" + customRenderRevision + "|" + values.join("|");
	}

	/**
	* Runs a registered custom renderer, caching its bitmap and returning a clone.
	* @param UIElement The UI type to render.
	* @param data The style data passed to the renderer.
	*
	* @return A cloned bitmap, or null when no renderer produces one.
	**/

	public static function runCustomRender(UIElement:UIBitmapType, data:Dynamic) : BitmapData {

		// Make sure everything is setup
		if (!initialized)
			initializeManager();

		var cacheKey:String = getCustomRenderCacheKey(UIElement, data);
		var cachedBitmap:BitmapData = customRenderCache.get(cacheKey);

		if (cachedBitmap != null)
		{
			customRenderCacheOrder.remove(cacheKey);
			customRenderCacheOrder.push(cacheKey);
			return cachedBitmap.clone();
		}

		var cr:Dynamic->BitmapData = Reflect.field(customRender,UIElement.getName());

		if (cr == null)
			return null;

		var renderedBitmap:BitmapData = cr(data);

		if (renderedBitmap == null)
			return null;

		customRenderCache.set(cacheKey, renderedBitmap);
		customRenderCacheOrder.push(cacheKey);

		while (customRenderCacheOrder.length > CUSTOM_RENDER_CACHE_LIMIT) {
			var oldestKey:String = customRenderCacheOrder.shift();
			var oldestBitmap:BitmapData = customRenderCache.get(oldestKey);

			if (oldestBitmap != null)
				oldestBitmap.dispose();

			customRenderCache.remove(oldestKey);
		}

		return renderedBitmap.clone();
	}
}

enum UIBitmapType {
	BaseContainer;
	AlignmentBaseContainer;
	Breadcrumb;
	Canvas;
	Carousel;
	DragContainer;
	FitContainer;
	FormBuilder;
	GridContainer;
	HorizontalContainer;
	MobileButtonList;
	NavigationMenu;
	VerticalContainer;
	Alert;
	Accordion;
	Bubble;
	Button;
	ToggleButton;
	CheckBox;
	ComboBox;
	Label;
	ListBox;
	ProgressBar;
	ProgressSlider;
	RadioButton;
	ScrollBar;
	ScrollPane;
	Slider;
	TabPane;
	ToolTip;
	TextInput;
	Window;
	ItemPane;
	GridPane;
	Menu;
    Chart;
}
