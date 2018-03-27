package com.chaos.ui;



import openfl.text.Font;
import openfl.text.TextFormatAlign;

/**
 * Setting the UI colors, fonts, font sizes and etc.
 *
 * @author Erick Feiling
 */

class UIStyleManager
{
    public static var ALERT_BACKGROUND_COLOR : Int = -1;
    
    public static var ALERT_TITLE_TEXT_EMBED : Font = null;
    public static var ALERT_TITLE_TEXT_FONT : String = "";
    public static var ALERT_TITLE_TEXT_COLOR : Int = -1;
    public static var ALERT_TITLE_TEXT_SIZE : Int = -1;
    
    public static var ALERT_TITLE_TEXT_BOLD : Bool = false;
    public static var ALERT_TITLE_TEXT_ITALIC : Bool = false;
    
    public static var ALERT_TITLE_AREA_COLOR : Int = -1;
    public static var ALERT_TITLE_AREA_UNFOCUS_COLOR : Int = -1;
    
    public static var ALERT_WINDOW_FOCUS_COLOR : Int = -1;
    public static var ALERT_WINDOW_UNFOCUS_COLOR : Int = -1;
    
    public static var ALERT_MODAL_TINT_ALPHA : Float = -1;
    public static var ALERT_MODAL_BACKGROUND_COLOR : Int = -1;
    
    public static var ALERT_OK_TEXT : String = "";
    public static var ALERT_CANCEL_TEXT : String = "";
    public static var ALERT_YES_TEXT : String = "";
    public static var ALERT_NO_TEXT : String = "";
    public static var ALERT_MAYBE_TEXT : String = "";
    
    public static var ALERT_BOTTOM_COLOR : Int = -1;
    public static var ALERT_UNFOCUS_BOTTOM_COLOR : Int = -1;
    
    public static var ALERT_ICON_LOCATION : String = "";
    public static var ALERT_BUTTON_LOCATION : String = "";
    public static var ALERT_LABEL_LOCATION : String = "";
    
    public static var ALERT_CLOSE_BUTTON_NORMAL_COLOR : Int = -1;
    public static var ALERT_CLOSE_BUTTON_OVER_COLOR : Int = -1;
    public static var ALERT_CLOSE_BUTTON_DOWN_COLOR : Int = -1;
    public static var ALERT_CLOSE_BUTTON_DISABLE_COLOR : Int = -1;
    
    public static var ALERT_POSITIVE_BUTTON_NORMAL_COLOR : Int = -1;
    public static var ALERT_POSITIVE_BUTTON_OVER_COLOR : Int = -1;
    public static var ALERT_POSITIVE_BUTTON_DOWN_COLOR : Int = -1;
    
    public static var ALERT_NEGATIVE_BUTTON_NORMAL_COLOR : Int = -1;
    public static var ALERT_NEGATIVE_BUTTON_OVER_COLOR : Int = -1;
    public static var ALERT_NEGATIVE_BUTTON_DOWN_COLOR : Int = -1;
    
    public static var ALERT_NEUTRAL_BUTTON_NORMAL_COLOR : Int = -1;
    public static var ALERT_NEUTRAL_BUTTON_OVER_COLOR : Int = -1;
    public static var ALERT_NEUTRAL_BUTTON_DOWN_COLOR : Int = -1;
    
    public static var BUBBLE_BACKGROUND_NORMAL_COLOR : Int = -1;
    public static var BUBBLE_BACKGROUND_ALPHA : Float = 1;
    
    public static var BUBBLE_BORDER_ALPHA : Float = -1;
    public static var BUBBLE_BORDER : Bool = true;
    public static var BUBBLE_BORDER_COLOR : Int = -1;
    public static var BUBBLE_BORDER_THINKNESS : Float = -1;
    
    public static var BUTTON_TINT_ALPHA : Float = -1;
    
    public static var BUTTON_NORMAL_COLOR : Int = -1;
    public static var BUTTON_OVER_COLOR : Int = -1;
    public static var BUTTON_DOWN_COLOR : Int = -1;
    public static var BUTTON_DISABLE_COLOR : Int = -1;
    
    public static var BUTTON_TEXT_EMBED : Font = null;
    public static var BUTTON_TEXT_FONT : String = "";
    public static var BUTTON_TEXT_COLOR : Int = -1;
    public static var BUTTON_TEXT_SIZE : Int = -1;
    
    public static var BUTTON_TEXT_BOLD : Bool = false;
    public static var BUTTON_TEXT_ITALIC : Bool = false;
    
    public static var BUTTON_TEXT_ALIGN : String = "";
    
    /** How rounded the button will be */
    public static var BUTTON_ROUND_NUM : Int = -1;
    
    /** Text label off set for location X */
    public static var BUTTON_TEXT_OFFSET_X : Int = 3;
    
    /** Text label off set for location Y */
    public static var BUTTON_TEXT_OFFSET_Y : Int = 0;
    
    /** Image icon off set for location X */
    public static var BUTTON_IMAGE_OFFSET_X : Int = 2;
    
    /** Image icon off set for location Y */
    public static var BUTTON_IMAGE_OFFSET_Y : Int = 2;
    
    /** Set the default size of the button icon width. If -1 then will load default size */
    public static var BUTTON_ICON_WIDTH : Int = -1;
    
    /** Set the default size of the button icon height. If -1 then will load default size */
    public static var BUTTON_ICON_HEIGHT : Int = -1;
    
    /** The default button width */
    public static var BUTTON_WIDTH : Int = -1;
    
    /** The default button height */
    public static var BUTTON_HEIGHT : Int = -1;
    
    /** The default button highlight color */
    public static var BUTTON_ALPHA : Float = 1;
    
    /** The filter mode for the button text */
    public static var BUTTON_SHADOW_FILTER : Bool = true;
    
    /** The default filter mode for the button bevel edge */
    public static var BUTTON_BEVEL_FILTER : Bool = true;
    
    public static var CHECKBOX_NORMAL_COLOR : Int = -1;
    public static var CHECKBOX_OVER_COLOR : Int = -1;
    public static var CHECKBOX_DOWN_COLOR : Int = -1;
    public static var CHECKBOX_DISABLE_COLOR : Int = -1;
    
    public static var CHECKBOX_NORMAL_SELECTED_COLOR : Int = -1;
    public static var CHECKBOX_OVER_SELECTED_COLOR : Int = -1;
    public static var CHECKBOX_DOWN_SELECTED_COLOR : Int = -1;
    public static var CHECKBOX_DISABLE_SELECTED_COLOR : Int = -1;
    
    public static var CHECKBOX_TEXT_EMBED : Font = null;
    public static var CHECKBOX_TEXT_FONT : String = "";
    public static var CHECKBOX_TEXT_COLOR : Int = -1;
    
    public static var CHECKBOX_TEXT_BOLD : Bool = false;
    public static var CHECKBOX_TEXT_ITALIC : Bool = false;
    public static var CHECKBOX_TEXT_SIZE : Int = -1;
    
    public static var CHECKBOX_TEXT_ALIGN : String = "";
    
    /** The over all size of checkbox */
    public static var CHECKBOX_SIZE : Int = 9;
    
    /** Label offset on x axis */
    public static var CHECKBOX_LABEL_OFFSET_X : Int = 12;
    
    /** Label offset on y axis */
    public static var CHECKBOX_LABEL_OFFSET_Y : Int = -1;
    
    public static var RADIOBUTTON_NORMAL_SELECTED_COLOR : Int = -1;
    public static var RADIOBUTTON_OVER_SELECTED_COLOR : Int = -1;
    public static var RADIOBUTTON_DOWN_SELECTED_COLOR : Int = -1;
    public static var RADIOBUTTON_DISABLE_SELECTED_COLOR : Int = -1;
    
    public static var RADIOBUTTON_NORMAL_COLOR : Int = -1;
    public static var RADIOBUTTON_OVER_COLOR : Int = -1;
    public static var RADIOBUTTON_DOWN_COLOR : Int = -1;
    public static var RADIOBUTTON_DISABLE_COLOR : Int = -1;
    
    public static var RADIOBUTTON_TEXT_EMBED : Font = null;
    public static var RADIOBUTTON_TEXT_FONT : String = "";
    public static var RADIOBUTTON_TEXT_COLOR : Int = -1;
    
    public static var RADIOBUTTON_TEXT_BOLD : Bool = false;
    public static var RADIOBUTTON_TEXT_ITALIC : Bool = false;
    public static var RADIOBUTTON_TEXT_SIZE : Int = -1;
    
    public static var RADIOBUTTON_TEXT_ALIGN : String = "";
    
    /** The radio button over all size */
    public static var RADIO_BTN_SIZE : Int = 4;
    
    /** The radio button dot */
    public static var RADIO_BTN_DOT : Int = 1;
    
    /** Radio button offset on the x axis */
    public static var RADIO_BTN_OFFSET_X : Int = 5;
    
    /** Radio button offset on the y axis */
    public static var RADIO_BTN_OFFSET_Y : Int = 6;
    
    /** Label offset on x axis */
    public static var RADIO_LABEL_OFFSET_X : Int = 10;
    
    /** Label offset on y axis */
    public static var RADIO_LABEL_OFFSET_Y : Int = 5;
    
    public static var COMBO_BUTTON_NORMAL_COLOR : Int = -1;
    public static var COMBO_BUTTON_OVER_COLOR : Int = -1;
    public static var COMBO_BUTTON_DOWN_COLOR : Int = -1;
    public static var COMBO_BUTTON_DISABLE_COLOR : Int = -1;
    
	public static var COMBO_BUTTON_ICON_COLOR : Int = -1;
	public static var COMBO_BUTTON_ICON_BORDER_COLOR : Int = -1;
	
    public static var COMBO_BORDER_ALPHA : Float = -1;
    public static var COMBO_BORDER : Bool = true;
    public static var COMBO_BORDER_COLOR : Int = -1;
    public static var COMBO_BORDER_THINKNESS : Float = -1;
    
	public static var COMBO_DROPDOWN_PADDING : Int = -1;
	
    public static var COMBO_TEXT_EMBED : Font = null;
    public static var COMBO_TEXT_FONT : String = "";
    public static var COMBO_TEXT_COLOR : Int = -1;
    
    public static var COMBO_TEXT_BOLD : Bool = false;
    public static var COMBO_TEXT_ITALIC : Bool = false;
    public static var COMBO_TEXT_SIZE : Int = -1;
    
    public static var COMBO_TEXT_ALIGN : String = "";
    
    public static var COMBO_TEXT_OVER_COLOR : Int = -1;
    public static var COMBO_TEXT_DOWN_COLOR : Int = -1;
    
    public static var COMBO_TEXT_NORMAL_BACKGROUND_COLOR : Int = -1;
    public static var COMBO_TEXT_OVER_BACKGROUND_COLOR : Int = -1;
    public static var COMBO_TEXT_DOWN_BACKGROUND_COLOR : Int = -1;
    
    public static var GRID_BACKGROUND : Bool = false;
    public static var GRID_BACKGROUND_COLOR : Int = -1;
    
    public static var GRID_CELL_BACKGROUND : Bool = false;
    public static var GRID_CELL_BACKGROUND_COLOR : Int = -1;
    
    public static var GRID_BORDER_ALPHA : Float = -1;
    public static var GRID_BORDER : Bool = false;
    public static var GRID_BORDER_COLOR : Int = -1;
    public static var GRID_BORDER_THINKNESS : Float = -1;
    
    public static var GRID_CELL_BORDER_ALPHA : Float = -1;
    public static var GRID_CELL_BORDER : Bool = false;
    public static var GRID_CELL_BORDER_COLOR : Int = -1;
    public static var GRID_CELL_BORDER_THINKNESS : Float = -1;
    
    public static var GRID_COLUMN_BUTTON_NORMAL_COLOR : Int = -1;
    public static var GRID_COLUMN_BUTTON_OVER_COLOR : Int = -1;
    public static var GRID_COLUMN_BUTTON_DOWN_COLOR : Int = -1;
    
    public static var LIST_BORDER_ALPHA : Float = -1;
    public static var LIST_BORDER : Bool = false;
    public static var LIST_BORDER_COLOR : Int = -1;
    public static var LIST_BORDER_THINKNESS : Float = -1;
    
    public static var LIST_BACKGROUND_COLOR : Int = -1;
    
    public static var LIST_TEXT_EMBED : Font = null;
    public static var LIST_TEXT_FONT : String = "";
    
    public static var LIST_TEXT_NORMAL_COLOR : Int = -1;
    public static var LIST_TEXT_OVER_COLOR : Int = -1;
    public static var LIST_TEXT_SELECTED_COLOR : Int = -1;
    
    public static var LIST_TEXT_SELECTED_BACKGROUND_COLOR : Int = -1;
    
    public static var LIST_TEXT_BOLD : Bool = false;
    public static var LIST_TEXT_ITALIC : Bool = false;
    public static var LIST_TEXT_SIZE : Int = -1;
    
    public static var LABEL_BORDER_ALPHA : Float = -1;
    public static var LABEL_BORDER : Bool = false;
    public static var LABEL_BORDER_COLOR : Int = -1;
    public static var LABEL_BORDER_THINKNESS : Float = -1;
    
    public static var LABEL_BACKGROUND : Bool = false;
    public static var LABEL_BACKGROUND_COLOR : Int = -1;
    
    public static var LABEL_TEXT_EMBED : Font = null;
    public static var LABEL_TEXT_FONT : String = "";
    public static var LABEL_TEXT_COLOR : Int = -1;
    
    public static var LABEL_TEXT_BOLD : Bool = false;
    public static var LABEL_TEXT_ITALIC : Bool = false;
    public static var LABEL_TEXT_SIZE : Int = -1;
    
    public static var LABEL_TEXT_ALIGN : String = "";
    
    /** Set the amount of pixels the text will be indented by  */
    public static var LABEL_INDENT : Int = 0;
    
    public static var INPUT_BACKGROUND : Bool = true;
    
    public static var INPUT_BACKGROUND_NORMAL_COLOR : Int = -1;
    public static var INPUT_BACKGROUND_OVER_COLOR : Int = -1;
    public static var INPUT_BACKGROUND_SELECTED_COLOR : Int = -1;
    public static var INPUT_BACKGROUND_DISABLE_COLOR : Int = -1;
    
    public static var INPUT_BORDER_ALPHA : Float = -1;
    public static var INPUT_BORDER : Bool = true;
    public static var INPUT_BORDER_COLOR : Int = -1;
    public static var INPUT_BORDER_THINKNESS : Float = -1;
    
    public static var INPUT_TEXT_EMBED : Font = null;
    public static var INPUT_TEXT_FONT : String = "";
    
    public static var INPUT_TEXT_COLOR : Int = -1;
    public static var INPUT_TEXT_OVER_COLOR : Int = -1;
    public static var INPUT_TEXT_SELECTED_COLOR : Int = -1;
    public static var INPUT_TEXT_DISABLE_COLOR : Int = -1;
    
    public static var INPUT_TEXT_BOLD : Bool = false;
    public static var INPUT_TEXT_ITALIC : Bool = false;
    
    public static var PROGRESSBAR_BORDER_ALPHA : Float = -1;
    public static var PROGRESSBAR_BORDER : Bool = true;
    public static var PROGRESSBAR_BORDER_COLOR : Int = -1;
    public static var PROGRESSBAR_BORDER_THINKNESS : Float = -1;
    
    public static var PROGRESSBAR_TEXT_EMBED : Font = null;
    public static var PROGRESSBAR_TEXT_FONT : String = "";
    
    public static var PROGRESSBAR_TEXT_LOADED_COLOR : Int = -1;
    public static var PROGRESSBAR_TEXT_COLOR : Int = -1;
    
    public static var PROGRESSBAR_TEXT_BOLD : Bool = false;
    public static var PROGRESSBAR_TEXT_ITALIC : Bool = false;
    public static var PROGRESSBAR_TEXT_SIZE : Int = -1;
    
    public static var PROGRESSBAR_COLOR : Int = -1;
    public static var PROGRESSBAR_COLOR_LOADED : Int = -1;
    
    public static var PROGRESSBAR_TEXT_ALIGN : String = "";
    
    public static var PROGRESS_SLIDER_BORDER_ALPHA : Float = -1;
    public static var PROGRESS_SLIDER_BORDER : Bool = true;
    public static var PROGRESS_SLIDER_BORDER_COLOR : Int = -1;
    public static var PROGRESS_SLIDER_BORDER_THINKNESS : Float = -1;
    
    public static var PROGRESS_SLIDER_TEXT_EMBED : Font = null;
    public static var PROGRESS_SLIDER_TEXT_FONT : String = "";
    
    public static var PROGRESS_SLIDER_TEXT_LOADED_COLOR : Int = -1;
    public static var PROGRESS_SLIDER_TEXT_COLOR : Int = -1;
    
    public static var PROGRESS_SLIDER_TEXT_BOLD : Bool = false;
    public static var PROGRESS_SLIDER_TEXT_ITALIC : Bool = false;
    public static var PROGRESS_SLIDER_TEXT_SIZE : Int = -1;
    
    public static var PROGRESS_SLIDER_COLOR : Int = -1;
    public static var PROGRESS_SLIDER_COLOR_LOADED : Int = -1;
    
    public static var PROGRESS_SLIDER_TEXT_ALIGN : String = "";
    
    public static var PROGRESS_SLIDER_NORMAL_COLOR : Int = -1;
    public static var PROGRESS_SLIDER_OVER_COLOR : Int = -1;
    public static var PROGRESS_SLIDER_DOWN_COLOR : Int = -1;
    public static var PROGRESS_SLIDER_DISABLE_COLOR : Int = -1;
    public static var PROGRESS_SLIDER_SIZE : Int = -1;
    
    public static var PROGRESS_SLIDER_ROTATE_IMAGE : Bool = false;
    
    public static var PROGRESS_SLIDER_OFFSET : Int = -1;
    
    public static var SCROLLBAR_ROTATE_IMAGE : Bool = false;
    public static var SCROLLBAR_SLIDER_OFFSET : Int = -1;
    
    public static var SCROLLBAR_BUTTON_NORMAL_COLOR : Int = -1;
    public static var SCROLLBAR_BUTTON_OVER_COLOR : Int = -1;
    public static var SCROLLBAR_BUTTON_DOWN_COLOR : Int = -1;
    
    public static var SCROLLBAR_BUTTON_SIZE : Int = -1;
    
    public static var SCROLLBAR_SLIDER_NORMAL_COLOR : Int = -1;
    public static var SCROLLBAR_SLIDER_OVER_COLOR : Int = -1;
    public static var SCROLLBAR_SLIDER_DOWN_COLOR : Int = -1;
    public static var SCROLLBAR_SLIDER_SIZE : Int = -1;
    
    public static var SCROLLBAR_TRACK_COLOR : Int = -1;
    public static var SCROLLBAR_TRACK_SIZE : Int = -1;
    public static var SCROLLBAR_SLIDER_ACTIVE_RESIZE : Bool = true;
    
    /** The scroller offset */
    public static var SCROLLBAR_OFFSET : Int = 0;
    
    public static var SLIDER_NORMAL_COLOR : Int = -1;
    public static var SLIDER_OVER_COLOR : Int = -1;
    public static var SLIDER_DOWN_COLOR : Int = -1;
    public static var SLIDER_DISABLE_COLOR : Int = -1;
    public static var SLIDER_SIZE : Int = -1;
    
    public static var SLIDER_TRACK_COLOR : Int = -1;
    public static var SLIDER_TRACK_SIZE : Int = -1;
    
    public static var SLIDER_ROTATE_IMAGE : Bool = false;
    
    public static var SLIDER_OFFSET : Int = -1;
    
    public static var SCROLLPANE_BACKGROUND : Int = -1;
    
    public static var SCROLLPANE_BORDER_ALPHA : Float = -1;
    public static var SCROLLPANE_BORDER : Bool = false;
    public static var SCROLLPANE_BORDER_COLOR : Int = -1;
    public static var SCROLLPANE_BORDER_THINKNESS : Float = -1;
    
    public static var SCROLLPANE_CONTENT_OFFSET_X : Float = 0;
    public static var SCROLLPANE_CONTENT_OFFSET_Y : Float = 0;
    
    public static var SCROLLPANE_CONTENT_WIDTH_OFFSET : Float = 0;
    public static var SCROLLPANE_CONTENT_HEIGHT_OFFSET : Float = 0;
    
    public static var ITEMPANE_BACKGROUND : Int = -1;
    
    public static var ITEMPANE_BORDER_ALPHA : Float = -1;
    public static var ITEMPANE_BORDER : Bool = false;
    public static var ITEMPANE_BORDER_COLOR : Int = -1;
    public static var ITEMPANE_BORDER_THINKNESS : Float = -1;
    
    public static var ITEMPANE_ITEM_BORDER_ALPHA : Float = -1;
    public static var ITEMPANE_ITEM_BORDER : Bool = false;
    public static var ITEMPANE_ITEM_BORDER_COLOR : Int = -1;
    public static var ITEMPANE_ITEM_BORDER_THINKNESS : Float = -1;
    
    public static var ITEMPANE_ITEM_NORMAL_COLOR : Int = -1;
    public static var ITEMPANE_ITEM_OVER_COLOR : Int = -1;
    public static var ITEMPANE_ITEM_SELECTED_COLOR : Int = -1;
    public static var ITEMPANE_ITEM_DISABLE_COLOR : Int = -1;
    
    public static var ITEMPANE_TEXT_EMBED : Font = null;
    public static var ITEMPANE_TEXT_FONT : String = "";
    public static var ITEMPANE_TEXT_COLOR : Int = -1;
    
    public static var ITEMPANE_TEXT_BOLD : Bool = false;
    public static var ITEMPANE_TEXT_ITALIC : Bool = false;
    public static var ITEMPANE_TEXT_SIZE : Int = -1;
    
    /** The default width of items for each */
    public static var ITEMPANE_DEFAULT_ITEM_WIDTH : Int = 40;
    
    /** The default height of items for each */
    public static var ITEMPANE_DEFAULT_ITEM_HEIGHT : Int = 40;
    
    /** The location use for icons on x-axis */
    public static var ITEMPANE_ICON_LOC_X : Int = 5;
    
    /** The location use for icons on y-axis */
    public static var ITEMPANE_ICON_LOC_Y : Int = 5;
    
    /** The location of the item itself on x-axis */
    public static var ITEMPANE_ITEM_LOC_X : Int = 0;
    
    /** The location of the item itself on y-axis */
    public static var ITEMPANE_ITEM_LOC_Y : Int = 0;
    
    /** The offset of the x-axis */
    public static var ITEMPANE_LABEL_OFFSET_X : Int = 0;
    
    /** The offset of the y-axis */
    public static var ITEMPANE_LABEL_OFFSET_Y : Int = -2;
    
    public static var TABPANE_BACKGROUND : Int = -1;
    
    public static var TABPANE_BUTTON_TINT_ALPHA : Float = -1;
    
    public static var TABPANE_BUTTON_NORMAL_COLOR : Int = -1;
    public static var TABPANE_BUTTON_OVER_COLOR : Int = -1;
    public static var TABPANE_BUTTON_DISABLE_COLOR : Int = -1;
    public static var TABPANE_BUTTON_SELECTED_COLOR : Int = -1;
    
    public static var TABPANE_BUTTON_TEXT_EMBED : Font = null;
    public static var TABPANE_BUTTON_TEXT_FONT : String = "";
    public static var TABPANE_BUTTON_TEXT_COLOR : Int = -1;
    public static var TABPANE_BUTTON_TEXT_COLOR_SELECTED : Int = -1;
    
    public static var TABPANE_BUTTON_TEXT_BOLD : Bool = false;
    public static var TABPANE_BUTTON_TEXT_ITALIC : Bool = false;
    public static var TABPANE_BUTTON_TEXT_SIZE : Int = -1;
    
    public static var TABPANE_BORDER_ALPHA : Float = -1;
    public static var TABPANE_BORDER : Bool = true;
    public static var TABPANE_BORDER_COLOR : Int = -1;
    public static var TABPANE_BORDER_THINKNESS : Float = -1;
    
    public static var TOOLTIP_BACKGROUND_NORMAL_COLOR : Int = -1;
    public static var TOOLTIP_BACKGROUND_ALPHA : Float = 1;
    
    public static var TOOLTIP_BORDER_ALPHA : Float = -1;
    public static var TOOLTIP_BORDER : Bool = true;
    public static var TOOLTIP_BORDER_COLOR : Int = -1;
    public static var TOOLTIP_BORDER_THINKNESS : Float = -1;
    
    public static var TOOLTIP_LABEL_TEXT_EMBED : Font = null;
    public static var TOOLTIP_LABEL_TEXT_FONT : String = "";
    public static var TOOLTIP_LABEL_TEXT_COLOR : Int = -1;
    
    public static var TOOLTIP_LABEL_TEXT_SIZE : Int = -1;
    
    public static var TOOLTIP_LABEL_PADDING : Int = 10;
    
    public static var TOOLTIP_BUBBLE_LOC_X : Float = 0;
    public static var TOOLTIP_BUBBLE_LOC_Y : Float = 0;
    
    public static var WINDOW_TITLE_TEXT_EMBED : Font = null;
    public static var WINDOW_TITLE_TEXT_FONT : String = "";
    public static var WINDOW_TITLE_TEXT_COLOR : Int = -1;
    public static var WINDOW_TITLE_TEXT_SIZE : Int = -1;
    
    public static var WINDOW_TITLE_AREA_COLOR : Int = -1;
    public static var WINDOW_TITLE_AREA_UNFOCUS_COLOR : Int = -1;
    
    public static var WINDOW_FOCUS_COLOR : Int = -1;
    public static var WINDOW_UNFOCUS_COLOR : Int = -1;
    
    public static var WINDOW_BORDER_ALPHA : Float = -1;
    public static var WINDOW_BORDER : Bool = false;
    public static var WINDOW_BORDER_COLOR : Int = -1;
    
    public static var WINDOW_BACKGROUND_COLOR : Int = -1;
    
    public static var WINDOW_ICON_LOCATION : String = "";
    public static var WINDOW_BUTTON_LOCATION : String = "";
    public static var WINDOW_LABEL_LOCATION : String = "";
    
    public static var WINDOW_MIN_NORMAL_COLOR : Int = -1;
    public static var WINDOW_MIN_OVER_COLOR : Int = -1;
    public static var WINDOW_MIN_DOWN_COLOR : Int = -1;
    public static var WINDOW_MIN_DISABLE_COLOR : Int = -1;
    
    public static var WINDOW_MAX_NORMAL_COLOR : Int = -1;
    public static var WINDOW_MAX_OVER_COLOR : Int = -1;
    public static var WINDOW_MAX_DOWN_COLOR : Int = -1;
    public static var WINDOW_MAX_DISABLE_COLOR : Int = -1;
    
    public static var WINDOW_CLOSE_NORMAL_COLOR : Int = -1;
    public static var WINDOW_CLOSE_OVER_COLOR : Int = -1;
    public static var WINDOW_CLOSE_DOWN_COLOR : Int = -1;
    public static var WINDOW_CLOSE_DISABLE_COLOR : Int = -1;
    
    public static var MENU_BACKGROUND_COLOR : Int = -1;
    public static var MENU_BACKGROUND_ALPHA : Float = -1;
    
    public static var MENU_NORMAL_COLOR : Int = -1;
    public static var MENU_OVER_COLOR : Int = -1;
    public static var MENU_DOWN_COLOR : Int = -1;
    public static var MENU_DISABLE_COLOR : Int = -1;
    
    public static var MENU_SUB_NORMAL_COLOR : Int = -1;
    public static var MENU_SUB_OVER_COLOR : Int = -1;
    public static var MENU_SUB_DOWN_COLOR : Int = -1;
    public static var MENU_SUB_DISABLE_COLOR : Int = -1;
    
    public static var MENU_BORDER_ALPHA : Float = -1;
    public static var MENU_BORDER : Bool = false;
    public static var MENU_BORDER_THINKNESS : Float = -1;
    
    public static var MENU_BORDER_NORMAL_COLOR : Int = -1;
    public static var MENU_BORDER_OVER_COLOR : Int = -1;
    public static var MENU_BORDER_DOWN_COLOR : Int = -1;
    public static var MENU_BORDER_DISABLE_COLOR : Int = -1;
    
    public static var MENU_SUB_BORDER_ALPHA : Float = -1;
    public static var MENU_SUB_BORDER : Bool = false;
    public static var MENU_SUB_BORDER_THINKNESS : Float = -1;
    
    public static var MENU_SUB_BORDER_NORMAL_COLOR : Int = -1;
    public static var MENU_SUB_BORDER_OVER_COLOR : Int = -1;
    public static var MENU_SUB_BORDER_DOWN_COLOR : Int = -1;
    public static var MENU_SUB_BORDER_DISABLE_COLOR : Int = -1;
    
    public static var MENU_LABEL_TEXT_EMBED : Font = null;
    public static var MENU_LABEL_TEXT_FONT : String = "";
    
    public static var MENU_LABEL_TEXT_NORMAL_COLOR : Int = -1;
    public static var MENU_LABEL_TEXT_OVER_COLOR : Int = -1;
    public static var MENU_LABEL_TEXT_DOWN_COLOR : Int = -1;
    public static var MENU_LABEL_TEXT_DISABLE_COLOR : Int = -1;
    
    public static var MENU_LABEL_TEXT_BOLD : Bool = false;
    public static var MENU_LABEL_TEXT_ITALIC : Bool = false;
    public static var MENU_LABEL_TEXT_SIZE : Int = -1;
    
    public static var MENU_SUB_LABEL_TEXT_EMBED : Font = null;
    public static var MENU_SUB_LABEL_TEXT_FONT : String = "";
    
    public static var MENU_SUB_LABEL_TEXT_NORMAL_COLOR : Int = -1;
    public static var MENU_SUB_LABEL_TEXT_OVER_COLOR : Int = -1;
    public static var MENU_SUB_LABEL_TEXT_DOWN_COLOR : Int = -1;
    public static var MENU_SUB_LABEL_TEXT_DISABLE_COLOR : Int = -1;
    
    public static var MENU_SUB_LABEL_TEXT_BOLD : Bool = false;
    public static var MENU_SUB_LABEL_TEXT_ITALIC : Bool = false;
    
    public static var MENU_SUB_LABEL_TEXT_SIZE : Int = -1;
    
    public function new()
    {
        
    }
}

