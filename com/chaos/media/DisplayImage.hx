/**
 * Standard way to load in images for framework
 *
 *  @author Erick Feiling
 */
package com.chaos.media;

import openfl.display.LoaderInfo;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.media.event.DisplayImageEvent;
import openfl.display.BitmapData;
import openfl.errors.Error;
import com.chaos.ui.BaseUI;
import com.chaos.utils.Debug;
import openfl.display.Loader;
import openfl.display.Bitmap;
import openfl.events.IOErrorEvent;
import openfl.net.URLRequest;
import openfl.geom.Matrix;
import openfl.events.Event;
import openfl.events.EventDispatcher;

#if html5
import haxe.crypto.Base64;
import openfl.utils.ByteArray;
#end


class DisplayImage extends BaseUI implements IBaseUI
{
	public static inline var TYPE : String = "DisplayImage";
	
    public var image(get, never) : BitmapData;
	public var repeat(get, set) : Bool;
    public var drawOffStage(get, set) : Bool;
	public var resizeImage(get, set) : Bool;
	
	private var _resizeImage : Bool = false;
	private var _drawOffStage:Bool = false;
	private var _image : BitmapData = null;
	private var _url : String = "";
	private var _repeat : Bool = false;

	private var _onBase64Image:Dynamic;
	
	/**
	 * Loads an image from a given loaction off the net. Use the onImageComplete call back or add an lisnter using Event.COMPLETE for when image loads.
	 *
	 */ 
	
	public function new(data:Dynamic = null )
    {
		super(data);
		
		addEventListener(Event.ADDED_TO_STAGE, onStageAdd);
		
    }
	
	private function onStageAdd(e:Event):Void 
	{
		removeEventListener(Event.ADDED_TO_STAGE, onStageAdd);
		addEventListener(Event.REMOVED_FROM_STAGE, onStageRemove);
		
		draw();
	}
	
	private function onStageRemove(e:Event):Void 
	{
		removeEventListener(Event.REMOVED_FROM_STAGE, onStageRemove);
		
		graphics.clear();
	}
	
	/**
	 * @inheritDoc
	 */
	override public function initialize():Void 
	{
		super.initialize();
		
		load(_url);
	}	
	
	/**
	 * @inheritDoc
	 */
	override public function setComponentData(data:Dynamic):Void 
	{
		super.setComponentData(data);
		
		if(Reflect.hasField(data,"url"))
			_url = Reflect.field(data, "url");
			
		if (Reflect.hasField(data, "drawOffStage"))
			_drawOffStage = Reflect.field(data, "drawOffStage");

		if (Reflect.hasField(data, "resizeImage"))
			_resizeImage = Reflect.field(data, "resizeImage");
		
		if (Reflect.hasField(data, "image")) {

			_image = Reflect.field(data, "image");

			_width = _image.width;
			_height = _image.height;
		}

		if (Reflect.hasField(data, "repeat"))
			_repeat = Reflect.field(data, "repeat");
		
		if(Reflect.hasField(data, "base64")) {
			setBase64Image(Reflect.field(data, "base64"));
		}
			
	}
	

	/**
	 * @inheritDoc
	 */
	
	override public function destroy():Void 
	{
		super.destroy();
		
		removeEventListener(Event.REMOVED_FROM_STAGE, onStageAdd);
		removeEventListener(Event.REMOVED_FROM_STAGE, onStageRemove);
		
		if (null != _image)
			_image.dispose();
	}
	
	private function get_image():BitmapData
	{
		return _image;
	}
	
	private function set_drawOffStage( value:Bool ) : Bool
	{
		_drawOffStage = value;
		
		return value;
	}
	
	private function get_drawOffStage() : Bool
	{
		return _drawOffStage;
	}

	private function set_resizeImage( value:Bool ) : Bool
	{
		_resizeImage = value;
		
		return value;
	}
	
	private function get_resizeImage() : Bool
	{
		return _resizeImage;
	}	

	private function set_repeat( value:Bool ) : Bool
	{
		_repeat = value;
		
		return value;
	}
	
	private function get_repeat() : Bool
	{
		return _repeat;
	}

	/**
	 * Convert Base64 string into image
	 *
	 * @param	base64String Base64 encoded string value
	 */
	

	public function setBase64Image( base64String:String) : Void {
		
		
		var type:String =  base64String.substr(base64String.indexOf(":") + 1);

		type = type.substr(0,type.indexOf(";"));

		

		if(type != "") {

			#if sys
			var bitmapData = BitmapData.fromBase64(base64String, type);

			if(bitmapData != null) 
			{
				Debug.print("[DisplayImage::setBase64Image] Set BitmapData: " + name);
				_image = bitmapData;

				if(_width != _image.width)
					_width = _image.width;

				if(_height != _image.height)
					_height = _image.height;

				dispatchEvent(new DisplayImageEvent( DisplayImageEvent.IMAGE_LOADED));
			
				draw();
			}
			else 
			{
				Debug.print("[DisplayImage::setBase64Image] Unable to create image.");
			}
			#end

			#if html5
			var imageBytes:ByteArray = Base64.decode(base64String.split(",")[1]);
			BitmapData.loadFromBytes(imageBytes).onComplete(function(bitmapData:BitmapData) {
				
				Debug.print("[DisplayImage::setBase64Image] Set HTML5 BitmapData: " + name);

				_image = bitmapData;

				_width = _image.width;
				_height = _image.height;

				dispatchEvent(new DisplayImageEvent( DisplayImageEvent.IMAGE_LOADED));

				draw();

			}).onError(function(error:Dynamic) {
				Debug.print("[DisplayImage::setBase64Image] Unable to create image. Error: " + error);
			});
			#end
		}
		else {
			Debug.print("[DisplayImage::setBase64Image] Unable to find image type: " + type);	
		}		
	}

	
	/**
	 * Store a bitmap in the display image
	 *
	 * @param	displayBitmap The bitmap you want to use
	 */
	
	public function setImage(image : BitmapData ) : Void
	{
		_image = image;

		_width = _image.width;
		_height = _image.height;

		dispatchEvent(new DisplayImageEvent(DisplayImageEvent.IMAGE_LOADED));
		
		draw();
    } 

	public function unload() : Void {

		if(null != image) {

			graphics.clear();

			_image.dispose();
		}
			
	}
	
	
	
	/**
	 * Load an image from a given location on the net
	 *
	 * @param	strImage The file including the path
	 *
	 * @eventType Event.COMPLETE
	 */
	
	public function load(imageURL : String) : Void 
	{
		var loader:Loader = new Loader();
		
		loader.contentLoaderInfo.addEventListener(Event.COMPLETE, fileComplete, false, 0, true);
		loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler, false, 0, true);
		loader.load(new URLRequest(imageURL));
		
    }
	
    /**
	 * Draw image if drawOffStage is true or on stage
	 */
	
	override public function draw():Void 
	{
		super.draw();
		
		var redraw:Bool = false;
		
		// This will check to see if image should displayed
		if (_drawOffStage || stage != null && _image != null)
			redraw = true;
		
		graphics.clear();

		if (redraw)
		{
			var bitmapData:BitmapData = null;

			// Resize image or keep default size
			if(_resizeImage) {
				bitmapData = resizeBitmapData(_image, Std.int(_width), Std.int(_height));
			}
			else {
				bitmapData = _image;
			}
			
			// Draw in new size
			graphics.beginBitmapFill(bitmapData, null, _repeat);
			graphics.drawRect(0, 0, _width, _height);
			graphics.endFill();
		}
	}
	
	private function ioErrorHandler(event : IOErrorEvent) : Void 
	{
		//NOTE: This will fire, if the image was loaded or not
		//Debug.print("[DisplayImage::ioErrorHandler] Fail to load file");
		
		dispatchEvent(event);
    }
	
	
	private function fileComplete(event : Event) : Void  
	{  
		var loaderFile:LoaderInfo = cast(event.target, LoaderInfo);
		_image = cast( (loaderFile.content), Bitmap).bitmapData;

		_image.width;
		_image.height;
		
		dispatchEvent(new DisplayImageEvent(DisplayImageEvent.IMAGE_LOADED));

		if (_drawOffStage)
			draw();
		
		dispatchEvent(event);
    }

	private function resizeBitmapData(originalBitmapData:BitmapData, newWidth:Int, newHeight:Int) : BitmapData {

		var resizedBitmapData:BitmapData = new BitmapData(newWidth, newHeight, true, 0x00000000); // true for transparency, 0x00000000 for transparent black

		var originalWidth:Int = originalBitmapData.width;
		var originalHeight:Int = originalBitmapData.height;

		var scaleX:Float = newWidth / originalWidth;
		var scaleY:Float = newHeight / originalHeight;

		var matrix:Matrix = new Matrix();

		matrix.scale(scaleX, scaleY);

		resizedBitmapData.draw(originalBitmapData, matrix);

		return resizedBitmapData;

	}
}