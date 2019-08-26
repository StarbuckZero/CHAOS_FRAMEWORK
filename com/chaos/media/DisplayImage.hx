/**
 * Standard way to load in images for framework
 *
 *  @author Erick Feiling
 */
package com.chaos.media;

import com.chaos.ui.classInterface.IBaseUI;

import openfl.display.BitmapData;
import openfl.errors.Error;
import com.chaos.ui.BaseUI;
import com.chaos.utils.Debug;
import openfl.display.Loader;
import openfl.display.Bitmap;
import openfl.events.IOErrorEvent;
import openfl.net.URLRequest;

import openfl.events.Event;


class DisplayImage extends BaseUI implements IBaseUI
{
	public static inline var TYPE : String = "DisplayImage";
	
    public var image(get, never) : BitmapData;
    public var drawOffStage(get, set) : Bool;
	
	private var _drawOffStage:Bool = false;
	private var _image : BitmapData = null;
	private var _url : String = "";
	

	
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
			_drawOffStage =  Reflect.field(data, "drawOffStage");
		
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
	
	/**
	 * Store a bitmap in the display image
	 *
	 * @param	displayBitmap The bitmap you want to use
	 */
	
	public function setImage(image : BitmapData ) : Void
	{
		_image = image;
		
		draw();
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
	 * @inheritDoc
	 */
	override public function draw():Void 
	{
		super.draw();
		
		var redraw:Bool = false;
		
		// This will check to see if image should displayed
		if (_drawOffStage || stage != null)
			redraw = true;
		
		if (redraw)
		{
			graphics.beginBitmapFill(_image, null, true);
			graphics.drawRect(0, 0, _image.width, _image.height);
			graphics.endFill();
		}
		
		
	}
	
	private function ioErrorHandler(event : IOErrorEvent) : Void 
	{
		Debug.print("[DisplayImage::ioErrorHandler] Fail to load file");
		
		dispatchEvent(event);
    }
	
	
	private function fileComplete(event : Event) : Void  
	{  
		try
		{
			var loaderFile:Loader = cast(event.target, Loader);
			_image = cast( (loaderFile.content), Bitmap).bitmapData;
			
			if (_drawOffStage)
				draw();
		}
		catch (error : Error)
		{
			Debug.print("[DisplayImage::fileComplete] Fail to convert image");
		}
			
		dispatchEvent(event);
    }
}