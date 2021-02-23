package com.chaos.ui;



import openfl.text.Font;


/**
 * Setting the UI colors, fonts, font sizes and etc.
 *
 * @author Erick Feiling
 */

class UIStyleManager
{
	
    public static var ACCORDION_BUTTON_NORMAL_COLOR : String = "ACCORDION_BUTTON_NORMAL_COLOR";
    public static var ACCORDION_BUTTON_OVER_COLOR : String = "ACCORDION_BUTTON_OVER_COLOR";
    public static var ACCORDION_BUTTON_SELECTED_COLOR : String = "ACCORDION_BUTTON_SELECTED_COLOR";
    public static var ACCORDION_BUTTON_DISABLE_COLOR : String = "ACCORDION_BUTTON_DISABLE_COLOR";
	
	public static var ACCORDION_BUTTON_TEXT_COLOR : String = "ACCORDION_BUTTON_TEXT_COLOR";
	public static var ACCORDION_BUTTON_SELECTED_TEXT_COLOR : String = "ACCORDION_BUTTON_SELECTED_TEXT_COLOR";
	
    public static var ACCORDION_BACKGROUND_COLOR : String = "ACCORDION_BACKGROUND_COLOR";
    
    public static var ACCORDION_USE_CUSTOM_RENDER : String = "ACCORDION_USE_CUSTOM_RENDER";//Bool = false;
	
    public static var ACCORDION_TEXT_EMBED : String = "ACCORDION_TEXT_EMBED";
    public static var ACCORDION_TEXT_FONT : String = "ACCORDION_TEXT_FONT";
	
    public static var ALERT_BACKGROUND_COLOR : String = "ALERT_BACKGROUND_COLOR";
    
    public static var ALERT_TITLE_TEXT_EMBED : String = "ALERT_TITLE_TEXT_EMBED";
    public static var ALERT_TITLE_TEXT_FONT : String = "ALERT_TITLE_TEXT_FONT";
    public static var ALERT_TITLE_TEXT_COLOR : String = "ALERT_TITLE_TEXT_COLOR";
    public static var ALERT_TITLE_TEXT_SIZE : String = "ALERT_TITLE_TEXT_SIZE";
    
    public static var ALERT_TITLE_TEXT_BOLD : String = "ALERT_TITLE_TEXT_BOLD";
    public static var ALERT_TITLE_TEXT_ITALIC : String = "ALERT_TITLE_TEXT_ITALIC";
    
    public static var ALERT_TITLE_AREA_COLOR : String = "ALERT_TITLE_AREA_COLOR";
    public static var ALERT_TITLE_AREA_UNFOCUS_COLOR : String = "ALERT_TITLE_AREA_UNFOCUS_COLOR";
    
    public static var ALERT_WINDOW_FOCUS_COLOR : String = "ALERT_WINDOW_FOCUS_COLOR";
    public static var ALERT_WINDOW_UNFOCUS_COLOR : String = "ALERT_WINDOW_UNFOCUS_COLOR";
    
    public static var ALERT_MODAL_TINT_ALPHA : String = "ALERT_MODAL_TINT_ALPHA";//Float = -1;
    public static var ALERT_MODAL_BACKGROUND_COLOR : String = "ALERT_MODAL_BACKGROUND_COLOR";
    
    public static var ALERT_OK_TEXT : String = "ALERT_OK_TEXT";
    public static var ALERT_CANCEL_TEXT : String = "ALERT_CANCEL_TEXT";
    public static var ALERT_YES_TEXT : String = "ALERT_YES_TEXT";
    public static var ALERT_NO_TEXT : String = "ALERT_NO_TEXT";
    public static var ALERT_MAYBE_TEXT : String = "ALERT_MAYBE_TEXT";
    
    public static var ALERT_BOTTOM_COLOR : String = "ALERT_BOTTOM_COLOR";
    public static var ALERT_UNFOCUS_BOTTOM_COLOR : String = "ALERT_UNFOCUS_BOTTOM_COLOR";//Int = -1;
    
    public static var ALERT_ICON_LOCATION : String = "ALERT_ICON_LOCATION";
    public static var ALERT_BUTTON_LOCATION : String = "ALERT_BUTTON_LOCATION";
    public static var ALERT_LABEL_LOCATION : String = "ALERT_LABEL_LOCATION";
    
    public static var ALERT_CLOSE_BUTTON_NORMAL_COLOR : String = "ALERT_CLOSE_BUTTON_NORMAL_COLOR";
    public static var ALERT_CLOSE_BUTTON_OVER_COLOR : String = "ALERT_CLOSE_BUTTON_OVER_COLOR";
    public static var ALERT_CLOSE_BUTTON_DOWN_COLOR : String = "ALERT_CLOSE_BUTTON_DOWN_COLOR";
    public static var ALERT_CLOSE_BUTTON_DISABLE_COLOR : String = "ALERT_CLOSE_BUTTON_DISABLE_COLOR";
    
    public static var ALERT_POSITIVE_BUTTON_NORMAL_COLOR : String = "ALERT_POSITIVE_BUTTON_NORMAL_COLOR";
    public static var ALERT_POSITIVE_BUTTON_OVER_COLOR : String = "ALERT_POSITIVE_BUTTON_OVER_COLOR";
    public static var ALERT_POSITIVE_BUTTON_DOWN_COLOR : String = "ALERT_POSITIVE_BUTTON_DOWN_COLOR";
    
    public static var ALERT_NEGATIVE_BUTTON_NORMAL_COLOR : String = "ALERT_NEGATIVE_BUTTON_NORMAL_COLOR";
    public static var ALERT_NEGATIVE_BUTTON_OVER_COLOR : String = "ALERT_NEGATIVE_BUTTON_OVER_COLOR";
    public static var ALERT_NEGATIVE_BUTTON_DOWN_COLOR : String = "ALERT_NEGATIVE_BUTTON_DOWN_COLOR";
    
    public static var ALERT_NEUTRAL_BUTTON_NORMAL_COLOR : String = "ALERT_NEUTRAL_BUTTON_NORMAL_COLOR";
    public static var ALERT_NEUTRAL_BUTTON_OVER_COLOR : String = "ALERT_NEUTRAL_BUTTON_OVER_COLOR";
    public static var ALERT_NEUTRAL_BUTTON_DOWN_COLOR : String = "ALERT_NEUTRAL_BUTTON_DOWN_COLOR";
    
    public static var BUBBLE_BACKGROUND_NORMAL_COLOR : String = "BUBBLE_BACKGROUND_NORMAL_COLOR";
    public static var BUBBLE_BACKGROUND_ALPHA : String = "BUBBLE_BACKGROUND_ALPHA";
    
    public static var BUBBLE_BORDER_ALPHA : String = "BUBBLE_BORDER_ALPHA";
    public static var BUBBLE_BORDER : String = "BUBBLE_BORDER";
    public static var BUBBLE_BORDER_COLOR : String = "BUBBLE_BORDER_COLOR";
    public static var BUBBLE_BORDER_THINKNESS : String = "BUBBLE_BORDER_THINKNESS";
    
    public static var BUTTON_TINT_ALPHA : String = "BUTTON_TINT_ALPHA";
    
    public static var BUTTON_NORMAL_COLOR : String = "BUTTON_NORMAL_COLOR";
    public static var BUTTON_OVER_COLOR : String = "BUTTON_OVER_COLOR";
    public static var BUTTON_DOWN_COLOR : String = "BUTTON_DOWN_COLOR";
    public static var BUTTON_DISABLE_COLOR : String = "BUTTON_DISABLE_COLOR";

    public static var BUTTON_TILE_IMAGE : String = "BUTTON_TILE_IMAGE";

    public static var BUTTON_USE_CUSTOM_RENDER : String = "BUTTON_USE_CUSTOM_RENDER";
    
    public static var BUTTON_TEXT_EMBED : String = "BUTTON_TEXT_EMBED";
    public static var BUTTON_TEXT_FONT : String = "BUTTON_TEXT_FONT";
    public static var BUTTON_TEXT_COLOR : String = "BUTTON_TEXT_COLOR";
    public static var BUTTON_TEXT_DISABLE_COLOR : String = "BUTTON_TEXT_DISABLE_COLOR";
    public static var BUTTON_TEXT_SIZE : String = "BUTTON_TEXT_SIZE";
    
    public static var BUTTON_TEXT_BOLD : String = "BUTTON_TEXT_BOLD";
    public static var BUTTON_TEXT_ITALIC : String = "BUTTON_TEXT_ITALIC";
    
    public static var BUTTON_TEXT_ALIGN : String = "BUTTON_TEXT_ALIGN";
    
    /** How rounded the button will be */
    public static var BUTTON_ROUND_NUM : String = "BUTTON_ROUND_NUM";
    
    /** Text label off set for location X */
    public static var BUTTON_TEXT_OFFSET_X : String = "BUTTON_TEXT_OFFSET_X";//Int = 3;
    
    /** Text label off set for location Y */
    public static var BUTTON_TEXT_OFFSET_Y : String = "BUTTON_TEXT_OFFSET_Y";//Int = 0;
    
    /** Image icon off set for location X */
    public static var BUTTON_IMAGE_OFFSET_X : String = "BUTTON_IMAGE_OFFSET_X";//Int = 2;
    
    /** Image icon off set for location Y */
    public static var BUTTON_IMAGE_OFFSET_Y : String = "BUTTON_IMAGE_OFFSET_Y";//Int = 2;
    
    /** Set the default size of the button icon width. If -1 then will load default size */
    public static var BUTTON_ICON_WIDTH : String = "BUTTON_ICON_WIDTH";//Int = -1;
    
    /** Set the default size of the button icon height. If -1 then will load default size */
    public static var BUTTON_ICON_HEIGHT : String = "BUTTON_ICON_HEIGHT";//Int = -1;
    
    /** The default button width */
    public static var BUTTON_WIDTH : String = "BUTTON_WIDTH";
    
    /** The default button height */
    public static var BUTTON_HEIGHT : String = "BUTTON_HEIGHT";
    
    /** The default button highlight color */
    public static var BUTTON_ALPHA : String = "BUTTON_ALPHA";
    
    /** The filter mode for the button text */
    public static var BUTTON_SHADOW_FILTER : String = "BUTTON_SHADOW_FILTER";
    
    /** The default filter mode for the button bevel edge */
    public static var BUTTON_BEVEL_FILTER : String = "BUTTON_BEVEL_FILTER";
    
    public static var CHECKBOX_NORMAL_COLOR : String = "CHECKBOX_NORMAL_COLOR";
    public static var CHECKBOX_OVER_COLOR : String = "CHECKBOX_OVER_COLOR";
    public static var CHECKBOX_DOWN_COLOR : String = "CHECKBOX_DOWN_COLOR";
    public static var CHECKBOX_DISABLE_COLOR : String = "CHECKBOX_DISABLE_COLOR";
    
    public static var CHECKBOX_TEXT_COLOR : String = "CHECKBOX_TEXT_COLOR";
    
    public static var CHECKBOX_TEXT_BOLD : String = "CHECKBOX_TEXT_BOLD";
    public static var CHECKBOX_TEXT_ITALIC : String = "CHECKBOX_TEXT_ITALIC";
    public static var CHECKBOX_TEXT_SIZE : String = "CHECKBOX_TEXT_SIZE";
    
    public static var CHECKBOX_TEXT_ALIGN : String = "CHECKBOX_TEXT_ALIGN";

    public static var CHECKBOX_USE_CUSTOM_RENDER : String = "CHECKBOX_USE_CUSTOM_RENDER";
    
    /** The over all size of checkbox */
    public static var CHECKBOX_SIZE : String = "CHECKBOX_SIZE";
    
    /** Label offset on x axis */
    public static var CHECKBOX_LABEL_OFFSET_X : String = "CHECKBOX_LABEL_OFFSET_X";
    
    /** Label offset on y axis */
    public static var CHECKBOX_LABEL_OFFSET_Y : String = "CHECKBOX_LABEL_OFFSET_Y";
    
    public static var RADIOBUTTON_NORMAL_COLOR : String = "RADIOBUTTON_NORMAL_COLOR";
    public static var RADIOBUTTON_OVER_COLOR : String = "RADIOBUTTON_OVER_COLOR";
    public static var RADIOBUTTON_DOWN_COLOR : String = "RADIOBUTTON_DOWN_COLOR";
    public static var RADIOBUTTON_DISABLE_COLOR : String = "RADIOBUTTON_DISABLE_COLOR";
    
    public static var RADIOBUTTON_TEXT_COLOR : String = "RADIOBUTTON_TEXT_COLOR";
    
    public static var RADIOBUTTON_TEXT_BOLD : String = "RADIOBUTTON_TEXT_BOLD";
    public static var RADIOBUTTON_TEXT_ITALIC : String = "RADIOBUTTON_TEXT_ITALIC";
    public static var RADIOBUTTON_TEXT_SIZE : String = "RADIOBUTTON_TEXT_SIZE";
    
    public static var RADIOBUTTON_TEXT_ALIGN : String = "RADIOBUTTON_TEXT_ALIGN";

    public static var RADIOBUTTON_USE_CUSTOM_RENDER : String = "RADIOBUTTON_USE_CUSTOM_RENDER";
    
    /** The radio button over all size */
    public static var RADIOBUTTON_SIZE : String = "RADIOBUTTON_SIZE";
    
    /** The radio button dot */
    public static var RADIOBUTTON_DOT : String = "RADIOBUTTON_DOT";
    
    /** Radio button offset on the x axis */
    public static var RADIOBUTTON_OFFSET_X : String = "RADIOBUTTON_OFFSET_X";
    
    /** Radio button offset on the y axis */
    public static var RADIOBUTTON_OFFSET_Y : String = "RADIOBUTTON_OFFSET_Y";
    
    /** Label offset on x axis */
    public static var RADIOBUTTON_LABEL_OFFSET_X : String = "RADIOBUTTON_LABEL_OFFSET_X";
    
    /** Label offset on y axis */
    public static var RADIOBUTTON_LABEL_OFFSET_Y : String = "RADIOBUTTON_LABEL_OFFSET_Y";
    
    public static var COMBO_BUTTON_NORMAL_COLOR : String = "COMBO_BUTTON_NORMAL_COLOR";
    public static var COMBO_BUTTON_OVER_COLOR : String = "COMBO_BUTTON_OVER_COLOR";
    public static var COMBO_BUTTON_DOWN_COLOR : String = "COMBO_BUTTON_DOWN_COLOR";
    public static var COMBO_BUTTON_DISABLE_COLOR : String = "COMBO_BUTTON_DISABLE_COLOR";
    
	public static var COMBO_BUTTON_ICON_COLOR : String = "COMBO_BUTTON_ICON_COLOR";
	public static var COMBO_BUTTON_ICON_BORDER_COLOR : String = "COMBO_BUTTON_ICON_BORDER_COLOR";
	
    public static var COMBO_BORDER_ALPHA : String = "COMBO_BORDER_ALPHA";
    public static var COMBO_BORDER : String = "COMBO_BORDER";
    public static var COMBO_BORDER_COLOR : String = "COMBO_BORDER_COLOR";
    public static var COMBO_BACKGROUND_COLOR : String = "COMBO_BACKGROUND_COLOR";
    public static var COMBO_BORDER_THINKNESS : String = "COMBO_BORDER_THINKNESS";
    
	public static var COMBO_DROPDOWN_PADDING : String = "COMBO_DROPDOWN_PADDING";
	
    public static var COMBO_TEXT_EMBED : String = "COMBO_TEXT_EMBED";
    public static var COMBO_TEXT_FONT : String = "COMBO_TEXT_FONT";
    public static var COMBO_TEXT_COLOR : String = "COMBO_TEXT_COLOR";
    
    public static var COMBO_TEXT_BOLD : String = "COMBO_TEXT_BOLD";
    public static var COMBO_TEXT_ITALIC : String = "COMBO_TEXT_ITALIC";
    public static var COMBO_TEXT_SIZE : String = "COMBO_TEXT_SIZE";
    
    public static var COMBO_TEXT_ALIGN : String = "COMBO_TEXT_ALIGN";
    
    public static var COMBO_TEXT_OVER_COLOR : String = "COMBO_TEXT_OVER_COLOR";
    public static var COMBO_TEXT_DOWN_COLOR : String = "COMBO_TEXT_DOWN_COLOR";
	
	public static var COMBO_DEFAULT_TEXT : String = "COMBO_DEFAULT_TEXT";
    
    public static var COMBO_TEXT_NORMAL_BACKGROUND_COLOR : String = "COMBO_TEXT_NORMAL_BACKGROUND_COLOR";
    public static var COMBO_TEXT_OVER_BACKGROUND_COLOR : String = "COMBO_TEXT_OVER_BACKGROUND_COLOR";
    public static var COMBO_TEXT_DOWN_BACKGROUND_COLOR : String = "COMBO_TEXT_DOWN_BACKGROUND_COLOR";
    
    public static var GRID_BACKGROUND : String = "GRID_BACKGROUND";
    public static var GRID_BACKGROUND_COLOR : String = "GRID_BACKGROUND_COLOR";
    
    public static var GRID_CELL_BACKGROUND : String = "GRID_CELL_BACKGROUND";
    public static var GRID_CELL_BACKGROUND_COLOR : String = "GRID_CELL_BACKGROUND_COLOR";
    
    public static var GRID_BORDER_ALPHA : String = "GRID_BORDER_ALPHA";
    public static var GRID_BORDER : String = "GRID_BORDER";
    public static var GRID_BORDER_COLOR : String = "GRID_BORDER_COLOR";
    public static var GRID_BORDER_THINKNESS : String = "GRID_BORDER_THINKNESS";
    
    public static var GRID_CELL_BORDER_ALPHA : String = "GRID_CELL_BORDER_ALPHA";
    public static var GRID_CELL_BORDER : String = "GRID_CELL_BORDER";
    public static var GRID_CELL_BORDER_COLOR : String = "GRID_CELL_BORDER_COLOR";
    public static var GRID_CELL_BORDER_THINKNESS : String = "GRID_CELL_BORDER_THINKNESS";
    
    public static var GRID_COLUMN_BUTTON_NORMAL_COLOR : String = "GRID_COLUMN_BUTTON_NORMAL_COLOR";
    public static var GRID_COLUMN_BUTTON_OVER_COLOR : String = "GRID_COLUMN_BUTTON_OVER_COLOR";
    public static var GRID_COLUMN_BUTTON_DOWN_COLOR : String = "GRID_COLUMN_BUTTON_DOWN_COLOR";
    
    public static var LIST_BORDER_ALPHA : String = "LIST_BORDER_ALPHA";
    public static var LIST_BORDER : String = "LIST_BORDER";
    public static var LIST_BORDER_COLOR : String = "LIST_BORDER_COLOR";
    public static var LIST_BORDER_THINKNESS : String = "LIST_BORDER_THINKNESS";
    
    public static var LIST_BACKGROUND_COLOR : String = "LIST_BACKGROUND_COLOR";
    
    public static var LIST_TEXT_EMBED : String = "LIST_TEXT_EMBED";
    /** String **/
    public static var LIST_TEXT_FONT : String = "LIST_TEXT_FONT";
    
    /** Int **/
    public static var LIST_TEXT_NORMAL_COLOR : String = "LIST_TEXT_NORMAL_COLOR";
    /** Int **/
    public static var LIST_TEXT_OVER_COLOR : String = "LIST_TEXT_OVER_COLOR";
    /** Int **/
    public static var LIST_TEXT_OVER_BACKGROUND_COLOR : String = "LIST_TEXT_OVER_BACKGROUND_COLOR";
    /** Int **/
    public static var LIST_TEXT_SELECTED_COLOR : String = "LIST_TEXT_SELECTED_COLOR";
    
    public static var LIST_TEXT_SELECTED_BACKGROUND_COLOR : String = "LIST_TEXT_SELECTED_BACKGROUND_COLOR";
    
    public static var LIST_TEXT_BOLD : String = "LIST_TEXT_BOLD";
    public static var LIST_TEXT_ITALIC : String = "LIST_TEXT_ITALIC";
    public static var LIST_TEXT_SIZE : String = "LIST_TEXT_SIZE";
    
    public static var LABEL_BORDER_ALPHA : String = "LABEL_BORDER_ALPHA";
    public static var LABEL_BORDER : String = "LABEL_BORDER";
    public static var LABEL_BORDER_COLOR : String = "LABEL_BORDER_COLOR";
    public static var LABEL_BORDER_THINKNESS : String = "LABEL_BORDER_THINKNESS";
    
    public static var LABEL_BACKGROUND : String = "LABEL_BACKGROUND";
    public static var LABEL_BACKGROUND_COLOR : String = "LABEL_BACKGROUND_COLOR";
    
    public static var LABEL_TEXT_EMBED : String = "LABEL_TEXT_EMBED";
    public static var LABEL_TEXT_FONT : String = "LABEL_TEXT_FONT";
    public static var LABEL_TEXT_COLOR : String = "LABEL_TEXT_COLOR";
    
    public static var LABEL_TEXT_BOLD : String = "LABEL_TEXT_BOLD";
    public static var LABEL_TEXT_ITALIC : String = "LABEL_TEXT_ITALIC";
    public static var LABEL_TEXT_SIZE : String = "LABEL_TEXT_SIZE";
    
    public static var LABEL_TEXT_ALIGN : String = "LABEL_TEXT_ALIGN";
    
    /** Set the amount of pixels the text will be indented by  */
    public static var LABEL_INDENT : String = "LABEL_INDENT";
    
    public static var INPUT_BACKGROUND : String = "INPUT_BACKGROUND";
    
    public static var INPUT_BACKGROUND_NORMAL_COLOR : String = "INPUT_BACKGROUND_NORMAL_COLOR";
    public static var INPUT_BACKGROUND_OVER_COLOR : String = "INPUT_BACKGROUND_OVER_COLOR";
    public static var INPUT_BACKGROUND_SELECTED_COLOR : String = "INPUT_BACKGROUND_SELECTED_COLOR";
    public static var INPUT_BACKGROUND_DISABLE_COLOR : String = "INPUT_BACKGROUND_DISABLE_COLOR";
    
    public static var INPUT_BORDER_ALPHA : String = "INPUT_BORDER_ALPHA";
    public static var INPUT_BORDER : String = "INPUT_BORDER";
    public static var INPUT_BORDER_COLOR : String = "INPUT_BORDER_COLOR";
    public static var INPUT_BORDER_THINKNESS : String = "INPUT_BORDER_THINKNESS";
    
    public static var INPUT_TEXT_EMBED : String = "INPUT_TEXT_EMBED";
    public static var INPUT_TEXT_FONT : String = "INPUT_TEXT_FONT";
    
    public static var INPUT_TEXT_COLOR : String = "INPUT_TEXT_COLOR";
    public static var INPUT_TEXT_OVER_COLOR : String = "INPUT_TEXT_OVER_COLOR";
    public static var INPUT_TEXT_SELECTED_COLOR : String = "INPUT_TEXT_SELECTED_COLOR";
    public static var INPUT_TEXT_DISABLE_COLOR : String = "INPUT_TEXT_DISABLE_COLOR";
    
    public static var INPUT_TEXT_BOLD : String = "INPUT_TEXT_BOLD";
    public static var INPUT_TEXT_ITALIC : String = "INPUT_TEXT_ITALIC";
    
    public static var PROGRESSBAR_BORDER_ALPHA : String = "PROGRESSBAR_BORDER_ALPHA";
    public static var PROGRESSBAR_BORDER : String = "PROGRESSBAR_BORDER";
	public static var PROGRESSBAR_BORDER_COLOR : String = "PROGRESSBAR_BORDER_COLOR";
    public static var PROGRESSBAR_BORDER_THINKNESS : String = "PROGRESSBAR_BORDER_THINKNESS";
    
    public static var PROGRESSBAR_TEXT_EMBED : String = "PROGRESSBAR_TEXT_EMBED";
    public static var PROGRESSBAR_TEXT_FONT : String = "PROGRESSBAR_TEXT_FONT";
    
    public static var PROGRESSBAR_TEXT_LOADED_COLOR : String = "PROGRESSBAR_TEXT_LOADED_COLOR";
    public static var PROGRESSBAR_TEXT_COLOR : String = "PROGRESSBAR_TEXT_COLOR";
    
    public static var PROGRESSBAR_TEXT_BOLD : String = "PROGRESSBAR_TEXT_BOLD";
    public static var PROGRESSBAR_TEXT_ITALIC : String = "PROGRESSBAR_TEXT_ITALIC";
    public static var PROGRESSBAR_TEXT_SIZE : String = "PROGRESSBAR_TEXT_SIZE";

    public static var PROGRESSBAR_USE_CUSTOM_RENDER : String = "PROGRESSBAR_USE_CUSTOM_RENDER";
    
    public static var PROGRESSBAR_COLOR : String = "PROGRESSBAR_COLOR";
    public static var PROGRESSBAR_COLOR_LOADED : String = "PROGRESSBAR_COLOR_LOADED";
    
    public static var PROGRESSBAR_TEXT_ALIGN : String = "PROGRESSBAR_TEXT_ALIGN";
    
    public static var PROGRESS_SLIDER_BORDER_ALPHA : String = "PROGRESS_SLIDER_BORDER_ALPHA";
    public static var PROGRESS_SLIDER_BORDER : String = "PROGRESS_SLIDER_BORDER";
    public static var PROGRESS_SLIDER_BORDER_COLOR : String = "PROGRESS_SLIDER_BORDER_COLOR";
    public static var PROGRESS_SLIDER_BORDER_THINKNESS : String = "PROGRESS_SLIDER_BORDER_THINKNESS";
    
    public static var PROGRESS_SLIDER_TEXT_EMBED : String = "PROGRESS_SLIDER_TEXT_EMBED";
    public static var PROGRESS_SLIDER_TEXT_FONT : String = "PROGRESS_SLIDER_TEXT_FONT";
    
    public static var PROGRESS_SLIDER_TEXT_LOADED_COLOR : String = "PROGRESS_SLIDER_TEXT_LOADED_COLOR";
    public static var PROGRESS_SLIDER_TEXT_COLOR : String = "PROGRESS_SLIDER_TEXT_COLOR";
    
    public static var PROGRESS_SLIDER_TEXT_BOLD : String = "PROGRESS_SLIDER_TEXT_BOLD";
    public static var PROGRESS_SLIDER_TEXT_ITALIC : String = "PROGRESS_SLIDER_TEXT_ITALIC";
    public static var PROGRESS_SLIDER_TEXT_SIZE : String = "PROGRESS_SLIDER_TEXT_SIZE";
    
    public static var PROGRESS_SLIDER_COLOR : String = "PROGRESS_SLIDER_COLOR";
    public static var PROGRESS_SLIDER_COLOR_LOADED : String = "PROGRESS_SLIDER_COLOR_LOADED";
    
    public static var PROGRESS_SLIDER_TEXT_ALIGN : String = "PROGRESS_SLIDER_TEXT_ALIGN";
    
    public static var PROGRESS_SLIDER_NORMAL_COLOR : String = "PROGRESS_SLIDER_NORMAL_COLOR";
    public static var PROGRESS_SLIDER_OVER_COLOR : String = "PROGRESS_SLIDER_OVER_COLOR";
    public static var PROGRESS_SLIDER_DOWN_COLOR : String = "PROGRESS_SLIDER_DOWN_COLOR";
    public static var PROGRESS_SLIDER_DISABLE_COLOR : String = "PROGRESS_SLIDER_DISABLE_COLOR";
    public static var PROGRESS_SLIDER_SIZE : String = "PROGRESS_SLIDER_SIZE";
    
    public static var PROGRESS_SLIDER_ROTATE_IMAGE : String = "PROGRESS_SLIDER_ROTATE_IMAGE";
    
    public static var PROGRESS_SLIDER_OFFSET : String = "PROGRESS_SLIDER_OFFSET";
    
    public static var SCROLLBAR_ROTATE_IMAGE : String = "SCROLLBAR_ROTATE_IMAGE";
    public static var SCROLLBAR_SLIDER_OFFSET : String = "SCROLLBAR_SLIDER_OFFSET";
    
    public static var SCROLLBAR_BUTTON_USE_CUSTOM_RENDER : String = "SCROLLBAR_BUTTON_USE_CUSTOM_RENDER";

    public static var SCROLLBAR_BUTTON_NORMAL_COLOR : String = "SCROLLBAR_BUTTON_NORMAL_COLOR";
    public static var SCROLLBAR_BUTTON_OVER_COLOR : String = "SCROLLBAR_BUTTON_OVER_COLOR";
    public static var SCROLLBAR_BUTTON_DOWN_COLOR : String = "SCROLLBAR_BUTTON_DOWN_COLOR";
    public static var SCROLLBAR_BUTTON_DISABLE_COLOR : String = "SCROLLBAR_BUTTON_DISABLE_COLOR";
    
    public static var SCROLLBAR_BUTTON_SIZE : String = "SCROLLBAR_BUTTON_SIZE";
    
    public static var SCROLLBAR_SLIDER_NORMAL_COLOR : String = "SCROLLBAR_SLIDER_NORMAL_COLOR";
    public static var SCROLLBAR_SLIDER_OVER_COLOR : String = "SCROLLBAR_SLIDER_OVER_COLOR";
    public static var SCROLLBAR_SLIDER_DOWN_COLOR : String = "SCROLLBAR_SLIDER_DOWN_COLOR";
    public static var SCROLLBAR_SLIDER_SIZE : String = "SCROLLBAR_SLIDER_SIZE";
    
    public static var SCROLLBAR_TRACK_COLOR : String = "SCROLLBAR_TRACK_COLOR";
    public static var SCROLLBAR_TRACK_SIZE : String = "SCROLLBAR_TRACK_SIZE";
    public static var SCROLLBAR_SLIDER_ACTIVE_RESIZE : String = "SCROLLBAR_SLIDER_ACTIVE_RESIZE";
    
    /** The scroller offset */
    public static var SCROLLBAR_OFFSET : String = "SCROLLBAR_OFFSET";
    
    public static var SLIDER_NORMAL_COLOR : String = "SLIDER_NORMAL_COLOR";
    public static var SLIDER_OVER_COLOR : String = "SLIDER_OVER_COLOR";
    public static var SLIDER_DOWN_COLOR : String = "SLIDER_DOWN_COLOR";
    public static var SLIDER_DISABLE_COLOR : String = "SLIDER_DISABLE_COLOR";
    public static var SLIDER_SIZE : String = "SLIDER_SIZE";
    
    public static var SLIDER_TRACK_COLOR : String = "SLIDER_TRACK_COLOR";
    public static var SLIDER_TRACK_SIZE : String = "SLIDER_TRACK_SIZE";
    
    public static var SLIDER_ROTATE_IMAGE : String = "SLIDER_ROTATE_IMAGE";

    public static var SLIDER_USE_CUSTOM_RENDER : String = "SLIDER_USE_CUSTOM_RENDER";
    
    public static var SLIDER_OFFSET : String = "SLIDER_OFFSET";
    
    public static var SCROLLPANE_BACKGROUND : String = "SCROLLPANE_BACKGROUND";
    
    public static var SCROLLPANE_BORDER_ALPHA : String = "SCROLLPANE_BORDER_ALPHA";
    public static var SCROLLPANE_BORDER : String = "SCROLLPANE_BORDER";
    public static var SCROLLPANE_BORDER_COLOR : String = "SCROLLPANE_BORDER_COLOR";
    public static var SCROLLPANE_BORDER_THINKNESS : String = "SCROLLPANE_BORDER_THINKNESS";

    public static var SCROLLPANE_USE_CUSTOM_RENDER : String = "SCROLLPANE_USE_CUSTOM_RENDER";
    
    public static var SCROLLPANE_CONTENT_OFFSET_X : String = "SCROLLPANE_CONTENT_OFFSET_X";
    public static var SCROLLPANE_CONTENT_OFFSET_Y : String = "SCROLLPANE_CONTENT_OFFSET_Y";
    
    public static var SCROLLPANE_CONTENT_WIDTH_OFFSET : String = "SCROLLPANE_CONTENT_WIDTH_OFFSET";
    public static var SCROLLPANE_CONTENT_HEIGHT_OFFSET : String = "SCROLLPANE_CONTENT_HEIGHT_OFFSET";
    
    public static var ITEMPANE_BACKGROUND : String = "ITEMPANE_BACKGROUND";
    
    public static var ITEMPANE_BORDER_ALPHA : String = "ITEMPANE_BORDER_ALPHA";
    public static var ITEMPANE_BORDER : String = "ITEMPANE_BORDER";
    public static var ITEMPANE_BORDER_COLOR : String = "ITEMPANE_BORDER_COLOR";
    public static var ITEMPANE_BORDER_THINKNESS : String = "ITEMPANE_BORDER_THINKNESS";
    
    public static var ITEMPANE_ITEM_BORDER_ALPHA : String = "ITEMPANE_ITEM_BORDER_ALPHA";
    public static var ITEMPANE_ITEM_BORDER : String = "ITEMPANE_ITEM_BORDER";
    public static var ITEMPANE_ITEM_BORDER_COLOR : String = "ITEMPANE_ITEM_BORDER_COLOR";
    public static var ITEMPANE_ITEM_BORDER_THINKNESS : String = "ITEMPANE_ITEM_BORDER_THINKNESS";
    
    public static var ITEMPANE_ITEM_NORMAL_COLOR : String = "ITEMPANE_ITEM_NORMAL_COLOR";
    public static var ITEMPANE_ITEM_OVER_COLOR : String = "ITEMPANE_ITEM_OVER_COLOR";
    public static var ITEMPANE_ITEM_SELECTED_COLOR : String = "ITEMPANE_ITEM_SELECTED_COLOR";
    public static var ITEMPANE_ITEM_DISABLE_COLOR : String = "ITEMPANE_ITEM_DISABLE_COLOR";
    
    public static var ITEMPANE_TEXT_EMBED : String = "ITEMPANE_TEXT_EMBED";
    public static var ITEMPANE_TEXT_FONT : String = "ITEMPANE_TEXT_FONT";
    public static var ITEMPANE_TEXT_COLOR : String = "ITEMPANE_TEXT_COLOR";
    public static var ITEMPANE_TEXT_SELECTED_COLOR : String = "ITEMPANE_TEXT_SELECTED_COLOR";
    
    public static var ITEMPANE_TEXT_BOLD : String = "ITEMPANE_TEXT_BOLD";
    public static var ITEMPANE_TEXT_ITALIC : String = "ITEMPANE_TEXT_ITALIC";
    public static var ITEMPANE_TEXT_SIZE : String = "ITEMPANE_TEXT_SIZE";
    
    /** The default width of items for each */
    public static var ITEMPANE_DEFAULT_ITEM_WIDTH : String = "ITEMPANE_DEFAULT_ITEM_WIDTH";
    
    /** The default height of items for each */
    public static var ITEMPANE_DEFAULT_ITEM_HEIGHT : String = "ITEMPANE_DEFAULT_ITEM_HEIGHT";
    
    /** The location of the item itself on x-axis */
    public static var ITEMPANE_ITEM_LOC_X : String = "ITEMPANE_ITEM_LOC_X";
    
    /** The location of the item itself on y-axis */
    public static var ITEMPANE_ITEM_LOC_Y : String = "ITEMPANE_ITEM_LOC_Y";
    
    /** The offset of the x-axis */
    public static var ITEMPANE_LABEL_OFFSET_X : String = "ITEMPANE_LABEL_OFFSET_X";
    
    /** The offset of the y-axis */
    public static var ITEMPANE_LABEL_OFFSET_Y : String = "ITEMPANE_LABEL_OFFSET_Y";
    
    public static var TABPANE_BACKGROUND : String = "TABPANE_BACKGROUND";
    
    public static var TABPANE_BUTTON_TINT_ALPHA : String = "TABPANE_BUTTON_TINT_ALPHA";
    
    public static var TABPANE_BUTTON_NORMAL_COLOR : String = "TABPANE_BUTTON_NORMAL_COLOR";
    public static var TABPANE_BUTTON_OVER_COLOR : String = "TABPANE_BUTTON_OVER_COLOR";
    public static var TABPANE_BUTTON_DISABLE_COLOR : String = "TABPANE_BUTTON_DISABLE_COLOR";
    public static var TABPANE_BUTTON_SELECTED_COLOR : String = "TABPANE_BUTTON_SELECTED_COLOR";
    
    public static var TABPANE_BUTTON_TEXT_EMBED : String = "TABPANE_BUTTON_TEXT_EMBED";
    public static var TABPANE_BUTTON_TEXT_FONT : String = "TABPANE_BUTTON_TEXT_FONT";
    public static var TABPANE_BUTTON_TEXT_COLOR : String = "TABPANE_BUTTON_TEXT_COLOR";
    public static var TABPANE_BUTTON_TEXT_COLOR_SELECTED : String = "TABPANE_BUTTON_TEXT_COLOR_SELECTED";
    
    public static var TABPANE_BUTTON_TEXT_BOLD : String = "TABPANE_BUTTON_TEXT_BOLD";
    public static var TABPANE_BUTTON_TEXT_ITALIC : String = "TABPANE_BUTTON_TEXT_ITALIC";
    public static var TABPANE_BUTTON_TEXT_SIZE : String = "TABPANE_BUTTON_TEXT_SIZE";
    
    public static var TABPANE_BORDER_ALPHA : String = "TABPANE_BORDER_ALPHA";
    public static var TABPANE_BORDER : String = "TABPANE_BORDER";
    public static var TABPANE_BORDER_COLOR : String = "TABPANE_BORDER_COLOR";
    public static var TABPANE_BORDER_THINKNESS : String = "TABPANE_BORDER_THINKNESS";

    public static var TOGGLE_BUTTON_BORDER : String = "TOGGLE_BUTTON_BORDER";
    public static var TOGGLE_BUTTON_BORDER_ALPHA : String = "TOGGLE_BUTTON_BORDER_ALPHA";
    
    public static var TOGGLE_BUTTON_BORDER_NORMAL_COLOR : String = "TOGGLE_BUTTON_BORDER_NORMAL_COLOR";
    public static var TOGGLE_BUTTON_BORDER_OVER_COLOR : String = "TOGGLE_BUTTON_BORDER_OVER_COLOR";
    public static var TOGGLE_BUTTON_BORDER_DISABLE_COLOR : String = "TOGGLE_BUTTON_BORDER_DISABLE_COLOR";
    public static var TOGGLE_BUTTON_BORDER_SELECTED_COLOR : String = "TOGGLE_BUTTON_BORDER_SELECTED_COLOR";

    public static var TOGGLE_BUTTON_BORDER_THINKNESS : String = "TOGGLE_BUTTON_BORDER_THINKNESS";

    public static var TOGGLE_BUTTON_NORMAL_COLOR : String = "TOGGLE_BUTTON_NORMAL_COLOR";
    public static var TOGGLE_BUTTON_OVER_COLOR :String = "TOGGLE_BUTTON_OVER_COLOR";
    public static var TOGGLE_BUTTON_DISABLE_COLOR :String = "TOGGLE_BUTTON_DISABLE_COLOR";
    public static var TOGGLE_BUTTON_SELECTED_COLOR : String = "TOGGLE_BUTTON_SELECTED_COLOR";
    
    public static var TOOLTIP_BACKGROUND_NORMAL_COLOR : String = "TOOLTIP_BACKGROUND_NORMAL_COLOR";
    public static var TOOLTIP_BACKGROUND_ALPHA : String = "TOOLTIP_BACKGROUND_ALPHA";

    public static var TOGGLE_BUTTON_USE_CUSTOM_RENDER : String = "TOGGLE_BUTTON_USE_CUSTOM_RENDER";

    public static var TOGGLE_TILE_IMAGE : String = "TOGGLE_TILE_IMAGE";
    
    public static var TOOLTIP_BORDER_ALPHA : String = "TOOLTIP_BORDER_ALPHA";
    public static var TOOLTIP_BORDER : String = "TOOLTIP_BORDER";
    public static var TOOLTIP_BORDER_COLOR : String = "TOOLTIP_BORDER_COLOR";
    public static var TOOLTIP_BORDER_THINKNESS : String = "TOOLTIP_BORDER_THINKNESS";
    
    public static var TOOLTIP_LABEL_TEXT_EMBED : String = "TOOLTIP_LABEL_TEXT_EMBED";
    public static var TOOLTIP_LABEL_TEXT_FONT : String = "TOOLTIP_LABEL_TEXT_FONT";
    public static var TOOLTIP_LABEL_TEXT_COLOR : String = "TOOLTIP_LABEL_TEXT_COLOR";
    
    public static var TOOLTIP_LABEL_TEXT_SIZE : String = "TOOLTIP_LABEL_TEXT_SIZE";
    
    public static var TOOLTIP_LABEL_PADDING : String = "TOOLTIP_LABEL_PADDING";
    
    public static var TOOLTIP_BUBBLE_LOC_X : String = "TOOLTIP_BUBBLE_LOC_X";
    public static var TOOLTIP_BUBBLE_LOC_Y : String = "TOOLTIP_BUBBLE_LOC_Y";
    
    public static var WINDOW_TITLE_TEXT_EMBED : String = "WINDOW_TITLE_TEXT_EMBED";
    public static var WINDOW_TITLE_TEXT_FONT : String = "WINDOW_TITLE_TEXT_FONT";
    public static var WINDOW_TITLE_TEXT_COLOR : String = "WINDOW_TITLE_TEXT_COLOR";
    public static var WINDOW_TITLE_TEXT_SIZE : String = "WINDOW_TITLE_TEXT_SIZE";
    
    public static var WINDOW_TITLE_AREA_COLOR : String = "";
    public static var WINDOW_TITLE_AREA_UNFOCUS_COLOR : String = "WINDOW_TITLE_AREA_UNFOCUS_COLOR";
    
    public static var WINDOW_FOCUS_COLOR : String = "WINDOW_FOCUS_COLOR";
    public static var WINDOW_UNFOCUS_COLOR : String = "WINDOW_UNFOCUS_COLOR";
    
    public static var WINDOW_BORDER_ALPHA : String = "WINDOW_BORDER_ALPHA";
    public static var WINDOW_BORDER : String = "WINDOW_BORDER";
    public static var WINDOW_BORDER_COLOR : String = "WINDOW_BORDER_COLOR";
    
    public static var WINDOW_BACKGROUND_COLOR : String = "WINDOW_BACKGROUND_COLOR";
    
    public static var WINDOW_ICON_LOCATION : String = "WINDOW_ICON_LOCATION";
    public static var WINDOW_BUTTON_LOCATION : String = "WINDOW_BUTTON_LOCATION";
    public static var WINDOW_LABEL_LOCATION : String = "WINDOW_LABEL_LOCATION";
	
    
    public static var WINDOW_MIN_NORMAL_COLOR : String = "WINDOW_MIN_NORMAL_COLOR";
    public static var WINDOW_MIN_OVER_COLOR : String = "WINDOW_MIN_OVER_COLOR";
    public static var WINDOW_MIN_DOWN_COLOR : String = "WINDOW_MIN_DOWN_COLOR";
    public static var WINDOW_MIN_DISABLE_COLOR : String = "WINDOW_MIN_DISABLE_COLOR";
    public static var WINDOW_MIN_UNFOCUS_COLOR : String = "WINDOW_MIN_UNFOCUS_COLOR";
	
    public static var WINDOW_MAX_NORMAL_COLOR : String = "WINDOW_MAX_NORMAL_COLOR";
    public static var WINDOW_MAX_OVER_COLOR : String = "WINDOW_MAX_OVER_COLOR";
    public static var WINDOW_MAX_DOWN_COLOR : String = "WINDOW_MAX_DOWN_COLOR";
    public static var WINDOW_MAX_DISABLE_COLOR : String = "WINDOW_MAX_DISABLE_COLOR";
    public static var WINDOW_MAX_UNFOCUS_COLOR : String = "WINDOW_MAX_UNFOCUS_COLOR";
	
    public static var WINDOW_CLOSE_NORMAL_COLOR : String = "WINDOW_CLOSE_NORMAL_COLOR";
    public static var WINDOW_CLOSE_OVER_COLOR : String = "WINDOW_CLOSE_OVER_COLOR";
    public static var WINDOW_CLOSE_DOWN_COLOR : String = "WINDOW_CLOSE_DOWN_COLOR";
    public static var WINDOW_CLOSE_DISABLE_COLOR : String = "WINDOW_CLOSE_DISABLE_COLOR";
    public static var WINDOW_CLOSE_UNFOCUS_COLOR : String = "WINDOW_CLOSE_UNFOCUS_COLOR";
	
    public static var MENU_BACKGROUND_COLOR : String = "MENU_BACKGROUND_COLOR";
    public static var MENU_BACKGROUND_ALPHA : String = "MENU_BACKGROUND_ALPHA";

    public static var ICON_BORDER : String = "ICON_BORDER";
    public static var ICON_COLOR : String = "ICON_COLOR";
    public static var ICON_BORDER_COLOR : String = "ICON_BORDER_COLOR";
    
    public static var MENU_NORMAL_COLOR : String = "MENU_NORMAL_COLOR";
    public static var MENU_OVER_COLOR : String = "MENU_OVER_COLOR";
    public static var MENU_DOWN_COLOR : String = "MENU_DOWN_COLOR";
    public static var MENU_DISABLE_COLOR : String = "MENU_DISABLE_COLOR";
    
    public static var MENU_SUB_NORMAL_COLOR : String = "MENU_SUB_NORMAL_COLOR";
    public static var MENU_SUB_OVER_COLOR : String = "MENU_SUB_OVER_COLOR";
    public static var MENU_SUB_DOWN_COLOR : String = "MENU_SUB_DOWN_COLOR";
    public static var MENU_SUB_DISABLE_COLOR : String = "MENU_SUB_DISABLE_COLOR";
    
    public static var MENU_BORDER_ALPHA : String = "MENU_BORDER_ALPHA";
    public static var MENU_BORDER : String = "MENU_BORDER";
    public static var MENU_BORDER_THINKNESS : String = "MENU_BORDER_THINKNESS";
    
    public static var MENU_BORDER_NORMAL_COLOR : String = "MENU_BORDER_NORMAL_COLOR";
    public static var MENU_BORDER_OVER_COLOR : String = "MENU_BORDER_OVER_COLOR";
    public static var MENU_BORDER_DOWN_COLOR : String = "MENU_BORDER_DOWN_COLOR";
    public static var MENU_BORDER_DISABLE_COLOR : String = "MENU_BORDER_DISABLE_COLOR";
    
    public static var MENU_SUB_BORDER_ALPHA : String = "MENU_SUB_BORDER_ALPHA";
    public static var MENU_SUB_BORDER : String = "MENU_SUB_BORDER";
    public static var MENU_SUB_BORDER_THINKNESS : String = "MENU_SUB_BORDER_THINKNESS";
    
    public static var MENU_SUB_BORDER_NORMAL_COLOR : String = "MENU_SUB_BORDER_NORMAL_COLOR";
    public static var MENU_SUB_BORDER_OVER_COLOR : String = "MENU_SUB_BORDER_OVER_COLOR";
    public static var MENU_SUB_BORDER_DOWN_COLOR : String = "MENU_SUB_BORDER_DOWN_COLOR";
    public static var MENU_SUB_BORDER_DISABLE_COLOR : String = "MENU_SUB_BORDER_DISABLE_COLOR";
    
    public static var MENU_LABEL_TEXT_EMBED : String = "MENU_LABEL_TEXT_EMBED";
    public static var MENU_LABEL_TEXT_FONT : String = "MENU_LABEL_TEXT_FONT";
    
    public static var MENU_LABEL_TEXT_NORMAL_COLOR : String = "MENU_LABEL_TEXT_NORMAL_COLOR";
    public static var MENU_LABEL_TEXT_OVER_COLOR : String = "MENU_LABEL_TEXT_OVER_COLOR";
    public static var MENU_LABEL_TEXT_DOWN_COLOR : String = "MENU_LABEL_TEXT_DOWN_COLOR";
    public static var MENU_LABEL_TEXT_DISABLE_COLOR : String = "MENU_LABEL_TEXT_DISABLE_COLOR";
    
    public static var MENU_LABEL_TEXT_BOLD : String = "MENU_LABEL_TEXT_BOLD";
    public static var MENU_LABEL_TEXT_ITALIC : String = "MENU_LABEL_TEXT_ITALIC";
    public static var MENU_LABEL_TEXT_SIZE : String = "MENU_LABEL_TEXT_SIZE";
    
    public static var MENU_SUB_LABEL_TEXT_EMBED : String = "MENU_SUB_LABEL_TEXT_EMBED";
    public static var MENU_SUB_LABEL_TEXT_FONT : String = "MENU_SUB_LABEL_TEXT_FONT";
    
    public static var MENU_SUB_LABEL_TEXT_NORMAL_COLOR : String = "MENU_SUB_LABEL_TEXT_NORMAL_COLOR";
    public static var MENU_SUB_LABEL_TEXT_OVER_COLOR : String = "MENU_SUB_LABEL_TEXT_OVER_COLOR";
    public static var MENU_SUB_LABEL_TEXT_DOWN_COLOR : String = "MENU_SUB_LABEL_TEXT_DOWN_COLOR";
    public static var MENU_SUB_LABEL_TEXT_DISABLE_COLOR : String = "MENU_SUB_LABEL_TEXT_DISABLE_COLOR";
    
    public static var MENU_SUB_LABEL_TEXT_BOLD : String = "MENU_SUB_LABEL_TEXT_BOLD";
    public static var MENU_SUB_LABEL_TEXT_ITALIC : String = "MENU_SUB_LABEL_TEXT_ITALIC";
    
    public static var MENU_SUB_LABEL_TEXT_SIZE : String = "MENU_SUB_LABEL_TEXT_SIZE";

    private static var styleList:Dynamic = {};
    
    public function new() {}

    public static function setStyle(styleName : String, value:Dynamic) : Void 
    {
		Reflect.setField(styleList,styleName,value);
	}

    public static function hasStyle(styleName : String) : Bool {
        return Reflect.hasField(styleList, styleName);
    }

    public static function getStyle(styleName : String) : Dynamic {
        return Reflect.field(styleList, styleName);
    }
}

