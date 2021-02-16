package com.chaos.ui;

import com.chaos.ui.Slider;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.classInterface.IProgressBar;
import com.chaos.ui.classInterface.IProgressSlider;
import com.chaos.ui.classInterface.ISlider;
import openfl.display.BitmapData;
import openfl.events.Event;

/**
 * ProgressBar is used for things like video and MP3 players
 * @author Erick Feiling
 */
class ProgressSlider extends ProgressBar implements IProgressSlider implements IProgressBar implements IBaseUI {
	/**
	 * Return the slider
	 */
	public var slider(get, never):ISlider;

	public static inline var TYPE:String = "ProgressSlider";

	private var _slider:Slider;

	private var _sliderButtonDefaultImage:BitmapData;
	private var _sliderButtonOverImage:BitmapData;
	private var _sliderButtonDownImage:BitmapData;
	private var _sliderButtonDisableImage:BitmapData;

	private var _sliderData:Dynamic;

	/**
	 * ProgressSlider
	 * @param	data The proprieties that you want to set on component.
	 */
	public function new(data:Dynamic = null) {
		super(data);

		addEventListener(Event.ADDED_TO_STAGE, onStageAdd, false, 0, true);
		addEventListener(Event.REMOVED_FROM_STAGE, onStageRemove, false, 0, true);

		addChild(_slider);
	}

	/**
	 * Set properties based on object
	 * @param	data object with supported types
	 */
	override public function setComponentData(data:Dynamic):Void {
		super.setComponentData(data);

		if (Reflect.hasField(data, "Slider"))
			_sliderData = Reflect.field(data, "Slider");
	}

	/**
	 * initialize all importain objects
	 */
	override public function initialize():Void {
		Reflect.setField(_sliderData, "width", _width);
		Reflect.setField(_sliderData, "height", _height);
		Reflect.setField(_sliderData, "showTrack", false);
		Reflect.setField(_sliderData, "direction", ScrollBarDirection.HORIZONTAL);

		_slider = new Slider(_sliderData);

		// Apply image and remove it
		if (null != _sliderButtonDefaultImage)
			_slider.setSliderImage(_sliderButtonDefaultImage.clone());

		if (null != _sliderButtonOverImage)
			_slider.setSliderOverImage(_sliderButtonOverImage.clone());

		if (null != _sliderButtonDownImage)
			_slider.setSliderDownImage(_sliderButtonDownImage.clone());

		if (null != _sliderButtonDisableImage)
			_slider.setSliderDisableImage(_sliderButtonDisableImage.clone());

		// Remove it
		if (null != _sliderButtonDefaultImage) {
			_sliderButtonDefaultImage.dispose();
			_sliderButtonDefaultImage = null;
		}

		if (null != _sliderButtonOverImage) {
			_sliderButtonOverImage.dispose();
			_sliderButtonOverImage = null;
		}

		if (null != _sliderButtonDownImage) {
			_sliderButtonDownImage.dispose();
			_sliderButtonDownImage = null;
		}

		if (null != _sliderButtonDisableImage) {
			_sliderButtonDisableImage.dispose();
			_sliderButtonDisableImage = null;
		}

		super.initialize();

		_sliderData = null;
	}

	/**
	 * Reload all bitmap images and UI Styles
	 */
	override public function reskin():Void {
		super.reskin();

		initBitmap();
		initStyle();
	}

	/**
	 * Unload Component
	 */
	override public function destroy():Void {
		super.destroy();

		_sliderData = null;
	}

	override private function initBitmap():Void {
		super.initBitmap();

		if (UIBitmapManager.hasUIElement(Slider.TYPE, UIBitmapManager.PROGRESS_SLIDER_BUTTON_NORMAL))
			_sliderButtonDefaultImage = UIBitmapManager.getUIElement(Slider.TYPE, UIBitmapManager.PROGRESS_SLIDER_BUTTON_NORMAL).clone();

		if (UIBitmapManager.hasUIElement(Slider.TYPE, UIBitmapManager.PROGRESS_SLIDER_BUTTON_OVER))
			_sliderButtonOverImage = UIBitmapManager.getUIElement(Slider.TYPE, UIBitmapManager.PROGRESS_SLIDER_BUTTON_OVER).clone();

		if (UIBitmapManager.hasUIElement(Slider.TYPE, UIBitmapManager.PROGRESS_SLIDER_BUTTON_DOWN))
			_sliderButtonDownImage = UIBitmapManager.getUIElement(Slider.TYPE, UIBitmapManager.PROGRESS_SLIDER_BUTTON_DOWN).clone();

		if (UIBitmapManager.hasUIElement(Slider.TYPE, UIBitmapManager.PROGRESS_SLIDER_BUTTON_DISABLE))
			_sliderButtonDisableImage = UIBitmapManager.getUIElement(Slider.TYPE, UIBitmapManager.PROGRESS_SLIDER_BUTTON_DISABLE).clone();

		if (UIBitmapManager.hasUIElement(ProgressBar.TYPE, UIBitmapManager.PROGRESS_SLIDER_BACKGROUND))
			setBackgroundImage(UIBitmapManager.getUIElement(ProgressBar.TYPE, UIBitmapManager.PROGRESS_SLIDER_BACKGROUND));

		if (UIBitmapManager.hasUIElement(ProgressBar.TYPE, UIBitmapManager.PROGRESS_SLIDER_LOADED_BACKGROUND))
			setLoadBarImage(UIBitmapManager.getUIElement(ProgressBar.TYPE, UIBitmapManager.PROGRESS_SLIDER_LOADED_BACKGROUND));

		if (null != _slider) {
			if (null != _sliderButtonDefaultImage) {
				_slider.setSliderImage(_sliderButtonDefaultImage.clone());

				_sliderButtonDefaultImage.dispose();
				_sliderButtonDefaultImage = null;
			}

			if (null != _sliderButtonOverImage) {
				_slider.setSliderOverImage(_sliderButtonOverImage.clone());

				_sliderButtonOverImage.dispose();
				_sliderButtonOverImage = null;
			}

			if (null != _sliderButtonDownImage) {
				_slider.setSliderDownImage(_sliderButtonDownImage.clone());

				_sliderButtonDownImage.dispose();
				_sliderButtonDownImage = null;
			}

			if (null != _sliderButtonDisableImage) {
				_slider.setSliderDisableImage(_sliderButtonDisableImage.clone());

				_sliderButtonDisableImage.dispose();
				_sliderButtonDisableImage = null;
			}
		}
	}

	override private function initStyle():Void {
		super.initStyle();

		_sliderData = {};

		// Set the style for progress bar
		if (UIStyleManager.hasStyle(UIStyleManager.PROGRESS_SLIDER_NORMAL_COLOR))
			Reflect.setField(_sliderData, "sliderColor", UIStyleManager.getStyle(UIStyleManager.PROGRESS_SLIDER_NORMAL_COLOR));

		if (UIStyleManager.hasStyle(UIStyleManager.PROGRESS_SLIDER_OVER_COLOR))
			Reflect.setField(_sliderData, "sliderOverColor", UIStyleManager.getStyle(UIStyleManager.PROGRESS_SLIDER_OVER_COLOR));

		if (UIStyleManager.hasStyle(UIStyleManager.PROGRESS_SLIDER_DOWN_COLOR))
			Reflect.setField(_sliderData, "sliderDownColor", UIStyleManager.getStyle(UIStyleManager.PROGRESS_SLIDER_DOWN_COLOR));

		if (UIStyleManager.hasStyle(UIStyleManager.PROGRESS_SLIDER_DISABLE_COLOR))
			Reflect.setField(_sliderData, "sliderDisableColor", UIStyleManager.getStyle(UIStyleManager.PROGRESS_SLIDER_DISABLE_COLOR));

		if (UIStyleManager.hasStyle(UIStyleManager.PROGRESS_SLIDER_SIZE))
			Reflect.setField(_sliderData, "sliderSize", UIStyleManager.getStyle(UIStyleManager.PROGRESS_SLIDER_SIZE));

		if (UIStyleManager.hasStyle(UIStyleManager.PROGRESS_SLIDER_OFFSET))
			Reflect.setField(_sliderData, "sliderOffSet", UIStyleManager.getStyle(UIStyleManager.PROGRESS_SLIDER_OFFSET));

		if (UIStyleManager.hasStyle(UIStyleManager.PROGRESS_SLIDER_ROTATE_IMAGE))
			Reflect.setField(_sliderData, "rotateImage", UIStyleManager.getStyle(UIStyleManager.PROGRESS_SLIDER_ROTATE_IMAGE));

		// Set the style slider
		if (UIStyleManager.hasStyle(UIStyleManager.PROGRESS_SLIDER_COLOR))
			_backgroundNormalColor = UIStyleManager.getStyle(UIStyleManager.PROGRESS_SLIDER_COLOR);

		if (UIStyleManager.hasStyle(UIStyleManager.PROGRESS_SLIDER_COLOR_LOADED))
			_loadColor = UIStyleManager.getStyle(UIStyleManager.PROGRESS_SLIDER_COLOR_LOADED);

		if (UIStyleManager.hasStyle(UIStyleManager.PROGRESS_SLIDER_BORDER))
			_border = UIStyleManager.getStyle(UIStyleManager.PROGRESS_SLIDER_BORDER);

		if (UIStyleManager.hasStyle(UIStyleManager.PROGRESS_SLIDER_TEXT_COLOR))
			_textColor = UIStyleManager.getStyle(UIStyleManager.PROGRESS_SLIDER_TEXT_COLOR);

		if (UIStyleManager.hasStyle(UIStyleManager.PROGRESS_SLIDER_COLOR_LOADED))
			_textLoadedColor = UIStyleManager.getStyle(UIStyleManager.PROGRESS_SLIDER_COLOR_LOADED);

		if (UIStyleManager.hasStyle(UIStyleManager.PROGRESS_SLIDER_BORDER_THINKNESS))
			_thinkness = UIStyleManager.getStyle(UIStyleManager.PROGRESS_SLIDER_BORDER_THINKNESS);

		if (UIStyleManager.hasStyle(UIStyleManager.PROGRESS_SLIDER_BORDER_COLOR))
			_outlineColor = UIStyleManager.getStyle(UIStyleManager.PROGRESS_SLIDER_BORDER_COLOR);

		if (UIStyleManager.hasStyle(UIStyleManager.PROGRESS_SLIDER_BORDER_ALPHA))
			_outlineAlpha = UIStyleManager.getStyle(UIStyleManager.PROGRESS_SLIDER_BORDER_ALPHA);

		// Set Label Style
		if (UIStyleManager.hasStyle(UIStyleManager.PROGRESS_SLIDER_TEXT_SIZE))
			Reflect.setField(_labelData, "size", UIStyleManager.getStyle(UIStyleManager.PROGRESS_SLIDER_TEXT_SIZE));

		Reflect.setField(_labelData, "italic", UIStyleManager.hasStyle(UIStyleManager.PROGRESS_SLIDER_TEXT_ITALIC) ? UIStyleManager.getStyle(UIStyleManager.PROGRESS_SLIDER_TEXT_ITALIC) : false );
		Reflect.setField(_labelData, "bold", UIStyleManager.hasStyle(UIStyleManager.PROGRESS_SLIDER_TEXT_BOLD) ? UIStyleManager.getStyle(UIStyleManager.PROGRESS_SLIDER_TEXT_BOLD) : false);

		if (UIStyleManager.hasStyle(UIStyleManager.PROGRESS_SLIDER_TEXT_FONT))
			Reflect.setField(_labelData, "font", UIStyleManager.getStyle(UIStyleManager.PROGRESS_SLIDER_TEXT_FONT));

		if (UIStyleManager.hasStyle(UIStyleManager.PROGRESS_SLIDER_TEXT_ALIGN))
			Reflect.setField(_labelData, "align", UIStyleManager.getStyle(UIStyleManager.PROGRESS_SLIDER_TEXT_ALIGN));

		// if (null != UIStyleManager.PROGRESS_SLIDER_TEXT_EMBED)
		// {
		//    label.setEmbedFont(UIStyleManager.PROGRESS_SLIDER_TEXT_EMBED);
		//    loadedLabel.setEmbedFont(UIStyleManager.PROGRESS_SLIDER_TEXT_EMBED);
		// }
	}

	override private function onStageAdd(event:Event):Void {
		UIBitmapManager.watchElement(TYPE, this);
	}

	override private function onStageRemove(event:Event):Void {
		UIBitmapManager.stopWatchElement(TYPE, this);
	}

	/**
	 * Return the slider
	 */
	private function get_slider():ISlider {
		return _slider;
	}

	override public function draw():Void {
		super.draw();

		_slider.width = _width;
		_slider.height = _height;

		_slider.sliderHeight = _height;

		_slider.draw();
	}
}