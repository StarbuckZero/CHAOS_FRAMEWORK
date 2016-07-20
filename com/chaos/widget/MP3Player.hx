package com.chaos.widget;


/**
	 * The MP3 Player use the SoundManager class to play, stop, pause and toggle between sound files.
	 *
	 * @author Erick Feiling
	 */

import com.chaos.drawing.icon.ArrowRightIcon;  // Used as PlayIcon  
import com.chaos.drawing.icon.interface.IBasicIcon;
import com.chaos.drawing.icon.PauseIcon;
import com.chaos.drawing.icon.StopIcon;
import com.chaos.drawing.icon.NextIcon;
import com.chaos.drawing.icon.PreviousIcon;
import com.chaos.drawing.icon.SoundIcon;
import com.chaos.drawing.icon.SoundMuteIcon;
import com.chaos.drawing.icon.SoundOnIcon;
import com.chaos.drawing.icon.ShuffleIcon;
import com.chaos.drawing.icon.UnshuffleIcon;
import com.chaos.media.event.SoundStatusEvent;
import com.chaos.media.Interface.ISoundManager;
import com.chaos.media.SoundManager;
import com.chaos.ui.event.SliderEvent;
import com.chaos.utils.CompositeManager;  // Use to turn Sound Icon into Bitmap  
import com.chaos.media.DisplayImage;
import com.chaos.ui.Label;
import com.chaos.ui.Button;
import com.chaos.ui.interface.IBaseUI;
import com.chaos.ui.interface.IProgressSlider;
import com.chaos.ui.layout.ContainerAlignPolicy;
import com.chaos.ui.Slider;
import com.chaos.ui.ScrollBarDirection;
import com.chaos.ui.interface.ILabel;
import com.chaos.ui.interface.ISlider;
import com.chaos.ui.interface.IButton;
import com.chaos.ui.layout.BaseContainer;
import com.chaos.ui.layout.Interface.IBaseContainer;
import com.chaos.ui.layout.VerticalContainer;
import com.chaos.ui.layout.HorizontalContainer;
import com.chaos.ui.layout.FitContainer;
import com.chaos.ui.layout.Interface.IAlignmentContainer;
import com.chaos.utils.Debug;
import com.chaos.utils.ThreadManager;
import com.chaos.ui.ProgressSlider;
import com.chaos.widget.event.MP3PlayerEvent;

import flash.display.Bitmap;
import flash.display.DisplayObject;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.media.ID3Info;
import flash.media.Sound;

class MP3Player extends BaseContainer implements IBaseContainer implements com.chaos.ui.classInterface.IBaseUI
{
    public var labelOffSet(get, set) : Int;
    public var artBoxX(get, set) : Int;
    public var artBoxY(get, set) : Int;
    public var playNextAudio(get, set) : Bool;
    public var delayBeforeDisplay(get, set) : Int;
    public var displayMode(get, set) : Int;
    public var updateArtistLabel(get, set) : Bool;
    public var showArtBox(get, set) : Bool;
    public var artist(get, set) : String;
    public var track(get, set) : String;
    public var album(get, set) : String;
    public var artistText(get, set) : String;
    public var albumText(never, set) : String;
    public var trackText(get, set) : String;
    public var iconDefaultStateColor(get, set) : Int;
    public var iconOverStateColor(get, set) : Int;
    public var iconDownStateColor(get, set) : Int;
    public var soundIconColor(get, set) : Int;
    public var showShuffleButton(get, set) : Bool;
    public var showLabelInfo(get, set) : Bool;
    public var usePrevAndNext(get, set) : Bool;

    
    /**
		 * The prefix being used when looking for tracks
		 */
    
    public static var TRACK_SOUND_MANAGER_PREFIX : String = "Track";
    
    public static var VOLUME_BAR_CONTAINER_WIDTH : Int = 60;
    public static var VOLUME_CONTAINER_OFFSET : Int = 10;
    
    public static var BUTTON_CONTAINER_OFFSET : Int = 50;
    
    private static var DEFAULT_BUTTON_WIDTH : Int = 20;
    private static var DEFAULT_BUTTON_HEIGHT : Int = 20;
    
    private static var DEFAULT_ICON_WIDTH : Int = 8;
    private static var DEFAULT_ICON_HEIGHT : Int = 8;
    
    public var playBtn : com.chaos.ui.classInterface.IButton = new Button();
    public var stopBtn : com.chaos.ui.classInterface.IButton = new Button();
    public var nextBtn : com.chaos.ui.classInterface.IButton = new Button();
    public var prevBtn : com.chaos.ui.classInterface.IButton = new Button();
    public var shuffleBtn : com.chaos.ui.classInterface.IButton = new Button();
    
    public var playIcon : com.chaos.drawing.icon.interface.IBasicIcon;
    public var pauseIcon : com.chaos.drawing.icon.interface.IBasicIcon;
    public var nextIcon : com.chaos.drawing.icon.interface.IBasicIcon;
    public var prevIcon : com.chaos.drawing.icon.interface.IBasicIcon;
    public var stopIcon : com.chaos.drawing.icon.interface.IBasicIcon;
    public var shuffleIcon : com.chaos.drawing.icon.interface.IBasicIcon;
    public var unShuffleIcon : com.chaos.drawing.icon.interface.IBasicIcon;
    
    private var playDisplayImage : DisplayImage = new DisplayImage();
    private var pauseDisplayImage : DisplayImage = new DisplayImage();
    private var nextDisplayImage : DisplayImage = new DisplayImage();
    private var prevDisplayImage : DisplayImage = new DisplayImage();
    private var stopDisplayImage : DisplayImage = new DisplayImage();
    private var shuffleDisplayImage : DisplayImage = new DisplayImage();
    private var unShuffleDisplayImage : DisplayImage = new DisplayImage();
    
    private var _updateArtistLabel : Bool = true;
    private var _usePrevAndNext : Bool = true;
    
    public var fileLoadList : Array<Dynamic> = new Array<Dynamic>();
    public var shuffleList : Array<Dynamic> = new Array<Dynamic>();
    public var shuffleMode : Bool = false;
    
    public var currentAudio : String = "";
    public var trackCount : Int = 0;
    
    private var volumeSlider : com.chaos.ui.classInterface.ISlider = new Slider();
    private var audioSlider : com.chaos.ui.classInterface.IProgressSlider = new ProgressSlider();
    
    private var artBoxShape : Shape = new Shape();
    private var artBoxDisplay : DisplayImage = new DisplayImage();
    private var artistInfoLabel : com.chaos.ui.classInterface.ILabel = new Label();
    
    private var artInfoLabelContainer : com.chaos.ui.layout.classInterface.IAlignmentContainer = new HorizontalContainer();
    private var buttonContainer : com.chaos.ui.layout.classInterface.IAlignmentContainer = new HorizontalContainer();
    private var volumeBarContainer : com.chaos.ui.layout.classInterface.IAlignmentContainer = new HorizontalContainer();
    
    private var soundIconDisplayImage : DisplayImage = new DisplayImage();
    
    private var soundIcon : com.chaos.drawing.icon.interface.IBasicIcon = new SoundIcon(16, 16);
    
    private var _artBoxWidth : Int = 50;
    private var _artBoxHeight : Int = 50;
    
    private var _artBoxX : Int = 10;
    private var _artBoxY : Int = 10;
    
    private var _showArtBox : Bool = false;
    private var _showShuffleButton : Bool = true;
    private var _showLabelInfo : Bool = true;
    
    private var _displayMode : Int = 0;  // For different modes  
    
    private var _timeLeftText : String = "Time Left:";
    private var _currentTimeText : String = "Time:";
    
    private var _showTime : Bool = false;
    
    private var _artistText : String = "Arist:";
    private var _albumText : String = "Album:";
    private var _trackText : String = "Song:";
    
    private var _artist : String = "";
    private var _track : String = "";
    private var _album : String = "";
    
    private var _artistOrder : Int = 1;
    private var _albumOrder : Int = 0;
    private var _trackOrder : Int = 2;
    
    private var _toggleDisplayOnClick : Bool = true;
    
    private var _labelOrderList : Array<Dynamic> = new Array<Dynamic>();
    private var _useLineBreak : Bool = true;
    
    private var _iconDefaultStateColor : Int = 0xFFFFFF;
    private var _iconOverStateColor : Int = 0x666666;
    private var _iconDownStateColor : Int = 0x999999;
    
    private var _soundIconColor : Int = 0x999999;
    
    private var _useSoundFileInfo : Bool = true;
    
    private var _playNextAudio : Bool = true;
    
    private var _delayBeforeDisplay : Int = 2;
    
    private var _soundManager : ISoundManager = new SoundManager();
    private var _currentIndex : Int = 0;
    
    private var _labelOffSet : Int = 20;
    
    /**
		 * Creates an MP3 Player
		 * @param	objWidth Set the default width
		 * @param	objHeight Set the default height
		 */
    
    public function new(objWidth : Int = 300, objHeight : Int = 100)
    {
        super();
        
        width = objWidth;
        height = objHeight;
        
        init();
        
        draw();
        
        addEventListener(Event.ADDED_TO_STAGE, onStageAdd, false, 0, true);
        addEventListener(Event.REMOVED_FROM_STAGE, onStageRemove, false, 0, true);
    }
    
    private function init() : Void
    {
        
        // Setup Art Box Image area
        artBoxDisplay.addEventListener(Event.COMPLETE, onArtImageComplete, false, 0, true);
        
        var slider : Slider = try cast(audioSlider.slider, Slider) catch(e:Dynamic) null;
        slider.marker.addEventListener(MouseEvent.MOUSE_DOWN, onMarkerMouseDown, false, 0, true);
        slider.marker.addEventListener(MouseEvent.MOUSE_UP, onMarkerMouseUp, false, 0, true);
        
        // Setup volume slider
        volumeSlider.showTrack = true;
        volumeSlider.percent = 1;
        volumeSlider.addEventListener(SliderEvent.CHANGE, onVolumeSliderChange, false, 0, true);
        
        // Audio Slider setup
        //audioSlider.slider.addEventListener(SliderEvent.CHANGE, onAudioSliderChange, false, 0, true);
        
        // Set the width of the buttons
        playBtn.width = stopBtn.width = nextBtn.width = prevBtn.width = shuffleBtn.width = DEFAULT_BUTTON_WIDTH;
        playBtn.height = stopBtn.height = nextBtn.height = prevBtn.height = shuffleBtn.height = DEFAULT_BUTTON_HEIGHT;
        
        playBtn.showLabel = stopBtn.showLabel = prevBtn.showLabel = shuffleBtn.showLabel = nextBtn.showLabel = false;
        playBtn.iconDisplay = stopBtn.iconDisplay = prevBtn.iconDisplay = shuffleBtn.iconDisplay = nextBtn.iconDisplay = true;
        
        shuffleBtn.imageOffSetX = 10;
        
        // Setup icons for buttons
        prevIcon = new PreviousIcon(DEFAULT_ICON_WIDTH, DEFAULT_ICON_HEIGHT);
        playIcon = new ArrowRightIcon(DEFAULT_ICON_WIDTH, DEFAULT_ICON_HEIGHT);
        stopIcon = new StopIcon(DEFAULT_ICON_WIDTH, DEFAULT_ICON_HEIGHT);
        nextIcon = new NextIcon(DEFAULT_ICON_WIDTH, DEFAULT_ICON_HEIGHT);
        
        shuffleIcon = new ShuffleIcon(DEFAULT_ICON_WIDTH, DEFAULT_ICON_HEIGHT);
        unShuffleIcon = new UnshuffleIcon(DEFAULT_ICON_WIDTH, DEFAULT_ICON_HEIGHT);
        pauseIcon = new PauseIcon(DEFAULT_ICON_WIDTH >> 1, DEFAULT_ICON_HEIGHT);
        
        soundIcon.baseColor = 0x999999;
        
        // Turn default icons filters off
        pauseIcon.filterMode = prevIcon.filterMode = playIcon.filterMode = stopIcon.filterMode = nextIcon.filterMode = unShuffleIcon.filterMode = shuffleIcon.filterMode = soundIcon.filterMode = false;
        
        // Add in icons
        prevBtn.setIcon(prevIcon.displayObject);
        playBtn.setIcon(playIcon.displayObject);
        stopBtn.setIcon(stopIcon.displayObject);
        nextBtn.setIcon(nextIcon.displayObject);
        shuffleBtn.setIcon(unShuffleIcon.displayObject);
        
        prevIcon.name = "prevIcon";
        playIcon.name = "playIcon";
        stopIcon.name = "stopIcon";
        nextIcon.name = "nextIcon";
        pauseIcon.name = "pauseIcon";
        shuffleIcon.name = "shuffleIcon";
        unShuffleIcon.name = "unShuffleIcon";
        
        prevBtn.name = "prevBtn";
        playBtn.name = "playBtn";
        stopBtn.name = "stopBtn";
        nextBtn.name = "nextBtn";
        shuffleBtn.name = "shuffleBtn";
        
        // Over State
        prevIcon.addEventListener(MouseEvent.MOUSE_OVER, onButtonOver, false, 0, true);
        playIcon.addEventListener(MouseEvent.MOUSE_OVER, onButtonOver, false, 0, true);
        pauseIcon.addEventListener(MouseEvent.MOUSE_OVER, onButtonOver, false, 0, true);
        stopIcon.addEventListener(MouseEvent.MOUSE_OVER, onButtonOver, false, 0, true);
        nextIcon.addEventListener(MouseEvent.MOUSE_OVER, onButtonOver, false, 0, true);
        shuffleIcon.addEventListener(MouseEvent.MOUSE_OVER, onButtonOver, false, 0, true);
        
        prevBtn.addEventListener(MouseEvent.MOUSE_OVER, onButtonOver, false, 0, true);
        playBtn.addEventListener(MouseEvent.MOUSE_OVER, onButtonOver, false, 0, true);
        stopBtn.addEventListener(MouseEvent.MOUSE_OVER, onButtonOver, false, 0, true);
        nextBtn.addEventListener(MouseEvent.MOUSE_OVER, onButtonOver, false, 0, true);
        shuffleBtn.addEventListener(MouseEvent.MOUSE_OVER, onButtonOver, false, 0, true);
        
        // Down State
        prevIcon.addEventListener(MouseEvent.MOUSE_DOWN, onButtonDown, false, 0, true);
        playIcon.addEventListener(MouseEvent.MOUSE_DOWN, onButtonDown, false, 0, true);
        pauseIcon.addEventListener(MouseEvent.MOUSE_DOWN, onButtonDown, false, 0, true);
        stopIcon.addEventListener(MouseEvent.MOUSE_DOWN, onButtonDown, false, 0, true);
        nextIcon.addEventListener(MouseEvent.MOUSE_DOWN, onButtonDown, false, 0, true);
        shuffleIcon.addEventListener(MouseEvent.MOUSE_DOWN, onButtonDown, false, 0, true);
        
        prevBtn.addEventListener(MouseEvent.MOUSE_DOWN, onButtonDown, false, 0, true);
        playBtn.addEventListener(MouseEvent.MOUSE_DOWN, onButtonDown, false, 0, true);
        pauseIcon.addEventListener(MouseEvent.MOUSE_DOWN, onButtonDown, false, 0, true);
        stopBtn.addEventListener(MouseEvent.MOUSE_DOWN, onButtonDown, false, 0, true);
        nextBtn.addEventListener(MouseEvent.MOUSE_DOWN, onButtonDown, false, 0, true);
        shuffleBtn.addEventListener(MouseEvent.MOUSE_DOWN, onButtonDown, false, 0, true);
        
        // Default State
        prevBtn.addEventListener(MouseEvent.MOUSE_OUT, onButtonOut, false, 0, true);
        playBtn.addEventListener(MouseEvent.MOUSE_OUT, onButtonOut, false, 0, true);
        stopBtn.addEventListener(MouseEvent.MOUSE_OUT, onButtonOut, false, 0, true);
        nextBtn.addEventListener(MouseEvent.MOUSE_OUT, onButtonOut, false, 0, true);
        shuffleBtn.addEventListener(MouseEvent.MOUSE_OUT, onButtonOut, false, 0, true);
        
        // Set SoundManager hooks
        prevBtn.addEventListener(MouseEvent.CLICK, onPrevButton, false, 0, true);
        playBtn.addEventListener(MouseEvent.CLICK, onPlayButton, false, 0, true);
        stopBtn.addEventListener(MouseEvent.CLICK, onStopButton, false, 0, true);
        nextBtn.addEventListener(MouseEvent.CLICK, onNextButton, false, 0, true);
        
        // Add in hook for shuffle mode
        shuffleBtn.addEventListener(MouseEvent.CLICK, onShuffleButton, false, 0, true);
        
        // Setup sound manager
        _soundManager.addEventListener(SoundStatusEvent.SOUND_ID3, onSoundID3, false, 0, true);
        
        // Button layout area
        buttonContainer.padding = 5;
        
        // Based on the mode show buttons
        if (_usePrevAndNext) 
        {
            addPrevAndNextButton();
        }
        else 
        {
            removePrevAndNextButton();
        }  // Setup label default  
        
        
        
        artistInfoLabel.background = true;
        artistInfoLabel.backgroundColor = 0x000000;
        artistInfoLabel.textColor = 0xFFFFFF;
        artistInfoLabel.align = "left";
        
        // Here is the label
        artInfoLabelContainer.align = ContainerAlignPolicy.TOP;
        artInfoLabelContainer.addElement(artistInfoLabel);
        artInfoLabelContainer.addEventListener(MouseEvent.CLICK, onArtLabelClick, false, 0, true);
        
        volumeSlider.direction = ScrollBarDirection.HORIZONTAL;
        
        soundIconDisplayImage.setImage(CompositeManager.displayObjectToBitmap(soundIcon.displayObject, imageSmoothing));
        
        volumeBarContainer.addElement(soundIconDisplayImage);
        volumeBarContainer.addElement(volumeSlider);
        
        // Set background color for
        backgroundColor = 0xFFFFFF;
        
        // Turn off backgrounds
        artInfoLabelContainer.background = buttonContainer.background = volumeBarContainer.background = false;
        
        // Add objects to display
        contentObject.addChild(artInfoLabelContainer.displayObject);
        contentObject.addChild(volumeBarContainer.displayObject);
        contentObject.addChild(buttonContainer.displayObject);
        contentObject.addChild(artBoxShape);
        
        // Set the order of the label items
        _labelOrderList[_albumOrder] = _albumText + " " + _album + "\r";
        _labelOrderList[_artistOrder] = _artistText + " " + _artist + "\r";
        _labelOrderList[_trackOrder] = _trackText + " " + _track;
    }
    
    /**
		 * The offset of the label
		 */
    private function set_LabelOffSet(value : Int) : Int
    {
        _labelOffSet = value;
        return value;
    }
    
    /**
		 * Return the offset value
		 */
    
    private function get_LabelOffSet() : Int
    {
        return _labelOffSet;
    }
    
    /**
		 * Set the location of the art box on the x axis
		 */
    private function set_ArtBoxX(value : Int) : Int
    {
        _artBoxX = value;
        return value;
    }
    
    /**
		 * Return the location of art box x
		 */
    
    private function get_ArtBoxX() : Int
    {
        return _artBoxX;
    }
    
    /**
		 * Set the location of the art box on the y axis
		 */
    private function set_ArtBoxY(value : Int) : Int
    {
        _artBoxY = value;
        return value;
    }
    
    /**
		 * Return the location of art box y
		 */
    
    private function get_ArtBoxY() : Int
    {
        return _artBoxY;
    }
    
    /**
		 * If true the next audio file in the list will play
		 */
    
    private function set_PlayNextAudio(value : Bool) : Bool
    {
        _playNextAudio = value;
        return value;
    }
    
    /**
		 * Return true if the next audio will play and false if not
		 */
    private function get_PlayNextAudio() : Bool
    {
        return _playNextAudio;
    }
    
    /**
		 * These will show the audio file information before switching mode display mode
		 */
    
    private function set_DelayBeforeDisplay(value : Int) : Int
    {
        _delayBeforeDisplay = value;
        return value;
    }
    
    /**
		 * Return the amount of time in seconds the audio information will be displayed
		 */
    
    private function get_DelayBeforeDisplay() : Int
    {
        return _delayBeforeDisplay;
    }
    
    /**
		 * Set the different display modes
		 */
    
    private function set_DisplayMode(value : Int) : Int
    {
        _displayMode = value;
        
        if (_displayMode == 0 && currentAudio != "") 
            updateArtistLabelInfo(_soundManager.getSoundObj(currentAudio).id3);
        return value;
    }
    
    /**
		 * Return the label mode.
		 * 0 - Audio Info
		 * 1 - Current Time
		 * 2 - Time Left
		 */
    
    private function get_DisplayMode() : Int
    {
        return _displayMode;
    }
    
    /**
		 * Update the artist text label
		 */
    
    private function set_UpdateArtistLabel(value : Bool) : Bool
    {
        _updateArtistLabel = value;
        return value;
    }
    
    /**
		 * Return true if artist label
		 */
    
    private function get_UpdateArtistLabel() : Bool
    {
        return _updateArtistLabel;
    }
    
    /**
		 * Show image area
		 */
    private function set_ShowArtBox(value : Bool) : Bool
    {
        _showArtBox = value;
        draw();
        return value;
    }
    
    /**
		 * If true the image art box will be show and false
		 */
    
    private function get_ShowArtBox() : Bool
    {
        return _showArtBox;
    }
    
    /**
		 * Set the artist name
		 */
    private function set_Artist(value : String) : String
    {
        _artist = value;
        draw();
        return value;
    }
    
    /**
		 * Return the artist name
		 */
    
    private function get_Artist() : String
    {
        return _artist;
    }
    
    /**
		 * Set the track name
		 */
    private function set_Track(value : String) : String
    {
        _track = value;
        draw();
        return value;
    }
    
    /**
		 * Return the track name
		 */
    
    private function get_Track() : String
    {
        return _track;
    }
    
    /**
		 * Set the album name
		 */
    
    private function set_Album(value : String) : String
    {
        _album = value;
        draw();
        return value;
    }
    
    /**
		 * Return the album name
		 */
    private function get_Album() : String
    {
        return _album;
    }
    
    /**
		 * Set the text that will be used before the artist name
		 */
    
    private function set_ArtistText(value : String) : String
    {
        _artistText = value;
        draw();
        return value;
    }
    
    /**
		 * Return the text being used before the artist name
		 */
    
    private function get_ArtistText() : String
    {
        return _artistText;
    }
    
    /**
		 * Set the text that will be used before the album name
		 */
    
    private function set_AlbumText(value : String) : String
    {
        _albumText = value;
        draw();
        return value;
    }
    
    /**
		 * Set the text that will be used before the track name
		 */
    
    private function set_TrackText(value : String) : String
    {
        _trackText = value;
        return value;
    }
    
    /**
		 * Return the text being used before the track name
		 */
    
    private function get_TrackText() : String
    {
        return _trackText;
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
		 * If you want to show the shuffle button
		 */
    
    private function set_ShowShuffleButton(value : Bool) : Bool
    {
        _showShuffleButton = value;
        draw();
        return value;
    }
    
    /**
		 * Return true if the shuffle button is being displayed and false if not
		 */
    
    private function get_ShowShuffleButton() : Bool
    {
        return _showShuffleButton;
    }
    
    /**
		 * Hide or show the label
		 */
    
    private function set_ShowLabelInfo(value : Bool) : Bool
    {
        _showLabelInfo = value;
        draw();
        return value;
    }
    
    /**
		 * Return the true the label is being used and false
		 */
    private function get_ShowLabelInfo() : Bool
    {
        return _showLabelInfo;
    }
    
    /**
		 * Hide or show the next and previous button
		 */
    
    private function set_UsePrevAndNext(value : Bool) : Bool
    {
        _usePrevAndNext = value;
        
        if (_usePrevAndNext) 
        {
            addPrevAndNextButton();
        }
        else 
        {
            removePrevAndNextButton();
        }
        return value;
    }
    
    /**
		 * Return true if the next and previous buttons are being displayed and false if not
		 */
    
    private function get_UsePrevAndNext() : Bool
    {
        return _usePrevAndNext;
    }
    
    /**
		 * Get the label being used
		 *
		 * @return Return a label interface
		 */
    
    public function getLabel() : com.chaos.ui.classInterface.ILabel
    {
        return artistInfoLabel;
    }
    
    /**
		 * Get the audio slider
		 *
		 * @return A progress slider interface
		 */
    public function getAudioSlider() : com.chaos.ui.classInterface.IProgressSlider
    {
        return audioSlider;
    }
    
    /**
		 * Get the volume loader being used
		 *
		 * @return A volume slider interface
		 */
    
    public function getVolumeSlider() : com.chaos.ui.classInterface.ISlider
    {
        return volumeSlider;
    }
    
    /**
		 * Set the volume icon
		 *
		 * @param	value The location of the icon
		 */
    public function setVolumeIconURL(value : String) : Void
    {
        soundIconDisplayImage.onImageComplete = function() : Void
                {
                    draw();
                    soundIconDisplayImage.onImageComplete = null;
                };
        
        soundIconDisplayImage.load(value);
    }
    
    /**
		 * Set the volume icon using a bitmap
		 *
		 * @param	value The bitmap that will be used
		 */
    public function setVolumeIconBitmap(value : Bitmap) : Void
    {
        soundIconDisplayImage.setImage(value);
    }
    
    /**
		 * Get one of the button
		 *
		 * @param	btnName The name of the button which is prev, play, pause, stop, next and shuffle
		 * @return A button interface of the button requested
		 */
    
    public function getButton(btnName : String) : com.chaos.ui.classInterface.IButton
    {
        switch (btnName)
        {
            case "prev":
                return prevBtn;
            case "play", "pause":
                return playBtn;
            
            case "stop":
                return stopBtn;
            
            case "next":
                return nextBtn;
            
            case "shuffle":
                return shuffleBtn;
            
            default:
                Debug.print("[MP3Player::getButton] Couldn't find " + btnName + ", returning null! You must pass play, stop, pause, prev, next or shuffle.");
        }
        
        return null;
    }
    
    /**
		 * Set an image being used
		 *
		 * @param	value The path to the image
		 */
    public function setBoxArtURL(value : String) : Void
    {
        artBoxDisplay.load(value);
    }
    
    /**
		 * Set the box art using a bitmap
		 * @param	value The bitmap that you want to be using
		 */
    
    public function setBoxArtBitmap(value : Bitmap) : Void
    {
        artBoxDisplay.setImage(value);
        _showArtBox = true;
        draw();
    }
    
    /**
		 * Set the order of the audio information
		 *
		 * @param	albumOrder A number from 0-1
		 * @param	artistOrder A number from 0-1
		 * @param	trackOrder A number from 0-1
		 */
    public function setLabelInfoTextOrder(albumOrder : Int, artistOrder : Int, trackOrder : Int) : Void
    {
        if (albumOrder > 2 || artistOrder > 2 || trackOrder > 2) 
        {
            Debug.print("[MP3Player::setLabelInfoTextOrder] The order can only be from 0 - 2");
            return;
        }
        
        _albumOrder = albumOrder;
        _artistOrder = artistOrder;
        _trackOrder = trackOrder;
        
        draw();
    }
    
    /**
		 * Get the sound manager
		 *
		 * @return The sound mangager interface
		 */
    
    public function getSoundManager() : ISoundManager
    {
        return _soundManager;
    }
    
    /**
		 * Set the sound manager, all the files must be named "Track" at the start follow by number
		 *
		 * @param	value A sound manager
		 */
    public function setSoundManger(value : ISoundManager) : Void
    {
        _soundManager = value;
    }
    
    /**
		 * Load an audio file
		 *
		 * @param	fileLocation The location of the audio file
		 */
    
    public function loadFile(fileLocation : String) : Void
    {
        trackCount++;
        _soundManager.load(TRACK_SOUND_MANAGER_PREFIX + trackCount, fileLocation);
    }
    
    /**
		 * Remove all sounds from play list
		 */
    public function clearPlayList() : Void
    {
        var soundList : Array<Dynamic> = _soundManager.getList();
        
        for (i in 0...soundList.length){_soundManager.removeSound(soundList[i]);
        }
        
        trackCount = 0;
    }
    
    /**
		 * Load play icon file URL
		 * @param	fileURL The path to the image being used
		 */
    
    public function setPlayURL(fileURL : String) : Void
    {
        playDisplayImage.onImageComplete = function() : Void
                {
                    
                    // If it is playing then just update icon
                    if (trackCount > 0 && _soundManager.getStatus(currentAudio).playing) 
                        playBtn.setIcon(playDisplayImage);
                    
                    playDisplayImage.onImageComplete = null;
                };
        
        playDisplayImage.load(fileURL);
    }
    
    /**
		 * Set play icon from bitmap
		 * @param	bitmap A bitmap displayobject
		 */
    
    public function setPlayBitmap(bitmap : Bitmap) : Void
    {
        playDisplayImage.setImage(bitmap);
        
        // If it is playing then just update icon
        if (trackCount > 0 && _soundManager.getStatus(currentAudio).playing) 
            playBtn.setIconBitmap(bitmap);
    }
    
    /**
		 * Load pause icon file URL
		 * @param	fileURL The path to the image being used
		 */
    
    public function setPauseURL(fileURL : String) : Void
    {
        
        pauseDisplayImage.onImageComplete = function() : Void
                {
                    // If it is playing then just update icon
                    if (trackCount > 0 && !_soundManager.getStatus(currentAudio).playing) 
                        playBtn.setIcon(pauseDisplayImage.image);
                    
                    pauseDisplayImage.onImageComplete = null;
                };
        
        pauseDisplayImage.load(fileURL);
    }
    
    /**
		 * Set pause icon from bitmap
		 * @param	bitmap A bitmap displayobject
		 */
    
    public function setPauseBitmap(bitmap : Bitmap) : Void
    {
        
        pauseDisplayImage.setImage(bitmap);
        
        // If it is playing then just update icon
        if (trackCount > 0 && !_soundManager.getStatus(currentAudio).playing) 
            playBtn.setIconBitmap(bitmap);
    }
    
    /**
		 * Load stop icon file from URL
		 * @param	fileURL The path to the image being used
		 */
    
    public function setStopURL(fileURL : String) : Void
    {
        stopDisplayImage.onImageComplete = function() : Void
                {
                    stopBtn.setIconBitmap(stopDisplayImage.image);
                    stopDisplayImage.onImageComplete = null;
                };
        
        stopDisplayImage.load(fileURL);
    }
    
    /**
		 * Set stop icon from bitmap
		 * @param	bitmap A bitmap DisplayObject
		 */
    
    public function setStopBitmap(bitmap : Bitmap) : Void
    {
        stopDisplayImage.setImage(bitmap);
        stopBtn.setIconBitmap(bitmap);
    }
    
    /**
		 * Load next icon from file URL
		 * @param	fileURL The path to the image being used
		 */
    
    public function setNextURL(fileURL : String) : Void
    {
        nextDisplayImage.onImageComplete = function() : Void
                {
                    nextBtn.setIconBitmap(nextDisplayImage.image);
                    nextDisplayImage.onImageComplete = null;
                };
        
        nextDisplayImage.load(fileURL);
    }
    
    /**
		 * Set next icon from bitmap
		 * @param	bitmap A bitmap DisplayObject
		 */
    
    public function setNextBitmap(bitmap : Bitmap) : Void
    {
        nextBtn.setIconBitmap(bitmap);
    }
    
    /**
		 * Load Shuffle icon from file URL
		 * @param	fileURL The path to the image being used
		 */
    
    public function setShuffleURL(fileURL : String) : Void
    {
        shuffleDisplayImage.onImageComplete = function() : Void
                {
                    if (shuffleMode) 
                        shuffleBtn.setIconBitmap(shuffleDisplayImage.image);
                    
                    shuffleDisplayImage.onImageComplete = null;
                };
        
        shuffleDisplayImage.load(fileURL);
    }
    
    /**
		 * Set Shuffle icon from bitmap
		 * @param	bitmap A bitmap DisplayObject
		 */
    
    public function setShuffleBitmap(bitmap : Bitmap) : Void
    {
        
        shuffleDisplayImage.setImage(bitmap);
        
        if (shuffleMode) 
            shuffleBtn.setIconBitmap(bitmap);
    }
    
    /**
		 * Load Unshuffle icon from file URL
		 * @param	fileURL The path to the image being used
		 */
    
    public function setUnshuffleURL(fileURL : String) : Void
    {
        unShuffleDisplayImage.onImageComplete = function() : Void
                {
                    if (!shuffleMode) 
                        shuffleBtn.setIconBitmap(unShuffleDisplayImage.image);
                    
                    unShuffleDisplayImage.onImageComplete = null;
                };
        
        unShuffleDisplayImage.load(fileURL);
    }
    
    /**
		 * Set next Unshuffle from bitmap
		 * @param	bitmap A bitmap DisplayObject
		 */
    
    public function setUnshuffleBitmap(bitmap : Bitmap) : Void
    {
        
        unShuffleDisplayImage.setImage(bitmap);
        
        if (!shuffleMode) 
            shuffleBtn.setIconBitmap(bitmap);
    }
    
    /**
		 * Load prev icon from file URL
		 * @param	fileURL The path to the image being used
		 */
    
    public function setPrevURL(fileURL : String) : Void
    {
        
        prevDisplayImage.onImageComplete = function() : Void
                {
                    prevBtn.setIconBitmap(prevDisplayImage.image);
                    prevDisplayImage.onImageComplete = null;
                };
        
        prevDisplayImage.load(fileURL);
    }
    
    /**
		 * Set prev icon from bitmap
		 * @param	bitmap A bitmap DisplayObject
		 */
    
    public function setPrevBitmap(bitmap : Bitmap) : Void
    {
        prevBtn.setIconBitmap(bitmap);
    }
    
    /**
		 * @inheritDoc
		 */
    
    override private function set_Detail(value : String) : String
    {
        unShuffleIcon.detail = shuffleIcon.detail = stopIcon.detail = prevIcon.detail = nextIcon.detail = pauseIcon.detail = playIcon.detail = value;
        volumeSlider.detail = volumeBarContainer.detail = shuffleBtn.detail = nextBtn.detail = audioSlider.detail = stopBtn.detail = playBtn.detail = prevBtn.detail = buttonContainer.detail = super.detail = value;
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
        
        // If there is art loaded for MP3 then show the art box
        if (_showArtBox) 
        {
            if (artBoxDisplay.image != null) 
            {
                artBoxShape.graphics.clear();
                artBoxShape.graphics.beginBitmapFill(artBoxDisplay.image.bitmapData, null, false, true);
                artBoxShape.graphics.drawRect(0, 0, _artBoxWidth, _artBoxHeight);
                artBoxShape.graphics.endFill();
                
                artBoxShape.x = _artBoxX;
                artBoxShape.y = _artBoxY;
                
                artistInfoLabel.width = width - _labelOffSet - _artBoxWidth - _artBoxX;
                artInfoLabelContainer.width = width;
                
                artInfoLabelContainer.x = artBoxShape.x + _artBoxWidth;
            }
            else 
            {
                artBoxShape.graphics.clear();
                
                artistInfoLabel.width = width - _labelOffSet - _artBoxWidth - _artBoxX;
                artInfoLabelContainer.width = width;
                
                artInfoLabelContainer.x = artBoxShape.x + _artBoxWidth;
            }
        }
        else 
        {
            artInfoLabelContainer.padding = 10;
            artInfoLabelContainer.width = width;
            
            artistInfoLabel.width = width - _labelOffSet;
            artistInfoLabel.height = artInfoLabelContainer.height >> 1;
        }
        
        shuffleBtn.visible = _showShuffleButton;
        
        artInfoLabelContainer.height = height - _labelOffSet;
        artInfoLabelContainer.visible = _showLabelInfo;
        
        // Set the size of the slider
        audioSlider.width = (width >> 1) - _labelOffSet;
        audioSlider.height = DEFAULT_BUTTON_HEIGHT;
        audioSlider.slider.sliderHeight = DEFAULT_BUTTON_HEIGHT;
        
        // Set the size of the over all button area
        buttonContainer.align = ContainerAlignPolicy.BOTTOM;
        buttonContainer.y = height - buttonContainer.height;
        buttonContainer.width = width - BUTTON_CONTAINER_OFFSET;
        buttonContainer.height = DEFAULT_BUTTON_HEIGHT + buttonContainer.padding;
        
        // Set the area and location of volume contorls
        volumeBarContainer.width = VOLUME_BAR_CONTAINER_WIDTH;
        volumeBarContainer.height = DEFAULT_BUTTON_HEIGHT;
        
        volumeBarContainer.x = width - volumeBarContainer.width - VOLUME_CONTAINER_OFFSET;
        volumeBarContainer.y = buttonContainer.y;
        
        volumeSlider.width = VOLUME_BAR_CONTAINER_WIDTH - soundIcon.width;
        
        // Update Art label
        if (_updateArtistLabel && _displayMode == 0) 
            updateArtistLabelInfo();
    }
    
    private function onPrevButton(event : MouseEvent = null) : Void
    {
        
        if (_soundManager.getList().length == 0) 
            return  // If already 0 than do nothing  ;
        
        
        
        if (_currentIndex <= 0) 
        {
            _currentIndex = 0;
            return;
        }
        else 
        {
            
            // If not set then set it
            if (currentAudio == "") 
                currentAudio = getTrackName(_currentIndex)  // Stop old  ;
            
            
            
            _soundManager.stopSound(currentAudio);
            _currentIndex--;
            
            currentAudio = getTrackName(_currentIndex);
            
            // Play new
            _soundManager.playSound(currentAudio);
            audioSlider.watchObject(_soundManager.getSoundObj(currentAudio));
        }  // Update label  
        
        
        
        if (_useSoundFileInfo) 
            updateArtistLabelInfo(_soundManager.getSoundObj(currentAudio).id3)  // Update volume  ;
        
        
        
        _soundManager.setVolume(currentAudio, volumeSlider.percent * 100);
        
        dispatchEvent(new MP3PlayerEvent(MP3PlayerEvent.TRACK_CHANGE));
    }
    
    private function onVolumeSliderChange(event : SliderEvent) : Void
    {
        if (_soundManager.getList().length == 0) 
            return  // Change volume of current playing soon.  ;
        
        
        
        _soundManager.setVolume(getTrackName(_currentIndex), event.percent * 100);
    }
    
    // NOTE: Not really being used
    /*
		   private function onAudioSliderChange( event:SliderEvent ):void
		   {
		   var currentAudio:String = getTrackName(_currentIndex);
		   }
		 */
    
    private function onPlayButton(event : MouseEvent = null) : Void
    {
        if (_soundManager.getList().length == 0) 
            return  // If not set then set it  ;
        
        
        
        if (currentAudio == "") 
            currentAudio = getTrackName(_currentIndex);
        
        if (!_soundManager.getStatus(currentAudio).playing) 
        {
            _soundManager.playSound(currentAudio);
            
            if (pauseDisplayImage.loaded) 
            {
                playBtn.setIcon(pauseDisplayImage);
            }
            else 
            {
                playBtn.setIcon(pauseIcon.displayObject);
            }  // Start Timer  
            
            
            
            ThreadManager.addEventTimer(onSliderUpdate);
            
            dispatchEvent(new MP3PlayerEvent(MP3PlayerEvent.PLAY));
        }
        else 
        {
            _soundManager.pauseSound(currentAudio);
            
            if (playDisplayImage.loaded) 
            {
                playBtn.setIcon(playDisplayImage);
            }
            else 
            {
                playBtn.setIcon(playIcon.displayObject);
            }  // Stop Timer  
            
            
            
            ThreadManager.removeEventTimer(onSliderUpdate);
            dispatchEvent(new MP3PlayerEvent(MP3PlayerEvent.PAUSE));
        }
        
        audioSlider.watchObject(_soundManager.getSoundObj(currentAudio));
        audioSlider.percent = _soundManager.getPercent(currentAudio);
    }
    
    private function onStopButton(event : MouseEvent = null) : Void
    {
        if (_soundManager.getList().length == 0) 
            return  // If no audio is set then what's the point  ;
        
        
        
        if (currentAudio == "") 
            return  // Switch back to play icon  ;
        
        
        
        if (_soundManager.getStatus(currentAudio).playing) 
            playBtn.setIcon(playIcon.displayObject);
        
        _soundManager.stopSound(currentAudio);
        
        // Stop timer
        ThreadManager.removeEventTimer(onSliderUpdate);
        audioSlider.watchObject(_soundManager.getSoundObj(currentAudio));
        
        dispatchEvent(new MP3PlayerEvent(MP3PlayerEvent.STOP));
    }
    
    private function onNextButton(event : MouseEvent = null) : Void
    {
        if (_soundManager.getList().length == 0) 
            return  // If greater or equal to current lenth of list then do nothing  ;
        
        
        
        if (_currentIndex == _soundManager.getList().length - 1) 
            return  // If not set then set it  ;
        
        
        
        if (currentAudio == "") 
            currentAudio = getTrackName(_currentIndex);
        
        _soundManager.stopSound(currentAudio);  // Stop old  
        _currentIndex++;
        
        currentAudio = getTrackName(_currentIndex);
        
        _soundManager.playSound(currentAudio);  // Play new  
        audioSlider.watchObject(_soundManager.getSoundObj(currentAudio));
        
        if (_useSoundFileInfo) 
            updateArtistLabelInfo(_soundManager.getSoundObj(currentAudio).id3)  // Update volume  ;
        
        
        
        _soundManager.setVolume(currentAudio, volumeSlider.percent * 100);
        
        dispatchEvent(new MP3PlayerEvent(MP3PlayerEvent.TRACK_CHANGE));
    }
    
    private function onShuffleButton(event : Event) : Void
    {
        if (_soundManager.getList().length == 0) 
            return  // If not set then set it  ;
        
        
        
        currentAudio = getTrackName(_currentIndex);
        
        var shuffleAudio : String;
        
        // Toggle shuffle mode
        shuffleMode = !shuffleMode;
        
        if (shuffleMode) 
        {
            updateShuffleList();
            shuffleBtn.setIcon(shuffleIcon.displayObject);
        }
        else 
        {
            shuffleBtn.setIcon(unShuffleIcon.displayObject);
        }  // Check to see if audio is playing and if it's not update list  
        
        
        
        if (!_soundManager.getStatus(currentAudio).playing) 
            updateArtistLabelInfo(_soundManager.getSoundObj(getTrackName(_currentIndex)).id3);
    }
    
    private function updateArtistLabelInfo(id3 : ID3Info = null) : Void
    {
        
        if (null != id3) 
        {
            _album = ((null != id3.album && id3.album != "")) ? id3.album : "";
            _track = ((null != id3.songName && id3.songName != "")) ? id3.songName : "";
            _artist = ((null != id3.artist && id3.artist != "")) ? id3.artist : "";
        }  // Set the order of the label items  
        
        
        
        _labelOrderList[_albumOrder] = _albumText + " " + _album;
        _labelOrderList[_artistOrder] = _artistText + " " + _artist;
        _labelOrderList[_trackOrder] = _trackText + " " + _track;
        
        artistInfoLabel.text = "";
        artistInfoLabel.align = "left";
        
        for (labelCount in 0..._labelOrderList.length){
            artistInfoLabel.text += _labelOrderList[labelCount];
            
            if (_useLineBreak && labelCount < _labelOrderList.length) 
                artistInfoLabel.text += "\r";
        }
    }
    
    private function updateAudioCurrentTime() : Void
    {
        
        artistInfoLabel.text = _currentTimeText + "\n" + _soundManager.getFormatTimeRemaing(currentAudio) + " - " + _soundManager.getFormatDuration(currentAudio);
        artistInfoLabel.align = "center";
    }
    
    private function updateAudioTimeLeft() : Void
    {
        
        artistInfoLabel.text = _timeLeftText + "\n" + _soundManager.getFormatTimeLeft(currentAudio) + " - " + _soundManager.getFormatDuration(currentAudio);
        artistInfoLabel.align = "center";
    }
    
    private function onSoundID3(event : SoundStatusEvent) : Void
    {
        if (null != event.soundData && event.soundData.soundObj != null && _soundManager.getSoundObj(getTrackName(_currentIndex)) == event.soundData.soundObj) 
            updateArtistLabelInfo(event.soundData.soundObj.id3);
    }
    
    private function onMarkerMouseDown(event : MouseEvent) : Void
    {
        ThreadManager.removeEventTimer(onSliderUpdate);
    }
    
    private function onMarkerMouseUp(event : MouseEvent) : Void
    {
        if (_soundManager.getList().length == 0) 
            return;
        
        var currentAudio : String = getTrackName(_currentIndex);
        var currentSoundObj : Sound = _soundManager.getSoundObj(currentAudio);
        
        var resumeTime : Float = ((audioSlider.slider.percent) * currentSoundObj.length) / 1000;
        _soundManager.setPosition(currentAudio, as3hx.Compat.parseInt(resumeTime));
        
        // If playing then start timer again.
        if (_soundManager.getStatus(currentAudio).playing) 
        {
            ThreadManager.addEventTimer(onSliderUpdate);
        }
        // Else set back to 0
        else 
        {
            audioSlider.slider.percent = 0;
        }
    }
    
    private function addPrevAndNextButton() : Void
    {
        removeAllMP3Controls();
        
        buttonContainer.addElement(prevBtn);
        buttonContainer.addElement(playBtn);
        buttonContainer.addElement(stopBtn);
        buttonContainer.addElement(audioSlider);
        buttonContainer.addElement(nextBtn);
        buttonContainer.addElement(shuffleBtn);
    }
    
    private function removePrevAndNextButton() : Void
    {
        removeAllMP3Controls();
        
        buttonContainer.addElement(playBtn);
        buttonContainer.addElement(stopBtn);
        buttonContainer.addElement(audioSlider);
        buttonContainer.addElement(shuffleBtn);
    }
    
    private function removeAllMP3Controls() : Void
    {
        if (null != prevBtn.parent) 
            buttonContainer.removeElement(prevBtn);
        
        if (null != playBtn.parent) 
            buttonContainer.removeElement(playBtn);
        
        if (null != stopBtn.parent) 
            buttonContainer.removeElement(stopBtn);
        
        if (null != audioSlider.parent) 
            buttonContainer.removeElement(audioSlider);
        
        if (null != nextBtn.parent) 
            buttonContainer.removeElement(nextBtn);
        
        if (null != shuffleBtn.parent) 
            buttonContainer.removeElement(shuffleBtn);
    }
    
    private function getTrackName(index : Int) : String
    {
        // Get sound by index in list
        if (shuffleMode) 
            return shuffleList[index];
        
        var soundList : Array<Dynamic> = _soundManager.getList();
        
        //Search for song based on name in list
        for (i in 0...soundList.length){
            if (soundList[i] == TRACK_SOUND_MANAGER_PREFIX + (index + 1)) 
                return soundList[i];
        }
        
        return null;
    }
    
    private function updateShuffleList() : Void
    {
        
        var tempList : Array<Dynamic> = _soundManager.getList();
        
        // Put in current song in list or only one sound object
        if (_soundManager.getStatus(currentAudio).playing || tempList.length == 1) 
            shuffleList.push(currentAudio);
        
        for (i in 0...tempList.length){
            // Add song to list long as it's not current song
            if (currentAudio != tempList[i]) 
                shuffleList.push(tempList[i]);
        }
    }
    
    private function onStageAdd(event : Event) : Void
    {
        ThreadManager.stage = stage;
        removeEventListener(Event.ADDED_TO_STAGE, onStageAdd);
        
        // Have to add stage to use for event thread
        ThreadManager.stage = stage;
    }
    
    /**
		 * Since using ThreadManager there is no need for event return
		 * @private
		 */
    
    private function onSliderUpdate() : Void
    {
        
        var currentSoundObj : Sound = _soundManager.getSoundObj(currentAudio);
        audioSlider.slider.percent = as3hx.Compat.parseInt(_soundManager.getPosition(currentAudio) / as3hx.Compat.parseInt(currentSoundObj.length / 1000) * 100) / 100;
        
        // Artist info
        if ((_delayBeforeDisplay >= _soundManager.getPosition(currentAudio) * 1) || _displayMode == 0) 
        {
            updateArtistLabelInfo();
        }
        else if (_displayMode == 1) 
        {
            updateAudioCurrentTime();
        }
        // Go to next audio file
        else if (_displayMode == 2) 
        {
            updateAudioTimeLeft();
        }
        
        
        
        if (_playNextAudio && audioSlider.slider.percent >= 1 && _currentIndex < _soundManager.getList().length - 1) 
            onNextButton();
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
    
    private function onStageRemove(event : Event) : Void
    {
        ThreadManager.removeEventTimer(onSliderUpdate);
        addEventListener(Event.ADDED_TO_STAGE, onStageAdd);
    }
    
    private function onArtLabelClick(event : MouseEvent) : Void
    {
        // If false do nothing
        if (!_toggleDisplayOnClick) 
            return;
        
        _displayMode++;
        
        if (_displayMode >= 3) 
            _displayMode = 0;
    }
    
    private function onArtImageComplete(event : Event) : Void
    {
        _showArtBox = true;
        draw();
    }
}

