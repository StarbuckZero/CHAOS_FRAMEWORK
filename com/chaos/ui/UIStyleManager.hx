package com.chaos.ui;



import openfl.text.Font;


/**
 * Defines style keys and shared values for UI colors, fonts, and sizing.
 *
 * @author Erick Feiling
 */

class UIStyleManager
{
    /** Style key for the chart background color. */
    public static inline var CHART_BACKGROUND_COLOR:String = "CHART_BACKGROUND_COLOR";
    /** Style key for the chart background alpha. */
    public static inline var CHART_BACKGROUND_ALPHA:String = "CHART_BACKGROUND_ALPHA";
    /** Style key for the chart border color. */
    public static inline var CHART_BORDER_COLOR:String = "CHART_BORDER_COLOR";
    /** Style key for the chart border thickness. */
    public static inline var CHART_BORDER_THICKNESS:String = "CHART_BORDER_THICKNESS";
    /** Style key for the chart border alpha. */
    public static inline var CHART_BORDER_ALPHA:String = "CHART_BORDER_ALPHA";
    /** Style key for the chart title color. */
    public static inline var CHART_TITLE_COLOR:String = "CHART_TITLE_COLOR";
    /** Style key for the chart label color. */
    public static inline var CHART_LABEL_COLOR:String = "CHART_LABEL_COLOR";
    /** Style key for the chart axis color. */
    public static inline var CHART_AXIS_COLOR:String = "CHART_AXIS_COLOR";
    /** Style key for the chart grid color. */
    public static inline var CHART_GRID_COLOR:String = "CHART_GRID_COLOR";
    /** Style key for the chart grid alpha. */
    public static inline var CHART_GRID_ALPHA:String = "CHART_GRID_ALPHA";
    /** Style key for the chart default width. */
    public static inline var CHART_DEFAULT_WIDTH:String = "CHART_DEFAULT_WIDTH";
    /** Style key for the chart default height. */
    public static inline var CHART_DEFAULT_HEIGHT:String = "CHART_DEFAULT_HEIGHT";
    /** Style key for the chart series colors. */
    public static inline var CHART_SERIES_COLORS:String = "CHART_SERIES_COLORS";
    /** Style key for the chart selection color. */
    public static inline var CHART_SELECTION_COLOR:String = "CHART_SELECTION_COLOR";
    /** Style key for the chart rollover color. */
    public static inline var CHART_ROLLOVER_COLOR:String = "CHART_ROLLOVER_COLOR";
    /** Style key for the chart empty text color. */
    public static inline var CHART_EMPTY_TEXT_COLOR:String = "CHART_EMPTY_TEXT_COLOR";
    /** Style key for the chart font. */
    public static inline var CHART_FONT:String = "CHART_FONT";
    /** Style key for the chart font size. */
    public static inline var CHART_FONT_SIZE:String = "CHART_FONT_SIZE";
	/** Default background color shared by BaseContainer and derived containers. */
	public static var BASE_CONTAINER_BACKGROUND_COLOR : String = "BASE_CONTAINER_BACKGROUND_COLOR";

	/** Repeat BaseContainer background images instead of stretching them. */
	public static var BASE_CONTAINER_TILE_IMAGE : String = "BASE_CONTAINER_TILE_IMAGE";
	
    /** Style key for the accordion button normal color. */
    public static var ACCORDION_BUTTON_NORMAL_COLOR : String = "ACCORDION_BUTTON_NORMAL_COLOR";
    /** Style key for the accordion button hover color. */
    public static var ACCORDION_BUTTON_OVER_COLOR : String = "ACCORDION_BUTTON_OVER_COLOR";
    /** Style key for the accordion button selected color. */
    public static var ACCORDION_BUTTON_SELECTED_COLOR : String = "ACCORDION_BUTTON_SELECTED_COLOR";
    /** Style key for the accordion button disabled color. */
    public static var ACCORDION_BUTTON_DISABLE_COLOR : String = "ACCORDION_BUTTON_DISABLE_COLOR";
	
	/** Style key for the accordion button text color. */
	public static var ACCORDION_BUTTON_TEXT_COLOR : String = "ACCORDION_BUTTON_TEXT_COLOR";
	/** Style key for the accordion button selected text color. */
	public static var ACCORDION_BUTTON_SELECTED_TEXT_COLOR : String = "ACCORDION_BUTTON_SELECTED_TEXT_COLOR";
	
    /** Style key for the accordion background color. */
    public static var ACCORDION_BACKGROUND_COLOR : String = "ACCORDION_BACKGROUND_COLOR";
    /** Style key for the accordion tile image. */
    public static var ACCORDION_TILE_IMAGE : String = "ACCORDION_TILE_IMAGE";
    
    /** Style key for the accordion use custom render. */
    public static var ACCORDION_USE_CUSTOM_RENDER : String = "ACCORDION_USE_CUSTOM_RENDER";//Bool = false;
	
    /** Style key for the accordion text embed. */
    public static var ACCORDION_TEXT_EMBED : String = "ACCORDION_TEXT_EMBED";
    /** Style key for the accordion text font. */
    public static var ACCORDION_TEXT_FONT : String = "ACCORDION_TEXT_FONT";
	
    /** Style key for the alert background color. */
    public static var ALERT_BACKGROUND_COLOR : String = "ALERT_BACKGROUND_COLOR";
    
    /** Style key for the alert title text embed. */
    public static var ALERT_TITLE_TEXT_EMBED : String = "ALERT_TITLE_TEXT_EMBED";
    /** Style key for the alert title text font. */
    public static var ALERT_TITLE_TEXT_FONT : String = "ALERT_TITLE_TEXT_FONT";
    /** Style key for the alert title text color. */
    public static var ALERT_TITLE_TEXT_COLOR : String = "ALERT_TITLE_TEXT_COLOR";
    /** Style key for the alert title text size. */
    public static var ALERT_TITLE_TEXT_SIZE : String = "ALERT_TITLE_TEXT_SIZE";
    
    /** Style key for the alert title text bold. */
    public static var ALERT_TITLE_TEXT_BOLD : String = "ALERT_TITLE_TEXT_BOLD";
    /** Style key for the alert title text italic. */
    public static var ALERT_TITLE_TEXT_ITALIC : String = "ALERT_TITLE_TEXT_ITALIC";
    
    /** Style key for the alert title area color. */
    public static var ALERT_TITLE_AREA_COLOR : String = "ALERT_TITLE_AREA_COLOR";
    /** Style key for the alert title area unfocused color. */
    public static var ALERT_TITLE_AREA_UNFOCUS_COLOR : String = "ALERT_TITLE_AREA_UNFOCUS_COLOR";
    
    /** Style key for the alert window focus color. */
    public static var ALERT_WINDOW_FOCUS_COLOR : String = "ALERT_WINDOW_FOCUS_COLOR";
    /** Style key for the alert window unfocused color. */
    public static var ALERT_WINDOW_UNFOCUS_COLOR : String = "ALERT_WINDOW_UNFOCUS_COLOR";
    
    /** Style key for the alert modal tint alpha. */
    public static var ALERT_MODAL_TINT_ALPHA : String = "ALERT_MODAL_TINT_ALPHA";//Float = -1;
    /** Style key for the alert modal background color. */
    public static var ALERT_MODAL_BACKGROUND_COLOR : String = "ALERT_MODAL_BACKGROUND_COLOR";
    
    /** Style key for the alert ok text. */
    public static var ALERT_OK_TEXT : String = "ALERT_OK_TEXT";
    /** Style key for the alert cancel text. */
    public static var ALERT_CANCEL_TEXT : String = "ALERT_CANCEL_TEXT";
    /** Style key for the alert yes text. */
    public static var ALERT_YES_TEXT : String = "ALERT_YES_TEXT";
    /** Style key for the alert no text. */
    public static var ALERT_NO_TEXT : String = "ALERT_NO_TEXT";
    /** Style key for the alert maybe text. */
    public static var ALERT_MAYBE_TEXT : String = "ALERT_MAYBE_TEXT";
    
    /** Style key for the alert bottom color. */
    public static var ALERT_BOTTOM_COLOR : String = "ALERT_BOTTOM_COLOR";
    /** Style key for the alert unfocused bottom color. */
    public static var ALERT_UNFOCUS_BOTTOM_COLOR : String = "ALERT_UNFOCUS_BOTTOM_COLOR";//Int = -1;
    
    /** Style key for the alert icon location. */
    public static var ALERT_ICON_LOCATION : String = "ALERT_ICON_LOCATION";
    /** Style key for the alert button location. */
    public static var ALERT_BUTTON_LOCATION : String = "ALERT_BUTTON_LOCATION";
    /** Style key for the alert label location. */
    public static var ALERT_LABEL_LOCATION : String = "ALERT_LABEL_LOCATION";
    
    /** Style key for the alert close button normal color. */
    public static var ALERT_CLOSE_BUTTON_NORMAL_COLOR : String = "ALERT_CLOSE_BUTTON_NORMAL_COLOR";
    /** Style key for the alert close button hover color. */
    public static var ALERT_CLOSE_BUTTON_OVER_COLOR : String = "ALERT_CLOSE_BUTTON_OVER_COLOR";
    /** Style key for the alert close button pressed color. */
    public static var ALERT_CLOSE_BUTTON_DOWN_COLOR : String = "ALERT_CLOSE_BUTTON_DOWN_COLOR";
    /** Style key for the alert close button disabled color. */
    public static var ALERT_CLOSE_BUTTON_DISABLE_COLOR : String = "ALERT_CLOSE_BUTTON_DISABLE_COLOR";
    
    /** Style key for the alert positive button normal color. */
    public static var ALERT_POSITIVE_BUTTON_NORMAL_COLOR : String = "ALERT_POSITIVE_BUTTON_NORMAL_COLOR";
    /** Style key for the alert positive button hover color. */
    public static var ALERT_POSITIVE_BUTTON_OVER_COLOR : String = "ALERT_POSITIVE_BUTTON_OVER_COLOR";
    /** Style key for the alert positive button pressed color. */
    public static var ALERT_POSITIVE_BUTTON_DOWN_COLOR : String = "ALERT_POSITIVE_BUTTON_DOWN_COLOR";
    
    /** Style key for the alert negative button normal color. */
    public static var ALERT_NEGATIVE_BUTTON_NORMAL_COLOR : String = "ALERT_NEGATIVE_BUTTON_NORMAL_COLOR";
    /** Style key for the alert negative button hover color. */
    public static var ALERT_NEGATIVE_BUTTON_OVER_COLOR : String = "ALERT_NEGATIVE_BUTTON_OVER_COLOR";
    /** Style key for the alert negative button pressed color. */
    public static var ALERT_NEGATIVE_BUTTON_DOWN_COLOR : String = "ALERT_NEGATIVE_BUTTON_DOWN_COLOR";
    
    /** Style key for the alert neutral button normal color. */
    public static var ALERT_NEUTRAL_BUTTON_NORMAL_COLOR : String = "ALERT_NEUTRAL_BUTTON_NORMAL_COLOR";
    /** Style key for the alert neutral button hover color. */
    public static var ALERT_NEUTRAL_BUTTON_OVER_COLOR : String = "ALERT_NEUTRAL_BUTTON_OVER_COLOR";
    /** Style key for the alert neutral button pressed color. */
    public static var ALERT_NEUTRAL_BUTTON_DOWN_COLOR : String = "ALERT_NEUTRAL_BUTTON_DOWN_COLOR";
    
    /** Style key for the bubble background normal color. */
    public static var BUBBLE_BACKGROUND_NORMAL_COLOR : String = "BUBBLE_BACKGROUND_NORMAL_COLOR";
    /** Style key for the bubble background alpha. */
    public static var BUBBLE_BACKGROUND_ALPHA : String = "BUBBLE_BACKGROUND_ALPHA";
    
    /** Style key for the bubble border alpha. */
    public static var BUBBLE_BORDER_ALPHA : String = "BUBBLE_BORDER_ALPHA";
    /** Style key for the bubble border. */
    public static var BUBBLE_BORDER : String = "BUBBLE_BORDER";
    /** Style key for the bubble border color. */
    public static var BUBBLE_BORDER_COLOR : String = "BUBBLE_BORDER_COLOR";
    /** Style key for the bubble border thickness. */
    public static var BUBBLE_BORDER_THICKNESS : String = "BUBBLE_BORDER_THICKNESS";
    
    /** Style key for the button tint alpha. */
    public static var BUTTON_TINT_ALPHA : String = "BUTTON_TINT_ALPHA";
    
    /** Style key for the button normal color. */
    public static var BUTTON_NORMAL_COLOR : String = "BUTTON_NORMAL_COLOR";
    /** Style key for the button hover color. */
    public static var BUTTON_OVER_COLOR : String = "BUTTON_OVER_COLOR";
    /** Style key for the button pressed color. */
    public static var BUTTON_DOWN_COLOR : String = "BUTTON_DOWN_COLOR";
    /** Style key for the button disabled color. */
    public static var BUTTON_DISABLE_COLOR : String = "BUTTON_DISABLE_COLOR";

    /** Style key for the button tile image. */
    public static var BUTTON_TILE_IMAGE : String = "BUTTON_TILE_IMAGE";

    /** Style key for the button use custom render. */
    public static var BUTTON_USE_CUSTOM_RENDER : String = "BUTTON_USE_CUSTOM_RENDER";
    
    /** Style key for the button text embed. */
    public static var BUTTON_TEXT_EMBED : String = "BUTTON_TEXT_EMBED";
    /** Style key for the button text font. */
    public static var BUTTON_TEXT_FONT : String = "BUTTON_TEXT_FONT";
    /** Style key for the button text color. */
    public static var BUTTON_TEXT_COLOR : String = "BUTTON_TEXT_COLOR";
    /** Style key for the button text disabled color. */
    public static var BUTTON_TEXT_DISABLE_COLOR : String = "BUTTON_TEXT_DISABLE_COLOR";
    /** Style key for the button text size. */
    public static var BUTTON_TEXT_SIZE : String = "BUTTON_TEXT_SIZE";
    
    /** Style key for the button text bold. */
    public static var BUTTON_TEXT_BOLD : String = "BUTTON_TEXT_BOLD";
    /** Style key for the button text italic. */
    public static var BUTTON_TEXT_ITALIC : String = "BUTTON_TEXT_ITALIC";
    
    /** Style key for the button text align. */
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
    
    /** Style key for the check box normal color. */
    public static var CHECKBOX_NORMAL_COLOR : String = "CHECKBOX_NORMAL_COLOR";
    /** Style key for the check box hover color. */
    public static var CHECKBOX_OVER_COLOR : String = "CHECKBOX_OVER_COLOR";
    /** Style key for the check box pressed color. */
    public static var CHECKBOX_DOWN_COLOR : String = "CHECKBOX_DOWN_COLOR";
    /** Style key for the check box disabled color. */
    public static var CHECKBOX_DISABLE_COLOR : String = "CHECKBOX_DISABLE_COLOR";

    /** Style key for the check box selected normal color. */
    public static var CHECKBOX_SELECTED_NORMAL_COLOR : String = "CHECKBOX_SELECTED_NORMAL_COLOR";
    /** Style key for the check box selected hover color. */
    public static var CHECKBOX_SELECTED_OVER_COLOR : String = "CHECKBOX_SELECTED_OVER_COLOR";
    /** Style key for the check box selected pressed color. */
    public static var CHECKBOX_SELECTED_DOWN_COLOR : String = "CHECKBOX_SELECTED_DOWN_COLOR";
    /** Style key for the check box selected disabled color. */
    public static var CHECKBOX_SELECTED_DISABLE_COLOR : String = "CHECKBOX_SELECTED_DISABLE_COLOR";
    
    /** Style key for the check box text color. */
    public static var CHECKBOX_TEXT_COLOR : String = "CHECKBOX_TEXT_COLOR";
    
    /** Style key for the check box text bold. */
    public static var CHECKBOX_TEXT_BOLD : String = "CHECKBOX_TEXT_BOLD";
    /** Style key for the check box text italic. */
    public static var CHECKBOX_TEXT_ITALIC : String = "CHECKBOX_TEXT_ITALIC";
    /** Style key for the check box text size. */
    public static var CHECKBOX_TEXT_SIZE : String = "CHECKBOX_TEXT_SIZE";
    
    /** Style key for the check box text align. */
    public static var CHECKBOX_TEXT_ALIGN : String = "CHECKBOX_TEXT_ALIGN";

    /** Style key for the check box use custom render. */
    public static var CHECKBOX_USE_CUSTOM_RENDER : String = "CHECKBOX_USE_CUSTOM_RENDER";
    /** Style key for the check box tile image. */
    public static var CHECKBOX_TILE_IMAGE : String = "CHECKBOX_TILE_IMAGE";
    
    /** The over all size of checkbox */
    public static var CHECKBOX_SIZE : String = "CHECKBOX_SIZE";
    
    /** Label offset on x axis */
    public static var CHECKBOX_LABEL_OFFSET_X : String = "CHECKBOX_LABEL_OFFSET_X";
    
    /** Label offset on y axis */
    public static var CHECKBOX_LABEL_OFFSET_Y : String = "CHECKBOX_LABEL_OFFSET_Y";
    
    /** Style key for the radio button normal color. */
    public static var RADIOBUTTON_NORMAL_COLOR : String = "RADIOBUTTON_NORMAL_COLOR";
    /** Style key for the radio button hover color. */
    public static var RADIOBUTTON_OVER_COLOR : String = "RADIOBUTTON_OVER_COLOR";
    /** Style key for the radio button pressed color. */
    public static var RADIOBUTTON_DOWN_COLOR : String = "RADIOBUTTON_DOWN_COLOR";
    /** Style key for the radio button disabled color. */
    public static var RADIOBUTTON_DISABLE_COLOR : String = "RADIOBUTTON_DISABLE_COLOR";

    /** Style key for the radio button selected normal color. */
    public static var RADIOBUTTON_SELECTED_NORMAL_COLOR : String = "RADIOBUTTON_SELECTED_NORMAL_COLOR";
    /** Style key for the radio button selected hover color. */
    public static var RADIOBUTTON_SELECTED_OVER_COLOR : String = "RADIOBUTTON_SELECTED_OVER_COLOR";
    /** Style key for the radio button selected pressed color. */
    public static var RADIOBUTTON_SELECTED_DOWN_COLOR : String = "RADIOBUTTON_SELECTED_DOWN_COLOR";
    /** Style key for the radio button selected disabled color. */
    public static var RADIOBUTTON_SELECTED_DISABLE_COLOR : String = "RADIOBUTTON_SELECTED_DISABLE_COLOR";
    
    /** Style key for the radio button text color. */
    public static var RADIOBUTTON_TEXT_COLOR : String = "RADIOBUTTON_TEXT_COLOR";
    
    /** Style key for the radio button text bold. */
    public static var RADIOBUTTON_TEXT_BOLD : String = "RADIOBUTTON_TEXT_BOLD";
    /** Style key for the radio button text italic. */
    public static var RADIOBUTTON_TEXT_ITALIC : String = "RADIOBUTTON_TEXT_ITALIC";
    /** Style key for the radio button text size. */
    public static var RADIOBUTTON_TEXT_SIZE : String = "RADIOBUTTON_TEXT_SIZE";
    
    /** Style key for the radio button text align. */
    public static var RADIOBUTTON_TEXT_ALIGN : String = "RADIOBUTTON_TEXT_ALIGN";
    /** Style key for the radio button tile image. */
    public static var RADIOBUTTON_TILE_IMAGE : String = "RADIOBUTTON_TILE_IMAGE";

    /** Style key for the radio button use custom render. */
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

    /** The default ComboBox width */
    public static var COMBO_WIDTH : String = "COMBO_WIDTH";

    /** The default ComboBox height */
    public static var COMBO_HEIGHT : String = "COMBO_HEIGHT";
    
    /** Style key for the combo button normal color. */
    public static var COMBO_BUTTON_NORMAL_COLOR : String = "COMBO_BUTTON_NORMAL_COLOR";
    /** Style key for the combo button hover color. */
    public static var COMBO_BUTTON_OVER_COLOR : String = "COMBO_BUTTON_OVER_COLOR";
    /** Style key for the combo button pressed color. */
    public static var COMBO_BUTTON_DOWN_COLOR : String = "COMBO_BUTTON_DOWN_COLOR";
    /** Style key for the combo button disabled color. */
    public static var COMBO_BUTTON_DISABLE_COLOR : String = "COMBO_BUTTON_DISABLE_COLOR";
    
	/** Style key for the combo button icon color. */
	public static var COMBO_BUTTON_ICON_COLOR : String = "COMBO_BUTTON_ICON_COLOR";
	/** Style key for the combo button icon border color. */
	public static var COMBO_BUTTON_ICON_BORDER_COLOR : String = "COMBO_BUTTON_ICON_BORDER_COLOR";
	
    /** Style key for the combo border alpha. */
    public static var COMBO_BORDER_ALPHA : String = "COMBO_BORDER_ALPHA";
    /** Style key for the combo border. */
    public static var COMBO_BORDER : String = "COMBO_BORDER";
    /** Style key for the combo border color. */
    public static var COMBO_BORDER_COLOR : String = "COMBO_BORDER_COLOR";
    /** Style key for the combo background color. */
    public static var COMBO_BACKGROUND_COLOR : String = "COMBO_BACKGROUND_COLOR";
    /** Style key for the combo border thickness. */
    public static var COMBO_BORDER_THICKNESS : String = "COMBO_BORDER_THICKNESS";
    
	/** Style key for the combo dropdown padding. */
	public static var COMBO_DROPDOWN_PADDING : String = "COMBO_DROPDOWN_PADDING";
	/** Style key for the combo dropdown label background. */
	public static var COMBO_DROPDOWN_LABEL_BACKGROUND : String = "COMBO_DROPDOWN_LABEL_BACKGROUND";
	/** Style key for the combo dropdown tile image. */
	public static var COMBO_DROPDOWN_TILE_IMAGE : String = "COMBO_DROPDOWN_TILE_IMAGE";
	
    /** Style key for the combo text embed. */
    public static var COMBO_TEXT_EMBED : String = "COMBO_TEXT_EMBED";
    /** Style key for the combo text font. */
    public static var COMBO_TEXT_FONT : String = "COMBO_TEXT_FONT";
    /** Style key for the combo text color. */
    public static var COMBO_TEXT_COLOR : String = "COMBO_TEXT_COLOR";
    
    /** Style key for the combo text bold. */
    public static var COMBO_TEXT_BOLD : String = "COMBO_TEXT_BOLD";
    /** Style key for the combo text italic. */
    public static var COMBO_TEXT_ITALIC : String = "COMBO_TEXT_ITALIC";
    /** Style key for the combo text size. */
    public static var COMBO_TEXT_SIZE : String = "COMBO_TEXT_SIZE";
    
    /** Style key for the combo text align. */
    public static var COMBO_TEXT_ALIGN : String = "COMBO_TEXT_ALIGN";
    
    /** Style key for the combo text hover color. */
    public static var COMBO_TEXT_OVER_COLOR : String = "COMBO_TEXT_OVER_COLOR";
    /** Style key for the combo text pressed color. */
    public static var COMBO_TEXT_DOWN_COLOR : String = "COMBO_TEXT_DOWN_COLOR";
	
	/** Style key for the combo default text. */
	public static var COMBO_DEFAULT_TEXT : String = "COMBO_DEFAULT_TEXT";
    
    /** Style key for the combo text normal background color. */
    public static var COMBO_TEXT_NORMAL_BACKGROUND_COLOR : String = "COMBO_TEXT_NORMAL_BACKGROUND_COLOR";
    /** Style key for the combo text hover background color. */
    public static var COMBO_TEXT_OVER_BACKGROUND_COLOR : String = "COMBO_TEXT_OVER_BACKGROUND_COLOR";
    /** Style key for the combo text pressed background color. */
    public static var COMBO_TEXT_DOWN_BACKGROUND_COLOR : String = "COMBO_TEXT_DOWN_BACKGROUND_COLOR";
    
    /** The default GridPane width */
    public static var GRID_WIDTH : String = "GRID_WIDTH";

    /** The default GridPane height */
    public static var GRID_HEIGHT : String = "GRID_HEIGHT";

    /** Style key for the grid background. */
    public static var GRID_BACKGROUND : String = "GRID_BACKGROUND";
    /** Style key for the grid background color. */
    public static var GRID_BACKGROUND_COLOR : String = "GRID_BACKGROUND_COLOR";
    /** Style key for the grid pane tile image. */
    public static var GRIDPANE_TILE_IMAGE : String = "GRIDPANE_TILE_IMAGE";
    
    /** Style key for the grid cell background. */
    public static var GRID_CELL_BACKGROUND : String = "GRID_CELL_BACKGROUND";
    /** Style key for the grid cell background color. */
    public static var GRID_CELL_BACKGROUND_COLOR : String = "GRID_CELL_BACKGROUND_COLOR";
    
    /** Style key for the grid border alpha. */
    public static var GRID_BORDER_ALPHA : String = "GRID_BORDER_ALPHA";
    /** Style key for the grid border. */
    public static var GRID_BORDER : String = "GRID_BORDER";
    /** Style key for the grid border color. */
    public static var GRID_BORDER_COLOR : String = "GRID_BORDER_COLOR";
    /** Style key for the grid border thickness. */
    public static var GRID_BORDER_THICKNESS : String = "GRID_BORDER_THICKNESS";
    
    /** Style key for the grid cell border alpha. */
    public static var GRID_CELL_BORDER_ALPHA : String = "GRID_CELL_BORDER_ALPHA";
    /** Style key for the grid cell border. */
    public static var GRID_CELL_BORDER : String = "GRID_CELL_BORDER";
    /** Style key for the grid cell border color. */
    public static var GRID_CELL_BORDER_COLOR : String = "GRID_CELL_BORDER_COLOR";
    /** Style key for the grid cell border thickness. */
    public static var GRID_CELL_BORDER_THICKNESS : String = "GRID_CELL_BORDER_THICKNESS";
    
    /** Style key for the grid column button normal color. */
    public static var GRID_COLUMN_BUTTON_NORMAL_COLOR : String = "GRID_COLUMN_BUTTON_NORMAL_COLOR";
    /** Style key for the grid column button hover color. */
    public static var GRID_COLUMN_BUTTON_OVER_COLOR : String = "GRID_COLUMN_BUTTON_OVER_COLOR";
    /** Style key for the grid column button pressed color. */
    public static var GRID_COLUMN_BUTTON_DOWN_COLOR : String = "GRID_COLUMN_BUTTON_DOWN_COLOR";
    
    /** The default ListBox width */
    public static var LIST_WIDTH : String = "LIST_WIDTH";

    /** The default ListBox height */
    public static var LIST_HEIGHT : String = "LIST_HEIGHT";

    /** Style key for the list border alpha. */
    public static var LIST_BORDER_ALPHA : String = "LIST_BORDER_ALPHA";
    /** Style key for the list border. */
    public static var LIST_BORDER : String = "LIST_BORDER";
    /** Style key for the list border color. */
    public static var LIST_BORDER_COLOR : String = "LIST_BORDER_COLOR";
    /** Style key for the list border thickness. */
    public static var LIST_BORDER_THICKNESS : String = "LIST_BORDER_THICKNESS";
    
    /** Style key for the list background color. */
    public static var LIST_BACKGROUND_COLOR : String = "LIST_BACKGROUND_COLOR";
    /** Style key for the list tile image. */
    public static var LIST_TILE_IMAGE : String = "LIST_TILE_IMAGE";
    
    /** Style key for the list text embed. */
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
    
    /** Style key for the list text selected background color. */
    public static var LIST_TEXT_SELECTED_BACKGROUND_COLOR : String = "LIST_TEXT_SELECTED_BACKGROUND_COLOR";
    
    /** Style key for the list text bold. */
    public static var LIST_TEXT_BOLD : String = "LIST_TEXT_BOLD";
    /** Style key for the list text italic. */
    public static var LIST_TEXT_ITALIC : String = "LIST_TEXT_ITALIC";
    /** Style key for the list text size. */
    public static var LIST_TEXT_SIZE : String = "LIST_TEXT_SIZE";
    
    /** The default Label width */
    public static var LABEL_WIDTH : String = "LABEL_WIDTH";

    /** The default Label height */
    public static var LABEL_HEIGHT : String = "LABEL_HEIGHT";

    /** Style key for the label border alpha. */
    public static var LABEL_BORDER_ALPHA : String = "LABEL_BORDER_ALPHA";
    /** Style key for the label border. */
    public static var LABEL_BORDER : String = "LABEL_BORDER";
    /** Style key for the label border color. */
    public static var LABEL_BORDER_COLOR : String = "LABEL_BORDER_COLOR";
    /** Style key for the label border thickness. */
    public static var LABEL_BORDER_THICKNESS : String = "LABEL_BORDER_THICKNESS";
    
    /** Style key for the label background. */
    public static var LABEL_BACKGROUND : String = "LABEL_BACKGROUND";
    /** Style key for the label background color. */
    public static var LABEL_BACKGROUND_COLOR : String = "LABEL_BACKGROUND_COLOR";
    
    /** Style key for the label text embed. */
    public static var LABEL_TEXT_EMBED : String = "LABEL_TEXT_EMBED";
    /** Style key for the label text font. */
    public static var LABEL_TEXT_FONT : String = "LABEL_TEXT_FONT";
    /** Style key for the label text color. */
    public static var LABEL_TEXT_COLOR : String = "LABEL_TEXT_COLOR";
    
    /** Style key for the label text bold. */
    public static var LABEL_TEXT_BOLD : String = "LABEL_TEXT_BOLD";
    /** Style key for the label text italic. */
    public static var LABEL_TEXT_ITALIC : String = "LABEL_TEXT_ITALIC";
    /** Style key for the label text size. */
    public static var LABEL_TEXT_SIZE : String = "LABEL_TEXT_SIZE";
    
    /** Style key for the label text align. */
    public static var LABEL_TEXT_ALIGN : String = "LABEL_TEXT_ALIGN";
    
    /** Set the amount of pixels the text will be indented by  */
    public static var LABEL_INDENT : String = "LABEL_INDENT";
    
    /** The default TextInput width */
    public static var INPUT_WIDTH : String = "INPUT_WIDTH";

    /** The default TextInput height */
    public static var INPUT_HEIGHT : String = "INPUT_HEIGHT";

    /** Style key for the input background. */
    public static var INPUT_BACKGROUND : String = "INPUT_BACKGROUND";
    
    /** Style key for the input background normal color. */
    public static var INPUT_BACKGROUND_NORMAL_COLOR : String = "INPUT_BACKGROUND_NORMAL_COLOR";
    /** Style key for the input background hover color. */
    public static var INPUT_BACKGROUND_OVER_COLOR : String = "INPUT_BACKGROUND_OVER_COLOR";
    /** Style key for the input background selected color. */
    public static var INPUT_BACKGROUND_SELECTED_COLOR : String = "INPUT_BACKGROUND_SELECTED_COLOR";
    /** Style key for the input background disabled color. */
    public static var INPUT_BACKGROUND_DISABLE_COLOR : String = "INPUT_BACKGROUND_DISABLE_COLOR";
    
    /** Style key for the input border alpha. */
    public static var INPUT_BORDER_ALPHA : String = "INPUT_BORDER_ALPHA";
    /** Style key for the input border. */
    public static var INPUT_BORDER : String = "INPUT_BORDER";
    /** Style key for the input border color. */
    public static var INPUT_BORDER_COLOR : String = "INPUT_BORDER_COLOR";
    /** Style key for the input border thickness. */
    public static var INPUT_BORDER_THICKNESS : String = "INPUT_BORDER_THICKNESS";
    
    /** Style key for the input text embed. */
    public static var INPUT_TEXT_EMBED : String = "INPUT_TEXT_EMBED";
    /** Style key for the input text font. */
    public static var INPUT_TEXT_FONT : String = "INPUT_TEXT_FONT";
    
    /** Style key for the input text color. */
    public static var INPUT_TEXT_COLOR : String = "INPUT_TEXT_COLOR";
    /** Style key for the input text hover color. */
    public static var INPUT_TEXT_OVER_COLOR : String = "INPUT_TEXT_OVER_COLOR";
    /** Style key for the input text selected color. */
    public static var INPUT_TEXT_SELECTED_COLOR : String = "INPUT_TEXT_SELECTED_COLOR";
    /** Style key for the input text disabled color. */
    public static var INPUT_TEXT_DISABLE_COLOR : String = "INPUT_TEXT_DISABLE_COLOR";
    
    /** Style key for the input text bold. */
    public static var INPUT_TEXT_BOLD : String = "INPUT_TEXT_BOLD";
    /** Style key for the input text italic. */
    public static var INPUT_TEXT_ITALIC : String = "INPUT_TEXT_ITALIC";
    
    /** The default ProgressBar width */
    public static var PROGRESSBAR_WIDTH : String = "PROGRESSBAR_WIDTH";

    /** The default ProgressBar height */
    public static var PROGRESSBAR_HEIGHT : String = "PROGRESSBAR_HEIGHT";

    /** Style key for the progressbar border alpha. */
    public static var PROGRESSBAR_BORDER_ALPHA : String = "PROGRESSBAR_BORDER_ALPHA";
    /** Style key for the progressbar border. */
    public static var PROGRESSBAR_BORDER : String = "PROGRESSBAR_BORDER";
	/** Style key for the progressbar border color. */
	public static var PROGRESSBAR_BORDER_COLOR : String = "PROGRESSBAR_BORDER_COLOR";
    /** Style key for the progressbar border thickness. */
    public static var PROGRESSBAR_BORDER_THICKNESS : String = "PROGRESSBAR_BORDER_THICKNESS";
    
    /** Style key for the progressbar text embed. */
    public static var PROGRESSBAR_TEXT_EMBED : String = "PROGRESSBAR_TEXT_EMBED";
    /** Style key for the progressbar text font. */
    public static var PROGRESSBAR_TEXT_FONT : String = "PROGRESSBAR_TEXT_FONT";
    
    /** Style key for the progressbar text loaded color. */
    public static var PROGRESSBAR_TEXT_LOADED_COLOR : String = "PROGRESSBAR_TEXT_LOADED_COLOR";
    /** Style key for the progressbar text color. */
    public static var PROGRESSBAR_TEXT_COLOR : String = "PROGRESSBAR_TEXT_COLOR";
    
    /** Style key for the progressbar text bold. */
    public static var PROGRESSBAR_TEXT_BOLD : String = "PROGRESSBAR_TEXT_BOLD";
    /** Style key for the progressbar text italic. */
    public static var PROGRESSBAR_TEXT_ITALIC : String = "PROGRESSBAR_TEXT_ITALIC";
    /** Style key for the progressbar text size. */
    public static var PROGRESSBAR_TEXT_SIZE : String = "PROGRESSBAR_TEXT_SIZE";

    /** Style key for the progressbar use custom render. */
    public static var PROGRESSBAR_USE_CUSTOM_RENDER : String = "PROGRESSBAR_USE_CUSTOM_RENDER";
    
    /** Style key for the progressbar color. */
    public static var PROGRESSBAR_COLOR : String = "PROGRESSBAR_COLOR";
    /** Style key for the progressbar color loaded. */
    public static var PROGRESSBAR_COLOR_LOADED : String = "PROGRESSBAR_COLOR_LOADED";
    
    /** Style key for the progressbar text align. */
    public static var PROGRESSBAR_TEXT_ALIGN : String = "PROGRESSBAR_TEXT_ALIGN";
    
    /** Style key for the progress slider border alpha. */
    public static var PROGRESS_SLIDER_BORDER_ALPHA : String = "PROGRESS_SLIDER_BORDER_ALPHA";
    /** Style key for the progress slider border. */
    public static var PROGRESS_SLIDER_BORDER : String = "PROGRESS_SLIDER_BORDER";
    /** Style key for the progress slider border color. */
    public static var PROGRESS_SLIDER_BORDER_COLOR : String = "PROGRESS_SLIDER_BORDER_COLOR";
    /** Style key for the progress slider border thickness. */
    public static var PROGRESS_SLIDER_BORDER_THICKNESS : String = "PROGRESS_SLIDER_BORDER_THICKNESS";
    
    /** Style key for the progress slider text embed. */
    public static var PROGRESS_SLIDER_TEXT_EMBED : String = "PROGRESS_SLIDER_TEXT_EMBED";
    /** Style key for the progress slider text font. */
    public static var PROGRESS_SLIDER_TEXT_FONT : String = "PROGRESS_SLIDER_TEXT_FONT";
    
    /** Style key for the progress slider text loaded color. */
    public static var PROGRESS_SLIDER_TEXT_LOADED_COLOR : String = "PROGRESS_SLIDER_TEXT_LOADED_COLOR";
    /** Style key for the progress slider text color. */
    public static var PROGRESS_SLIDER_TEXT_COLOR : String = "PROGRESS_SLIDER_TEXT_COLOR";
    
    /** Style key for the progress slider text bold. */
    public static var PROGRESS_SLIDER_TEXT_BOLD : String = "PROGRESS_SLIDER_TEXT_BOLD";
    /** Style key for the progress slider text italic. */
    public static var PROGRESS_SLIDER_TEXT_ITALIC : String = "PROGRESS_SLIDER_TEXT_ITALIC";
    /** Style key for the progress slider text size. */
    public static var PROGRESS_SLIDER_TEXT_SIZE : String = "PROGRESS_SLIDER_TEXT_SIZE";
    
    /** Style key for the progress slider color. */
    public static var PROGRESS_SLIDER_COLOR : String = "PROGRESS_SLIDER_COLOR";
    /** Style key for the progress slider color loaded. */
    public static var PROGRESS_SLIDER_COLOR_LOADED : String = "PROGRESS_SLIDER_COLOR_LOADED";
    
    /** Style key for the progress slider text align. */
    public static var PROGRESS_SLIDER_TEXT_ALIGN : String = "PROGRESS_SLIDER_TEXT_ALIGN";
    
    /** Style key for the progress slider normal color. */
    public static var PROGRESS_SLIDER_NORMAL_COLOR : String = "PROGRESS_SLIDER_NORMAL_COLOR";
    /** Style key for the progress slider hover color. */
    public static var PROGRESS_SLIDER_OVER_COLOR : String = "PROGRESS_SLIDER_OVER_COLOR";
    /** Style key for the progress slider pressed color. */
    public static var PROGRESS_SLIDER_DOWN_COLOR : String = "PROGRESS_SLIDER_DOWN_COLOR";
    /** Style key for the progress slider disabled color. */
    public static var PROGRESS_SLIDER_DISABLE_COLOR : String = "PROGRESS_SLIDER_DISABLE_COLOR";
    /** Style key for the progress slider size. */
    public static var PROGRESS_SLIDER_SIZE : String = "PROGRESS_SLIDER_SIZE";
    
    /** Style key for the progress slider rotate image. */
    public static var PROGRESS_SLIDER_ROTATE_IMAGE : String = "PROGRESS_SLIDER_ROTATE_IMAGE";
    
    /** Style key for the progress slider offset. */
    public static var PROGRESS_SLIDER_OFFSET : String = "PROGRESS_SLIDER_OFFSET";
    
    /** Style key for the scroll bar rotate image. */
    public static var SCROLLBAR_ROTATE_IMAGE : String = "SCROLLBAR_ROTATE_IMAGE";
    /** Style key for the scroll bar tile image. */
    public static var SCROLLBAR_TILE_IMAGE : String = "SCROLLBAR_TILE_IMAGE";
    /** Style key for the scroll bar slider offset. */
    public static var SCROLLBAR_SLIDER_OFFSET : String = "SCROLLBAR_SLIDER_OFFSET";
    
    /** Style key for the scroll bar button use custom render. */
    public static var SCROLLBAR_BUTTON_USE_CUSTOM_RENDER : String = "SCROLLBAR_BUTTON_USE_CUSTOM_RENDER";

    /** Style key for the scroll bar button normal color. */
    public static var SCROLLBAR_BUTTON_NORMAL_COLOR : String = "SCROLLBAR_BUTTON_NORMAL_COLOR";
    /** Style key for the scroll bar button hover color. */
    public static var SCROLLBAR_BUTTON_OVER_COLOR : String = "SCROLLBAR_BUTTON_OVER_COLOR";
    /** Style key for the scroll bar button pressed color. */
    public static var SCROLLBAR_BUTTON_DOWN_COLOR : String = "SCROLLBAR_BUTTON_DOWN_COLOR";
    /** Style key for the scroll bar button disabled color. */
    public static var SCROLLBAR_BUTTON_DISABLE_COLOR : String = "SCROLLBAR_BUTTON_DISABLE_COLOR";
    
    /** Style key for the scroll bar button size. */
    public static var SCROLLBAR_BUTTON_SIZE : String = "SCROLLBAR_BUTTON_SIZE";
    
    /** Style key for the scroll bar slider normal color. */
    public static var SCROLLBAR_SLIDER_NORMAL_COLOR : String = "SCROLLBAR_SLIDER_NORMAL_COLOR";
    /** Style key for the scroll bar slider hover color. */
    public static var SCROLLBAR_SLIDER_OVER_COLOR : String = "SCROLLBAR_SLIDER_OVER_COLOR";
    /** Style key for the scroll bar slider pressed color. */
    public static var SCROLLBAR_SLIDER_DOWN_COLOR : String = "SCROLLBAR_SLIDER_DOWN_COLOR";
    /** Style key for the scroll bar slider size. */
    public static var SCROLLBAR_SLIDER_SIZE : String = "SCROLLBAR_SLIDER_SIZE";
    
    /** Style key for the scroll bar track color. */
    public static var SCROLLBAR_TRACK_COLOR : String = "SCROLLBAR_TRACK_COLOR";
    /** Style key for the scroll bar track size. */
    public static var SCROLLBAR_TRACK_SIZE : String = "SCROLLBAR_TRACK_SIZE";
    /** Style key for the scroll bar slider active resize. */
    public static var SCROLLBAR_SLIDER_ACTIVE_RESIZE : String = "SCROLLBAR_SLIDER_ACTIVE_RESIZE";
    
    /** The scroller offset */
    public static var SCROLLBAR_OFFSET : String = "SCROLLBAR_OFFSET";

    /** The default Slider width */
    public static var SLIDER_WIDTH : String = "SLIDER_WIDTH";

    /** The default Slider height */
    public static var SLIDER_HEIGHT : String = "SLIDER_HEIGHT";
    
    /** Style key for the slider normal color. */
    public static var SLIDER_NORMAL_COLOR : String = "SLIDER_NORMAL_COLOR";
    /** Style key for the slider hover color. */
    public static var SLIDER_OVER_COLOR : String = "SLIDER_OVER_COLOR";
    /** Style key for the slider pressed color. */
    public static var SLIDER_DOWN_COLOR : String = "SLIDER_DOWN_COLOR";
    /** Style key for the slider disabled color. */
    public static var SLIDER_DISABLE_COLOR : String = "SLIDER_DISABLE_COLOR";
    /** Style key for the slider size. */
    public static var SLIDER_SIZE : String = "SLIDER_SIZE";
    
    /** Style key for the slider track color. */
    public static var SLIDER_TRACK_COLOR : String = "SLIDER_TRACK_COLOR";
    /** Style key for the slider track size. */
    public static var SLIDER_TRACK_SIZE : String = "SLIDER_TRACK_SIZE";
    /** Style key for the slider size to track. */
    public static var SLIDER_SIZE_TO_TRACK : String = "SLIDER_SIZE_TO_TRACK";
    
    /** Style key for the slider rotate image. */
    public static var SLIDER_ROTATE_IMAGE : String = "SLIDER_ROTATE_IMAGE";
    /** Style key for the slider tile image. */
    public static var SLIDER_TILE_IMAGE : String = "SLIDER_TILE_IMAGE";

    /** Style key for the slider use custom render. */
    public static var SLIDER_USE_CUSTOM_RENDER : String = "SLIDER_USE_CUSTOM_RENDER";
    
    /** Style key for the slider offset. */
    public static var SLIDER_OFFSET : String = "SLIDER_OFFSET";
    
    /** The default ScrollPane width */
    public static var SCROLLPANE_WIDTH : String = "SCROLLPANE_WIDTH";

    /** The default ScrollPane height */
    public static var SCROLLPANE_HEIGHT : String = "SCROLLPANE_HEIGHT";

    /** Style key for the scroll pane background. */
    public static var SCROLLPANE_BACKGROUND : String = "SCROLLPANE_BACKGROUND";
    /** Style key for the scroll pane background color. */
    public static var SCROLLPANE_BACKGROUND_COLOR : String = "SCROLLPANE_BACKGROUND_COLOR";
    /** Style key for the scroll pane tile image. */
    public static var SCROLLPANE_TILE_IMAGE : String = "SCROLLPANE_TILE_IMAGE";
    
    /** Style key for the scroll pane border alpha. */
    public static var SCROLLPANE_BORDER_ALPHA : String = "SCROLLPANE_BORDER_ALPHA";
    /** Style key for the scroll pane border. */
    public static var SCROLLPANE_BORDER : String = "SCROLLPANE_BORDER";
    /** Style key for the scroll pane border color. */
    public static var SCROLLPANE_BORDER_COLOR : String = "SCROLLPANE_BORDER_COLOR";
    /** Style key for the scroll pane border thickness. */
    public static var SCROLLPANE_BORDER_THICKNESS : String = "SCROLLPANE_BORDER_THICKNESS";

    /** Style key for the scroll pane use custom render. */
    public static var SCROLLPANE_USE_CUSTOM_RENDER : String = "SCROLLPANE_USE_CUSTOM_RENDER";
    
    /** Style key for the scroll pane content offset x. */
    public static var SCROLLPANE_CONTENT_OFFSET_X : String = "SCROLLPANE_CONTENT_OFFSET_X";
    /** Style key for the scroll pane content offset y. */
    public static var SCROLLPANE_CONTENT_OFFSET_Y : String = "SCROLLPANE_CONTENT_OFFSET_Y";
    
    /** Style key for the scroll pane content width offset. */
    public static var SCROLLPANE_CONTENT_WIDTH_OFFSET : String = "SCROLLPANE_CONTENT_WIDTH_OFFSET";
    /** Style key for the scroll pane content height offset. */
    public static var SCROLLPANE_CONTENT_HEIGHT_OFFSET : String = "SCROLLPANE_CONTENT_HEIGHT_OFFSET";
    
    /** The default ItemPane width */
    public static var ITEMPANE_WIDTH : String = "ITEMPANE_WIDTH";

    /** The default ItemPane height */
    public static var ITEMPANE_HEIGHT : String = "ITEMPANE_HEIGHT";

    /** Style key for the item pane background. */
    public static var ITEMPANE_BACKGROUND : String = "ITEMPANE_BACKGROUND";
    /** Style key for the item pane tile image. */
    public static var ITEMPANE_TILE_IMAGE : String = "ITEMPANE_TILE_IMAGE";
    
    /** Style key for the item pane border alpha. */
    public static var ITEMPANE_BORDER_ALPHA : String = "ITEMPANE_BORDER_ALPHA";
    /** Style key for the item pane border. */
    public static var ITEMPANE_BORDER : String = "ITEMPANE_BORDER";
    /** Style key for the item pane border color. */
    public static var ITEMPANE_BORDER_COLOR : String = "ITEMPANE_BORDER_COLOR";
    /** Style key for the item pane border thickness. */
    public static var ITEMPANE_BORDER_THICKNESS : String = "ITEMPANE_BORDER_THICKNESS";
    
    /** Style key for the item pane item border alpha. */
    public static var ITEMPANE_ITEM_BORDER_ALPHA : String = "ITEMPANE_ITEM_BORDER_ALPHA";
    /** Style key for the item pane item border. */
    public static var ITEMPANE_ITEM_BORDER : String = "ITEMPANE_ITEM_BORDER";
    /** Style key for the item pane item border color. */
    public static var ITEMPANE_ITEM_BORDER_COLOR : String = "ITEMPANE_ITEM_BORDER_COLOR";
    /** Style key for the item pane item border thickness. */
    public static var ITEMPANE_ITEM_BORDER_THICKNESS : String = "ITEMPANE_ITEM_BORDER_THICKNESS";
    
    /** Style key for the item pane item normal color. */
    public static var ITEMPANE_ITEM_NORMAL_COLOR : String = "ITEMPANE_ITEM_NORMAL_COLOR";
    /** Style key for the item pane item hover color. */
    public static var ITEMPANE_ITEM_OVER_COLOR : String = "ITEMPANE_ITEM_OVER_COLOR";
    /** Style key for the item pane item selected color. */
    public static var ITEMPANE_ITEM_SELECTED_COLOR : String = "ITEMPANE_ITEM_SELECTED_COLOR";
    /** Style key for the item pane item disabled color. */
    public static var ITEMPANE_ITEM_DISABLE_COLOR : String = "ITEMPANE_ITEM_DISABLE_COLOR";
    
    /** Style key for the item pane text embed. */
    public static var ITEMPANE_TEXT_EMBED : String = "ITEMPANE_TEXT_EMBED";
    /** Style key for the item pane text font. */
    public static var ITEMPANE_TEXT_FONT : String = "ITEMPANE_TEXT_FONT";
    /** Style key for the item pane text color. */
    public static var ITEMPANE_TEXT_COLOR : String = "ITEMPANE_TEXT_COLOR";
    /** Style key for the item pane text selected color. */
    public static var ITEMPANE_TEXT_SELECTED_COLOR : String = "ITEMPANE_TEXT_SELECTED_COLOR";
    
    /** Style key for the item pane text bold. */
    public static var ITEMPANE_TEXT_BOLD : String = "ITEMPANE_TEXT_BOLD";
    /** Style key for the item pane text italic. */
    public static var ITEMPANE_TEXT_ITALIC : String = "ITEMPANE_TEXT_ITALIC";
    /** Style key for the item pane text size. */
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

    /** The default TabPane width */
    public static var TABPANE_WIDTH : String = "TABPANE_WIDTH";

    /** The default TabPane height */
    public static var TABPANE_HEIGHT : String = "TABPANE_HEIGHT";
    
    /** Style key for the tab pane background. */
    public static var TABPANE_BACKGROUND : String = "TABPANE_BACKGROUND";
    
    /** Style key for the tab pane button tint alpha. */
    public static var TABPANE_BUTTON_TINT_ALPHA : String = "TABPANE_BUTTON_TINT_ALPHA";
    
    /** Style key for the tab pane button normal color. */
    public static var TABPANE_BUTTON_NORMAL_COLOR : String = "TABPANE_BUTTON_NORMAL_COLOR";
    /** Style key for the tab pane button hover color. */
    public static var TABPANE_BUTTON_OVER_COLOR : String = "TABPANE_BUTTON_OVER_COLOR";
    /** Style key for the tab pane button disabled color. */
    public static var TABPANE_BUTTON_DISABLE_COLOR : String = "TABPANE_BUTTON_DISABLE_COLOR";
    /** Style key for the tab pane button selected color. */
    public static var TABPANE_BUTTON_SELECTED_COLOR : String = "TABPANE_BUTTON_SELECTED_COLOR";
    
    /** Style key for the tab pane button text embed. */
    public static var TABPANE_BUTTON_TEXT_EMBED : String = "TABPANE_BUTTON_TEXT_EMBED";
    /** Style key for the tab pane button text font. */
    public static var TABPANE_BUTTON_TEXT_FONT : String = "TABPANE_BUTTON_TEXT_FONT";
    /** Style key for the tab pane button text color. */
    public static var TABPANE_BUTTON_TEXT_COLOR : String = "TABPANE_BUTTON_TEXT_COLOR";
    /** Style key for the tab pane button text color selected. */
    public static var TABPANE_BUTTON_TEXT_COLOR_SELECTED : String = "TABPANE_BUTTON_TEXT_COLOR_SELECTED";
    
    /** Style key for the tab pane button text bold. */
    public static var TABPANE_BUTTON_TEXT_BOLD : String = "TABPANE_BUTTON_TEXT_BOLD";
    /** Style key for the tab pane button text italic. */
    public static var TABPANE_BUTTON_TEXT_ITALIC : String = "TABPANE_BUTTON_TEXT_ITALIC";
    /** Style key for the tab pane button text size. */
    public static var TABPANE_BUTTON_TEXT_SIZE : String = "TABPANE_BUTTON_TEXT_SIZE";
    
    /** Style key for the tab pane border alpha. */
    public static var TABPANE_BORDER_ALPHA : String = "TABPANE_BORDER_ALPHA";
    /** Style key for the tab pane border. */
    public static var TABPANE_BORDER : String = "TABPANE_BORDER";
    /** Style key for the tab pane border color. */
    public static var TABPANE_BORDER_COLOR : String = "TABPANE_BORDER_COLOR";
    /** Style key for the tab pane border thickness. */
    public static var TABPANE_BORDER_THICKNESS : String = "TABPANE_BORDER_THICKNESS";

    /** The default toggle button width */
    public static var TOGGLE_BUTTON_WIDTH : String = "TOGGLE_BUTTON_WIDTH";

    /** The default toggle button height */
    public static var TOGGLE_BUTTON_HEIGHT : String = "TOGGLE_BUTTON_HEIGHT";

    /** Style key for the toggle button border. */
    public static var TOGGLE_BUTTON_BORDER : String = "TOGGLE_BUTTON_BORDER";
    /** Style key for the toggle button border alpha. */
    public static var TOGGLE_BUTTON_BORDER_ALPHA : String = "TOGGLE_BUTTON_BORDER_ALPHA";
    
    /** Style key for the toggle button border normal color. */
    public static var TOGGLE_BUTTON_BORDER_NORMAL_COLOR : String = "TOGGLE_BUTTON_BORDER_NORMAL_COLOR";
    /** Style key for the toggle button border hover color. */
    public static var TOGGLE_BUTTON_BORDER_OVER_COLOR : String = "TOGGLE_BUTTON_BORDER_OVER_COLOR";
    /** Style key for the toggle button border disabled color. */
    public static var TOGGLE_BUTTON_BORDER_DISABLE_COLOR : String = "TOGGLE_BUTTON_BORDER_DISABLE_COLOR";
    /** Style key for the toggle button border selected color. */
    public static var TOGGLE_BUTTON_BORDER_SELECTED_COLOR : String = "TOGGLE_BUTTON_BORDER_SELECTED_COLOR";

    /** Style key for the toggle button border thickness. */
    public static var TOGGLE_BUTTON_BORDER_THICKNESS : String = "TOGGLE_BUTTON_BORDER_THICKNESS";

    /** Style key for the toggle button normal color. */
    public static var TOGGLE_BUTTON_NORMAL_COLOR : String = "TOGGLE_BUTTON_NORMAL_COLOR";
    /** Style key for the toggle button hover color. */
    public static var TOGGLE_BUTTON_OVER_COLOR :String = "TOGGLE_BUTTON_OVER_COLOR";
    /** Style key for the toggle button disabled color. */
    public static var TOGGLE_BUTTON_DISABLE_COLOR :String = "TOGGLE_BUTTON_DISABLE_COLOR";
    /** Style key for the toggle button selected color. */
    public static var TOGGLE_BUTTON_SELECTED_COLOR : String = "TOGGLE_BUTTON_SELECTED_COLOR";
    
    /** Style key for the tooltip background normal color. */
    public static var TOOLTIP_BACKGROUND_NORMAL_COLOR : String = "TOOLTIP_BACKGROUND_NORMAL_COLOR";
    /** Style key for the tooltip background alpha. */
    public static var TOOLTIP_BACKGROUND_ALPHA : String = "TOOLTIP_BACKGROUND_ALPHA";

    /** Style key for the toggle button use custom render. */
    public static var TOGGLE_BUTTON_USE_CUSTOM_RENDER : String = "TOGGLE_BUTTON_USE_CUSTOM_RENDER";

    /** Style key for the toggle tile image. */
    public static var TOGGLE_TILE_IMAGE : String = "TOGGLE_TILE_IMAGE";
    
    /** Style key for the tooltip border alpha. */
    public static var TOOLTIP_BORDER_ALPHA : String = "TOOLTIP_BORDER_ALPHA";
    /** Style key for the tooltip border. */
    public static var TOOLTIP_BORDER : String = "TOOLTIP_BORDER";
    /** Style key for the tooltip border color. */
    public static var TOOLTIP_BORDER_COLOR : String = "TOOLTIP_BORDER_COLOR";
    /** Style key for the tooltip border thickness. */
    public static var TOOLTIP_BORDER_THICKNESS : String = "TOOLTIP_BORDER_THICKNESS";
    
    /** Style key for the tooltip label text embed. */
    public static var TOOLTIP_LABEL_TEXT_EMBED : String = "TOOLTIP_LABEL_TEXT_EMBED";
    /** Style key for the tooltip label text font. */
    public static var TOOLTIP_LABEL_TEXT_FONT : String = "TOOLTIP_LABEL_TEXT_FONT";
    /** Style key for the tooltip label text color. */
    public static var TOOLTIP_LABEL_TEXT_COLOR : String = "TOOLTIP_LABEL_TEXT_COLOR";
    
    /** Style key for the tooltip label text size. */
    public static var TOOLTIP_LABEL_TEXT_SIZE : String = "TOOLTIP_LABEL_TEXT_SIZE";
    
    /** Style key for the tooltip label padding. */
    public static var TOOLTIP_LABEL_PADDING : String = "TOOLTIP_LABEL_PADDING";
    
    /** Style key for the tooltip bubble loc x. */
    public static var TOOLTIP_BUBBLE_LOC_X : String = "TOOLTIP_BUBBLE_LOC_X";
    /** Style key for the tooltip bubble loc y. */
    public static var TOOLTIP_BUBBLE_LOC_Y : String = "TOOLTIP_BUBBLE_LOC_Y";
    
    /** The default Window width */
    public static var WINDOW_WIDTH : String = "WINDOW_WIDTH";

    /** The default Window height */
    public static var WINDOW_HEIGHT : String = "WINDOW_HEIGHT";

    /** Style key for the window button width. */
    public static var WINDOW_BUTTON_WIDTH : String = "WINDOW_BUTTON_WIDTH";
    /** Style key for the window button height. */
    public static var WINDOW_BUTTON_HEIGHT : String = "WINDOW_BUTTON_HEIGHT";

    /** Style key for the window title text embed. */
    public static var WINDOW_TITLE_TEXT_EMBED : String = "WINDOW_TITLE_TEXT_EMBED";
    /** Style key for the window title text font. */
    public static var WINDOW_TITLE_TEXT_FONT : String = "WINDOW_TITLE_TEXT_FONT";
    /** Style key for the window title text color. */
    public static var WINDOW_TITLE_TEXT_COLOR : String = "WINDOW_TITLE_TEXT_COLOR";
    /** Style key for the window title text size. */
    public static var WINDOW_TITLE_TEXT_SIZE : String = "WINDOW_TITLE_TEXT_SIZE";
    
    /** Style key for the window title area color. */
    public static var WINDOW_TITLE_AREA_COLOR : String = "WINDOW_TITLE_AREA_COLOR";
    /** Style key for the window title area unfocused color. */
    public static var WINDOW_TITLE_AREA_UNFOCUS_COLOR : String = "WINDOW_TITLE_AREA_UNFOCUS_COLOR";
    
    /** Style key for the window focus color. */
    public static var WINDOW_FOCUS_COLOR : String = "WINDOW_FOCUS_COLOR";
    /** Style key for the window unfocused color. */
    public static var WINDOW_UNFOCUS_COLOR : String = "WINDOW_UNFOCUS_COLOR";
    
    /** Style key for the window border alpha. */
    public static var WINDOW_BORDER_ALPHA : String = "WINDOW_BORDER_ALPHA";
    /** Style key for the window border. */
    public static var WINDOW_BORDER : String = "WINDOW_BORDER";
    /** Style key for the window border color. */
    public static var WINDOW_BORDER_COLOR : String = "WINDOW_BORDER_COLOR";
    
    /** Style key for the window background color. */
    public static var WINDOW_BACKGROUND_COLOR : String = "WINDOW_BACKGROUND_COLOR";
    
    /** Style key for the window icon location. */
    public static var WINDOW_ICON_LOCATION : String = "WINDOW_ICON_LOCATION";
    /** Style key for the window button location. */
    public static var WINDOW_BUTTON_LOCATION : String = "WINDOW_BUTTON_LOCATION";
    /** Style key for the window label location. */
    public static var WINDOW_LABEL_LOCATION : String = "WINDOW_LABEL_LOCATION";
	
    
    /** Style key for the window min normal color. */
    public static var WINDOW_MIN_NORMAL_COLOR : String = "WINDOW_MIN_NORMAL_COLOR";
    /** Style key for the window min hover color. */
    public static var WINDOW_MIN_OVER_COLOR : String = "WINDOW_MIN_OVER_COLOR";
    /** Style key for the window min pressed color. */
    public static var WINDOW_MIN_DOWN_COLOR : String = "WINDOW_MIN_DOWN_COLOR";
    /** Style key for the window min disabled color. */
    public static var WINDOW_MIN_DISABLE_COLOR : String = "WINDOW_MIN_DISABLE_COLOR";
    /** Style key for the window min unfocused color. */
    public static var WINDOW_MIN_UNFOCUS_COLOR : String = "WINDOW_MIN_UNFOCUS_COLOR";
	
    /** Style key for the window max normal color. */
    public static var WINDOW_MAX_NORMAL_COLOR : String = "WINDOW_MAX_NORMAL_COLOR";
    /** Style key for the window max hover color. */
    public static var WINDOW_MAX_OVER_COLOR : String = "WINDOW_MAX_OVER_COLOR";
    /** Style key for the window max pressed color. */
    public static var WINDOW_MAX_DOWN_COLOR : String = "WINDOW_MAX_DOWN_COLOR";
    /** Style key for the window max disabled color. */
    public static var WINDOW_MAX_DISABLE_COLOR : String = "WINDOW_MAX_DISABLE_COLOR";
    /** Style key for the window max unfocused color. */
    public static var WINDOW_MAX_UNFOCUS_COLOR : String = "WINDOW_MAX_UNFOCUS_COLOR";
	
    /** Style key for the window close normal color. */
    public static var WINDOW_CLOSE_NORMAL_COLOR : String = "WINDOW_CLOSE_NORMAL_COLOR";
    /** Style key for the window close hover color. */
    public static var WINDOW_CLOSE_OVER_COLOR : String = "WINDOW_CLOSE_OVER_COLOR";
    /** Style key for the window close pressed color. */
    public static var WINDOW_CLOSE_DOWN_COLOR : String = "WINDOW_CLOSE_DOWN_COLOR";
    /** Style key for the window close disabled color. */
    public static var WINDOW_CLOSE_DISABLE_COLOR : String = "WINDOW_CLOSE_DISABLE_COLOR";
    /** Style key for the window close unfocused color. */
    public static var WINDOW_CLOSE_UNFOCUS_COLOR : String = "WINDOW_CLOSE_UNFOCUS_COLOR";
	
    /** The default Menu width */
    public static var MENU_WIDTH : String = "MENU_WIDTH";

    /** The default Menu height */
    public static var MENU_HEIGHT : String = "MENU_HEIGHT";

    /** Style key for the menu background. */
    public static var MENU_BACKGROUND : String = "MENU_BACKGROUND";
    /** Style key for the menu background color. */
    public static var MENU_BACKGROUND_COLOR : String = "MENU_BACKGROUND_COLOR";
    /** Style key for the menu background alpha. */
    public static var MENU_BACKGROUND_ALPHA : String = "MENU_BACKGROUND_ALPHA";
    /** Style key for the menu tile image. */
    public static var MENU_TILE_IMAGE : String = "MENU_TILE_IMAGE";

    /** Style key for the icon border. */
    public static var ICON_BORDER : String = "ICON_BORDER";
    /** Style key for the icon color. */
    public static var ICON_COLOR : String = "ICON_COLOR";
    /** Style key for the icon border color. */
    public static var ICON_BORDER_COLOR : String = "ICON_BORDER_COLOR";
    
    /** Style key for the menu button normal color. */
    public static var MENU_BUTTON_NORMAL_COLOR : String = "MENU_BUTTON_NORMAL_COLOR";
    /** Style key for the menu button hover color. */
    public static var MENU_BUTTON_OVER_COLOR : String = "MENU_BUTTON_OVER_COLOR";
    /** Style key for the menu button pressed color. */
    public static var MENU_BUTTON_DOWN_COLOR : String = "MENU_BUTTON_DOWN_COLOR";
    /** Style key for the menu button disabled color. */
    public static var MENU_BUTTON_DISABLE_COLOR : String = "MENU_BUTTON_DISABLE_COLOR";
    
    /** Style key for the menu sub button normal color. */
    public static var MENU_SUB_BUTTON_NORMAL_COLOR : String = "MENU_SUB_BUTTON_NORMAL_COLOR";
    /** Style key for the menu sub button hover color. */
    public static var MENU_SUB_BUTTON_OVER_COLOR : String = "MENU_SUB_BUTTON_OVER_COLOR";
    /** Style key for the menu sub button pressed color. */
    public static var MENU_SUB_BUTTON_DOWN_COLOR : String = "MENU_SUB_BUTTON_DOWN_COLOR";
    /** Style key for the menu sub button disabled color. */
    public static var MENU_SUB_BUTTON_DISABLE_COLOR : String = "MENU_SUB_BUTTON_DISABLE_COLOR";
    
    /** Style key for the menu button border alpha. */
    public static var MENU_BUTTON_BORDER_ALPHA : String = "MENU_BUTTON_BORDER_ALPHA";
    /** Style key for the menu button border. */
    public static var MENU_BUTTON_BORDER : String = "MENU_BUTTON_BORDER";
    /** Style key for the menu button border thickness. */
    public static var MENU_BUTTON_BORDER_THICKNESS : String = "MENU_BUTTON_BORDER_THICKNESS";
    
    /** Style key for the menu button border normal color. */
    public static var MENU_BUTTON_BORDER_NORMAL_COLOR : String = "MENU_BUTTON_BORDER_NORMAL_COLOR";
    /** Style key for the menu button border hover color. */
    public static var MENU_BUTTON_BORDER_OVER_COLOR : String = "MENU_BUTTON_BORDER_OVER_COLOR";
    /** Style key for the menu button border pressed color. */
    public static var MENU_BUTTON_BORDER_DOWN_COLOR : String = "MENU_BUTTON_BORDER_DOWN_COLOR";
    /** Style key for the menu button border disabled color. */
    public static var MENU_BUTTON_BORDER_DISABLE_COLOR : String = "MENU_BUTTON_BORDER_DISABLE_COLOR";
    
    /** Style key for the menu sub button border alpha. */
    public static var MENU_SUB_BUTTON_BORDER_ALPHA : String = "MENU_SUB_BUTTON_BORDER_ALPHA";
    /** Style key for the menu sub button border. */
    public static var MENU_SUB_BUTTON_BORDER : String = "MENU_SUB_BUTTON_BORDER";
    /** Style key for the menu sub button border thickness. */
    public static var MENU_SUB_BUTTON_BORDER_THICKNESS : String = "MENU_SUB_BUTTON_BORDER_THICKNESS";
    
    /** Style key for the menu sub button border normal color. */
    public static var MENU_SUB_BUTTON_BORDER_NORMAL_COLOR : String = "MENU_SUB_BUTTON_BORDER_NORMAL_COLOR";
    /** Style key for the menu sub button border hover color. */
    public static var MENU_SUB_BUTTON_BORDER_OVER_COLOR : String = "MENU_SUB_BUTTON_BORDER_OVER_COLOR";
    /** Style key for the menu sub button border pressed color. */
    public static var MENU_SUB_BUTTON_BORDER_DOWN_COLOR : String = "MENU_SUB_BUTTON_BORDER_DOWN_COLOR";
    /** Style key for the menu sub button border disabled color. */
    public static var MENU_SUB_BUTTON_BORDER_DISABLE_COLOR : String = "MENU_SUB_BUTTON_BORDER_DISABLE_COLOR";
    
    /** Style key for the menu label text embed. */
    public static var MENU_LABEL_TEXT_EMBED : String = "MENU_LABEL_TEXT_EMBED";
    /** Style key for the menu label text font. */
    public static var MENU_LABEL_TEXT_FONT : String = "MENU_LABEL_TEXT_FONT";
    
    /** Style key for the menu label text normal color. */
    public static var MENU_LABEL_TEXT_NORMAL_COLOR : String = "MENU_LABEL_TEXT_NORMAL_COLOR";
    /** Style key for the menu label text hover color. */
    public static var MENU_LABEL_TEXT_OVER_COLOR : String = "MENU_LABEL_TEXT_OVER_COLOR";
    /** Style key for the menu label text pressed color. */
    public static var MENU_LABEL_TEXT_DOWN_COLOR : String = "MENU_LABEL_TEXT_DOWN_COLOR";
    /** Style key for the menu label text disabled color. */
    public static var MENU_LABEL_TEXT_DISABLE_COLOR : String = "MENU_LABEL_TEXT_DISABLE_COLOR";
    
    /** Style key for the menu label text bold. */
    public static var MENU_LABEL_TEXT_BOLD : String = "MENU_LABEL_TEXT_BOLD";
    /** Style key for the menu label text italic. */
    public static var MENU_LABEL_TEXT_ITALIC : String = "MENU_LABEL_TEXT_ITALIC";
    /** Style key for the menu label text size. */
    public static var MENU_LABEL_TEXT_SIZE : String = "MENU_LABEL_TEXT_SIZE";
    
    /** Style key for the menu sub label text embed. */
    public static var MENU_SUB_LABEL_TEXT_EMBED : String = "MENU_SUB_LABEL_TEXT_EMBED";
    /** Style key for the menu sub label text font. */
    public static var MENU_SUB_LABEL_TEXT_FONT : String = "MENU_SUB_LABEL_TEXT_FONT";
    
    /** Style key for the menu sub label text normal color. */
    public static var MENU_SUB_LABEL_TEXT_NORMAL_COLOR : String = "MENU_SUB_LABEL_TEXT_NORMAL_COLOR";
    /** Style key for the menu sub label text hover color. */
    public static var MENU_SUB_LABEL_TEXT_OVER_COLOR : String = "MENU_SUB_LABEL_TEXT_OVER_COLOR";
    /** Style key for the menu sub label text pressed color. */
    public static var MENU_SUB_LABEL_TEXT_DOWN_COLOR : String = "MENU_SUB_LABEL_TEXT_DOWN_COLOR";
    /** Style key for the menu sub label text disabled color. */
    public static var MENU_SUB_LABEL_TEXT_DISABLE_COLOR : String = "MENU_SUB_LABEL_TEXT_DISABLE_COLOR";
    
    /** Style key for the menu sub label text bold. */
    public static var MENU_SUB_LABEL_TEXT_BOLD : String = "MENU_SUB_LABEL_TEXT_BOLD";
    /** Style key for the menu sub label text italic. */
    public static var MENU_SUB_LABEL_TEXT_ITALIC : String = "MENU_SUB_LABEL_TEXT_ITALIC";
    
    /** Style key for the menu sub label text size. */
    public static var MENU_SUB_LABEL_TEXT_SIZE : String = "MENU_SUB_LABEL_TEXT_SIZE";

    private static var styleList:Dynamic = {};
    
    /** Creates a style manager; shared styles are stored statically. */
    public function new() {}

    /** Stores a shared style and invalidates rendered textures when its value changes. */
    public static function setStyle(styleName : String, value:Dynamic) : Void 
    {
		if (!Reflect.hasField(styleList, styleName) || Reflect.field(styleList, styleName) != value) {
			Reflect.setField(styleList,styleName,value);
			UIBitmapManager.invalidateCustomRenderCache();
		}
	}

    /** Reports whether a shared style has been registered under the given key. */
    public static function hasStyle(styleName : String) : Bool {
        return Reflect.hasField(styleList, styleName);
    }

    /** Returns the value registered under the given style key, or null if absent. */
    public static function getStyle(styleName : String) : Dynamic {
        return Reflect.field(styleList, styleName);
    }

    /** Removes a style key and invalidates rendered textures when it existed. */
    public static function removeStyle(styleName:String):Void {
        if (styleName == null || styleName == "") {
            return;
        }

        if (Reflect.hasField(styleList, styleName)) {
			Reflect.deleteField(styleList, styleName);
			UIBitmapManager.invalidateCustomRenderCache();
		}
    }

    /** Removes every shared style and invalidates rendered textures if any existed. */
    public static function clear() : Void {
		var hadStyles:Bool = Reflect.fields(styleList).length > 0;

        for (index in Reflect.fields(styleList)) 
            Reflect.deleteField(styleList,index);

		if (hadStyles)
			UIBitmapManager.invalidateCustomRenderCache();
    }


}

