package com.chaos.media;


/**
 * Adds a video to the display
 *
 * @author Erick Feiling
 */


import com.chaos.media.event.DisplayVideoEvent;
import haxe.Constraints.Function;
import openfl.Assets;
import openfl.display.BitmapData;
import openfl.display.DisplayObject;
import openfl.display.Shape;
import openfl.display.Sprite;
import com.chaos.ui.BaseUI;
import com.chaos.ui.classInterface.IBaseUI;
import openfl.events.Event;
import openfl.events.NetStatusEvent;
import openfl.events.AsyncErrorEvent;
import openfl.events.SecurityErrorEvent;
import openfl.utils.ByteArray;
import openfl.utils.Object;

import com.chaos.utils.ThreadManager;

import openfl.media.Video;

import openfl.net.NetConnection;
import openfl.net.NetStream;

class DisplayVideo extends BaseUI implements IBaseUI
{
	public static inline var TYPE : String = "DisplayVideo";
    public var videoLoaded(get, never) : Int;
    public var bufferAmount(get, set) : Int;
    public var video(get, never) : Video;
    public var isPlaying(get, never) : Bool;
    public var connection(get, never) : NetConnection;
    public var netStream(get, never) : NetStream;
	public var backgroundColor(get, set) : Int;
	public var backgroundAlpha(get, set) : Float;
	
    
    
    private var _videoURL : String = "";
    private var _connection : NetConnection = new NetConnection();
    private var _stream : NetStream;
    
    private var _bufferAmount : Int = 30;
    private var _isPlaying : Bool = false;
    
    private var _videoLoaded : Int = 0;
    private var _video : Video  = new Video();
    private var _background : Shape = new Shape();
    
    private var _metaData : Dynamic = {};
    
    private var _callBack : Dynamic->Void = null;
	
    
    private var _autoStart : Bool = false;
	
	private var _backgroundColor : Int = 0x000000;
	private var _backgroundAlpha : Float = 1;
	private var _backgroundImage : BitmapData;
	
	private var _timeOut:Int = 0;
	private var _timeOutMax:Int = 10;
    
    private var protocolList : Array<Dynamic> = ["rtmp", "rtmpe", "rtmps", "rtmpt", "rtmpte"];
    private var bufferReached : Bool = false;
    
    /**
	 *
	 * Create a video screen
	 *
	 * @eventType com.chaos.media.Event.DisplayVideoEvent.VIDEO_BUFFER
	 * @eventType com.chaos.media.Event.DisplayVideoEvent.VIDEO_COMPLETE
	 * @eventType com.chaos.media.Event.DisplayVideoEvent.DisplayVideoEvent.VIDEO_METADATA
	 */
	
    public function new(data:Dynamic = null)
    {
		
        super(data);
		
        addEventListener(Event.ADDED_TO_STAGE, onStageAdd, false, 0, true);
    }
	
	
	/**
	 * @inheritDoc
	 */
	override public function initialize():Void 
	{
		super.initialize();
		
        _connection.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
        _connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
        
        addChild(_background);
        addChild(_video);
		
	}
	
	/**
	 * @inheritDoc
	 */
	override public function setComponentData(data:Dynamic):Void 
	{
		super.setComponentData(data);
		
		if (Reflect.hasField(data, "backgroundColor"))
			_backgroundColor = Reflect.field(data, "backgroundColor");
			
		if (Reflect.hasField(data, "backgroundAlpha"))
			_backgroundAlpha = Reflect.field(data, "backgroundAlpha");
		
		if (Reflect.hasField(data, "backgroundImage"))
			_backgroundImage = Reflect.field(data, "backgroundImage");
			
		if (Reflect.hasField(data, "autoStart"))
			_autoStart = Reflect.field(data, "autoStart");
			
		if (Reflect.hasField(data, "bufferAmount"))
			_bufferAmount = Reflect.field(data, "bufferAmount");
		
		if (Reflect.hasField(data, "url"))
            _videoURL = Reflect.field(data, "url");
        

        if(_videoURL != "")
           load(_videoURL, _autoStart); 
		
	}
	

    
    private function onStageAdd(event : Event) : Void
    {
        if (null == ThreadManager.stage) 
            ThreadManager.stage = stage;
    }
    
	
    /**
	 * Update the UI class
	 */
	
	override public function draw():Void 
	{
		super.draw();
		
		_background.graphics.clear();
		
		if (_backgroundImage != null)
			_background.graphics.beginBitmapFill(_backgroundImage);
		else
			_background.graphics.beginFill(_backgroundColor, _backgroundAlpha);
		
		_background.graphics.drawRect(0, 0, _width, _height);
		_background.graphics.endFill();
		_video.width = _width;
		_video.height = _height;
		
	}
	
	private function set_backgroundColor( value:Int ) : Int
	{
		_backgroundColor = value;
		
		return value;
	}
	
	private function get_backgroundColor() : Int
	{
		return _backgroundColor;
	}
	
	
	private function set_backgroundAlpha( value:Float ) : Float
	{
		_backgroundAlpha = value;
		
		return value;
	}
	
	private function get_backgroundAlpha() : Float
	{
		return _backgroundAlpha;
	}
	
    
    /**
	 * The amount of the video loaded from 0 to 100 percent
	 */
    
    private function get_videoLoaded() : Int
    {
        return _videoLoaded;
    }
    
    /**
	 * The amount of the video loaded before event is fired
	 */
    
    private function set_bufferAmount(value : Int) : Int
    {
        _bufferAmount = value;
        return value;
    }
    
    /**
	 * Return the buffer amount
	 */
	
    private function get_bufferAmount() : Int
    {
        return _bufferAmount;
    }
    
    /**
	 * Return the video display object
	 */
	
    private function get_video() : Video
    {
        return _video;
    }
    
    /**
	 * Is video playing return true if so and false if not
	 */
	
    private function get_isPlaying() : Bool
    {
        return _isPlaying;
    }
    
    /**
	 *  Reutrn a object with all the meta data on it.
	 *  Things on the object duration, width, height and framerate
	 */
    
    private function get_metaData() : Dynamic
    {
        return _metaData;
    }
    
    /**
	 * Returns the connection object
	 */
    
    private function get_connection() : NetConnection
    {
        return _connection;
    }
    
    /**
	 * Returns the net stream so you can attach a microphone or camera
	 */
    
    private function get_netStream() : NetStream
    {
        return _stream;
    }
	
	/**
	 * Set background image to be used
	 * @param	value The image that will be displayed
	 */
	public function setBackgroundImage( value:BitmapData):Void
	{
		_backgroundImage = value;
	}
    
    /**
	 * Plays a video from the server
	 *
	 * @param	value The URL of the video or media server
	 *
	 */
    
    public function load(value : String, autoStart : Bool = false, callBack : Dynamic->Void = null) : Void
    {
        _videoURL = value;
        _autoStart = autoStart;
        
		
		var isMediaServer : Bool = false;
		
		// Check to see if string is pointing to media server
		for (i in 0...protocolList.length)
		{
			if (Std.string(_videoURL).indexOf(protocolList[i]) != -1)
				isMediaServer = true;
		}
		
		_callBack = callBack;
		
		// Force video connect after setting url
		_connection.connect(((isMediaServer)) ? _videoURL : null);
		
    }
    
    /**
	 * Stop and close connection of video stream
	 */
    
    public function stop() : Void
    {
        if (null != _stream) 
            _stream.close();
    }
    
    /**
	 * Pause video stream if the video is already paused then we resume playing
	 *
	 */
    
    public function pause() : Void
    {
        if (null != _stream) 
            _stream.togglePause();
    }
    
    /**
	 * Play video stream
	 *
	 */
    
    public function play() : Void
    {
        if (null != _stream) 
            _stream.play(_videoURL);
		
    }
    
    private function netStatusHandler(event : NetStatusEvent) : Void
    {
        
		handleVideoStatus(Reflect.field(event.info, "code"));
    }
	
	private function handleVideoStatus( status:String ) : Void
	{
		trace("handleVideoStatus: " + status);
        switch (status)
        {
            
            case "NetConnection.Connect.Success":
				connectStream();
			case "connectSuccess":
                connectStream();
            
            case "NetStream.Play.StreamNotFound":
                trace("Unable to locate video: " + _videoURL);
            
            case "NetStream.Play.Start":
                _isPlaying = true;
                
                // Call back
                if (null != _callBack) 
					_callBack(status);
                
                _callBack = null;
            
            case "NetStream.Play.Stop":
                _isPlaying = false;
            
            case "NetStream.Pause.Notify":
                _isPlaying = false;
            
            case "NetStream.Unpause.Notify":
                _isPlaying = true;
        }		
	}
    
    private function connectStream(event : NetStatusEvent = null) : Void
    {
        
        var customClient:Object = new Object();

		#if html5
		customClient.onPlayStatus = metaDataHandler;
		#else
		customClient.onMetaData = metaDataHandler;
		#end
		
        _stream = new NetStream(_connection);
        
        _stream.client = customClient;
        
        _stream.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
        _stream.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
        
        _video.attachNetStream(_stream);
		
        
        // Calback will be called once movie is playing else just do callback
        if (_autoStart) 
        {
            play();
        }
        else 
        {
            // Call back
            if (null != _callBack) 
                _callBack("connectStream");
            
			
            _callBack = null;
        }
        
        ThreadManager.addEventTimer(videoBuffer);
        
        addChild(_video);
    }
    
    private function metaDataHandler(infoObj : Dynamic) : Void
    {
        // NOTE: Just needed to handle this so it wouldn't throw an error message
        _metaData = infoObj;
        
        dispatchEvent(new DisplayVideoEvent(DisplayVideoEvent.VIDEO_METADATA));
    }
	
	private function onPlayStatus(meta:Object) : Void
	{
		
		handleVideoStatus(Reflect.field(meta, "code"));
	}
    
    private function securityErrorHandler(event : SecurityErrorEvent) : Void
    {
        trace("securityErrorHandler: " + event);
    }
    
    private function asyncErrorHandler(event : AsyncErrorEvent) : Void
    {
        // ignore AsyncErrorEvent events.
        
    }
    
    private function videoBuffer( status:Dynamic ) : Void
    {
        if (null == _stream) 
            return;
        
        _videoLoaded = Std.int( (_stream.bytesLoaded / _stream.bytesTotal) * 100);
        
        if (_videoLoaded > bufferAmount && !bufferReached) 
        {
            bufferReached = true;
            dispatchEvent(new DisplayVideoEvent(DisplayVideoEvent.VIDEO_BUFFER));
        }
        
        if (_stream.bytesLoaded == _stream.bytesTotal && _stream.bytesTotal > 0 || _timeOut == _timeOutMax) 
        {
			ThreadManager.removeEventTimer(videoBuffer);
			
            dispatchEvent(new DisplayVideoEvent(DisplayVideoEvent.VIDEO_COMPLETE));
			
			_timeOut = 0;
        }
		else if(_stream.bytesLoaded == 0 && _stream.bytesTotal == 0 && _stream.bytesTotal == 0)
			_timeOut++;
    }
}

