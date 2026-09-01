package com.chaos.media;


/**
 * Adds a video to the display
 *
 * @author Erick Feiling
 */


import com.chaos.media.event.DisplayVideoEvent;
import openfl.display.BitmapData;
import openfl.display.Shape;
import com.chaos.ui.BaseUI;
import com.chaos.ui.classInterface.IBaseUI;
import openfl.events.Event;
import openfl.events.NetStatusEvent;
import openfl.events.AsyncErrorEvent;
import openfl.events.SecurityErrorEvent;
import openfl.utils.Object;

import com.chaos.utils.ThreadManager;

import openfl.media.Video;
import openfl.media.SoundTransform;

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
	public var volume(get, set) : Float;
	public var muted(get, set) : Bool;
	public var backgroundColor(get, set) : Int;
	public var backgroundAlpha(get, set) : Float;
	
    
    
    private var _videoURL : String = "";
    private var _connection : NetConnection = new NetConnection();
    private var _stream : NetStream;
    
    private var _bufferAmount : Int = 30;
    private var _isPlaying : Bool = false;
	private var _volume : Float = 100;
	private var _muted : Bool = false;
    
    private var _videoLoaded : Int = 0;
    private var _video : Video  = new Video();
    private var _background : Shape = new Shape();
    
    private var _metaData : Dynamic = {};
    
    private var _callBack : Dynamic->Void = null;
	private var _initialized : Bool = false;
	private var _loadPending : Bool = false;
	private var _bufferTimerActive : Bool = false;
	private var _completeDispatched : Bool = false;
	
    
    private var _autoStart : Bool = false;
	
	private var _backgroundColor : Int = 0x000000;
	private var _backgroundAlpha : Float = 1;
	private var _backgroundImage : BitmapData;
	
    private var protocolList : Array<String> = ["rtmp", "rtmpe", "rtmps", "rtmpt", "rtmpte"];
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
        addEventListener(Event.REMOVED_FROM_STAGE, onStageRemove, false, 0, true);
    }
	
	
	/**
	 * @inheritDoc
	 */
	override public function initialize():Void 
	{
		super.initialize();
		
        _connection.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
        _connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
        
        if (_background.parent != this)
            addChild(_background);

        if (_video.parent != this)
            addChild(_video);

		_initialized = true;

		if (_loadPending && _videoURL != "")
		{
			_loadPending = false;
			load(_videoURL, _autoStart, _callBack);
		}
		
	}
	
	/**
	 * @inheritDoc
	 */
	override public function setComponentData(data:Dynamic):Void 
	{
		if (data == null)
			return;

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
			bufferAmount = Std.int(Reflect.field(data, "bufferAmount"));

		if (Reflect.hasField(data, "volume"))
		{
			var requestedVolume:Float = Std.parseFloat(Std.string(Reflect.field(data, "volume")));

			if (!Math.isNaN(requestedVolume))
				volume = requestedVolume;
		}

		if (Reflect.hasField(data, "muted"))
			muted = Reflect.field(data, "muted") == true;
		
		if (Reflect.hasField(data, "url"))
		{
			var requestedURL:String = Std.string(Reflect.field(data, "url"));
			var shouldReload:Bool = requestedURL != _videoURL || _stream == null;

			_videoURL = requestedURL;

			if (_videoURL == "")
			{
				_loadPending = false;
				disposeStream();
				_isPlaying = false;
			}
			else if (!_initialized)
			{
				_loadPending = true;
			}
			else if (shouldReload)
			{
				load(_videoURL, _autoStart);
			}
		}
		
	}
	

    
    private function onStageAdd(event : Event) : Void
    {
        if (null == ThreadManager.stage) 
            ThreadManager.stage = stage;

		if (_loadPending && _videoURL != "")
		{
			_loadPending = false;
			load(_videoURL, _autoStart, _callBack);
		}
		else
		{
			startBufferTimer();
		}
    }

	private function onStageRemove(event : Event) : Void
	{
		_loadPending = _videoURL != "";
		disposeStream();
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
        _bufferAmount = value < 0 ? 0 : value > 100 ? 100 : value;
        return _bufferAmount;
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
    
     /*
    private function get_metaData() : Dynamic
    {
        return _metaData;
    }
        */
    
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

	private function set_volume(value:Float):Float
	{
		if (!Math.isNaN(value))
			_volume = Math.max(0, Math.min(100, value));

		applySoundTransform();
		return _volume;
	}

	private function get_volume():Float
	{
		return _volume;
	}

	private function set_muted(value:Bool):Bool
	{
		_muted = value;
		applySoundTransform();
		return _muted;
	}

	private function get_muted():Bool
	{
		return _muted;
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
		if (value == null || StringTools.trim(value) == "")
		{
			_videoURL = "";
			_callBack = null;
			_loadPending = false;
			disposeStream();
			_isPlaying = false;
			return;
		}

        _videoURL = StringTools.trim(value);
        _autoStart = autoStart;
		_callBack = callBack;

		if (!_initialized)
		{
			_loadPending = true;
			return;
		}

		disposeStream();
		bufferReached = false;
		_completeDispatched = false;
		_videoLoaded = 0;
        
		
		var isMediaServer : Bool = false;
		
		// Check to see if string is pointing to media server
		var normalizedURL:String = _videoURL.toLowerCase();
		for (protocol in protocolList)
		{
			if (StringTools.startsWith(normalizedURL, protocol + "://"))
				isMediaServer = true;
		}
		
		// Force video connect after setting url
		try
		{
			_connection.connect(isMediaServer ? _videoURL : null);
		}
		catch (error:Dynamic)
		{
			trace("Unable to connect video: " + error);
			_isPlaying = false;
		}
		
    }
    
    /**
	 * Stop playback and reset the video stream to the beginning
	 */
    
    public function stop() : Void
    {
		_loadPending = false;

		if (_stream != null)
		{
			try
			{
				_stream.pause();
				_stream.seek(0);
			}
			catch (error:Dynamic)
			{
				trace("Unable to stop video: " + error);
			}
		}

		_isPlaying = false;
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
		if (event != null && event.info != null && Reflect.hasField(event.info, "code"))
			handleVideoStatus(Std.string(Reflect.field(event.info, "code")));
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
				dispatchComplete();
            
            case "NetStream.Pause.Notify":
                _isPlaying = false;
            
            case "NetStream.Unpause.Notify":
                _isPlaying = true;
        }		
	}
    
    private function connectStream(event : NetStatusEvent = null) : Void
    {
		disposeStream();

        var customClient:Object = new Object();

		Reflect.setField(customClient, "onMetaData", metaDataHandler);
		Reflect.setField(customClient, "onPlayStatus", onPlayStatus);
		
        _stream = new NetStream(_connection);
        
        _stream.client = customClient;
        
        _stream.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
        _stream.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
        
        _video.attachNetStream(_stream);
		applySoundTransform();
		
        
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
        
        startBufferTimer();
        
		if (_video.parent != this)
			addChild(_video);
    }

	private function applySoundTransform():Void
	{
		if (_stream != null)
			_stream.soundTransform = new SoundTransform((_muted ? 0 : _volume) / 100);
	}
    
    private function metaDataHandler(infoObj : Dynamic) : Void
    {
        // NOTE: Just needed to handle this so it wouldn't throw an error message
        _metaData = infoObj;
        
        dispatchEvent(new DisplayVideoEvent(DisplayVideoEvent.VIDEO_METADATA));
    }
	
	private function onPlayStatus(meta:Object) : Void
	{
		if (meta != null && Reflect.hasField(meta, "code"))
			handleVideoStatus(Std.string(Reflect.field(meta, "code")));
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
        
		var bytesTotal:Float = _stream.bytesTotal;

		if (bytesTotal <= 0)
			return;

		_videoLoaded = Std.int((_stream.bytesLoaded / bytesTotal) * 100);
		_videoLoaded = _videoLoaded < 0 ? 0 : _videoLoaded > 100 ? 100 : _videoLoaded;
        
        if (_videoLoaded >= bufferAmount && !bufferReached)
        {
            bufferReached = true;
            dispatchEvent(new DisplayVideoEvent(DisplayVideoEvent.VIDEO_BUFFER));
        }
        
		if (_stream.bytesLoaded >= bytesTotal)
        {
			stopBufferTimer();
			dispatchComplete();
        }
    }

	private function startBufferTimer():Void
	{
		if (_bufferTimerActive || _stream == null || ThreadManager.stage == null)
			return;

		ThreadManager.addEventTimer(videoBuffer);
		_bufferTimerActive = true;
	}

	private function stopBufferTimer():Void
	{
		if (!_bufferTimerActive)
			return;

		ThreadManager.removeEventTimer(videoBuffer);
		_bufferTimerActive = false;
	}

	private function dispatchComplete():Void
	{
		if (_completeDispatched)
			return;

		_completeDispatched = true;
		dispatchEvent(new DisplayVideoEvent(DisplayVideoEvent.VIDEO_COMPLETE));
	}

	private function disposeStream():Void
	{
		stopBufferTimer();

		if (_stream == null)
			return;

		_stream.removeEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
		_stream.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
		_stream.close();
		_video.attachNetStream(null);
		_stream = null;
	}

	override public function destroy():Void
	{
		disposeStream();
		_connection.removeEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
		_connection.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
		removeEventListener(Event.ADDED_TO_STAGE, onStageAdd);
		removeEventListener(Event.REMOVED_FROM_STAGE, onStageRemove);
		super.destroy();
	}
}

