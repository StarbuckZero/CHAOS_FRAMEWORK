package com.chaos.ui;

import com.chaos.ui.classInterface.IScrollPane;
import com.chaos.ui.UIBitmapManager.UIBitmapType;
import openfl.display.BitmapData;
import openfl.display.Shape;
import openfl.events.Event;

/** A rounded frame with scrollable content and optional corner artwork. */
class Frame extends BaseUI {
    public var scrollPane(get, never):IScrollPane;
    public var rounded(default, default):Float = 24;
    public var border(default, default):Bool = true;
    public var borderColor(default, default):Int = 0x000000;
    public var borderAlpha(default, default):Float = 1;
    public var borderThickness(default, default):Float = 2;
    public var backgroundColor(default, default):Int = 0xFFFFFF;
    public var backgroundAlpha(default, default):Float = 1;
    public var contentPadding(default, default):Float = 8;

    private var _background:Shape = new Shape();
    private var _border:Shape = new Shape();
    private var _corners:Array<Shape> = [new Shape(), new Shape(), new Shape(), new Shape()];
    private var _cornerImages:Array<BitmapData> = [null, null, null, null];
    private var _backgroundImage:BitmapData;
    private var _scrollPane:ScrollPane;
    private var _scrollPanelData:Dynamic;

    public function new(data:Dynamic = null) {
        super(data);
        addEventListener(Event.ADDED_TO_STAGE, onStageAdd, false, 0, true);
        addEventListener(Event.REMOVED_FROM_STAGE, onStageRemove, false, 0, true);
    }

    override public function setComponentData(data:Dynamic):Void {
        super.setComponentData(data);
        if (data == null) return;
        for (key in ["rounded", "border", "borderColor", "borderAlpha", "borderThickness",
            "backgroundColor", "backgroundAlpha", "contentPadding"])
            if (Reflect.hasField(data, key)) Reflect.setProperty(this, key, Reflect.field(data, key));
        if (Reflect.hasField(data, "ScrollPanel")) {
            _scrollPanelData = Reflect.field(data, "ScrollPanel");
            if (_scrollPane != null && _scrollPanelData != null) {
                _scrollPane.setComponentData(_scrollPanelData);
                _scrollPane.background = false;
            }
        }
    }

    override public function initialize():Void {
        super.initialize();
        addChild(_background);
        _scrollPane = new ScrollPane(_scrollPanelData == null ? {mode:ScrollPolicy.AUTO, background:false} : _scrollPanelData);
        _scrollPane.background = false;
        addChild(_scrollPane);
        addChild(_border);
        for (corner in _corners) addChild(corner);
    }

    private function get_scrollPane():IScrollPane return _scrollPane;

    public function setBackgroundImage(image:BitmapData):Void {
        _backgroundImage = image;
        draw();
    }

    /** Images are ordered top left, top right, bottom left, bottom right. */
    public function setCornerImages(topLeft:BitmapData, topRight:BitmapData,
        bottomLeft:BitmapData, bottomRight:BitmapData):Void {
        _cornerImages = [topLeft, topRight, bottomLeft, bottomRight];
        draw();
    }

    override public function reskin():Void {
        super.reskin();
        var type = UIBitmapType.Frame;
        var keys = [UIBitmapManager.FRAME_TOP_LEFT, UIBitmapManager.FRAME_TOP_RIGHT,
            UIBitmapManager.FRAME_BOTTOM_LEFT, UIBitmapManager.FRAME_BOTTOM_RIGHT];
        for (i in 0...keys.length)
            _cornerImages[i] = hasResolvedBitmap(type, keys[i]) ? getResolvedBitmap(type, keys[i]) : null;
        _backgroundImage = hasResolvedBitmap(type, UIBitmapManager.FRAME_BACKGROUND)
            ? getResolvedBitmap(type, UIBitmapManager.FRAME_BACKGROUND) : null;
        if (hasResolvedStyle(UIStyleManager.FRAME_BACKGROUND_COLOR)) backgroundColor = getResolvedStyle(UIStyleManager.FRAME_BACKGROUND_COLOR);
        if (hasResolvedStyle(UIStyleManager.FRAME_BACKGROUND_ALPHA)) backgroundAlpha = getResolvedStyle(UIStyleManager.FRAME_BACKGROUND_ALPHA);
        if (hasResolvedStyle(UIStyleManager.FRAME_BORDER)) border = getResolvedStyle(UIStyleManager.FRAME_BORDER);
        if (hasResolvedStyle(UIStyleManager.FRAME_BORDER_COLOR)) borderColor = getResolvedStyle(UIStyleManager.FRAME_BORDER_COLOR);
        if (hasResolvedStyle(UIStyleManager.FRAME_BORDER_ALPHA)) borderAlpha = getResolvedStyle(UIStyleManager.FRAME_BORDER_ALPHA);
        if (hasResolvedStyle(UIStyleManager.FRAME_BORDER_THICKNESS)) borderThickness = getResolvedStyle(UIStyleManager.FRAME_BORDER_THICKNESS);
        if (hasResolvedStyle(UIStyleManager.FRAME_ROUNDED)) rounded = getResolvedStyle(UIStyleManager.FRAME_ROUNDED);
    }

    override public function draw():Void {
        if (_background == null || _border == null || _corners == null) return;
        var w = Math.max(0, width);
        var h = Math.max(0, height);
        _background.graphics.clear();
        if (_backgroundImage != null) _background.graphics.beginBitmapFill(_backgroundImage, null, true, _smoothImage);
        else _background.graphics.beginFill(backgroundColor, backgroundAlpha);
        _background.graphics.drawRoundRect(0, 0, w, h, rounded, rounded);
        _background.graphics.endFill();
        _border.graphics.clear();
        if (border) {
            _border.graphics.lineStyle(borderThickness, borderColor, borderAlpha);
            _border.graphics.drawRoundRect(0, 0, w, h, rounded, rounded);
        }
        for (i in 0...4) {
            var corner = _corners[i];
            var image = _cornerImages[i];
            corner.graphics.clear();
            if (image == null) continue;
            corner.graphics.beginBitmapFill(image, null, false, _smoothImage);
            corner.graphics.drawRect(0, 0, image.width, image.height);
            corner.graphics.endFill();
            corner.x = i % 2 == 0 ? 0 : w - image.width;
            corner.y = i < 2 ? 0 : h - image.height;
        }
        if (_scrollPane != null) {
            var inset = Math.max(0, contentPadding);
            _scrollPane.x = inset;
            _scrollPane.y = inset;
            var paneWidth = Math.max(0, w - inset * 2);
            var paneHeight = Math.max(0, h - inset * 2);
            var resized = _scrollPane.width != paneWidth || _scrollPane.height != paneHeight;
            _scrollPane.width = paneWidth;
            _scrollPane.height = paneHeight;
            _scrollPane.draw();
            if (resized) _scrollPane.update();
        }
    }

    private function onStageAdd(event:Event):Void UIBitmapManager.watchElement(UIBitmapType.Frame, this);
    private function onStageRemove(event:Event):Void UIBitmapManager.stopWatchElement(UIBitmapType.Frame, this);

    override public function destroy():Void {
        UIBitmapManager.stopWatchElement(UIBitmapType.Frame, this);
        removeEventListener(Event.ADDED_TO_STAGE, onStageAdd);
        removeEventListener(Event.REMOVED_FROM_STAGE, onStageRemove);
        _scrollPane.destroy();
        super.destroy();
    }
}
