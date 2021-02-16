package com.chaos.ui.theming;

/**
* Apply Color UI Components using the UIStyleManager and UIBitmapManager
**/

class Theme {

    
    private var _primaryColor : Int = 0xCCCCCC;
    private var _secondaryColor :Int = 0x333333;

    private var _primaryTextColor : Int = 0x000000;
    private var _secondaryTextColor :Int = 0xFFFFFF;

    private var _highlightColor : Int = 0x666666;
    private var _shadowColor : Int = 0x000000;

    private var _background : Int = 0xF5F2F0;


    /**
    * Style Components based on passed in values
    *  @param	data The colors that will be used for the theme
    *  
    * primaryColor - The default color 
    * secondaryColor - The border color 
    * selectedColor - The down state or selected state. Will use secondaryColor if not set.
    * primaryTextColor - The default color text
    * secondaryTextColor - The down or selected state for text
    * highlightColor - The over state 
    * shadowColor - The down state 
    * background - The background color used on all layout containers
    **/

    public function new(data:Dynamic = null) {

        if(null == data)
            data = {};
        
        initialize(data);
    }

    private function initialize(data:Dynamic = null):Void {

        // Set all the base level details
        if(Reflect.hasField(data,"primaryColor"))
            _primaryColor = Reflect.field(data,"primaryColor");

        if(Reflect.hasField(data,"secondaryColor"))
            _secondaryColor = Reflect.field(data,"secondaryColor");

        if(Reflect.hasField(data,"primaryTextColor"))
            _primaryTextColor = Reflect.field(data,"primaryTextColor");

        if(Reflect.hasField(data,"secondaryTextColor"))
            _secondaryTextColor = Reflect.field(data,"secondaryTextColor");

        if(Reflect.hasField(data,"highlightColor"))
            _highlightColor = Reflect.field(data,"highlightColor");

        if(Reflect.hasField(data,"shadowColor"))
            _shadowColor = Reflect.field(data,"shadowColor");

        if(Reflect.hasField(data,"background"))
            _background = Reflect.field(data,"background");

    }

    /**
    * Style and Skin the UI Components
    **/

    public function apply():Void {

        // Setup all the default base items
        style();
        skin();

        // Set UIBitmapManager
        UIBitmapManager.updateAllUIElement();

    }

    private function style() {
        
        // Set UIStyleManager

        // ACCORDION 
        UIStyleManager.setStyle(UIStyleManager.ACCORDION_BUTTON_NORMAL_COLOR , _primaryColor);
        UIStyleManager.setStyle(UIStyleManager.ACCORDION_BUTTON_OVER_COLOR , _highlightColor);
        UIStyleManager.setStyle(UIStyleManager.ACCORDION_BUTTON_SELECTED_COLOR , _secondaryColor);
        UIStyleManager.setStyle(UIStyleManager.ACCORDION_BUTTON_DISABLE_COLOR , _shadowColor);

        UIStyleManager.setStyle(UIStyleManager.ACCORDION_BUTTON_TEXT_COLOR , _primaryTextColor);
        UIStyleManager.setStyle(UIStyleManager.ACCORDION_BUTTON_SELECTED_TEXT_COLOR , _secondaryTextColor);

        // BUBBLE
        UIStyleManager.setStyle(UIStyleManager.BUBBLE_BACKGROUND_NORMAL_COLOR , _background);
        UIStyleManager.setStyle(UIStyleManager.BUBBLE_BORDER_COLOR , _secondaryColor);


        // BUTTON
        UIStyleManager.setStyle(UIStyleManager.BUTTON_NORMAL_COLOR , _primaryColor);
        UIStyleManager.setStyle(UIStyleManager.BUTTON_OVER_COLOR , _highlightColor);
        UIStyleManager.setStyle(UIStyleManager.BUTTON_DOWN_COLOR , _shadowColor);
        UIStyleManager.setStyle(UIStyleManager.BUTTON_DISABLE_COLOR , _secondaryColor);

        UIStyleManager.setStyle(UIStyleManager.BUTTON_TEXT_COLOR , _primaryTextColor);
        UIStyleManager.setStyle(UIStyleManager.BUTTON_TEXT_DISABLE_COLOR , _secondaryTextColor);

        // CHECKBOX
        UIStyleManager.setStyle(UIStyleManager.CHECKBOX_NORMAL_COLOR , _primaryColor);
        UIStyleManager.setStyle(UIStyleManager.CHECKBOX_OVER_COLOR , _highlightColor);
        UIStyleManager.setStyle(UIStyleManager.CHECKBOX_DOWN_COLOR , _shadowColor);
        UIStyleManager.setStyle(UIStyleManager.CHECKBOX_DISABLE_COLOR , _secondaryColor);

        UIStyleManager.setStyle(UIStyleManager.CHECKBOX_TEXT_COLOR , _primaryTextColor);

        // COMBOBOX
        UIStyleManager.setStyle(UIStyleManager.COMBO_BACKGROUND_COLOR , _background);
        UIStyleManager.setStyle(UIStyleManager.COMBO_BORDER_COLOR , _secondaryColor);

        UIStyleManager.setStyle(UIStyleManager.COMBO_TEXT_COLOR , _primaryTextColor);
        UIStyleManager.setStyle(UIStyleManager.COMBO_TEXT_OVER_COLOR , _secondaryTextColor);

        UIStyleManager.setStyle(UIStyleManager.COMBO_TEXT_NORMAL_BACKGROUND_COLOR , _secondaryColor);
        UIStyleManager.setStyle(UIStyleManager.COMBO_TEXT_OVER_BACKGROUND_COLOR , _highlightColor);

        // GRID PANE
        UIStyleManager.setStyle(UIStyleManager.GRID_BACKGROUND_COLOR , _background);
        UIStyleManager.setStyle(UIStyleManager.GRID_CELL_BORDER_COLOR , _secondaryColor);
        UIStyleManager.setStyle(UIStyleManager.GRID_BORDER_COLOR , _secondaryColor);

        // ICON
        UIStyleManager.setStyle(UIStyleManager.ICON_COLOR , _background);
        UIStyleManager.setStyle(UIStyleManager.ICON_BORDER_COLOR , _secondaryColor);

        // ITEM PANE
        UIStyleManager.setStyle(UIStyleManager.ITEMPANE_BORDER_COLOR , _secondaryColor);

        UIStyleManager.setStyle(UIStyleManager.ITEMPANE_ITEM_NORMAL_COLOR , _primaryColor);
        UIStyleManager.setStyle(UIStyleManager.ITEMPANE_ITEM_OVER_COLOR , _highlightColor);
        UIStyleManager.setStyle(UIStyleManager.ITEMPANE_ITEM_SELECTED_COLOR , _secondaryColor);
        UIStyleManager.setStyle(UIStyleManager.ITEMPANE_ITEM_DISABLE_COLOR , _secondaryColor);

        UIStyleManager.setStyle(UIStyleManager.ITEMPANE_TEXT_COLOR , _primaryTextColor);
        UIStyleManager.setStyle(UIStyleManager.ITEMPANE_TEXT_SELECTED_COLOR , _secondaryTextColor);
        

        // LABEL
        UIStyleManager.setStyle(UIStyleManager.LABEL_TEXT_COLOR , _primaryTextColor);
        UIStyleManager.setStyle(UIStyleManager.LABEL_BORDER_COLOR , _secondaryColor);
        UIStyleManager.setStyle(UIStyleManager.LABEL_BORDER , false);

        // LISTBOX
        UIStyleManager.setStyle(UIStyleManager.LIST_BORDER_COLOR , _secondaryColor);
        UIStyleManager.setStyle(UIStyleManager.LIST_BACKGROUND_COLOR , _background);

        UIStyleManager.setStyle(UIStyleManager.LIST_TEXT_NORMAL_COLOR , _primaryTextColor);

        UIStyleManager.setStyle(UIStyleManager.LIST_TEXT_OVER_BACKGROUND_COLOR , _highlightColor);
        UIStyleManager.setStyle(UIStyleManager.LIST_TEXT_OVER_COLOR , _secondaryTextColor);

        UIStyleManager.setStyle(UIStyleManager.LIST_TEXT_SELECTED_BACKGROUND_COLOR , _secondaryColor);
        UIStyleManager.setStyle(UIStyleManager.LIST_TEXT_SELECTED_COLOR , _secondaryTextColor);

        // MENU
        UIStyleManager.setStyle(UIStyleManager.MENU_BACKGROUND_COLOR , _background);

        UIStyleManager.setStyle(UIStyleManager.MENU_BORDER_NORMAL_COLOR , _secondaryColor);
        UIStyleManager.setStyle(UIStyleManager.MENU_BORDER_OVER_COLOR , _primaryColor);
        UIStyleManager.setStyle(UIStyleManager.MENU_BORDER_DOWN_COLOR , _secondaryColor);
        UIStyleManager.setStyle(UIStyleManager.MENU_BORDER_DISABLE_COLOR , _primaryColor);

        UIStyleManager.setStyle(UIStyleManager.MENU_LABEL_TEXT_NORMAL_COLOR , _primaryTextColor);
        UIStyleManager.setStyle(UIStyleManager.MENU_LABEL_TEXT_OVER_COLOR , _secondaryTextColor);

        UIStyleManager.setStyle(UIStyleManager.MENU_NORMAL_COLOR , _primaryColor);
        UIStyleManager.setStyle(UIStyleManager.MENU_OVER_COLOR , _highlightColor);
        UIStyleManager.setStyle(UIStyleManager.MENU_DOWN_COLOR , _shadowColor);
        UIStyleManager.setStyle(UIStyleManager.MENU_DISABLE_COLOR , _secondaryColor);

        UIStyleManager.setStyle(UIStyleManager.MENU_SUB_BORDER_NORMAL_COLOR , _primaryColor);
        UIStyleManager.setStyle(UIStyleManager.MENU_SUB_BORDER_OVER_COLOR , _secondaryColor);
        UIStyleManager.setStyle(UIStyleManager.MENU_SUB_BORDER_DOWN_COLOR , _shadowColor);
        UIStyleManager.setStyle(UIStyleManager.MENU_SUB_BORDER_DISABLE_COLOR , _secondaryColor);

        UIStyleManager.setStyle(UIStyleManager.MENU_SUB_NORMAL_COLOR , _secondaryColor);
        UIStyleManager.setStyle(UIStyleManager.MENU_SUB_OVER_COLOR , _highlightColor);
        UIStyleManager.setStyle(UIStyleManager.MENU_SUB_DOWN_COLOR , _primaryColor);
        UIStyleManager.setStyle(UIStyleManager.MENU_SUB_DISABLE_COLOR , _secondaryColor);

        UIStyleManager.setStyle(UIStyleManager.MENU_SUB_LABEL_TEXT_NORMAL_COLOR , _secondaryTextColor);
        UIStyleManager.setStyle(UIStyleManager.MENU_SUB_LABEL_TEXT_OVER_COLOR , _primaryTextColor);

        // PROGRESSBAR
        UIStyleManager.setStyle(UIStyleManager.PROGRESSBAR_COLOR , _primaryColor);
        UIStyleManager.setStyle(UIStyleManager.PROGRESSBAR_COLOR_LOADED , _secondaryColor);

        UIStyleManager.setStyle(UIStyleManager.PROGRESSBAR_BORDER_COLOR , _secondaryColor);
        
        UIStyleManager.setStyle(UIStyleManager.PROGRESSBAR_TEXT_COLOR , _primaryTextColor);
        UIStyleManager.setStyle(UIStyleManager.PROGRESSBAR_TEXT_LOADED_COLOR , _secondaryTextColor);

        // PROGRESS SLIDER
        UIStyleManager.setStyle(UIStyleManager.PROGRESS_SLIDER_COLOR , _primaryColor);
        UIStyleManager.setStyle(UIStyleManager.PROGRESS_SLIDER_COLOR_LOADED , _secondaryColor);

        UIStyleManager.setStyle(UIStyleManager.PROGRESS_SLIDER_BORDER_COLOR , _secondaryColor);

        // RADIO
        UIStyleManager.setStyle(UIStyleManager.RADIOBUTTON_NORMAL_COLOR , _primaryColor);
        UIStyleManager.setStyle(UIStyleManager.RADIOBUTTON_OVER_COLOR , _highlightColor);
        UIStyleManager.setStyle(UIStyleManager.RADIOBUTTON_DOWN_COLOR , _shadowColor);
        UIStyleManager.setStyle(UIStyleManager.RADIOBUTTON_DISABLE_COLOR , _secondaryColor);

        UIStyleManager.setStyle(UIStyleManager.RADIOBUTTON_TEXT_COLOR , _primaryTextColor);

        // SCROLLBAR
        UIStyleManager.setStyle(UIStyleManager.SCROLLBAR_BUTTON_NORMAL_COLOR , _primaryColor);
        UIStyleManager.setStyle(UIStyleManager.SCROLLBAR_BUTTON_OVER_COLOR , _highlightColor);
        UIStyleManager.setStyle(UIStyleManager.SCROLLBAR_BUTTON_DOWN_COLOR , _shadowColor);
        UIStyleManager.setStyle(UIStyleManager.SCROLLBAR_BUTTON_DISABLE_COLOR , _secondaryColor);

        UIStyleManager.setStyle(UIStyleManager.SCROLLBAR_TRACK_COLOR , _highlightColor);

        UIStyleManager.setStyle(UIStyleManager.SCROLLBAR_SLIDER_NORMAL_COLOR , _primaryColor);
        UIStyleManager.setStyle(UIStyleManager.SCROLLBAR_SLIDER_OVER_COLOR , _highlightColor);
        UIStyleManager.setStyle(UIStyleManager.SCROLLBAR_SLIDER_DOWN_COLOR , _shadowColor);

        // SCORLLPANE
        UIStyleManager.setStyle(UIStyleManager.SCROLLPANE_BACKGROUND , _background);
        
        // SLIDER
        UIStyleManager.setStyle(UIStyleManager.SLIDER_NORMAL_COLOR , _primaryColor);
        UIStyleManager.setStyle(UIStyleManager.SLIDER_OVER_COLOR , _primaryColor);
        UIStyleManager.setStyle(UIStyleManager.SLIDER_DOWN_COLOR , _shadowColor);
        UIStyleManager.setStyle(UIStyleManager.SLIDER_DISABLE_COLOR , _secondaryColor);

        UIStyleManager.setStyle(UIStyleManager.SLIDER_TRACK_COLOR , _highlightColor);

        // TABPANE
        UIStyleManager.setStyle(UIStyleManager.TABPANE_BACKGROUND , _background);
        UIStyleManager.setStyle(UIStyleManager.TABPANE_BORDER , true);

        UIStyleManager.setStyle(UIStyleManager.TABPANE_BUTTON_NORMAL_COLOR , _primaryColor);
        UIStyleManager.setStyle(UIStyleManager.TABPANE_BUTTON_OVER_COLOR , _highlightColor);
        UIStyleManager.setStyle(UIStyleManager.TABPANE_BUTTON_SELECTED_COLOR , _shadowColor);
        UIStyleManager.setStyle(UIStyleManager.TABPANE_BUTTON_DISABLE_COLOR , _secondaryColor);

        UIStyleManager.setStyle(UIStyleManager.TABPANE_BUTTON_TEXT_COLOR , _primaryTextColor);
        UIStyleManager.setStyle(UIStyleManager.TABPANE_BUTTON_TEXT_COLOR_SELECTED , _secondaryTextColor);
        
        // TEXTINPUT
        UIStyleManager.setStyle(UIStyleManager.INPUT_BACKGROUND_NORMAL_COLOR , _background);
        UIStyleManager.setStyle(UIStyleManager.INPUT_BACKGROUND_OVER_COLOR , _highlightColor);
        UIStyleManager.setStyle(UIStyleManager.INPUT_BACKGROUND_SELECTED_COLOR , _shadowColor);
        UIStyleManager.setStyle(UIStyleManager.INPUT_BACKGROUND_DISABLE_COLOR , _secondaryColor);

        UIStyleManager.setStyle(UIStyleManager.INPUT_BORDER_COLOR , _secondaryColor);

        UIStyleManager.setStyle(UIStyleManager.INPUT_TEXT_COLOR , _primaryTextColor);
        UIStyleManager.setStyle(UIStyleManager.INPUT_TEXT_OVER_COLOR , _primaryTextColor);
        UIStyleManager.setStyle(UIStyleManager.INPUT_TEXT_SELECTED_COLOR , _secondaryTextColor);
        UIStyleManager.setStyle(UIStyleManager.INPUT_TEXT_DISABLE_COLOR , _secondaryTextColor);

        // TOGGLE
        UIStyleManager.setStyle(UIStyleManager.TOGGLE_BUTTON_BORDER , true);
        UIStyleManager.setStyle(UIStyleManager.TOGGLE_BUTTON_BORDER_ALPHA , .4);
        UIStyleManager.setStyle(UIStyleManager.TOGGLE_BUTTON_BORDER_NORMAL_COLOR , _secondaryColor);
        UIStyleManager.setStyle(UIStyleManager.TOGGLE_BUTTON_BORDER_OVER_COLOR , _secondaryColor);
        UIStyleManager.setStyle(UIStyleManager.TOGGLE_BUTTON_BORDER_SELECTED_COLOR , _shadowColor);
        UIStyleManager.setStyle(UIStyleManager.TOGGLE_BUTTON_BORDER_DISABLE_COLOR , _shadowColor);


        // TOOLTIP
        UIStyleManager.setStyle(UIStyleManager.TOOLTIP_BACKGROUND_NORMAL_COLOR , _background);
        UIStyleManager.setStyle(UIStyleManager.TOOLTIP_BORDER_COLOR , _secondaryColor);
        UIStyleManager.setStyle(UIStyleManager.TOOLTIP_BORDER , true);
        UIStyleManager.setStyle(UIStyleManager.TOOLTIP_LABEL_TEXT_COLOR , _primaryTextColor);

        // WINDOWS
        UIStyleManager.setStyle(UIStyleManager.WINDOW_BACKGROUND_COLOR , _background);

        UIStyleManager.setStyle(UIStyleManager.WINDOW_TITLE_AREA_COLOR , _primaryColor);
        UIStyleManager.setStyle(UIStyleManager.WINDOW_TITLE_AREA_UNFOCUS_COLOR , _secondaryColor);

        UIStyleManager.setStyle(UIStyleManager.WINDOW_FOCUS_COLOR , _primaryColor);
        UIStyleManager.setStyle(UIStyleManager.WINDOW_UNFOCUS_COLOR , _secondaryColor);

        UIStyleManager.setStyle(UIStyleManager.WINDOW_MAX_NORMAL_COLOR , _secondaryColor);
        UIStyleManager.setStyle(UIStyleManager.WINDOW_MAX_UNFOCUS_COLOR , _primaryColor);

        UIStyleManager.setStyle(UIStyleManager.WINDOW_MIN_NORMAL_COLOR , _secondaryColor);
        UIStyleManager.setStyle(UIStyleManager.WINDOW_MIN_UNFOCUS_COLOR , _primaryColor);

        UIStyleManager.setStyle(UIStyleManager.WINDOW_CLOSE_NORMAL_COLOR , _secondaryColor);
        UIStyleManager.setStyle(UIStyleManager.WINDOW_CLOSE_UNFOCUS_COLOR , _primaryColor);


    }

    private function skin() {
    }    

    
}