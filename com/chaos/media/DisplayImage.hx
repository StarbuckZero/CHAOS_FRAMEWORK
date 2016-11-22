/**
 * Standard way to load in images or swf files for framework
 *
 *  @author Erick Feiling
 */
package com.chaos.media;

import com.chaos.ui.classInterface.IBaseUI;
import haxe.Constraints.Function;
import openfl.errors.Error;
import com.chaos.ui.BaseUI;
import com.chaos.utils.Debug;
import openfl.display.Loader;
import openfl.display.LoaderInfo;
import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.events.IOErrorEvent;
import openfl.net.URLLoader;
import openfl.net.URLLoaderDataFormat;
import openfl.net.URLRequest;
import openfl.utils.ByteArray;
import openfl.events.Event;

class DisplayImage extends BaseUI implements IBaseUI
{
	public static inline var TYPE : String = "DisplayImage";

    public var loader(get, never) : Loader;
    public var data(get, never) : ByteArray;
    public var swfMode(get, never) : Bool;
    public var pixelSnapping(get, set) : String;
    public var smoothing(get, set) : Bool;
    public var image(get, never) : Bitmap;
    public var loaded(get, never) : Bool;
	
	private var _imageURL : String = "";
	private var _smoothImage : Bool = true;
	private var _snapImage : String = "auto";
	private var _loader : Loader;
	private var _urlLoader : URLLoader;
	private var _loaded : Bool = false;
	private var _swfMode : Bool = false;
	private var _imageData : Bitmap = null;
	private var _data : ByteArray; 
	
	/** This can be called as a single callback but can also attach an Event.COMPLETE event as well */
	public var onImageComplete : Function;
	
	/** This is called if an image fail to load can also use IOErrorEvent.IO_ERROR event as well **/
	public var onImageFail : Function; 
	
	/**
	 * Loads an image or swf file from a given loaction off the net. Use the onImageComplete call back or add an lisnter using Event.COMPLETE for when image loads.
	 *
	 * @eventType openfl.events.IOErrorEvent.IO_ERROR
	 * @eventType openfl.events.Event.COMPLETE
	 */ 
	
	private function new()
    {
		super();
		init();
    }
	
	private function init() : Void
	{
		_urlLoader = new URLLoader();
		_urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
		
    } 
	
	/**
	 * The loader that is used for the content
	 */
	
	private function get_loader() : Loader
	{
		return _loader;
    } 
	
	/**
	 * Returns the raw data as a byte array
	 */
	
	private function get_data() : ByteArray
	{
		return _data;
    } 
	
	/**
	 * If true the item is a swf file and false if an image
	 */ 
	
	private function get_swfMode() : Bool
	{
		return _swfMode;
    } 
	
	/**
	 * Set the image pixel shanpping mode
	 */
	
	private function set_pixelSnapping(sToggle : String) : String
	{
		_snapImage = sToggle;
		
		if (_loaded && !_swfMode) 
		_imageData.pixelSnapping = _snapImage;
		
        return sToggle;
    } 
	
	/**
	 * Return the mode being used
	 */
	
	private function get_pixelSnapping() : String
	{
		return _snapImage;
    } 
	
	/**
	 * Set the smoothing mode
	 */
	private function set_smoothing(bToggle : Bool) : Bool
	{
		_smoothImage = bToggle;
		
		if (_loaded && !_swfMode)
		_imageData.smoothing = _smoothImage;
		
        return bToggle;
    } 
	
	/**
	 * Return true if smoothing is on and false if not
	 */
	
	private function get_smoothing() : Bool
	{
		return _smoothImage;
    }
	
	/**
	 * Return a bitmap if an image was loaded. If no image was loaded image item will be null.
	 */ 
	
	private function get_image() : Bitmap
	{
		return _imageData;
    } 
	
	/**
	 * Returns true if content is loaded and false if not
	 */
	
	private function get_loaded() : Bool
	{
		return _loaded;
    } 
	/**
	 * Store a bitmap in the display image
	 *
	 * @param	displayBitmap The bitmap you want to use
	 */
	
	public function setImage(displayBitmap : Bitmap) : Void
	{
		_imageData = displayBitmap;
		_imageData.smoothing = _smoothImage;
		_imageData.pixelSnapping = _snapImage;
		_loaded = true;
		
		graphics.clear();
		graphics.beginBitmapFill(_imageData.bitmapData, null, false, _smoothImage);
		graphics.drawRect(0, 0, _imageData.width, _imageData.height);
		graphics.endFill();
    } 
	
	/**
	 * Create a copy of the display image loader
	 *
	 * @param	callBack This will fire an event.
	 *
	 * @return Return a loader
	 */ 
	
	public function clone(callBack : Event->Void = null) : Loader 
	{ 	if (!_loaded) 
		{
			Debug.print("[DisplayImage::clone] There isn't anything to copy");
			return null;
        }
		
		var newLoader : Loader = new Loader();
		
		if (null != callBack) 
		newLoader.addEventListener(Event.COMPLETE, callBack, false, 0, true);
		
		_data = try cast(_urlLoader.data, ByteArray) catch (e:Dynamic) null;
		
		newLoader.loadBytes(data);
		
		return newLoader;
    } 
	
	/**
	 * Load an image from a given location on the net
	 *
	 * @param	strImage The file including the path
	 *
	 * @eventType Event.COMPLETE
	 */
	
	public function load(strImage : String) : Void 
	{
		var request : URLRequest = new URLRequest(strImage);
		
		_urlLoader.addEventListener(Event.COMPLETE, onDataComplete, false, 0, true);
		_urlLoader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler, false, 0, true);
		_urlLoader.load(request);
		
		if (strImage.indexOf(".swf") != -1)  
		_swfMode = true;
    }
	
	private function ioErrorHandler(event : IOErrorEvent) : Void 
	{
		Debug.print("[DisplayImage::ioErrorHandler] Fail to load file");
		onImageFail(event);
		
		dispatchEvent(event);
    }
	
	private function onDataComplete(event : Event) : Void 
	{  
		// Save the byte data for clone
		_data = try cast(_urlLoader.data, ByteArray) catch(e:Dynamic) null; 
		
		// Remove old one
		if (null != _loader) 
		{  
			// Remove old event  
			if (_loader.contentLoaderInfo.hasEventListener(Event.COMPLETE)) 
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, fileComplete);
			
			// Stop and remove any data
			_loader.unload(); 
			
			// Remove the loader from display 
			removeChild(_loader);
        } 
		
		// Setup loader
		_loader = new Loader();
		_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, fileComplete, false, 0, true);
		_loader.loadBytes(_data);
		
		addChild(_loader);
    }
	
	private function fileComplete(event : Event) : Void  
	{  
		// If not a swf file then must be image of some kind so setup image for display  
		if (!_swfMode) 
		{	try
			{
				var loaderFile:Loader = cast(event.target, Loader);
				
				_imageData = cast( (loaderFile.content), Bitmap);
				_imageData.smoothing = _smoothImage;
				_imageData.pixelSnapping = _snapImage;
            }
            catch (error : Error)
			{
				Debug.print("[DisplayImage::fileComplete] Fail to convert image");
            }
			
        }
		
		dispatchEvent(event);
		
		// Event for when image is done loading
		onImageComplete(event);
		
		// Set loaded flag
		_loaded = true;
    }
}