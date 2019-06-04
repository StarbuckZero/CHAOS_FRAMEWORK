package com.chaos.ui;



import com.chaos.ui.Slider;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.classInterface.IProgressBar;
import com.chaos.ui.classInterface.IProgressSlider;
import com.chaos.ui.classInterface.ISlider;
import openfl.events.Event;

/**
 * A SliderBar that also has a ProgressBar as well. There is not track because the ProgressBar is in the background.
 * @author Erick Feiling
 */

class ProgressSlider extends ProgressBar implements IProgressSlider implements IProgressBar implements IBaseUI
{
    public var slider(get, never) : ISlider;

    
    public static inline var TYPE : String = "ProgressSlider";
    
    private var _slider : Slider = new Slider();
    
    /**
	 * A slider that can be used to keep try of objects that are loading
	 */
    
    public function new()
    {
        super();
        
        addEventListener(Event.ADDED_TO_STAGE, onStageAdd, false, 0, true);
        addEventListener(Event.REMOVED_FROM_STAGE, onStageRemove, false, 0, true);
        
        addChild(_slider);
       
    }
    
    /**
	 * @inheritDoc
	 */
    
    override public function reskin() : Void
    {
        super.reskin();
        
        initBitmap();
        initStyle();
    }
    
    override private function init() : Void
    {
		super.init();
		
        _slider.direction = ScrollBarDirection.HORIZONTAL;
        _slider.showTrack = false;
        showLabel = false;
        
        _slider.width = width;
        _slider.height = height;
        
        reskin();
    }
    
    override private function initBitmap() : Void
    {
		super.initBitmap();
		
        if (null != UIBitmapManager.getUIElement(Slider.TYPE, UIBitmapManager.PROGRESS_SLIDER_BUTTON_NORMAL)) 
            _slider.setSliderImage(UIBitmapManager.getUIElement(Slider.TYPE, UIBitmapManager.PROGRESS_SLIDER_BUTTON_NORMAL));
        
        if (null != UIBitmapManager.getUIElement(Slider.TYPE, UIBitmapManager.PROGRESS_SLIDER_BUTTON_OVER)) 
            _slider.setSliderOverImage(UIBitmapManager.getUIElement(Slider.TYPE, UIBitmapManager.PROGRESS_SLIDER_BUTTON_OVER));
        
        if (null != UIBitmapManager.getUIElement(Slider.TYPE, UIBitmapManager.PROGRESS_SLIDER_BUTTON_DOWN)) 
            _slider.setSliderDownImage(UIBitmapManager.getUIElement(Slider.TYPE, UIBitmapManager.PROGRESS_SLIDER_BUTTON_DOWN));
        
        if (null != UIBitmapManager.getUIElement(Slider.TYPE, UIBitmapManager.PROGRESS_SLIDER_BUTTON_DISABLE)) 
            _slider.setSliderDisableImage(UIBitmapManager.getUIElement(Slider.TYPE, UIBitmapManager.PROGRESS_SLIDER_BUTTON_DISABLE));
        
        if (null != UIBitmapManager.getUIElement(ProgressBar.TYPE, UIBitmapManager.PROGRESS_SLIDER_BACKGROUND)) 
            setBackgroundImage(UIBitmapManager.getUIElement(ProgressBar.TYPE, UIBitmapManager.PROGRESS_SLIDER_BACKGROUND));
        
        if (null != UIBitmapManager.getUIElement(ProgressBar.TYPE, UIBitmapManager.PROGRESS_SLIDER_LOADED_BACKGROUND)) 
            setLoadBarImage(UIBitmapManager.getUIElement(ProgressBar.TYPE, UIBitmapManager.PROGRESS_SLIDER_LOADED_BACKGROUND));
    }
    
    override private function initStyle() : Void
    {
		super.initStyle();
		
        // Set the style for progress bar
        if (-1 != UIStyleManager.PROGRESS_SLIDER_NORMAL_COLOR) 
            _slider.sliderColor = UIStyleManager.PROGRESS_SLIDER_NORMAL_COLOR;
        
        if (-1 != UIStyleManager.PROGRESS_SLIDER_OVER_COLOR) 
            _slider.sliderOverColor = UIStyleManager.PROGRESS_SLIDER_OVER_COLOR;
        
        if (-1 != UIStyleManager.PROGRESS_SLIDER_DOWN_COLOR) 
            _slider.sliderDownColor = UIStyleManager.PROGRESS_SLIDER_DOWN_COLOR;
        
        if (-1 != UIStyleManager.PROGRESS_SLIDER_DISABLE_COLOR) 
            _slider.sliderDisableColor = UIStyleManager.PROGRESS_SLIDER_DISABLE_COLOR;
        
        if (-1 != UIStyleManager.PROGRESS_SLIDER_SIZE) 
            _slider.sliderWidth = _slider.sliderHeightNum = UIStyleManager.PROGRESS_SLIDER_SIZE;
        
        if (-1 != UIStyleManager.PROGRESS_SLIDER_OFFSET) 
            _slider.sliderOffSet = UIStyleManager.PROGRESS_SLIDER_OFFSET;
        
        _slider.rotateImage = UIStyleManager.PROGRESS_SLIDER_ROTATE_IMAGE;
        
        // Set the style slider
        if (-1 != UIStyleManager.PROGRESS_SLIDER_COLOR) 
            backgroundColor = UIStyleManager.PROGRESS_SLIDER_COLOR;
        
        if (-1 != UIStyleManager.PROGRESS_SLIDER_COLOR_LOADED) 
            loadColor = UIStyleManager.PROGRESS_SLIDER_COLOR_LOADED;
        
        border = UIStyleManager.PROGRESS_SLIDER_BORDER;
        
        if (-1 != UIStyleManager.PROGRESSBAR_BORDER_COLOR) 
            borderColor = UIStyleManager.PROGRESSBAR_BORDER_COLOR;
        
        if (-1 != UIStyleManager.PROGRESS_SLIDER_TEXT_COLOR) 
            textColor = UIStyleManager.PROGRESS_SLIDER_TEXT_COLOR;
        
        if (-1 != UIStyleManager.PROGRESS_SLIDER_COLOR_LOADED) 
            textLoadColor = UIStyleManager.PROGRESS_SLIDER_COLOR_LOADED;
        
        if (-1 != UIStyleManager.PROGRESS_SLIDER_BORDER_THINKNESS) 
            borderThinkness = UIStyleManager.PROGRESS_SLIDER_BORDER_THINKNESS;
        
        if (-1 != UIStyleManager.PROGRESS_SLIDER_BORDER_COLOR) 
            borderColor = UIStyleManager.PROGRESS_SLIDER_BORDER_COLOR;
        
        if (-1 != UIStyleManager.PROGRESS_SLIDER_BORDER_ALPHA) 
            borderAlpha = UIStyleManager.PROGRESS_SLIDER_BORDER_ALPHA;
        
        
        // Set Label Style
        if (-1 != UIStyleManager.PROGRESS_SLIDER_TEXT_SIZE) 
            label.size = loadedLabel.size = UIStyleManager.PROGRESS_SLIDER_TEXT_SIZE;
        
        label.textFormat.italic = loadedLabel.textFormat.italic = UIStyleManager.PROGRESS_SLIDER_TEXT_ITALIC;
        label.textFormat.bold = loadedLabel.textFormat.bold = UIStyleManager.PROGRESS_SLIDER_TEXT_BOLD;
        
        if ("" != UIStyleManager.PROGRESS_SLIDER_TEXT_FONT) 
            label.font = loadedLabel.font = UIStyleManager.PROGRESS_SLIDER_TEXT_FONT;
        
        if ("" != UIStyleManager.PROGRESS_SLIDER_TEXT_ALIGN) 
            label.align = loadedLabel.align = UIStyleManager.PROGRESS_SLIDER_TEXT_ALIGN;
        
        if (null != UIStyleManager.PROGRESS_SLIDER_TEXT_EMBED) 
        {
            label.setEmbedFont(UIStyleManager.PROGRESS_SLIDER_TEXT_EMBED);
            loadedLabel.setEmbedFont(UIStyleManager.PROGRESS_SLIDER_TEXT_EMBED);
        }
    }
    
    override private function onStageAdd(event : Event) : Void
    {
        UIBitmapManager.watchElement(TYPE, this);
    }
    
    override private function onStageRemove(event : Event) : Void
    {
        UIBitmapManager.stopWatchElement(TYPE, this);
    }
    
    /**
	 * Return the slider
	 */
    
    private function get_slider() : ISlider
    {
        return _slider;
    }
    

	
	override public function draw():Void 
	{
		super.draw();
		
		_slider.width = _width;
		_slider.height = _height;
	}
    

}

