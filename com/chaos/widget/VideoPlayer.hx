package com.chaos.widget;

import nme.errors.SecurityError;


import com.chaos.media.event.DisplayVideoEvent;
import com.chaos.ui.layout.FitContainer;
import com.chaos.widget.event.VideoPlayerEvent;
import flash.display.Bitmap;
import flash.display.Shape;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageDisplayState;
import flash.events.Event;
import flash.events.FullScreenEvent;
import flash.events.MouseEvent;
import flash.events.NetStatusEvent;
import flash.media.SoundTransform;
import flash.utils.Timer;
import flash.events.TimerEvent;

import com.chaos.drawing.icon.StopIcon;
import com.chaos.ui.event.SliderEvent;
import com.chaos.ui.ScrollBarDirection;
import com.chaos.utils.CompositeManager;
import com.chaos.utils.Debug;

import com.chaos.drawing.icon.ArrowRightIcon;
import com.chaos.drawing.icon.PauseIcon;
import com.chaos.drawing.icon.SoundIcon;

import com.chaos.ui.interface.ILabel;
import com.chaos.ui.Label;
import com.chaos.ui.layout.Interface.IAlignmentContainer;
import com.chaos.ui.layout.Interface.IBaseContainer;
import com.chaos.ui.layout.BaseContainer;
import com.chaos.ui.layout.HorizontalContainer;
import com.chaos.utils.ThreadManager;

import com.chaos.ui.interface.IButton;
import com.chaos.ui.interface.ISlider;
import com.chaos.ui.interface.IBaseUI;
import com.chaos.ui.interface.IProgressSlider;

import com.chaos.drawing.icon.interface.IBasicIcon;

import com.chaos.media.DisplayImage;
import com.chaos.media.DisplayVideo;

import com.chaos.ui.Button;
import com.chaos.ui.Slider;
import com.chaos.ui.ProgressSlider;

/**
	 * ...
	 * @author Erick Feiling
	 */

class VideoPlayer extends BaseContainer implements IBaseContainer implements com.chaos.ui.classInterface.IBaseUI
{
    public var useMetaDataSize(get, set) : Bool;
    public var autoStart(get, set) : Bool;
    public var iconDefaultStateColor(get, set) : Int;
    public var iconOverStateColor(get, set) : Int;
    public var iconDownStateColor(get, set) : Int;
    public var soundIconColor(get, set) : Int;
    public var playOnClick(never, set) : Bool;
    public var startVideoOnClick(get, never) : Bool;

    
    public var playBtn : com.chaos.ui.classInterface.IButton = new Button();
    public var fullscreenBtn : com.chaos.ui.classInterface.IButton = new Button();
    
    public var playIcon : com.chaos.drawing.icon.interface.IBasicIcon;
    public var pauseIcon : com.chaos.drawing.icon.interface.IBasicIcon;
    public var fullScreenIcon : com.chaos.drawing.icon.interface.IBasicIcon;
    
    public var playDisplayImage : DisplayImage = new DisplayImage();
    public var pauseDisplayImage : DisplayImage = new DisplayImage();
    public var fullScreenDisplayImage : DisplayImage = new DisplayImage();
    
    public static var VOLUME_BAR_CONTAINER_WIDTH : Int = 80;
    
    private static inline var DEFAULT_BUTTON_WIDTH : Int = 20;
    private static inline var DEFAULT_BUTTON_HEIGHT : Int = 20;
    
    private static inline var DEFAULT_ICON_WIDTH : Int = 8;
    private static inline var DEFAULT_ICON_HEIGHT : Int = 8;
    
    private var _videoDisplay : DisplayVideo = new DisplayVideo();
    
    private var _autoStart : Bool = false;
    
    private var statusLabel : com.chaos.ui.classInterface.ILabel = new Label();
    private var timeLabel : com.chaos.ui.classInterface.ILabel = new Label();
    private var volumeSlider : com.chaos.ui.classInterface.ISlider = new Slider();
    private var videoSlider : com.chaos.ui.classInterface.IProgressSlider = new ProgressSlider();
    
    private var _iconDefaultStateColor : Int = 0xFFFFFF;
    private var _iconOverStateColor : Int = 0x666666;
    private var _iconDownStateColor : Int = 0x999999;
    
    private var _soundIconColor : Int = 0x999999;
    private var soundIcon : com.chaos.drawing.icon.interface.IBasicIcon = new SoundIcon(16, 16);
    
    private var soundIconDisplayImage : DisplayImage = new DisplayImage();
    
    private var contorlsContainer : com.chaos.ui.layout.classInterface.IAlignmentContainer = new HorizontalContainer();
    private var volumeBarContainer : com.chaos.ui.layout.classInterface.IAlignmentContainer = new HorizontalContainer();
    private var infoLabelContainer : com.chaos.ui.layout.classInterface.IAlignmentContainer = new FitContainer();
    
    private var _showInfoStatus : Bool = true;
    
    private var _useMetaDataSize : Bool = true;
    
    private var _hideContorlDelay : Int = 3000;
    private var autoHideTimer : Timer = new Timer(_hideContorlDelay, 0);
    
    private var oldStageAlignment : String = "";
    
    private var oldWidth : Float = 0;
    private var oldHeight : Float = 0;
    
    private var oldLocX : Float = 0;
    private var oldLocY : Float = 0;
    
    private var clickArea : Sprite = new Sprite();
    private var fullScreenMode : Bool = false;
    
    private var _playOnClick : Bool = true;
    
    public function new()
    {
        super();
        
        init();
        
        addEventListener(Event.REMOVED_FROM_STAGE, onStageRemove, false, 0, true);
        addEventListener(Event.ADDED_TO_STAGE, onStageAdd, false, 0, true);
    }
    
    private function init() : Void
    {
        
        // Setup video display area and events
        _videoDisplay.connection.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler, false, 0, true);
        _videoDisplay.addEventListener(DisplayVideoEvent.VIDEO_METADATA, onMetaData, false, 0, true);
        
        statusLabel.textColor = timeLabel.textColor = 0xFFFFFF;
        statusLabel.align = "left";
        timeLabel.align = "right";
        backgroundColor = infoLabelContainer.backgroundColor = 0x000000;
        infoLabelContainer.backgroundAlpha = .5;
        
        // Setup volume slider
        volumeSlider.showTrack = true;
        volumeSlider.percent = 1;
        volumeSlider.addEventListener(SliderEvent.CHANGE, onVolumeSliderChange, false, 0, true);
        volumeSlider.sliderHeight = DEFAULT_BUTTON_HEIGHT;
        
        playBtn.width = fullscreenBtn.width = DEFAULT_BUTTON_WIDTH;
        playBtn.height = fullscreenBtn.height = DEFAULT_BUTTON_HEIGHT;
        
        playIcon = new ArrowRightIcon(DEFAULT_ICON_WIDTH, DEFAULT_ICON_HEIGHT);
        playIcon.name = "playIcon";
        
        pauseIcon = new PauseIcon(DEFAULT_ICON_WIDTH >> 1, DEFAULT_ICON_HEIGHT);
        pauseIcon.name = "pauseIcon";
        
        fullScreenIcon = new StopIcon(DEFAULT_ICON_WIDTH + 4, DEFAULT_ICON_HEIGHT);
        fullScreenIcon.borderColor = 0x000000;
        fullScreenIcon.borderAlpha = .2;
        
        // Timer Events
        autoHideTimer.addEventListener(TimerEvent.TIMER, timerHandler, false, 0, true);
        
        // Events
        playBtn.addEventListener(MouseEvent.MOUSE_OVER, onButtonOver, false, 0, true);
        playBtn.addEventListener(MouseEvent.MOUSE_DOWN, onButtonDown, false, 0, true);
        playBtn.addEventListener(MouseEvent.MOUSE_OUT, onButtonOut, false, 0, true);
        
        playBtn.addEventListener(MouseEvent.CLICK, onPlayButton, false, 0, true);
        playBtn.addEventListener(MouseEvent.MOUSE_OUT, onButtonOut, false, 0, true);
        
        playIcon.addEventListener(MouseEvent.MOUSE_OVER, onButtonOver, false, 0, true);
        playIcon.addEventListener(MouseEvent.MOUSE_DOWN, onButtonDown, false, 0, true);
        
        pauseIcon.addEventListener(MouseEvent.MOUSE_OVER, onButtonOver, false, 0, true);
        pauseIcon.addEventListener(MouseEvent.MOUSE_DOWN, onButtonDown, false, 0, true);
        
        playIcon.filterMode = pauseIcon.filterMode = soundIcon.filterMode = fullScreenIcon.filterMode = false;
        
        // Setup timer and click event
        clickArea.addEventListener(MouseEvent.CLICK, onVideoClick, false, 0, true);  // Click area  
        clickArea.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove, false, 0, true);
        autoHideTimer.start();
        
        playBtn.setIcon(playIcon.displayObject);
        playBtn.iconDisplay = fullscreenBtn.iconDisplay = true;
        playBtn.showLabel = fullscreenBtn.showLabel = false;
        
        fullscreenBtn.setIcon(fullScreenIcon.displayObject);
        
        fullscreenBtn.addEventListener(MouseEvent.CLICK, onFullScreenClick, false, 0, true);
        
        soundIconDisplayImage.setImage(CompositeManager.displayObjectToBitmap(soundIcon.displayObject, imageSmoothing));
        
        contorlsContainer.addElement(playBtn);
        contorlsContainer.addElement(videoSlider);
        contorlsContainer.addElement(fullscreenBtn);
        
        volumeBarContainer.addElement(soundIconDisplayImage);
        volumeBarContainer.addElement(volumeSlider);
        volumeBarContainer.padding = 2;
        
        volumeSlider.direction = ScrollBarDirection.HORIZONTAL;
        videoSlider.border = false;
        
        var slider : Slider = try cast(videoSlider.slider, Slider) catch(e:Dynamic) null;
        slider.marker.addEventListener(MouseEvent.MOUSE_DOWN, onMarkerMouseDown, false, 0, true);
        slider.marker.addEventListener(MouseEvent.MOUSE_UP, onMarkerMouseUp, false, 0, true);
        
        // Set the default state for info label area
        infoLabelContainer.visible = _showInfoStatus;
        
        infoLabelContainer.addElement(statusLabel);
        infoLabelContainer.addElement(timeLabel);
        
        addChild(_videoDisplay);
        addChild(clickArea);
        addChild(infoLabelContainer.displayObject);
        addChild(contorlsContainer.displayObject);
        addChild(volumeBarContainer.displayObject);
    }
    
    /**
		 * Will size the video player based on width and height in meta data
		 */
    private function set_UseMetaDataSize(value : Bool) : Bool
    {
        _useMetaDataSize = value;
        return value;
    }
    
    /**
		 * Return true if the meta data is being used to size the video and false if not.
		 */
    
    private function get_UseMetaDataSize() : Bool
    {
        return _useMetaDataSize;
    }
    
    /**
		 * Video will start once loaded if true
		 */
    private function set_AutoStart(value : Bool) : Bool
    {
        _autoStart = true;
        return value;
    }
    
    /**
		 * Return true if video is start to auto start and false if not
		 */
    
    private function get_AutoStart() : Bool
    {
        return _autoStart;
    }
    
    /**
		 * Default state icon color
		 */
    private function set_IconDefaultStateColor(value : Int) : Int
    {
        _iconDefaultStateColor = value;
        draw();
        return value;
    }
    
    /**
		 * Return the default state icon color
		 */
    
    private function get_IconDefaultStateColor() : Int
    {
        return _iconDefaultStateColor;
    }
    
    /**
		 * Set the over state icon color
		 */
    
    private function set_IconOverStateColor(value : Int) : Int
    {
        _iconOverStateColor = value;
        draw();
        return value;
    }
    
    /**
		 * Return the over state icon color
		 */
    
    private function get_IconOverStateColor() : Int
    {
        return _iconOverStateColor;
    }
    
    /**
		 * Set the down state icon color
		 */
    private function set_IconDownStateColor(value : Int) : Int
    {
        _iconDownStateColor = value;
        return value;
    }
    
    /**
		 * Return the icon down state icon color
		 */
    private function get_IconDownStateColor() : Int
    {
        return _iconDownStateColor;
    }
    
    /**
		 * Set the sound icon color
		 */
    private function set_SoundIconColor(value : Int) : Int
    {
        _soundIconColor = soundIcon.baseColor = soundIcon.borderColor = value;
        soundIconDisplayImage.setImage(CompositeManager.displayObjectToBitmap(soundIcon.displayObject));
        return value;
    }
    
    /**
		 * Return the sound icon color
		 */
    
    private function get_SoundIconColor() : Int
    {
        return _soundIconColor;
    }
    
    /**
		 * Play video when clicked
		 */
    
    private function set_PlayOnClick(value : Bool) : Bool
    {
        _playOnClick = value;
        return value;
    }
    
    /**
		 * Start video and stop video if clicked
		 */
    
    private function get_StartVideoOnClick() : Bool
    {
        return _playOnClick;
    }
    
    /**
		 * Get the button
		 *
		 * @param strName The name of the button you want to get. You can pass play, pause or fullscreen
		 * @return A button interface
		 */
    
    public function getButton(strName : String) : com.chaos.ui.classInterface.IButton
    {
        if (strName == "play" || strName == "pause") 
        {
            return playBtn;
        }
        else if (strName == "fullscreen") 
        {
            return fullscreenBtn;
        }
        
        return null;
    }
    
    /**
		 * Get the volume slider
		 * @return The interface being used
		 */
    public function getVolumeSlider() : com.chaos.ui.classInterface.ISlider
    {
        return volumeSlider;
    }
    
    /**
		 * Plays a video from the server
		 *
		 * @param	value The URL of the video or media server
		 */
    public function load(value : String) : Void
    {
        _videoDisplay.load(value, _autoStart);
    }
    
    /**
		 * Get the video slider
		 *
		 * @return The video slider inteface
		 */
    
    public function getVideoSlider() : com.chaos.ui.classInterface.IProgressSlider
    {
        return videoSlider;
    }
    
    /**
		 * Get the status label
		 * @return The status label interface
		 */
    
    public function getStatusLabel() : com.chaos.ui.classInterface.ILabel
    {
        return statusLabel;
    }
    
    /**
		 * Get the time label
		 * @return The time label interface
		 */
    public function getTimeLabel() : com.chaos.ui.classInterface.ILabel
    {
        return timeLabel;
    }
    
    /**
		 * Set the sound volume icon
		 *
		 * @param	fileURL The url location
		 */
    
    public function setVolumeIconURL(fileURL : String) : Void
    {
        soundIconDisplayImage.load(fileURL);
    }
    
    /**
		 * Set the volume icon based on bitmap
		 * @param	bitmap The bitmap display object
		 */
    public function setVolumeBitmap(bitmap : Bitmap) : Void
    {
        soundIconDisplayImage.setImage(bitmap);
    }
    
    /**
		 * Set the play icon
		 *
		 * @param	fileURL The url location
		 */
    
    public function setPlayIconURL(fileURL : String) : Void
    {
        playDisplayImage.onImageComplete = function() : Void
                {
                    if (_videoDisplay.isPlaying) 
                        playBtn.setIconBitmap(playDisplayImage.image);
                    
                    pauseDisplayImage.onImageComplete = null;
                };
        
        playDisplayImage.load(fileURL);
    }
    
    /**
		 * Set the play icon based on bitmap
		 * @param	bitmap The bitmap display object
		 */
    public function setPlayBitmap(bitmap : Bitmap) : Void
    {
        playDisplayImage.setImage(bitmap);
        
        if (_videoDisplay.isPlaying) 
            playBtn.setIconBitmap(playDisplayImage.image);
    }
    
    /**
		 * Set the pause icon
		 *
		 * @param	fileURL The url location
		 */
    
    public function setPauseIconURL(fileURL : String) : Void
    {
        pauseDisplayImage.load(fileURL);
        
        pauseDisplayImage.onImageComplete = function() : Void
                {
                    if (!_videoDisplay.isPlaying) 
                        playBtn.setIconBitmap(pauseDisplayImage.image);
                    
                    pauseDisplayImage.onImageComplete = null;
                };
    }
    
    /**
		 * Set the pause icon based on bitmap
		 * @param	bitmap The bitmap display object
		 */
    public function setPauseBitmap(bitmap : Bitmap) : Void
    {
        pauseDisplayImage.setImage(bitmap);
        
        if (!_videoDisplay.isPlaying) 
            playBtn.setIconBitmap(pauseDisplayImage.image);
    }
    
    /**
		 * Set the full screen icon
		 *
		 * @param	fileURL The url location
		 */
    
    public function setFullScreenIconURL(fileURL : String) : Void
    {
        
        fullScreenDisplayImage.load(fileURL);
        
        fullScreenDisplayImage.onImageComplete = function() : Void
                {
                    fullscreenBtn.setIconBitmap(fullScreenDisplayImage.image);
                    fullScreenDisplayImage.onImageComplete = null;
                };
    }
    
    /**
		 * Set the full screen icon based on bitmap
		 * @param	bitmap The bitmap display object
		 */
    public function setFullScreenBitmap(bitmap : Bitmap) : Void
    {
        fullScreenDisplayImage.setImage(bitmap);
        fullscreenBtn.setIconBitmap(bitmap);
    }
    
    /**
		 * @inheritDoc
		 */
    override private function set_Detail(value : String) : String
    {
        super.detail = timeLabel.detail = statusLabel.detail = videoSlider.detail = volumeSlider.detail = fullscreenBtn.detail = fullScreenIcon.detail = playIcon.detail = playBtn.detail = contorlsContainer.detail = volumeBarContainer.detail = infoLabelContainer.detail = value;
        return value;
    }
    
    /**
		 * @inheritDoc
		 */
    override private function get_Detail() : String
    {
        return super.detail;
    }
    
    /**
		 * @inheritDoc
		 */
    
    override public function draw() : Void
    {
        super.draw();
        
        _videoDisplay.x = _videoDisplay.y = 0;
        _videoDisplay.width = width;
        _videoDisplay.height = height;
        
        // Main contorls
        videoSlider.width = (width - playBtn.width - fullscreenBtn.width) - VOLUME_BAR_CONTAINER_WIDTH;
        videoSlider.height = DEFAULT_BUTTON_HEIGHT;
        videoSlider.slider.sliderHeight = DEFAULT_BUTTON_HEIGHT;
        
        contorlsContainer.width = width - VOLUME_BAR_CONTAINER_WIDTH;
        contorlsContainer.height = DEFAULT_BUTTON_HEIGHT;
        contorlsContainer.y = height - contorlsContainer.height;
        
        // Volume slider area
        volumeSlider.width = VOLUME_BAR_CONTAINER_WIDTH - (soundIconDisplayImage.width) - (volumeBarContainer.padding * 2);
        volumeSlider.height = DEFAULT_BUTTON_HEIGHT;
        
        volumeBarContainer.x = contorlsContainer.width;
        volumeBarContainer.y = contorlsContainer.y;
        volumeBarContainer.width = VOLUME_BAR_CONTAINER_WIDTH;
        volumeBarContainer.height = DEFAULT_BUTTON_HEIGHT;
        volumeBarContainer.draw();
        
        // Info Label area
        infoLabelContainer.width = width;
        infoLabelContainer.height = 20;
        infoLabelContainer.y = contorlsContainer.y - contorlsContainer.height;
        
        // Draw click area
        clickArea.graphics.clear();
        clickArea.graphics.beginFill(0, 0);
        clickArea.graphics.drawRect(0, 0, width, height);
    }
    
    /**
		 * Since using ThreadManager there is no need for event return
		 * @private
		 */
    
    private function onSliderUpdate() : Void
    {
        if (_videoDisplay.netStream.bytesLoaded < _videoDisplay.netStream.bytesTotal) 
            videoSlider.percent = (_videoDisplay.netStream.bytesLoaded / _videoDisplay.netStream.bytesTotal) * 100;
        
        if (_videoDisplay.metaData.exists("duration")) 
        {
            var currentTime : String = formatTime(as3hx.Compat.parseInt(_videoDisplay.netStream.time));
            var totalTime : String = formatTime(as3hx.Compat.parseInt(_videoDisplay.metaData.duration));
            
            timeLabel.text = currentTime + "/" + totalTime;
            
            if (currentTime == totalTime) 
                statusLabel.text = "";
        }
        
        videoSlider.slider.percent = as3hx.Compat.parseInt(_videoDisplay.netStream.time) / as3hx.Compat.parseInt(_videoDisplay.metaData.duration);
    }
    
    private function formatTime(t : Int) : String
    {
        // returns the minutes and seconds with leading zeros
        // for example: 70 returns 01:10
        var s : Int = Math.round(t);
        var m : Int = 0;
        if (s > 0) 
        {
            while (s > 59)
            {
                m++;
                s -= 60;
            }
            return Std.string((m < (10) ? "0" : "") + m + ":" + (s < (10) ? "0" : "") + s);
        }
        else 
        {
            return "00:00";
        }
    }
    
    /**
		 * Get icon for color change, this is used for changing the color of icons on button
		 *
		 * @param	displayObj The button or icon
		 * @return The icon that is on the button
		 *
		 * @private
		 */
    
    private function getIcon(displayObj : Dynamic) : IBasicIcon
    {
        // Check to see if it's a button
        if (Std.is(displayObj, com.chaos.ui.classInterface.IButton) && (try cast(displayObj, com.chaos.ui.classInterface.IButton) catch(e:Dynamic) null).getIcon() != null && Std.is((try cast(displayObj, com.chaos.ui.classInterface.IButton) catch(e:Dynamic) null).getIcon(), IBasicIcon)) 
        {
            return try cast((try cast(displayObj, com.chaos.ui.classInterface.IButton) catch(e:Dynamic) null).getIcon(), IBasicIcon) catch(e:Dynamic) null;
        }
        // Or Icon
        else if (Std.is(displayObj, IBasicIcon)) 
        {
            return try cast(displayObj, IBasicIcon) catch(e:Dynamic) null;
        }
        
        return null;
    }
    
    private function onVideoClick(event : MouseEvent) : Void
    {
        if (_playOnClick) 
            onPlayButton(event);
    }
    
    private function onPlayButton(event : MouseEvent) : Void
    {
        
        // Toggle pause
        if (!_videoDisplay.isPlaying) 
        {
            _videoDisplay.play();
            dispatchEvent(new VideoPlayerEvent(VideoPlayerEvent.PLAY));
        }
        else 
        {
            _videoDisplay.pause();
            dispatchEvent(new VideoPlayerEvent(VideoPlayerEvent.PAUSE));
        }
        
        if (playBtn.getIcon().name == "pauseIcon") 
        {
            ThreadManager.removeEventTimer(onSliderUpdate);
            
            if (playDisplayImage.loaded) 
            {
                playBtn.setIconBitmap(playDisplayImage.image);
            }
            else 
            {
                playBtn.setIcon(playIcon.displayObject);
            }
        }
        else 
        {
            ThreadManager.addEventTimer(onSliderUpdate);
            
            if (pauseDisplayImage.loaded) 
            {
                playBtn.setIconBitmap(pauseDisplayImage.image);
            }
            else 
            {
                playBtn.setIcon(pauseIcon.displayObject);
            }
        }
    }
    
    private function netStatusHandler(event : NetStatusEvent) : Void
    {
        
        var _sw0_ = (event.info.code);        

        switch (_sw0_)
        {
            case "NetConnection.Connect.Success":
                
                if (null != _videoDisplay.netStream) 
                    _videoDisplay.netStream.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler, false, 0, true);
            
            case "NetStream.Play.Start":
                playBtn.setIcon(pauseIcon.displayObject);
            
            case "NetStream.Play.Failed", "NetStream.Play.Stop", "NetStream.Pause.Notify", "NetStream.Buffer.Empty":

                switch (_sw0_)
                {case "NetStream.Pause.Notify":
                        playBtn.setIcon(playIcon.displayObject);
                }
                statusLabel.text = "Buffing";
            case "NetStream.Play.Stop", "NetStream.Buffer.Flush", "NetStream.Buffer.Full":
                statusLabel.text = "";
                break;
        }
    }
    
    private function onMetaData(event : DisplayVideoEvent) : Void
    {
        if (null != _videoDisplay.netStream && _useMetaDataSize) 
        {
            if (_videoDisplay.metaData.exists("width")) 
                width = _videoDisplay.metaData.width;
            
            if (_videoDisplay.metaData.exists("height")) 
                height = _videoDisplay.metaData.height;
        }
    }
    
    private function timerHandler(event : TimerEvent) : Void
    {
        contorlsContainer.visible = volumeBarContainer.visible = infoLabelContainer.visible = false;
    }
    
    private function onMouseMove(event : MouseEvent) : Void
    {
        contorlsContainer.visible = volumeBarContainer.visible = true;
        
        if (_showInfoStatus) 
            infoLabelContainer.visible = true;
        
        autoHideTimer.reset();
        autoHideTimer.start();
    }
    
    private function onVolumeSliderChange(event : SliderEvent) : Void
    {
        
        var newVolume : SoundTransform = new SoundTransform(event.percent);
        
        if (null != _videoDisplay.netStream) 
            _videoDisplay.netStream.soundTransform = newVolume;
    }
    
    private function onMarkerMouseDown(event : MouseEvent) : Void
    {
        ThreadManager.removeEventTimer(onSliderUpdate);
    }
    
    private function onMarkerMouseUp(event : MouseEvent) : Void
    {
        if (!_videoDisplay.isPlaying) 
        {
            videoSlider.slider.percent = 0;
            return;
        }
        
        var resumeTime : Float = (((videoSlider.slider.percent * 1) * _videoDisplay.metaData.duration));
        _videoDisplay.netStream.seek(resumeTime);
        
        ThreadManager.addEventTimer(onSliderUpdate);
    }
    
    private function onFullScreenClick(event : MouseEvent) : Void
    {
        if (stage.displayState == StageDisplayState.NORMAL) 
        {
            try
            {
                oldStageAlignment = stage.align;
                
                oldWidth = width;
                oldHeight = height;
                
                oldLocX = x;
                oldLocY = y;
                
                stage.displayState = StageDisplayState.FULL_SCREEN;
            }            catch (e : SecurityError)
            {
                //if you don't complete STEP TWO below, you will get this SecurityError
                Debug.print("[VideoPlayer::onFullScreenClick] Can not switch into fullscreen mode.");
            }
        }
        else 
        {
            stage.displayState = StageDisplayState.NORMAL;
        }
    }
    
    private function onButtonOver(event : MouseEvent) : Void
    {
        var currentIcon : com.chaos.drawing.icon.interface.IBasicIcon = getIcon(event.currentTarget);
        
        if (currentIcon != null) 
            currentIcon.baseColor = currentIcon.borderColor = _iconOverStateColor;
    }
    
    private function onButtonDown(event : MouseEvent) : Void
    {
        var currentIcon : com.chaos.drawing.icon.interface.IBasicIcon = getIcon(event.currentTarget);
        
        if (currentIcon != null) 
            currentIcon.baseColor = currentIcon.borderColor = _iconDownStateColor;
    }
    
    private function onButtonOut(event : MouseEvent) : Void
    {
        var currentIcon : com.chaos.drawing.icon.interface.IBasicIcon = getIcon(event.currentTarget);
        
        if (currentIcon != null) 
            currentIcon.baseColor = currentIcon.borderColor = _iconDefaultStateColor;
    }
    
    private function onFullScreenMode(event : FullScreenEvent) : Void
    {
        fullScreenMode = event.fullScreen;
        
        // Restore old alignment
        if (!event.fullScreen) 
        {
            stage.align = oldStageAlignment;
            
            width = oldWidth;
            height = oldHeight;
            
            x = oldLocX;
            y = oldLocY;
            
            draw();
        }
    }
    
    private function onStageResize(event : Event) : Void
    {
        
        if (fullScreenMode) 
        {
            stage.align = StageAlign.TOP_LEFT;
            
            width = stage.stageWidth;
            height = stage.stageHeight;
            
            x = y = 0;
        }
    }
    
    private function onStageAdd(event : Event) : Void
    {
        
        removeEventListener(Event.ADDED_TO_STAGE, onStageAdd);
        
        // Have to add stage to use for event thread
        ThreadManager.stage = stage;
        
        stage.addEventListener(FullScreenEvent.FULL_SCREEN, onFullScreenMode, false, 0, true);
        stage.addEventListener(Event.RESIZE, onStageResize, false, 0, true);
        
        if (_autoStart) 
            ThreadManager.addEventTimer(onSliderUpdate);
    }
    
    private function onStageRemove(event : Event) : Void
    {
        ThreadManager.removeEventTimer(onSliderUpdate);
        addEventListener(Event.ADDED_TO_STAGE, onStageAdd);
    }
}

