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
	private var _base64 : String = "";

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
		removeEventListener(Event.REMOVED_FROM_STAGE, onStageRemove);
		addEventListener(Event.REMOVED_FROM_STAGE, onStageRemove);

		draw();
	}
	
	private function onStageRemove(e:Event):Void 
	{
		graphics.clear();

		addEventListener(Event.ADDED_TO_STAGE, onStageAdd);
	}
		
	/**
	 * @inheritDoc
	 */
	override public function initialize():Void 
	{
		super.initialize();

		if (_url != null && _url != "")
			load(_url);
	}	
	
	/**
	 * @inheritDoc
	 */
	override public function setComponentData(data:Dynamic):Void
	{
		super.setComponentData(data);

		if (data == null)
			return;

		if (Reflect.hasField(data, "drawOffStage"))
			_drawOffStage = Reflect.field(data, "drawOffStage");

		if (Reflect.hasField(data, "resizeImage"))
			_resizeImage = Reflect.field(data, "resizeImage");

		if (Reflect.hasField(data, "repeat"))
			_repeat = Reflect.field(data, "repeat");

		if (Reflect.hasField(data, "image"))
		{
			var bitmapData:BitmapData = Reflect.field(data, "image");

			if (bitmapData != null)
				setImage(bitmapData);
		}

		if (Reflect.hasField(data, "base64"))
		{
			var base64:String = Reflect.field(data, "base64");

			if (base64 != null && base64 != "")
				setBase64Image(base64);
		}

		if (Reflect.hasField(data, "url"))
		{
			var url:String = Reflect.field(data, "url");

			if (url != null && url != "" && url != _url)
			{
				_url = url;
				load(_url);
			}
		}

		draw();
	}
	

	/**
	 * @inheritDoc
	 */
	
	override public function destroy():Void 
	{
		super.destroy();
		
		removeEventListener(Event.ADDED_TO_STAGE, onStageAdd);
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
	

	public function setBase64Image(base64String:String):Void
	{
		if (base64String == null || base64String == "")
		{
			Debug.print("[DisplayImage::setBase64Image] Base64 string is empty.");
			return;
		}

		if (_base64 == base64String && _image != null)
			return;

		var commaIndex:Int = base64String.indexOf(",");

		if (commaIndex == -1)
		{
			Debug.print(
				"[DisplayImage::setBase64Image] Invalid Base64 data URL."
			);
			return;
		}

		var header:String = base64String.substr(0, commaIndex);
		var encodedData:String = base64String.substr(commaIndex + 1);

		var typeStart:Int = header.indexOf(":");
		var typeEnd:Int = header.indexOf(";");

		if (typeStart == -1 || typeEnd == -1 || typeEnd <= typeStart)
		{
			Debug.print(
				"[DisplayImage::setBase64Image] Unable to determine image type."
			);
			return;
		}

		var type:String = header.substring(typeStart + 1, typeEnd);

		_base64 = base64String;

		#if html5
		var imageBytes:ByteArray;

		try
		{
			imageBytes = Base64.decode(encodedData);
		}
		catch (error:Dynamic)
		{
			_base64 = "";
			Debug.print(
				"[DisplayImage::setBase64Image] Base64 decode failed: " + error
			);
			return;
		}

		BitmapData.loadFromBytes(imageBytes)
			.onComplete(function(bitmapData:BitmapData)
			{
				if (bitmapData == null)
				{
					_base64 = "";
					Debug.print(
						"[DisplayImage::setBase64Image] BitmapData is null."
					);
					return;
				}

				Debug.print(
					"[DisplayImage::setBase64Image] Set HTML5 BitmapData: " + name
				);

				setImage(bitmapData);
			})
			.onError(function(error:Dynamic)
			{
				_base64 = "";

				Debug.print(
					"[DisplayImage::setBase64Image] Unable to create image: " +
					error
				);
			});
		#end
	}

	
	/**
	 * Store a bitmap in the display image
	 *
	 * @param	displayBitmap The bitmap you want to use
	 */
	
	public function setImage(image:BitmapData):Void
	{
		if (image == null)
			return;

		_image = image;

		if (_width <= 0)
			_width = _image.width;

		if (_height <= 0)
			_height = _image.height;

		draw();

		dispatchEvent(new DisplayImageEvent(DisplayImageEvent.IMAGE_LOADED));
	}

	public function unload():Void
	{
		graphics.clear();

		if (_image != null)
		{
			_image.dispose();
			_image = null;
		}

		_base64 = "";
		_url = "";
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
	
	
	private function fileComplete(event:Event):Void
	{
		var loaderFile:LoaderInfo = cast(event.target, LoaderInfo);
		var bitmap:Bitmap = cast(loaderFile.content, Bitmap);

		if (bitmap == null || bitmap.bitmapData == null)
		{
			Debug.print("[DisplayImage::fileComplete] BitmapData is null.");
			return;
		}

		Debug.print("[DisplayImage::fileComplete] Image loaded: " + name);

		setImage(bitmap.bitmapData);
	}

	private function resizeBitmapData(source:BitmapData,width:Int,height:Int):BitmapData {

		if (source == null || width <= 0 || height <= 0) {
			return source;
		}

		if (source.width == width && source.height == height) {
			return source.clone();
		}

		var resizedBitmapData:BitmapData = new BitmapData(
			width,
			height,
			true,
			0x00000000
		);

		var sourceBitmap:Bitmap = new Bitmap(source);

		var scaleX:Float = width / source.width;
		var scaleY:Float = height / source.height;

		var matrix:Matrix = new Matrix();
		matrix.scale(scaleX, scaleY);

		resizedBitmapData.draw(
			sourceBitmap,
			matrix,
			null,
			null,
			null,
			true
		);

		return resizedBitmapData;
	}
}