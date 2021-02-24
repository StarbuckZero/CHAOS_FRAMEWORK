package com.chaos.engine;

import openfl.display.BitmapData;
import openfl.events.Event;
import com.chaos.ui.UIStyleManager;
import com.chaos.ui.UIBitmapManager;
import com.chaos.media.DisplayImage;

/**
* Skin all UI classes in the CHAOS framework
* @author Erick Feiling
* 
*    {
*        "style": {},
*        "bitmap": {}
*    }
*  
*/


class ThemeSystem
{
    public static var uiList : Array<Dynamic>;
    public function new(){}
    
    public static function setBitmap(style : String, image:BitmapData) : Void
    {
        if (null == uiList)
            uiList = UIBitmapManager.getUIElementNameList();
        
        var UITypeElement : String = style.substring(0, style.indexOf("_"));
                    
        for (i in 0...uiList.length)
        {
            if (Std.string(uiList[i]).toUpperCase() == UITypeElement.toUpperCase())
                UIBitmapManager.setUIElement(uiList[i], style.toLowerCase(), image);
        }
    }
    
    /**
    * Update all bitmaps
    */
    public static function updateAllElement() : Void
    {
        var list : Array<Dynamic> = UIBitmapManager.getUIElementNameList();
        
        for (i in 0...list.length)
        {
            UIBitmapManager.updateUIElement(list[i]);
        }
    }
    
    public static function setStyle(name : String, value : Dynamic) : Void
    {
        name = name.toUpperCase();
        
        if (name.indexOf("ALERT_") != -1)
        {
            setAlertStyle(name, value);
        }
        else if (name.indexOf("BUBBLE_") != -1)
        {
            setBubbleStyle(name, value);
        }
        else if (name.indexOf("BUTTON_") != -1)
        {
            setButtonStyle(name, value);
        }
        else if (name.indexOf("CHECKBOX_") != -1)
        {
            setCheckBoxStyle(name, value);
        }
        else if (name.indexOf("RADIOBUTTON_") != -1)
        {
            setRadioStyle(name, value);
        }
        else if (name.indexOf("COMBO_") != -1)
        {
            setComboStyle(name, value);
        }
        else if (name.indexOf("GRID_") != -1)
        {
            setGridStyle(name, value);
        }
        else if (name.indexOf("LIST_") != -1)
        {
            setListStyle(name, value);
        }
        else if (name.indexOf("LABEL_") != -1)
        {
            setLabelStyle(name, value);
        }
        else if (name.indexOf("INPUT_") != -1)
        {
            setInputStyle(name, value);
        }
        else if (name.indexOf("PROGRESSBAR_") != -1)
        {
            setProgressBarStyle(name, value);
        }
        else if (name.indexOf("PROGRESS_SLIDER_") != -1)
        {
            setProgressSliderStyle(name, value);
        }
        else if (name.indexOf("SCROLLBAR_") != -1)
        {
            setScrollBarStyle(name, value);
        }
        else if (name.indexOf("SLIDER_") != -1)
        {
            setSliderStyle(name, value);
        }
        else if (name.indexOf("SCROLLPANE_") != -1)
        {
            setScrollPaneStyle(name, value);
        }
        else if (name.indexOf("ITEMPANE_") != -1)
        {
            setItemPaneStyle(name, value);
        }
        else if (name.indexOf("TABPANE_") != -1)
        {
            setTabPaneStyle(name, value);
        }
        else if (name.indexOf("TOOLTIP_") != -1)
        {
            setToolTipStyle(name, value);
        }
        else if (name.indexOf("WINDOW_") != -1)
        {
            setWindowStyle(name, value);
        }
        else if (name.indexOf("MENU_") != -1)
        {
            setMenuStyle(name, value);
        }
    }
    
    public static function setAlertStyle(name : String, value : Dynamic) : Void
    {
        if (name == "ALERT_BACKGROUND_COLOR")
        {
            UIStyleManager.ALERT_BACKGROUND_COLOR = value;
            return;
        }
        else if (name == "ALERT_TITLE_TEXT_EMBED")
        {
            UIStyleManager.ALERT_TITLE_TEXT_EMBED = value;
            return;
        }
        else if (name == "ALERT_TITLE_TEXT_FONT")
        {
            UIStyleManager.ALERT_TITLE_TEXT_FONT = value;
            return;
        }
        else if (name == "ALERT_TITLE_TEXT_COLOR")
        {
            UIStyleManager.ALERT_TITLE_TEXT_COLOR = value;
            return;
        }
        else if (name == "ALERT_TITLE_TEXT_SIZE")
        {
            UIStyleManager.ALERT_TITLE_TEXT_SIZE = value;
            return;
        }
        else if (name == "ALERT_TITLE_TEXT_BOLD")
        {
            UIStyleManager.ALERT_TITLE_TEXT_BOLD = value;
            return;
        }
        else if (name == "ALERT_TITLE_TEXT_ITALIC")
        {
            UIStyleManager.ALERT_TITLE_TEXT_ITALIC = value;
            return;
        }
        else if (name == "ALERT_TITLE_AREA_COLOR")
        {
            UIStyleManager.ALERT_TITLE_AREA_COLOR = value;
            return;
        }
        else if (name == "ALERT_TITLE_AREA_UNFOCUS_COLOR")
        {
            UIStyleManager.ALERT_TITLE_AREA_UNFOCUS_COLOR = value;
            return;
        }
        else if (name == "ALERT_WINDOW_FOCUS_COLOR")
        {
            UIStyleManager.ALERT_WINDOW_FOCUS_COLOR = value;
            return;
        }
        else if (name == "ALERT_WINDOW_UNFOCUS_COLOR")
        {
            UIStyleManager.ALERT_WINDOW_UNFOCUS_COLOR = value;
            return;
        }
        else if (name == "ALERT_MODAL_TINT_ALPHA")
        {
            UIStyleManager.ALERT_MODAL_TINT_ALPHA = value;
            return;
        }
        else if (name == "ALERT_MODAL_BACKGROUND_COLOR")
        {
            UIStyleManager.ALERT_MODAL_BACKGROUND_COLOR = value;
            return;
        }
        else if (name == "ALERT_OK_TEXT")
        {
            UIStyleManager.ALERT_OK_TEXT = value;
            return;
        }
        else if (name == "ALERT_CANCEL_TEXT")
        {
            UIStyleManager.ALERT_CANCEL_TEXT = value;
            return;
        }
        else if (name == "ALERT_YES_TEXT")
        {
            UIStyleManager.ALERT_YES_TEXT = value;
            return;
        }
        else if (name == "ALERT_NO_TEXT")
        {
            UIStyleManager.ALERT_NO_TEXT = value;
            return;
        }
        else if (name == "ALERT_MAYBE_TEXT")
        {
            UIStyleManager.ALERT_MAYBE_TEXT = value;
            return;
        }
        else if (name == "ALERT_BOTTOM_COLOR")
        {
            UIStyleManager.ALERT_BOTTOM_COLOR = value;
            return;
        }
        else if (name == "ALERT_UNFOCUS_BOTTOM_COLOR")
        {
            UIStyleManager.ALERT_UNFOCUS_BOTTOM_COLOR = value;
            return;
        }
        else if (name == "ALERT_ICON_LOCATION")
        {
            UIStyleManager.ALERT_ICON_LOCATION = value;
            return;
        }
        else if (name == "ALERT_BUTTON_LOCATION")
        {
            UIStyleManager.ALERT_BUTTON_LOCATION = value;
            return;
        }
        else if (name == "ALERT_LABEL_LOCATION")
        {
            UIStyleManager.ALERT_LABEL_LOCATION = value;
            return;
        }
        else if (name == "ALERT_CLOSE_BUTTON_NORMAL_COLOR")
        {
            UIStyleManager.ALERT_CLOSE_BUTTON_NORMAL_COLOR = value;
            return;
        }
        else if (name == "ALERT_CLOSE_BUTTON_OVER_COLOR")
        {
            UIStyleManager.ALERT_CLOSE_BUTTON_OVER_COLOR = value;
            return;
        }
        else if (name == "ALERT_CLOSE_BUTTON_DOWN_COLOR")
        {
            UIStyleManager.ALERT_CLOSE_BUTTON_DOWN_COLOR = value;
            return;
        }
        else if (name == "ALERT_CLOSE_BUTTON_DISABLE_COLOR")
        {
            UIStyleManager.ALERT_CLOSE_BUTTON_DISABLE_COLOR = value;
            return;
        }
        else if (name == "ALERT_POSITIVE_BUTTON_NORMAL_COLOR")
        {
            UIStyleManager.ALERT_POSITIVE_BUTTON_NORMAL_COLOR = value;
            return;
        }
        else if (name == "ALERT_POSITIVE_BUTTON_OVER_COLOR")
        {
            UIStyleManager.ALERT_POSITIVE_BUTTON_OVER_COLOR = value;
            return;
        }
        else if (name == "ALERT_POSITIVE_BUTTON_DOWN_COLOR")
        {
            UIStyleManager.ALERT_POSITIVE_BUTTON_DOWN_COLOR = value;
            return;
        }
        else if (name == "ALERT_NEGATIVE_BUTTON_NORMAL_COLOR")
        {
            UIStyleManager.ALERT_NEGATIVE_BUTTON_NORMAL_COLOR = value;
            return;
        }
        else if (name == "ALERT_NEGATIVE_BUTTON_OVER_COLOR")
        {
            UIStyleManager.ALERT_NEGATIVE_BUTTON_OVER_COLOR = value;
            return;
        }
        else if (name == "ALERT_NEGATIVE_BUTTON_DOWN_COLOR")
        {
            UIStyleManager.ALERT_NEGATIVE_BUTTON_DOWN_COLOR = value;
            return;
        }
        else if (name == "ALERT_NEUTRAL_BUTTON_NORMAL_COLOR")
        {
            UIStyleManager.ALERT_NEUTRAL_BUTTON_NORMAL_COLOR = value;
            return;
        }
        else if (name == "ALERT_NEUTRAL_BUTTON_OVER_COLOR")
        {
            UIStyleManager.ALERT_NEUTRAL_BUTTON_OVER_COLOR = value;
            return;
        }
        else if (name == "ALERT_NEUTRAL_BUTTON_DOWN_COLOR")
        {
            UIStyleManager.ALERT_NEUTRAL_BUTTON_DOWN_COLOR = value;
            return;
        }
        else if (name == "BUBBLE_BACKGROUND_NORMAL_COLOR")
        {
            UIStyleManager.BUBBLE_BACKGROUND_NORMAL_COLOR = value;
            return;
        }
        else if (name == "BUBBLE_BACKGROUND_ALPHA")
        {
            UIStyleManager.BUBBLE_BACKGROUND_ALPHA = value;
            return;
        }
        else if (name == "BUBBLE_BORDER_ALPHA")
        {
            UIStyleManager.BUBBLE_BORDER_ALPHA = value;
            return;
        }
        else if (name == "BUBBLE_BORDER")
        {
            UIStyleManager.BUBBLE_BORDER = value;
            return;
        }
        else if (name == "BUBBLE_BORDER_COLOR")
        {
            UIStyleManager.BUBBLE_BORDER_COLOR = value;
            return;
        }
        else if (name == "BUBBLE_BORDER_THINKNESS")
        {
            UIStyleManager.BUBBLE_BORDER_THINKNESS = value;
            return;
        }
    }
    
    public static function setBubbleStyle(name : String, value : Dynamic) : Void
    {
        switch (name)
        {
            case "BUBBLE_BACKGROUND_NORMAL_COLOR":
                UIStyleManager.BUBBLE_BACKGROUND_NORMAL_COLOR = value;
            
            case "BUBBLE_BACKGROUND_ALPHA":
                UIStyleManager.BUBBLE_BACKGROUND_ALPHA = value;
            
            case "BUBBLE_BORDER_ALPHA":
                UIStyleManager.BUBBLE_BORDER_ALPHA = value;
            
            case "BUBBLE_BORDER":
                UIStyleManager.BUBBLE_BORDER = value;
            
            case "BUBBLE_BORDER_COLOR":
                UIStyleManager.BUBBLE_BORDER_COLOR = value;
            
            case "BUBBLE_BORDER_THINKNESS":
                UIStyleManager.BUBBLE_BORDER_THINKNESS = value;
        }
    }
    
    public static function setButtonStyle(name : String, value : Dynamic) : Void
    {
        switch (name)
        {
            case "BUTTON_TINT_ALPHA":
                UIStyleManager.BUTTON_TINT_ALPHA = value;
            
            case "BUTTON_NORMAL_COLOR":
                UIStyleManager.BUTTON_NORMAL_COLOR = value;
            
            case "BUTTON_OVER_COLOR":
                UIStyleManager.BUTTON_OVER_COLOR = value;
            
            case "BUTTON_DOWN_COLOR":
                UIStyleManager.BUTTON_DOWN_COLOR = value;
            
            case "BUTTON_DISABLE_COLOR":
                UIStyleManager.BUTTON_DISABLE_COLOR = value;
            
            case "BUTTON_TEXT_EMBED":
                UIStyleManager.BUTTON_TEXT_EMBED = value;
            
            case "BUTTON_TEXT_FONT":
                UIStyleManager.BUTTON_TEXT_FONT = value;
            
            case "BUTTON_TEXT_COLOR":
                UIStyleManager.BUTTON_TEXT_COLOR = value;
            
            case "BUTTON_TEXT_SIZE":
                UIStyleManager.BUTTON_TEXT_SIZE = value;
            
            case "BUTTON_TEXT_BOLD":
                UIStyleManager.BUTTON_TEXT_BOLD = value;
            
            case "BUTTON_TEXT_ITALIC":
                UIStyleManager.BUTTON_TEXT_ITALIC = value;
            
            case "BUTTON_TEXT_ALIGN":
                UIStyleManager.BUTTON_TEXT_ALIGN = value;
            
            case "BUTTON_ROUND_NUM":
                UIStyleManager.BUTTON_ROUND_NUM = value;
            
            case "BUTTON_TEXT_OFFSET_X":
                UIStyleManager.BUTTON_TEXT_OFFSET_X = value;
            
            case "BUTTON_TEXT_OFFSET_Y":
                UIStyleManager.BUTTON_TEXT_OFFSET_Y = value;
            
            case "BUTTON_IMAGE_OFFSET_X":
                UIStyleManager.BUTTON_IMAGE_OFFSET_X = value;
            
            case "BUTTON_IMAGE_OFFSET_Y":
                UIStyleManager.BUTTON_IMAGE_OFFSET_Y = value;
            
            case "BUTTON_ICON_WIDTH":
                UIStyleManager.BUTTON_ICON_WIDTH = value;
            
            case "BUTTON_ICON_HEIGHT":
                UIStyleManager.BUTTON_ICON_HEIGHT = value;
            
            case "BUTTON_WIDTH":
                UIStyleManager.BUTTON_WIDTH = value;
            
            case "BUTTON_HEIGHT":
                UIStyleManager.BUTTON_HEIGHT = value;
            
            case "BUTTON_ALPHA":
                UIStyleManager.BUTTON_ALPHA = value;
        }
    }
    
    public static function setCheckBoxStyle(name : String, value : Dynamic) : Void
    {
        switch (name)
        {
            
            case "CHECKBOX_NORMAL_COLOR":
                UIStyleManager.CHECKBOX_NORMAL_COLOR = value;
            
            case "CHECKBOX_OVER_COLOR":
                UIStyleManager.CHECKBOX_OVER_COLOR = value;
            
            case "CHECKBOX_DOWN_COLOR":
                UIStyleManager.CHECKBOX_DOWN_COLOR = value;
            
            case "CHECKBOX_DISABLE_COLOR":
                UIStyleManager.CHECKBOX_DISABLE_COLOR = value;
            
            case "CHECKBOX_TEXT_COLOR":
                UIStyleManager.CHECKBOX_TEXT_COLOR = value;
            
            case "CHECKBOX_TEXT_BOLD":
                UIStyleManager.CHECKBOX_TEXT_BOLD = value;
            
            case "CHECKBOX_TEXT_ITALIC":
                UIStyleManager.CHECKBOX_TEXT_ITALIC = value;
            
            case "CHECKBOX_TEXT_SIZE":
                UIStyleManager.CHECKBOX_TEXT_SIZE = value;
            
            case "CHECKBOX_TEXT_ALIGN":
                UIStyleManager.CHECKBOX_TEXT_ALIGN = value;
            
            case "CHECKBOX_SIZE":
                UIStyleManager.CHECKBOX_SIZE = value;
            
            case "CHECKBOX_LABEL_OFFSET_X":
                UIStyleManager.CHECKBOX_LABEL_OFFSET_X = value;
            
            case "CHECKBOX_LABEL_OFFSET_Y":
                UIStyleManager.CHECKBOX_LABEL_OFFSET_Y = value;
        }
    }
    
    public static function setRadioStyle(name : String, value : Dynamic) : Void
    {
        switch (name)
        {
            
            case "RADIOBUTTON_NORMAL_COLOR":
                UIStyleManager.RADIOBUTTON_NORMAL_COLOR = value;
            
            case "RADIOBUTTON_OVER_COLOR":
                UIStyleManager.RADIOBUTTON_OVER_COLOR = value;
            
            case "RADIOBUTTON_DOWN_COLOR":
                UIStyleManager.RADIOBUTTON_DOWN_COLOR = value;
            
            case "RADIOBUTTON_DISABLE_COLOR":
                UIStyleManager.RADIOBUTTON_DISABLE_COLOR = value;
            
            case "RADIOBUTTON_TEXT_COLOR":
                UIStyleManager.RADIOBUTTON_TEXT_COLOR = value;
            
            case "RADIOBUTTON_TEXT_BOLD":
                UIStyleManager.RADIOBUTTON_TEXT_BOLD = value;
            
            case "RADIOBUTTON_TEXT_ITALIC":
                UIStyleManager.RADIOBUTTON_TEXT_ITALIC = value;
            
            case "RADIOBUTTON_TEXT_SIZE":
                UIStyleManager.RADIOBUTTON_TEXT_SIZE = value;
            
            case "RADIOBUTTON_TEXT_ALIGN":
                UIStyleManager.RADIOBUTTON_TEXT_ALIGN = value;
            
            case "RADIOBUTTON_SIZE":
                UIStyleManager.RADIOBUTTON_SIZE = value;
            
            case "RADIOBUTTON_DOT":
                UIStyleManager.RADIOBUTTON_DOT = value;
            
            case "RADIOBUTTON_OFFSET_X":
                UIStyleManager.RADIOBUTTON_OFFSET_X = value;
            
            case "RADIOBUTTON_OFFSET_Y":
                UIStyleManager.RADIOBUTTON_OFFSET_Y = value;
            
            case "RADIOBUTTON_LABEL_OFFSET_X":
                UIStyleManager.RADIOBUTTON_LABEL_OFFSET_X = value;
            
            case "RADIOBUTTON_LABEL_OFFSET_Y":
                UIStyleManager.RADIOBUTTON_LABEL_OFFSET_Y = value;
        }
    }
    
    public static function setComboStyle(name : String, value : Dynamic) : Void
    {
        switch (name)
        {
            case "COMBO_BUTTON_NORMAL_COLOR":
                UIStyleManager.COMBO_BUTTON_NORMAL_COLOR = value;
            
            case "COMBO_BUTTON_OVER_COLOR":
                UIStyleManager.COMBO_BUTTON_OVER_COLOR = value;
            
            case "COMBO_BUTTON_DOWN_COLOR":
                UIStyleManager.COMBO_BUTTON_DOWN_COLOR = value;
            
            case "COMBO_BUTTON_DISABLE_COLOR":
                UIStyleManager.COMBO_BUTTON_DISABLE_COLOR = value;
            
            case "COMBO_BORDER_ALPHA":
                UIStyleManager.COMBO_BORDER_ALPHA = value;
            
            case "COMBO_BORDER":
                UIStyleManager.COMBO_BORDER = value;
            
            case "COMBO_BORDER_COLOR":
                UIStyleManager.COMBO_BORDER_COLOR = value;
            
            case "COMBO_BORDER_THINKNESS":
                UIStyleManager.COMBO_BORDER_THINKNESS = value;
            
            case "COMBO_TEXT_EMBED":
                UIStyleManager.COMBO_TEXT_EMBED = value;
            
            case "COMBO_TEXT_FONT":
                UIStyleManager.COMBO_TEXT_FONT = value;
            
            case "COMBO_TEXT_COLOR":
                UIStyleManager.COMBO_TEXT_COLOR = value;
            
            case "COMBO_TEXT_BOLD":
                UIStyleManager.COMBO_TEXT_BOLD = value;
            
            case "COMBO_TEXT_ITALIC":
                UIStyleManager.COMBO_TEXT_ITALIC = value;
            
            case "COMBO_TEXT_SIZE":
                UIStyleManager.COMBO_TEXT_SIZE = value;
            
            case "COMBO_TEXT_ALIGN":
                UIStyleManager.COMBO_TEXT_ALIGN = value;
            
            case "COMBO_TEXT_OVER_COLOR":
                UIStyleManager.COMBO_TEXT_OVER_COLOR = value;
            
            case "COMBO_TEXT_DOWN_COLOR":
                UIStyleManager.COMBO_TEXT_DOWN_COLOR = value;
            
            case "COMBO_TEXT_NORMAL_BACKGROUND_COLOR":
                UIStyleManager.COMBO_TEXT_NORMAL_BACKGROUND_COLOR = value;
            
            case "COMBO_TEXT_OVER_BACKGROUND_COLOR":
                UIStyleManager.COMBO_TEXT_OVER_BACKGROUND_COLOR = value;
            
            case "COMBO_TEXT_DOWN_BACKGROUND_COLOR":
                UIStyleManager.COMBO_TEXT_DOWN_BACKGROUND_COLOR = value;
        }
    }
    
    public static function setGridStyle(name : String, value : Dynamic) : Void
    {
        switch (name)
        {
            case "GRID_BACKGROUND":
                UIStyleManager.GRID_BACKGROUND = value;
            
            case "GRID_BACKGROUND_COLOR":
                UIStyleManager.GRID_BACKGROUND_COLOR = value;
            
            case "GRID_CELL_BACKGROUND":
                UIStyleManager.GRID_CELL_BACKGROUND = value;
            
            case "GRID_CELL_BACKGROUND_COLOR":
                UIStyleManager.GRID_CELL_BACKGROUND_COLOR = value;
            
            case "GRID_BORDER_ALPHA":
                UIStyleManager.GRID_BORDER_ALPHA = value;
            
            case "GRID_BORDER":
                UIStyleManager.GRID_BORDER = value;
            
            case "GRID_BORDER_COLOR":
                UIStyleManager.GRID_BORDER_COLOR = value;
            
            case "GRID_BORDER_THINKNESS":
                UIStyleManager.GRID_BORDER_THINKNESS = value;
            
            case "GRID_CELL_BORDER_ALPHA":
                UIStyleManager.GRID_CELL_BORDER_ALPHA = value;
            
            case "GRID_CELL_BORDER":
                UIStyleManager.GRID_CELL_BORDER = value;
            
            case "GRID_CELL_BORDER_COLOR":
                UIStyleManager.GRID_CELL_BORDER_COLOR = value;
            
            case "GRID_CELL_BORDER_THINKNESS":
                UIStyleManager.GRID_CELL_BORDER_THINKNESS = value;
            
            case "GRID_COLUMN_BUTTON_NORMAL_COLOR":
                UIStyleManager.GRID_COLUMN_BUTTON_NORMAL_COLOR = value;
            
            case "GRID_COLUMN_BUTTON_OVER_COLOR":
                UIStyleManager.GRID_COLUMN_BUTTON_OVER_COLOR = value;
            
            case "GRID_COLUMN_BUTTON_DOWN_COLOR":
                UIStyleManager.GRID_COLUMN_BUTTON_DOWN_COLOR = value;
        }
    }
    
    public static function setListStyle(name : String, value : Dynamic) : Void
    {
        switch (name)
        {
            
            case "LIST_BORDER_ALPHA":
                UIStyleManager.LIST_BORDER_ALPHA = value;
            
            case "LIST_BORDER":
                UIStyleManager.LIST_BORDER = value;
            
            case "LIST_BORDER_COLOR":
                UIStyleManager.LIST_BORDER_COLOR = value;
            
            case "LIST_BORDER_THINKNESS":
                UIStyleManager.LIST_BORDER_THINKNESS = value;
            
            case "LIST_BACKGROUND_COLOR":
                UIStyleManager.LIST_BACKGROUND_COLOR = value;
            
            case "LIST_TEXT_EMBED":
                UIStyleManager.LIST_TEXT_EMBED = value;
            
            case "LIST_TEXT_FONT":
                UIStyleManager.LIST_TEXT_FONT = value;
            
            case "LIST_TEXT_NORMAL_COLOR":
                UIStyleManager.LIST_TEXT_NORMAL_COLOR = value;
            
            case "LIST_TEXT_OVER_COLOR":
                UIStyleManager.LIST_TEXT_OVER_COLOR = value;
            
            case "LIST_TEXT_SELECTED_COLOR":
                UIStyleManager.LIST_TEXT_SELECTED_COLOR = value;
            
            case "LIST_TEXT_BOLD":
                UIStyleManager.LIST_TEXT_BOLD = value;
            
            case "LIST_TEXT_ITALIC":
                UIStyleManager.LIST_TEXT_ITALIC = value;
            
            case "LABEL_INDENT":
                UIStyleManager.LABEL_INDENT = value;
        }
    }
    
    public static function setLabelStyle(name : String, value : Dynamic) : Void
    {
        switch (name)
        {
            
            case "LABEL_BORDER_ALPHA":
                UIStyleManager.LABEL_BORDER_ALPHA = value;
            
            case "LABEL_BORDER":
                UIStyleManager.LABEL_BORDER = value;
            
            case "LABEL_BORDER_COLOR":
                UIStyleManager.LABEL_BORDER_COLOR = value;
            
            case "LABEL_BORDER_THINKNESS":
                UIStyleManager.LABEL_BORDER_THINKNESS = value;
            
            case "LABEL_BACKGROUND":
                UIStyleManager.LABEL_BACKGROUND = value;
            
            case "LABEL_BACKGROUND_COLOR":
                UIStyleManager.LABEL_BACKGROUND_COLOR = value;
            
            case "LABEL_TEXT_EMBED":
                UIStyleManager.LABEL_TEXT_EMBED = value;
            
            case "LABEL_TEXT_FONT":
                UIStyleManager.LABEL_TEXT_FONT = value;
            
            case "LABEL_TEXT_COLOR":
                UIStyleManager.LABEL_TEXT_COLOR = value;
            
            case "LABEL_TEXT_BOLD":
                UIStyleManager.LABEL_TEXT_BOLD = value;
            
            case "LABEL_TEXT_ITALIC":
                UIStyleManager.LABEL_TEXT_ITALIC = value;
            
            case "LABEL_TEXT_SIZE":
                UIStyleManager.LABEL_TEXT_SIZE = value;
            
            case "LABEL_TEXT_ALIGN":
                UIStyleManager.LABEL_TEXT_ALIGN = value;
            
        }
    }
    
    public static function setInputStyle(name : String, value : Dynamic) : Void
    {
        switch (name)
        {
            case "INPUT_BACKGROUND":
                UIStyleManager.INPUT_BACKGROUND = value;
            
            case "INPUT_BACKGROUND_NORMAL_COLOR":
                UIStyleManager.INPUT_BACKGROUND_NORMAL_COLOR = value;
            
            case "INPUT_BACKGROUND_OVER_COLOR":
                UIStyleManager.INPUT_BACKGROUND_OVER_COLOR = value;
            
            case "INPUT_BACKGROUND_SELECTED_COLOR":
                UIStyleManager.INPUT_BACKGROUND_SELECTED_COLOR = value;
            
            case "INPUT_BACKGROUND_DISABLE_COLOR":
                UIStyleManager.INPUT_BACKGROUND_DISABLE_COLOR = value;
            
            case "INPUT_BORDER":
                UIStyleManager.INPUT_BORDER = value;
            
            case "INPUT_BORDER_COLOR":
                UIStyleManager.INPUT_BORDER_COLOR = value;
            
            case "INPUT_BORDER_THINKNESS":
                UIStyleManager.INPUT_BORDER_THINKNESS = value;
            
            case "INPUT_TEXT_EMBED":
                UIStyleManager.INPUT_TEXT_EMBED = value;
            
            case "INPUT_TEXT_FONT":
                UIStyleManager.INPUT_TEXT_FONT = value;
            
            case "INPUT_TEXT_COLOR":
                UIStyleManager.INPUT_TEXT_COLOR = value;
            
            case "INPUT_TEXT_OVER_COLOR":
                UIStyleManager.INPUT_TEXT_OVER_COLOR = value;
            
            case "INPUT_TEXT_SELECTED_COLOR":
                UIStyleManager.INPUT_TEXT_SELECTED_COLOR = value;
            
            case "INPUT_TEXT_DISABLE_COLOR":
                UIStyleManager.INPUT_TEXT_DISABLE_COLOR = value;
            
            case "INPUT_TEXT_BOLD":
                UIStyleManager.INPUT_TEXT_BOLD = value;
            
            case "INPUT_TEXT_ITALIC":
                UIStyleManager.INPUT_TEXT_ITALIC = value;
        }
    }
    
    public static function setProgressBarStyle(name : String, value : Dynamic) : Void
    {
        switch (name)
        {
            case "PROGRESSBAR_BORDER_ALPHA":
                UIStyleManager.PROGRESSBAR_BORDER_ALPHA = value;
            
            case "PROGRESSBAR_BORDER":
                UIStyleManager.PROGRESSBAR_BORDER = value;
            
            case "PROGRESSBAR_BORDER_COLOR":
                UIStyleManager.PROGRESSBAR_BORDER_COLOR = value;
            
            case "PROGRESSBAR_BORDER_THINKNESS":
                UIStyleManager.PROGRESSBAR_BORDER_THINKNESS = value;
            
            case "PROGRESSBAR_TEXT_EMBED":
                UIStyleManager.PROGRESSBAR_TEXT_EMBED = value;
            
            case "PROGRESSBAR_TEXT_FONT":
                UIStyleManager.PROGRESSBAR_TEXT_FONT = value;
            
            case "PROGRESSBAR_TEXT_LOADED_COLOR":
                UIStyleManager.PROGRESSBAR_TEXT_LOADED_COLOR = value;
            
            case "PROGRESSBAR_TEXT_COLOR":
                UIStyleManager.PROGRESSBAR_TEXT_COLOR = value;
            
            case "PROGRESSBAR_TEXT_BOLD":
                UIStyleManager.PROGRESSBAR_TEXT_BOLD = value;
            
            case "PROGRESSBAR_TEXT_ITALIC":
                UIStyleManager.PROGRESSBAR_TEXT_ITALIC = value;
            
            case "PROGRESSBAR_TEXT_SIZE":
                UIStyleManager.PROGRESSBAR_TEXT_SIZE = value;
            
            case "PROGRESSBAR_COLOR":
                UIStyleManager.PROGRESSBAR_COLOR = value;
            
            case "PROGRESSBAR_COLOR_LOADED":
                UIStyleManager.PROGRESSBAR_COLOR_LOADED = value;
            
            case "PROGRESSBAR_TEXT_ALIGN":
                UIStyleManager.PROGRESSBAR_TEXT_ALIGN = value;
        }
    }
    
    public static function setProgressSliderStyle(name : String, value : Dynamic) : Void
    {
        switch (name)
        {
            case "PROGRESS_SLIDER_BORDER_ALPHA":
                UIStyleManager.PROGRESS_SLIDER_BORDER_ALPHA = value;
            
            case "PROGRESS_SLIDER_BORDER":
                UIStyleManager.PROGRESS_SLIDER_BORDER = value;
            
            case "PROGRESS_SLIDER_BORDER_COLOR":
                UIStyleManager.PROGRESS_SLIDER_BORDER_COLOR = value;
            
            case "PROGRESS_SLIDER_BORDER_THINKNESS":
                UIStyleManager.PROGRESS_SLIDER_BORDER_THINKNESS = value;
            
            case "PROGRESS_SLIDER_TEXT_EMBED":
                UIStyleManager.PROGRESS_SLIDER_TEXT_EMBED = value;
            
            case "PROGRESS_SLIDER_TEXT_FONT":
                UIStyleManager.PROGRESS_SLIDER_TEXT_FONT = value;
            
            case "PROGRESS_SLIDER_TEXT_LOADED_COLOR":
                UIStyleManager.PROGRESS_SLIDER_TEXT_LOADED_COLOR = value;
            
            case "PROGRESS_SLIDER_TEXT_COLOR":
                UIStyleManager.PROGRESS_SLIDER_TEXT_COLOR = value;
            
            case "PROGRESS_SLIDER_TEXT_BOLD":
                UIStyleManager.PROGRESS_SLIDER_TEXT_BOLD = value;
            
            case "PROGRESS_SLIDER_TEXT_ITALIC":
                UIStyleManager.PROGRESS_SLIDER_TEXT_ITALIC = value;
            
            case "PROGRESS_SLIDER_TEXT_SIZE":
                UIStyleManager.PROGRESS_SLIDER_TEXT_SIZE = value;
            
            case "PROGRESS_SLIDER_COLOR":
                UIStyleManager.PROGRESS_SLIDER_COLOR = value;
            
            case "PROGRESS_SLIDER_COLOR_LOADED":
                UIStyleManager.PROGRESS_SLIDER_COLOR_LOADED = value;
            
            case "PROGRESS_SLIDER_TEXT_ALIGN":
                UIStyleManager.PROGRESS_SLIDER_TEXT_ALIGN = value;
            
            case "PROGRESS_SLIDER_NORMAL_COLOR":
                UIStyleManager.PROGRESS_SLIDER_NORMAL_COLOR = value;
            
            case "PROGRESS_SLIDER_OVER_COLOR":
                UIStyleManager.PROGRESS_SLIDER_OVER_COLOR = value;
            
            case "PROGRESS_SLIDER_DOWN_COLOR":
                UIStyleManager.PROGRESS_SLIDER_DOWN_COLOR = value;
            
            case "PROGRESS_SLIDER_DISABLE_COLOR":
                UIStyleManager.PROGRESS_SLIDER_DISABLE_COLOR = value;
            
            case "PROGRESS_SLIDER_SIZE":
                UIStyleManager.PROGRESS_SLIDER_SIZE = value;
            
            case "PROGRESS_SLIDER_ROTATE_IMAGE":
                UIStyleManager.PROGRESS_SLIDER_ROTATE_IMAGE = value;
            
            case "PROGRESS_SLIDER_OFFSET":
                UIStyleManager.PROGRESS_SLIDER_OFFSET = value;
        }
    }
    
    public static function setScrollBarStyle(name : String, value : Dynamic) : Void
    {
        switch (name)
        {
            case "SCROLLBAR_ROTATE_IMAGE":
                UIStyleManager.SCROLLBAR_ROTATE_IMAGE = value;
            
            case "SCROLLBAR_SLIDER_OFFSET":
                UIStyleManager.SCROLLBAR_SLIDER_OFFSET = value;
            
            case "SCROLLBAR_BUTTON_NORMAL_COLOR":
                UIStyleManager.SCROLLBAR_BUTTON_NORMAL_COLOR = value;
            
            case "SCROLLBAR_BUTTON_OVER_COLOR":
                UIStyleManager.SCROLLBAR_BUTTON_OVER_COLOR = value;
            
            case "SCROLLBAR_BUTTON_DOWN_COLOR":
                UIStyleManager.SCROLLBAR_BUTTON_DOWN_COLOR = value;
            
            case "SCROLLBAR_BUTTON_SIZE":
                UIStyleManager.SCROLLBAR_BUTTON_SIZE = value;
            
            case "SCROLLBAR_SLIDER_NORMAL_COLOR":
                UIStyleManager.SCROLLBAR_SLIDER_NORMAL_COLOR = value;
            
            case "SCROLLBAR_SLIDER_OVER_COLOR":
                UIStyleManager.SCROLLBAR_SLIDER_OVER_COLOR = value;
            
            case "SCROLLBAR_SLIDER_DOWN_COLOR":
                UIStyleManager.SCROLLBAR_SLIDER_DOWN_COLOR = value;
            
            case "SCROLLBAR_SLIDER_SIZE":
                UIStyleManager.SCROLLBAR_SLIDER_SIZE = value;
            
            case "SCROLLBAR_TRACK_COLOR":
                UIStyleManager.SCROLLBAR_TRACK_COLOR = value;
            
            case "SCROLLBAR_TRACK_SIZE":
                UIStyleManager.SCROLLBAR_TRACK_SIZE = value;
            
            case "SCROLLBAR_SLIDER_ACTIVE_RESIZE":
                UIStyleManager.SCROLLBAR_SLIDER_ACTIVE_RESIZE = value;
            
            case "SCROLLBAR_OFFSET":
                UIStyleManager.SCROLLBAR_OFFSET = value;
        }
    }
    
    public static function setSliderStyle(name : String, value : Dynamic) : Void
    {
        switch (name)
        {
            case "SLIDER_NORMAL_COLOR":
                UIStyleManager.SLIDER_NORMAL_COLOR = value;
            
            case "SLIDER_OVER_COLOR":
                UIStyleManager.SLIDER_OVER_COLOR = value;
            
            case "SLIDER_DOWN_COLOR":
                UIStyleManager.SLIDER_DOWN_COLOR = value;
            
            case "SLIDER_DISABLE_COLOR":
                UIStyleManager.SLIDER_DISABLE_COLOR = value;
            
            case "SLIDER_SIZE":
                UIStyleManager.SLIDER_SIZE = value;
            
            case "SLIDER_TRACK_COLOR":
                UIStyleManager.SLIDER_TRACK_COLOR = value;
            
            case "SLIDER_TRACK_SIZE":
                UIStyleManager.SLIDER_TRACK_SIZE = value;
            
            case "SLIDER_ROTATE_IMAGE":
                UIStyleManager.SLIDER_ROTATE_IMAGE = value;
            
            case "SLIDER_OFFSET":
                UIStyleManager.SLIDER_OFFSET = value;
        }
    }
    
    public static function setScrollPaneStyle(name : String, value : Dynamic) : Void
    {
        switch (name)
        {
            case "SCROLLPANE_BACKGROUND":
                UIStyleManager.SCROLLPANE_BACKGROUND = value;
            
            case "SCROLLPANE_BORDER_ALPHA":
                UIStyleManager.SCROLLPANE_BORDER_ALPHA = value;
            
            case "SCROLLPANE_BORDER":
                UIStyleManager.SCROLLPANE_BORDER = value;
            
            case "SCROLLPANE_BORDER_COLOR":
                UIStyleManager.SCROLLPANE_BORDER_COLOR = value;
            
            case "SCROLLPANE_BORDER_THINKNESS":
                UIStyleManager.SCROLLPANE_BORDER_THINKNESS = value;
            
            case "SCROLLPANE_CONTENT_OFFSET_X":
                UIStyleManager.SCROLLPANE_CONTENT_OFFSET_X = value;
            
            case "SCROLLPANE_CONTENT_OFFSET_Y":
                UIStyleManager.SCROLLPANE_CONTENT_OFFSET_Y = value;
            
            case "SCROLLPANE_CONTENT_WIDTH_OFFSET":
                UIStyleManager.SCROLLPANE_CONTENT_WIDTH_OFFSET = value;
            
            case "SCROLLPANE_CONTENT_HEIGHT_OFFSET":
                UIStyleManager.SCROLLPANE_CONTENT_HEIGHT_OFFSET = value;
        }
    }
    
    public static function setItemPaneStyle(name : String, value : Dynamic) : Void
    {
        switch (name)
        {
            case "ITEMPANE_BACKGROUND":
                UIStyleManager.ITEMPANE_BACKGROUND = value;
            
            case "ITEMPANE_BORDER_ALPHA":
                UIStyleManager.ITEMPANE_BORDER_ALPHA = value;
            
            case "ITEMPANE_BORDER":
                UIStyleManager.ITEMPANE_BORDER = value;
            
            case "ITEMPANE_BORDER_COLOR":
                UIStyleManager.ITEMPANE_BORDER_COLOR = value;
            
            case "ITEMPANE_BORDER_THINKNESS":
                UIStyleManager.ITEMPANE_BORDER_THINKNESS = value;
            
            case "ITEMPANE_ITEM_BORDER_ALPHA":
                UIStyleManager.ITEMPANE_ITEM_BORDER_ALPHA = value;
            
            case "ITEMPANE_ITEM_BORDER":
                UIStyleManager.ITEMPANE_ITEM_BORDER = value;
            
            case "ITEMPANE_ITEM_BORDER_COLOR":
                UIStyleManager.ITEMPANE_ITEM_BORDER_COLOR = value;
            
            case "ITEMPANE_ITEM_BORDER_THINKNESS":
                UIStyleManager.ITEMPANE_ITEM_BORDER_THINKNESS = value;
            
            case "ITEMPANE_ITEM_NORMAL_COLOR":
                UIStyleManager.ITEMPANE_ITEM_NORMAL_COLOR = value;
            
            case "ITEMPANE_ITEM_OVER_COLOR":
                UIStyleManager.ITEMPANE_ITEM_OVER_COLOR = value;
            
            case "ITEMPANE_ITEM_SELECTED_COLOR":
                UIStyleManager.ITEMPANE_ITEM_SELECTED_COLOR = value;
            
            case "ITEMPANE_ITEM_DISABLE_COLOR":
                UIStyleManager.ITEMPANE_ITEM_DISABLE_COLOR = value;
            
            case "ITEMPANE_TEXT_EMBED":
                UIStyleManager.ITEMPANE_TEXT_EMBED = value;
            
            case "ITEMPANE_TEXT_FONT":
                UIStyleManager.ITEMPANE_TEXT_FONT = value;
            
            case "ITEMPANE_TEXT_COLOR":
                UIStyleManager.ITEMPANE_TEXT_COLOR = value;
            
            case "ITEMPANE_TEXT_BOLD":
                UIStyleManager.ITEMPANE_TEXT_BOLD = value;
            
            case "ITEMPANE_TEXT_ITALIC":
                UIStyleManager.ITEMPANE_TEXT_ITALIC = value;
            
            case "ITEMPANE_TEXT_SIZE":
                UIStyleManager.ITEMPANE_TEXT_SIZE = value;
            
            case "ITEMPANE_DEFAULT_ITEM_WIDTH":
                UIStyleManager.ITEMPANE_DEFAULT_ITEM_WIDTH = value;
            
            case "ITEMPANE_DEFAULT_ITEM_HEIGHT":
                UIStyleManager.ITEMPANE_DEFAULT_ITEM_HEIGHT = value;
            
            case "ITEMPANE_ICON_LOC_X":
                UIStyleManager.ITEMPANE_ICON_LOC_X = value;
            
            case "ITEMPANE_ICON_LOC_Y":
                UIStyleManager.ITEMPANE_ICON_LOC_Y = value;
            
            case "ITEMPANE_ITEM_LOC_X":
                UIStyleManager.ITEMPANE_ITEM_LOC_X = value;
            
            case "ITEMPANE_ITEM_LOC_Y":
                UIStyleManager.ITEMPANE_ITEM_LOC_Y = value;
            
            case "ITEMPANE_LABEL_OFFSET_X":
                UIStyleManager.ITEMPANE_LABEL_OFFSET_X = value;
            
            case "ITEMPANE_LABEL_OFFSET_Y":
                UIStyleManager.ITEMPANE_LABEL_OFFSET_Y = value;
        }
    }
    
    public static function setTabPaneStyle(name : String, value : Dynamic) : Void
    {
        switch (name)
        {
            case "TABPANE_BACKGROUND":
                UIStyleManager.TABPANE_BACKGROUND = value;
            
            case "TABPANE_BUTTON_TINT_ALPHA":
                UIStyleManager.TABPANE_BUTTON_TINT_ALPHA = value;
            
            case "TABPANE_BUTTON_NORMAL_COLOR":
                UIStyleManager.TABPANE_BUTTON_NORMAL_COLOR = value;
            
            case "TABPANE_BUTTON_OVER_COLOR":
                UIStyleManager.TABPANE_BUTTON_OVER_COLOR = value;
            
            case "TABPANE_BUTTON_DISABLE_COLOR":
                UIStyleManager.TABPANE_BUTTON_DISABLE_COLOR = value;
            
            case "TABPANE_BUTTON_SELECTED_COLOR":
                UIStyleManager.TABPANE_BUTTON_SELECTED_COLOR = value;
            
            case "TABPANE_BUTTON_TEXT_EMBED":
                UIStyleManager.TABPANE_BUTTON_TEXT_EMBED = value;
            
            case "TABPANE_BUTTON_TEXT_FONT":
                UIStyleManager.TABPANE_BUTTON_TEXT_FONT = value;
            
            case "TABPANE_BUTTON_TEXT_COLOR":
                UIStyleManager.TABPANE_BUTTON_TEXT_COLOR = value;
            
            case "TABPANE_BUTTON_TEXT_COLOR_SELECTED":
                UIStyleManager.TABPANE_BUTTON_TEXT_COLOR_SELECTED = value;
            
            case "TABPANE_BUTTON_TEXT_BOLD":
                UIStyleManager.TABPANE_BUTTON_TEXT_BOLD = value;
            
            case "TABPANE_BUTTON_TEXT_ITALIC":
                UIStyleManager.TABPANE_BUTTON_TEXT_ITALIC = value;
            
            case "TABPANE_BUTTON_TEXT_SIZE":
                UIStyleManager.TABPANE_BUTTON_TEXT_SIZE = value;
            
            case "TABPANE_BORDER_ALPHA":
                UIStyleManager.TABPANE_BORDER_ALPHA = value;
            
            case "TABPANE_BORDER":
                UIStyleManager.TABPANE_BORDER = value;
            
            case "TABPANE_BORDER_COLOR":
                UIStyleManager.TABPANE_BORDER_COLOR = value;
            
            case "TABPANE_BORDER_THINKNESS":
                UIStyleManager.TABPANE_BORDER_THINKNESS = value;
        }
    }
    
    public static function setToolTipStyle(name : String, value : Dynamic) : Void
    {
        switch (name)
        {
            case "TOOLTIP_BACKGROUND_NORMAL_COLOR":
                UIStyleManager.TOOLTIP_BACKGROUND_NORMAL_COLOR = value;
            
            case "TOOLTIP_BACKGROUND_ALPHA":
                UIStyleManager.TOOLTIP_BACKGROUND_ALPHA = value;
            
            case "TOOLTIP_BORDER_ALPHA":
                UIStyleManager.TOOLTIP_BORDER_ALPHA = value;
            
            case "TOOLTIP_BORDER":
                UIStyleManager.TOOLTIP_BORDER = value;
            
            case "TOOLTIP_BORDER_COLOR":
                UIStyleManager.TOOLTIP_BORDER_COLOR = value;
            
            case "TOOLTIP_BORDER_THINKNESS":
                UIStyleManager.TOOLTIP_BORDER_THINKNESS = value;
            
            case "TOOLTIP_LABEL_TEXT_EMBED":
                UIStyleManager.TOOLTIP_LABEL_TEXT_EMBED = value;
            
            case "TOOLTIP_LABEL_TEXT_FONT":
                UIStyleManager.TOOLTIP_LABEL_TEXT_FONT = value;
            
            case "TOOLTIP_LABEL_TEXT_COLOR":
                UIStyleManager.TOOLTIP_LABEL_TEXT_COLOR = value;
            
            case "TOOLTIP_LABEL_TEXT_SIZE":
                UIStyleManager.TOOLTIP_LABEL_TEXT_SIZE = value;
            
            case "TOOLTIP_LABEL_PADDING":
                UIStyleManager.TOOLTIP_LABEL_PADDING = value;
            
            case "TOOLTIP_BUBBLE_LOC_X":
                UIStyleManager.TOOLTIP_BUBBLE_LOC_X = value;
            
            case "TOOLTIP_BUBBLE_LOC_Y":
                UIStyleManager.TOOLTIP_BUBBLE_LOC_Y = value;
        }
    }
    
    public static function setWindowStyle(name : String, value : Dynamic) : Void
    {
        switch (name)
        {
            case "WINDOW_TITLE_TEXT_EMBED":
                UIStyleManager.WINDOW_TITLE_TEXT_EMBED = value;
            
            case "WINDOW_TITLE_TEXT_FONT":
                UIStyleManager.WINDOW_TITLE_TEXT_FONT = value;
            
            case "WINDOW_TITLE_TEXT_COLOR":
                UIStyleManager.WINDOW_TITLE_TEXT_COLOR = value;
            
            case "WINDOW_TITLE_TEXT_SIZE":
                UIStyleManager.WINDOW_TITLE_TEXT_SIZE = value;
            
            case "WINDOW_TITLE_AREA_COLOR":
                UIStyleManager.WINDOW_TITLE_AREA_COLOR = value;
            
            case "WINDOW_TITLE_AREA_UNFOCUS_COLOR":
                UIStyleManager.WINDOW_TITLE_AREA_UNFOCUS_COLOR = value;
            
            case "WINDOW_FOCUS_COLOR":
                UIStyleManager.WINDOW_FOCUS_COLOR = value;
            
            case "WINDOW_UNFOCUS_COLOR":
                UIStyleManager.WINDOW_UNFOCUS_COLOR = value;
            
            case "WINDOW_BORDER_ALPHA":
                UIStyleManager.WINDOW_BORDER_ALPHA = value;
            
            case "WINDOW_BORDER":
                UIStyleManager.WINDOW_BORDER = value;
            
            case "WINDOW_BORDER_COLOR":
                UIStyleManager.WINDOW_BORDER_COLOR = value;
            
            case "WINDOW_BACKGROUND_COLOR":
                UIStyleManager.WINDOW_BACKGROUND_COLOR = value;
            
            case "WINDOW_ICON_LOCATION":
                UIStyleManager.WINDOW_ICON_LOCATION = value;
            
            case "WINDOW_BUTTON_LOCATION":
                UIStyleManager.WINDOW_BUTTON_LOCATION = value;
            
            case "WINDOW_LABEL_LOCATION":
                UIStyleManager.WINDOW_LABEL_LOCATION = value;
            
            case "WINDOW_MIN_NORMAL_COLOR":
                UIStyleManager.WINDOW_MIN_NORMAL_COLOR = value;
            
            case "WINDOW_MIN_OVER_COLOR":
                UIStyleManager.WINDOW_MIN_OVER_COLOR = value;
            
            case "WINDOW_MIN_DOWN_COLOR":
                UIStyleManager.WINDOW_MIN_DOWN_COLOR = value;
            
            case "WINDOW_MIN_DISABLE_COLOR":
                UIStyleManager.WINDOW_MIN_DISABLE_COLOR = value;
            
            case "WINDOW_MAX_NORMAL_COLOR":
                UIStyleManager.WINDOW_MAX_NORMAL_COLOR = value;
            
            case "WINDOW_MAX_OVER_COLOR":
                UIStyleManager.WINDOW_MAX_OVER_COLOR = value;
            
            case "WINDOW_MAX_DOWN_COLOR":
                UIStyleManager.WINDOW_MAX_DOWN_COLOR = value;
            
            case "WINDOW_MAX_DISABLE_COLOR":
                UIStyleManager.WINDOW_MAX_DISABLE_COLOR = value;
            
            case "WINDOW_CLOSE_NORMAL_COLOR":
                UIStyleManager.WINDOW_CLOSE_NORMAL_COLOR = value;
            
            case "WINDOW_CLOSE_OVER_COLOR":
                UIStyleManager.WINDOW_CLOSE_OVER_COLOR = value;
            
            case "WINDOW_CLOSE_DOWN_COLOR":
                UIStyleManager.WINDOW_CLOSE_DOWN_COLOR = value;
            
            case "WINDOW_CLOSE_DISABLE_COLOR":
                UIStyleManager.WINDOW_CLOSE_DISABLE_COLOR = value;
        }
    }
    
    public static function setMenuStyle(name : String, value : Dynamic) : Void
    {
        switch (name)
        {
            case "MENU_BACKGROUND_COLOR":
                UIStyleManager.MENU_BACKGROUND_COLOR = value;
            
            case "MENU_BACKGROUND_ALPHA":
                UIStyleManager.MENU_BACKGROUND_ALPHA = value;
            
            case "MENU_NORMAL_COLOR":
                UIStyleManager.MENU_NORMAL_COLOR = value;
            
            case "MENU_OVER_COLOR":
                UIStyleManager.MENU_OVER_COLOR = value;
            
            case "MENU_DOWN_COLOR":
                UIStyleManager.MENU_DOWN_COLOR = value;
            
            case "MENU_DISABLE_COLOR":
                UIStyleManager.MENU_DISABLE_COLOR = value;
            
            case "MENU_SUB_NORMAL_COLOR":
                UIStyleManager.MENU_SUB_NORMAL_COLOR = value;
            
            case "MENU_SUB_OVER_COLOR":
                UIStyleManager.MENU_SUB_OVER_COLOR = value;
            
            case "MENU_SUB_DOWN_COLOR":
                UIStyleManager.MENU_SUB_DOWN_COLOR = value;
            
            case "MENU_SUB_DISABLE_COLOR":
                UIStyleManager.MENU_SUB_DISABLE_COLOR = value;
            
            case "MENU_BORDER":
                UIStyleManager.MENU_BORDER = value;
            
            case "MENU_BORDER_ALPHA":
                UIStyleManager.MENU_BORDER_ALPHA = value;
            
            case "MENU_BORDER_THINKNESS":
                UIStyleManager.MENU_BORDER_THINKNESS = value;
            
            case "MENU_BORDER_NORMAL_COLOR":
                UIStyleManager.MENU_BORDER_NORMAL_COLOR = value;
            
            case "MENU_BORDER_OVER_COLOR":
                UIStyleManager.MENU_BORDER_OVER_COLOR = value;
            
            case "MENU_BORDER_DOWN_COLOR":
                UIStyleManager.MENU_BORDER_DOWN_COLOR = value;
            
            case "MENU_BORDER_DISABLE_COLOR":
                UIStyleManager.MENU_BORDER_DISABLE_COLOR = value;
            
            case "MENU_SUB_BORDER_ALPHA":
                UIStyleManager.MENU_SUB_BORDER_ALPHA = value;
            
            case "MENU_SUB_BORDER":
                UIStyleManager.MENU_SUB_BORDER = value;
            
            case "MENU_SUB_BORDER_THINKNESS":
                UIStyleManager.MENU_SUB_BORDER_THINKNESS = value;
            
            case "MENU_SUB_BORDER_NORMAL_COLOR":
                UIStyleManager.MENU_SUB_BORDER_NORMAL_COLOR = value;
            
            case "MENU_SUB_BORDER_OVER_COLOR":
                UIStyleManager.MENU_SUB_BORDER_OVER_COLOR = value;
            
            case "MENU_SUB_BORDER_DOWN_COLOR":
                UIStyleManager.MENU_SUB_BORDER_DOWN_COLOR = value;
            
            case "MENU_SUB_BORDER_DISABLE_COLOR":
                UIStyleManager.MENU_SUB_BORDER_DISABLE_COLOR = value;
            
            case "MENU_LABEL_TEXT_EMBED":
                UIStyleManager.MENU_LABEL_TEXT_EMBED = value;
            
            case "MENU_LABEL_TEXT_FONT":
                UIStyleManager.MENU_LABEL_TEXT_FONT = value;
            
            case "MENU_LABEL_TEXT_NORMAL_COLOR":
                UIStyleManager.MENU_LABEL_TEXT_NORMAL_COLOR = value;
            
            case "MENU_LABEL_TEXT_OVER_COLOR":
                UIStyleManager.MENU_LABEL_TEXT_OVER_COLOR = value;
            
            case "MENU_LABEL_TEXT_DOWN_COLOR":
                UIStyleManager.MENU_LABEL_TEXT_DOWN_COLOR = value;
            
            case "MENU_LABEL_TEXT_DISABLE_COLOR":
                UIStyleManager.MENU_LABEL_TEXT_DISABLE_COLOR = value;
            
            case "MENU_LABEL_TEXT_BOLD":
                UIStyleManager.MENU_LABEL_TEXT_BOLD = value;
            
            case "MENU_LABEL_TEXT_ITALIC":
                UIStyleManager.MENU_LABEL_TEXT_ITALIC = value;
            
            case "MENU_LABEL_TEXT_SIZE":
                UIStyleManager.MENU_LABEL_TEXT_SIZE = value;
            
            case "MENU_SUB_LABEL_TEXT_EMBED":
                UIStyleManager.MENU_SUB_LABEL_TEXT_EMBED = value;
            
            case "MENU_SUB_LABEL_TEXT_FONT":
                UIStyleManager.MENU_SUB_LABEL_TEXT_FONT = value;
            
            case "MENU_SUB_LABEL_TEXT_NORMAL_COLOR":
                UIStyleManager.MENU_SUB_LABEL_TEXT_NORMAL_COLOR = value;
            
            case "MENU_SUB_LABEL_TEXT_OVER_COLOR":
                UIStyleManager.MENU_SUB_LABEL_TEXT_OVER_COLOR = value;
            
            case "MENU_SUB_LABEL_TEXT_DOWN_COLOR":
                UIStyleManager.MENU_SUB_LABEL_TEXT_DOWN_COLOR = value;
            
            case "MENU_SUB_LABEL_TEXT_DISABLE_COLOR":
                UIStyleManager.MENU_SUB_LABEL_TEXT_DISABLE_COLOR = value;
            
            case "MENU_SUB_LABEL_TEXT_BOLD":
                UIStyleManager.MENU_SUB_LABEL_TEXT_BOLD = value;
            
            case "MENU_SUB_LABEL_TEXT_ITALIC":
                UIStyleManager.MENU_SUB_LABEL_TEXT_ITALIC = value;
            
            case "MENU_SUB_LABEL_TEXT_SIZE":
                UIStyleManager.MENU_SUB_LABEL_TEXT_SIZE = value;
        }
    }
}

