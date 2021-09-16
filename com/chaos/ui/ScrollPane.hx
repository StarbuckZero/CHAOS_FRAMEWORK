package com.chaos.ui;

import com.chaos.ui.UIBitmapManager;
import com.chaos.ui.ScrollPolicy;
import com.chaos.ui.layout.BaseContainer;
import com.chaos.ui.classInterface.IScrollBar;
import com.chaos.ui.classInterface.IScrollPane;
import com.chaos.ui.classInterface.IBorder;
import com.chaos.ui.layout.classInterface.IBaseContainer;

import openfl.display.DisplayObject;
import openfl.display.Shape;
import openfl.geom.Rectangle;
import openfl.events.Event;

/**
 *  A container for loading in DisplayObject
 */
class ScrollPane extends BaseContainer implements IScrollPane implements IBaseContainer {

	private static inline var RECT_MODE:String = "rect";
	private static inline var MASK_MODE:String = "mask";

	/**
	 * Returns the bottom horizontal scrollbar being used
	 */
	public var scrollBarH(get, never):IScrollBar;

	/**
	 * Returns the vertical scrollbar on the righ side
	 */
	public var scrollBarV(get, never):IScrollBar;

	/**
	 * Hide or show the outline around the component
	 */
	public var showOutline(get, set):Bool;	

	/**
	 * Get border
	 */
	public var outline(get, never):IBorder;

	/**
	 * Places a DisplayObject in the ScrollPane
	 */
	 public var source(get, set):DisplayObject;	

	/**
	 * Change the ScrollBar settings on the ScrollPane. This changes the way the scrollbars react to content.
	 * The settings are ScrollPolicy.AUTO,ScrollPolicy.VERTICAL_ONLY,ScrollPolicy.HORIZONTAL_ONLY,ScrollPolicy.ON or ScrollPolicy.OFF.
	 *
	 * @see com.chaos.ui.ScrollPolicy
	 */
	public var mode(get, set):ScrollPolicy;

	public var shapeBlock:Shape;

	private var _mode:ScrollPolicy = ScrollPolicy.AUTO;
	private var _scrollContentType:String = RECT_MODE;

	private var _scrollContentLoaded:Bool = false;

	private var _scrollContentH:ScrollContentBase;
	private var _scrollContentV:ScrollContentBase;
	private var _scrollRectH:Rectangle;
	private var _scrollRectV:Rectangle;
	private var _scrollMask:Shape;
	private var _scrollBarH:IScrollBar;
	private var _scrollBarV:IScrollBar;
	private var _contentSizeBox:Shape;
	private var _mask:Shape;

	private var _offsetX:Int = 0;
	private var _offsetY:Int = 0;
	private var _contentOffsetX:Int = 0;
	private var _contentOffsetY:Int = 0;

	// This is used for the real size
	private var _outline:IBorder;

	private var _showOutline : Bool = false;

	private var _bgDisplayImage:Bool = false;

	private var _borderData:Dynamic = {};

	/**
	 * UI ScrollPane
	 * @param	data The proprieties that you want to set on component.
	 */
	public function new(data:Dynamic = null) {
		super(data);

		addEventListener(Event.ADDED_TO_STAGE, onStageAdd, false, 0, true);
		addEventListener(Event.REMOVED_FROM_STAGE, onStageRemove, false, 0, true);
	}

	private function onStageAdd(event:Event):Void {
		UIBitmapManager.watchElement(UIBitmapType.ScrollPane, this);
	}

	private function onStageRemove(event:Event):Void {
		UIBitmapManager.stopWatchElement(UIBitmapType.ScrollPane, this);
	}

	/**
	 * Set properties based on object
	 * @param	data object with supported types
	 */
	override function setComponentData(data:Dynamic) {
		super.setComponentData(data);

		if (Reflect.hasField(data, "showOutline"))
			_showOutline = Reflect.field(data, "showOutline");

		if (Reflect.hasField(data, "Border"))
			_borderData = Reflect.field(data, "Border");

		if (Reflect.hasField(data, "mode"))
			_mode = Reflect.field(data, "mode");

		if (Reflect.hasField(data, "scrollContentType")) 
		{
			if (Reflect.field(data, "scrollContentType") == RECT_MODE || Reflect.field(data, "scrollContentType") == MASK_MODE)
				_scrollContentType = Reflect.field(data, "scrollContentType");
		}
	}

	/**
	 * initialize all importain objects
	 */
	override public function initialize():Void {
		
		_scrollBarH = new ScrollBar();
		_scrollBarV = new ScrollBar();

		shapeBlock = new Shape();
		_outline = new Border(_borderData);

		_scrollMask = new Shape();

		_contentSizeBox = new Shape();
		_contentSizeBox.visible = false;

		_mask = new Shape();

		super.initialize();

		_scrollBarH.slider.direction = ScrollBarDirection.HORIZONTAL;
		_scrollBarV.slider.direction = ScrollBarDirection.VERTICAL;
		_scrollBarH.visible = false;
		_scrollBarV.visible = false;

		addChild(_contentSizeBox);

		addChild(shapeBlock);
		addChild(_outline.displayObject);
		addChild(_scrollBarH.displayObject);
		addChild(_scrollBarV.displayObject);
	}

	/**
	 * Unload Component
	 */
	override public function destroy():Void {
		super.destroy();

		_contentSizeBox.graphics.clear();
		shapeBlock.graphics.clear();

		removeEventListener(Event.ADDED_TO_STAGE, onStageAdd);
		removeEventListener(Event.REMOVED_FROM_STAGE, onStageRemove);

		removeChild(_contentSizeBox);

		removeChild(shapeBlock);
		removeChild(_outline.displayObject);
		removeChild(_scrollBarH.displayObject);
		removeChild(_scrollBarV.displayObject);

		// See if some content is already loaded
		if (_content.numChildren > 0)
			_content.removeChildAt(0);

		_scrollBarH.destroy();
		_scrollBarV.destroy();
		_outline.destroy();

	}

	/**
	 * Reload all bitmap images and UI Styles
	 */
	override public function reskin():Void {
		super.reskin();

		initUISkin();
		initStyle();
	}

	private function initUISkin():Void {
		if (UIBitmapManager.hasUIElement(UIBitmapType.ScrollPane, UIBitmapManager.SCROLLPANE_BACKGROUND))
			setBackgroundImage(UIBitmapManager.getUIElement(UIBitmapType.ScrollPane, UIBitmapManager.SCROLLPANE_BACKGROUND));
	}

	private function initStyle():Void {
		if (UIStyleManager.hasStyle(UIStyleManager.SCROLLPANE_BACKGROUND))
			_backgroundColor = UIStyleManager.getStyle(UIStyleManager.SCROLLPANE_BACKGROUND);

		if (UIStyleManager.hasStyle(UIStyleManager.SCROLLPANE_CONTENT_OFFSET_X))
			_offsetX = UIStyleManager.getStyle(UIStyleManager.SCROLLPANE_CONTENT_OFFSET_X);

		if (UIStyleManager.hasStyle(UIStyleManager.SCROLLPANE_CONTENT_OFFSET_Y))
			_offsetY = UIStyleManager.getStyle(UIStyleManager.SCROLLPANE_CONTENT_OFFSET_Y);

		if (UIStyleManager.hasStyle(UIStyleManager.SCROLLPANE_CONTENT_WIDTH_OFFSET))
			_contentOffsetX = UIStyleManager.getStyle(UIStyleManager.SCROLLPANE_CONTENT_WIDTH_OFFSET);

		if (UIStyleManager.hasStyle(UIStyleManager.SCROLLPANE_CONTENT_HEIGHT_OFFSET))
			_contentOffsetY = UIStyleManager.getStyle(UIStyleManager.SCROLLPANE_CONTENT_HEIGHT_OFFSET);

		if (UIStyleManager.hasStyle(UIStyleManager.SCROLLPANE_BORDER))
			_showOutline = UIStyleManager.getStyle(UIStyleManager.SCROLLPANE_BORDER);

		if (UIStyleManager.hasStyle(UIStyleManager.SCROLLPANE_USE_CUSTOM_RENDER))
			_useCustomRender = UIStyleManager.getStyle(UIStyleManager.SCROLLPANE_USE_CUSTOM_RENDER);

	}

	/**
	 * Hide or show the outline
	 */
	 private function set_showOutline(value:Bool):Bool {
		
		_showOutline = value;
		return value;
	}

	private function get_showOutline():Bool {
		return _showOutline;
	}

	/**
	 * Return outline used on component
	 */
	private function get_outline():IBorder {
		return _outline;
	}

	/**
	 * Set the color of the ScrollPane background
	 *
	 * @param value The color that you want to set the scroll pane background to
	 *
	 */
	override private function set_backgroundColor(value:Int):Int {
		_backgroundColor = value;

		return value;
	}

	/**
	 *
	 * @return Returns the color
	 */
	override private function get_backgroundColor():Int {
		return super.backgroundColor;
	}

	/**
	 * Set if the ScrollPane is enabled
	 */
	override private function set_enabled(value:Bool):Bool {
		_scrollBarH.enabled = _scrollBarV.enabled = super.enabled = value;
		return value;
	}

	/**
	 *
	 * @return Return if the ScrollPane is enabled or disable
	 */
	override private function get_enabled():Bool {
		return super.enabled;
	}

	/**
	 * Returns the bottom horizontal scrollbar being used
	 */
	private function get_scrollBarH():IScrollBar {
		return _scrollBarH;
	}

	/**
	 * Returns the vertical scrollbar on the righ side
	 */
	private function get_scrollBarV():IScrollBar {
		return _scrollBarV;
	}

	/**
	 * The content clip that hoses the data that was loaded.
	 */
	override private function get_content():DisplayObject {
		return ((_content.numChildren > 0)) ? _content.getChildAt(0) : null;
	}

	/**
	 * Places a DisplayObject in the ScrollPane
	 */
	private function set_source(value:DisplayObject):DisplayObject {

		if (null == _scrollBarH && null == _scrollBarV)
			return null;

		_contentSizeBox.graphics.clear();
		_contentSizeBox.graphics.beginFill(_backgroundColor);
		_contentSizeBox.graphics.drawRect(0, 0, value.width, value.height);
		_contentSizeBox.graphics.endFill();

		// See if some content is already loaded
		if (_content.numChildren > 0)
			_content.removeChildAt(0);

		_content.addChild(value);

		// Update scroll pane
		update();

		return value;
	}

	/**
	 * Returns the DisplayObject that was stored. If nothing was set then return null.
	 */
	private function get_source():DisplayObject {
		return ((_content.numChildren > 0)) ? _content.getChildAt(0) : null;
	}

	/**
	 * Reload the content that is inside the ScrollPane
	 */
	public function refreshPane():Void {
		// Pull content out of display clip
		var tempClip:DisplayObject = _content.getChildAt(0);

		if (tempClip != null) {
			// Redraw the content size blog based on display object removed
			_contentSizeBox.graphics.clear();
			_contentSizeBox.graphics.beginFill(_backgroundColor);
			_contentSizeBox.graphics.drawRect(0, 0, tempClip.width, tempClip.height);
			_contentSizeBox.graphics.endFill();

			// Update Scrollbar
			contentHolder.addChild(_scrollBarH.displayObject);
			contentHolder.addChild(_scrollBarV.displayObject);
			contentHolder.addChild(_outline.displayObject);
		}

		update();
	}

	/**
	 * Update the content area, this is needed for when the content loaded inside the ScrollPane size has changed
	 */
	public function update():Void {
		if (_scrollContentLoaded) {
			_scrollContentH.unload();
			_scrollContentV.unload();
		}

		// Set things based on scroll mode
		if (_scrollContentType == RECT_MODE) {
			_scrollRectH = new Rectangle(_offsetX, _offsetY, _width,
				_height - shapeBlock.height);
			_scrollRectV = new Rectangle(_offsetX, _offsetY, _width,
				_height - shapeBlock.height);

			_scrollContentH = new ScrollRectContent(_content, _scrollBarH, _scrollRectH);
			_scrollContentV = new ScrollRectContent(_content, _scrollBarV, _scrollRectV);
		} else if (_scrollContentType == MASK_MODE) {
			_scrollContentH = new ScrollMaskContent(_content, _scrollBarH, _scrollMask);
			_scrollContentV = new ScrollMaskContent(_content, _scrollBarV, _scrollMask);
		}

		_scrollBarH.slider.percent = 0;
		_scrollBarV.slider.percent = 0;

		_content.visible = _scrollContentLoaded = true;

		updatePolicy(_mode);
	}

	/**
	 * Draw the ScrollPane and all the UI classes it's using
	 */
	override public function draw():Void {

		if(_useCustomRender && UIBitmapManager.hasCustomRenderTexture(UIBitmapType.ScrollPane) && _width > 0 && _height > 0)  {
			setBackgroundImage(UIBitmapManager.runCustomRender(UIBitmapType.ScrollPane,{"width":_width,"height":_height}));
		}		

		// Draw background image
		super.draw();

		if (null == _outline || null == shapeBlock)
			return;

		shapeBlock.graphics.clear();

		shapeBlock.graphics.beginFill(_backgroundColor);
		shapeBlock.graphics.drawRect(0, 0, _scrollBarH.buttonWidth, _scrollBarH.buttonHeight);
		shapeBlock.graphics.endFill();

		_mask.graphics.clear();
		this.mask = _content.mask = null;

		// Scroll mask if mode is enabled
		_scrollMask.graphics.clear();

		if (_scrollContentType == RECT_MODE) {

			// Over all mask
			_mask.graphics.beginFill();
			_mask.graphics.drawRect(0, 0, _width, _height);
			_mask.graphics.endFill();

			// contentObject.mask = _mask;
		} else if (_scrollContentType == MASK_MODE) {

			_scrollMask.graphics.beginFill(0, 1);
			_scrollMask.graphics.drawRect(_offsetX, _offsetY,

				(_scrollBarH.visible) ? _width - shapeBlock.width : _width, (_scrollBarV.visible) ? _height : _height - _scrollBarV.buttonHeight);
			_scrollMask.graphics.endFill();
		}

		_outline.visible = _showOutline;

		_outline.width = _width;
		_outline.height = _height;

		_outline.draw();

	}

	/**
	 * Change the ScrollBar settings on the ScrollPane. This changes the way the scrollbars react to content.
	 * The settings are ScrollPolicy.AUTO, ScrollPolicy.VERTICAL_ONLY, ScrollPolicy.HORIZONTAL_ONLY, ScrollPolicy.ON or ScrollPolicy.OFF.
	 *
	 * @see com.chaos.ui.ScrollPolicy
	 */
	public function set_mode(value:ScrollPolicy):ScrollPolicy {
		_mode = value;
		updatePolicy(_mode);

		return value;
	}

	/**
	 * Returns what mode the ScrollPane is in
	 *
	 * @see com.chaos.ui.ScrollPolicy
	 */
	public function get_mode():ScrollPolicy {
		return _mode;
	}

	private function updatePolicy(value:ScrollPolicy = ScrollPolicy.AUTO):Void {
		
		// If nothing was setup then leave
		if (_content.numChildren == 0)
			return;

		// Figure out what to do with the
		if (value == ScrollPolicy.AUTO) {

			// Make sure scroll bars are hidden
			_scrollBarH.visible = true;
			_scrollBarV.visible = true;

			shapeBlock.visible = true;

			// Set the size of the scrollbars
			_scrollBarH.width = (_width - shapeBlock.width) - _contentOffsetX;
			_scrollBarV.height = (_height - shapeBlock.height) - _contentOffsetY;

			_scrollBarV.draw();
			_scrollBarH.draw();

			// Check to see width of the content loaded width greather
			if (_contentSizeBox.width > _width) {
				_scrollBarH.visible = true;
			} else {
				shapeBlock.visible = false;
				_scrollBarH.visible = false;
			}

			// Check to see height of the content loaded width greather
			if (_contentSizeBox.height > _height) {
				_scrollBarV.visible = true;
			} else {
				shapeBlock.visible = false;
				_scrollBarV.visible = false;
			}

			// If you can see the shape block then move the block into the right place
			if (shapeBlock.visible) 
			{
				shapeBlock.x = (_width - shapeBlock.width) + _contentOffsetX;
				shapeBlock.y = (_height - shapeBlock.height) + _contentOffsetY;
			}
			
			else { // Else figure out how to adjust the scroll bars
				
				// If Hoz is the only one being displayed
				if (_scrollBarH.visible && !_scrollBarV.visible) {
					_scrollBarH.width = _width - _contentOffsetX;
					_scrollBarH.draw();
				} else if (!_scrollBarH.visible && _scrollBarV.visible) // If Vert is the only one being displayed
				{
					_scrollBarV.height = _height - _contentOffsetY;
					_scrollBarV.draw();
				}

				// Move to a safe place
				shapeBlock.x = shapeBlock.y = 0;
			}
		} else if (value == ScrollPolicy.ON) {

			_scrollBarH.width = (_width - shapeBlock.width) - _contentOffsetX;
			_scrollBarV.height = (_height - shapeBlock.height) - _contentOffsetY;

			_scrollBarV.draw();
			_scrollBarH.draw();

			_scrollBarH.visible = (_content.numChildren == 0) ? false : true;
			_scrollBarV.visible = (_content.numChildren == 0) ? false : true;

			// Check to see width of the content loaded width greather
			if (_contentSizeBox.width > _width)
				_scrollBarH.enabled = true;
			else
				_scrollBarH.enabled = false;

			// Check to see height of the s loaded width greather
			if (_contentSizeBox.height > _height)
				_scrollBarV.enabled = true;
			else
				_scrollBarV.enabled = false;
		} else if (value == ScrollPolicy.ONLY_VERTICAL) {

			_scrollBarH.visible = false;
			_scrollBarV.visible = true;

			shapeBlock.visible = false;

			_scrollBarV.height = _height + _contentOffsetX;
			_scrollBarV.draw();

			// Check to see height of the s loaded width greather
			if (_contentSizeBox.height > _height)
				_scrollBarV.enabled = true;
			else
				_scrollBarV.enabled = false;

		} else if (value == ScrollPolicy.ONLY_HORIZONTAL) {

			_scrollBarV.visible = false;
			_scrollBarH.visible = true;

			shapeBlock.visible = false;

			_scrollBarH.width = _width + _contentOffsetX;
			_scrollBarH.draw();

			// Check to see width of the content loaded width greather
			if (_contentSizeBox.width > _width)
				_scrollBarH.enabled = true;
			else
				_scrollBarH.enabled = false;

		} else if (value == ScrollPolicy.OFF) {

			_scrollBarH.visible = false;
			_scrollBarV.visible = false;

			shapeBlock.visible = false;
		}
	}
}
