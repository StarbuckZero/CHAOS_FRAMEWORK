package com.chaos.drawing;


import com.chaos.media.DisplayAnimation;
import com.chaos.media.DisplayImage;
import com.chaos.media.DisplayVideo;
import com.chaos.ui.BaseUI;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.layout.BaseContainer;
import com.chaos.ui.layout.classInterface.IBaseContainer;
import com.chaos.utils.Debug;
import openfl.display.BitmapData;

/**
 * A place to draw shapes and load media objects.
 * @author Erick Feiling
 */
class Canvas extends BaseContainer implements IBaseContainer implements IBaseUI 
{

	public function new(data:Dynamic=null) 
	{
		super(data);
	}
	
	override public function setComponentData(data:Dynamic):Void 
	{
		super.setComponentData(data);
		
		if (Reflect.hasField(data, "data"))
		{
			var data:Array<Dynamic> = Reflect.field(data, "data");
			
			for (i in 0 ... data.length)
			{
				var canvasData:Dynamic = data[i];
				
				var obj:Dynamic = {};
				var objectName:String = "";
				var layerName:String = "";
				
				var locX:Int = 0;
				var locY:Int = 0;
				
				var shapeWidth:Int = 0;
				var shapeHeight:Int = 0;
				var shapeAlpha:Float = 1;
				
				var color:Int = 0xFFFFF;
				
				var url:String = "";
				
				var thinkness:Int = 1;
				
				var image:BitmapData = null;
				var tile:Bool = true;
				
				if (Reflect.hasField(canvasData, "Layer") )
				{
					obj = Reflect.field(canvasData, "Layer");
					
					if (Reflect.hasField(obj, "name"))
						addLayer(Reflect.field(obj, "name"));
				}
				else if (Reflect.hasField(canvasData, "Image"))
				{
					obj = Reflect.field(canvasData, "Image");
					
					if (Reflect.hasField(obj, "layerName"))
						layerName = Reflect.field(obj, "layerName");
					
					if (Reflect.hasField(obj, "name"))
						objectName = Reflect.field(obj, "name");
					
					if (Reflect.hasField(obj, "x"))
						locX = Reflect.field(obj, "x");
					
					if (Reflect.hasField(obj, "y"))
						locY = Reflect.field(obj, "y");
					
					if (Reflect.hasField(obj, "url"))
						url = Reflect.field(obj, "url");
						
					addImage(objectName, layerName, url, locX, locY);
				}
				else if (Reflect.hasField(canvasData, "Square"))
				{
					
					obj = Reflect.field(canvasData, "Square");
					
					if (Reflect.hasField(obj, "layerName"))
						layerName = Reflect.field(obj, "layerName");
					
					if (Reflect.hasField(obj, "name"))
						objectName = Reflect.field(obj, "name");
					
					if (Reflect.hasField(obj, "width"))
						shapeWidth = Reflect.field(obj, "height");
					
					if (Reflect.hasField(obj, "height"))
						shapeHeight = Reflect.field(obj, "height");
						
					if (Reflect.hasField(obj, "x"))
						locX = Reflect.field(obj, "x");
					
					if (Reflect.hasField(obj, "y"))
						locY = Reflect.field(obj, "y");
					
					if (Reflect.hasField(obj, "color"))
						color = Reflect.field(obj, "color");
						
					if (Reflect.hasField(obj, "alpha"))
						shapeAlpha = Reflect.field(obj, "alpha");
						
					if (Reflect.hasField(obj, "image"))
						image = Reflect.field(obj, "image");
						
					if (Reflect.hasField(obj, "tile"))
						tile = Reflect.field(obj, "tile");
						
					addSquare(objectName, layerName, locX, locY, shapeWidth, shapeHeight, color, shapeAlpha, image, tile);
				}
				else if (Reflect.hasField(canvasData, "RoundSquare"))
				{
					var roundEdge:Int = 0;
					
					obj = Reflect.field(canvasData, "RoundSquare");
					
					if (Reflect.hasField(obj, "layerName"))
						layerName = Reflect.field(obj, "layerName");
					
					if (Reflect.hasField(obj, "name"))
						objectName = Reflect.field(obj, "name");
					
					if (Reflect.hasField(obj, "width"))
						shapeWidth = Reflect.field(obj, "height");
					
					if (Reflect.hasField(obj, "height"))
						shapeHeight = Reflect.field(obj, "height");
						
					if (Reflect.hasField(obj, "x"))
						locX = Reflect.field(obj, "x");
					
					if (Reflect.hasField(obj, "y"))
						locY = Reflect.field(obj, "y");
					
					if (Reflect.hasField(obj, "color"))
						color = Reflect.field(obj, "color");
						
					if (Reflect.hasField(obj, "alpha"))
						shapeAlpha = Reflect.field(obj, "alpha");	
					
					if (Reflect.hasField(obj, "roundEdge"))
						roundEdge = Reflect.field(obj, "roundEdge");	
						
					if (Reflect.hasField(obj, "image"))
						image = Reflect.field(obj, "image");
						
					if (Reflect.hasField(obj, "tile"))
						tile = Reflect.field(obj, "tile");
						
					addRoundSquare(objectName, layerName, locX, locY, shapeWidth, shapeHeight, color, roundEdge, shapeAlpha, image, tile);
				}
				else if (Reflect.hasField(canvasData, "SquareOutline"))
				{
					obj = Reflect.field(canvasData, "SquareOutline");
					
					if (Reflect.hasField(obj, "layerName"))
						layerName = Reflect.field(obj, "layerName");
					
					if (Reflect.hasField(obj, "name"))
						objectName = Reflect.field(obj, "name");
					
					if (Reflect.hasField(obj, "width"))
						shapeWidth = Reflect.field(obj, "height");
					
					if (Reflect.hasField(obj, "height"))
						shapeHeight = Reflect.field(obj, "height");
						
					if (Reflect.hasField(obj, "x"))
						locX = Reflect.field(obj, "x");
					
					if (Reflect.hasField(obj, "y"))
						locY = Reflect.field(obj, "y");
					
					if (Reflect.hasField(obj, "color"))
						color = Reflect.field(obj, "color");
						
					if (Reflect.hasField(obj, "alpha"))
						shapeAlpha = Reflect.field(obj, "alpha");	
					
					if (Reflect.hasField(obj, "thinkness"))
						thinkness = Reflect.field(obj, "thinkness");	
						
					addSquareOutline(objectName, layerName, locX, locY, shapeWidth, shapeHeight, color, thinkness, shapeAlpha);
					
				}
				else if (Reflect.hasField(canvasData, "CircleOutline"))
				{
					obj = Reflect.field(canvasData, "CircleOutline");
					
					var radius:Int = 0;
					
					if (Reflect.hasField(obj, "layerName"))
						layerName = Reflect.field(obj, "layerName");
					
					if (Reflect.hasField(obj, "name"))
						objectName = Reflect.field(obj, "name");
					
					if (Reflect.hasField(obj, "radius"))
						radius = Reflect.field(obj, "radius");
						
					if (Reflect.hasField(obj, "x"))
						locX = Reflect.field(obj, "x");
					
					if (Reflect.hasField(obj, "y"))
						locY = Reflect.field(obj, "y");
					
					if (Reflect.hasField(obj, "color"))
						color = Reflect.field(obj, "color");
						
					if (Reflect.hasField(obj, "alpha"))
						shapeAlpha = Reflect.field(obj, "alpha");	
					
					if (Reflect.hasField(obj, "thinkness"))
						thinkness = Reflect.field(obj, "thinkness");	
						
					addCircleOutline(objectName, layerName, locX, locY, radius, color, thinkness, shapeAlpha);
				}			
				else if (Reflect.hasField(canvasData, "Circle"))
				{
					
					obj = Reflect.field(canvasData, "Circle");
					
					var radius:Int = 0;
					
					if (Reflect.hasField(obj, "layerName"))
						layerName = Reflect.field(obj, "layerName");
					
					if (Reflect.hasField(obj, "name"))
						objectName = Reflect.field(obj, "name");
					
					if (Reflect.hasField(obj, "radius"))
						radius = Reflect.field(obj, "radius");
						
					if (Reflect.hasField(obj, "x"))
						locX = Reflect.field(obj, "x");
					
					if (Reflect.hasField(obj, "y"))
						locY = Reflect.field(obj, "y");
					
					if (Reflect.hasField(obj, "color"))
						color = Reflect.field(obj, "color");
						
					if (Reflect.hasField(obj, "alpha"))
						shapeAlpha = Reflect.field(obj, "alpha");
						
					if (Reflect.hasField(obj, "image"))
						image = Reflect.field(obj, "image");
						
					if (Reflect.hasField(obj, "tile"))
						tile = Reflect.field(obj, "tile");
						
					addCircle(objectName, layerName, locX, locY, radius, color, shapeAlpha, image, tile);
				}
				else if (Reflect.hasField(canvasData, "Line"))
				{
					var startX:Int = 0;
					var startY:Int = 0;
					
					var endX:Int = 0;
					var endY:Int = 0;
					
					obj = Reflect.field(canvasData, "Line");
					
					if (Reflect.hasField(obj, "layerName"))
						layerName = Reflect.field(obj, "layerName");
					
					if (Reflect.hasField(obj, "name"))
						objectName = Reflect.field(obj, "name");
					
					if (Reflect.hasField(obj, "width"))
						shapeWidth = Reflect.field(obj, "height");
					
					if (Reflect.hasField(obj, "height"))
						shapeHeight = Reflect.field(obj, "height");
						
						
					if (Reflect.hasField(obj, "startX"))
						startX = Reflect.field(obj, "startX");
					
					if (Reflect.hasField(obj, "startY"))
						startY = Reflect.field(obj, "startY");

					if (Reflect.hasField(obj, "endX"))
						endX = Reflect.field(obj, "endX");
					
					if (Reflect.hasField(obj, "endY"))
						endY = Reflect.field(obj, "endY");
						
						
					if (Reflect.hasField(obj, "x"))
						locX = Reflect.field(obj, "x");
					
					if (Reflect.hasField(obj, "y"))
						locY = Reflect.field(obj, "y");
					
					if (Reflect.hasField(obj, "color"))
						color = Reflect.field(obj, "color");
						
					if (Reflect.hasField(obj, "alpha"))
						shapeAlpha = Reflect.field(obj, "alpha");	
					
					if (Reflect.hasField(obj, "thinkness"))
						thinkness = Reflect.field(obj, "thinkness");		
						
						
					addLine(objectName, layerName, locX, locY, startX, startY, endX, endY, color, thinkness, shapeAlpha);
					
				}
				
				
				
			}
			
		}
	}
	
	/**
	 * Create a layer to store shapes
	 * @param	layerName the name of the layer
	 */
	
	public function addLayer( layerName:String ) : Void
	{
		if (contentObject.getChildByName(layerName) == null)
			contentObject.addChild(new BaseUI({"name":layerName}));
	}
	
	/**
	 *  Remove layer
	 * @param	layerName the name of the layer
	 */
	
	public function removeLayer( layerName:String ) : Void
	{
		if (contentObject.getChildByName(layerName) != null)
			contentObject.removeChild(contentObject.getChildByName(layerName));
	}
	
	/**
	 * Get layer
	 * @param	layerName The name of the layer
	 * @return A BaseUI object
	 */
	
	public function getLayer(layerName:String) : BaseUI
	{
		var layer:BaseUI = cast(contentObject.getChildByName(layerName), BaseUI);
		
		// Check for layer
		if (layer != null)
			return layer;
		else
			Debug.print("[Canvas::getLayer] Uanble to find " + layerName + " layer.");
		
		return null;
	}
	
	/**
	 * Get element in layer 
	 * @param	elementName Name of element you'll trying to get.
	 * @param	layerName Name of layer element is in
	 * @return BaseUI object if it was found and null if not
	 */
	
	public function getElement(elementName:String, layerName:String) : BaseUI
	{
		var layer:BaseUI = cast(contentObject.getChildByName(layerName), BaseUI);
		
		if (layer != null)
		{
			var element:BaseUI = cast(layer.getChildByName(elementName), BaseUI);
			
			if (element != null)
				return element;
			else
				Debug.print("[Canvas::geElement] Uanble to find element " + elementName + " in layer " + layerName );
			 
		}
		else
			Debug.print("[Canvas::geElement] Uanble to find " + layerName + " layer.");
			
		return null;
	}
	
	/**
	 * Load a video from a url
	 * @param	videoName Name of video
	 * @param	layerName The layer it should be displayed in
	 * @param	url The URL to the video
	 * @param	locX The location on X axis
	 * @param	locY The location on Y axis
	 * @param	autoStart start video soon as it's loaded
	 */
	
	public function addVideo(videoName:String, layerName:String, url:String, locX:Int, locY:Int, autoStart:Bool = false) : Void
	{
		var video:DisplayVideo = new DisplayVideo({"name":videoName, "autoStart":autoStart , "url":url, "x":locX, "y":locY});
		
		addToLayer(layerName, video);
	}
	
	/**
	 * Load an image from a url
	 * 
	 * @param	imageName Name of image
	 * @param	layerName The name of the layer image will be added to
	 * @param	url The location of the image on the net
	 * @param	locX The location on X axis
	 * @param	locY The location on Y axis
	 */
	
	public function addImage(imageName:String, layerName:String, url:String, locX:Int, locY:Int) : Void
	{
		
		var image:DisplayImage = new DisplayImage({"name":imageName, "url":url, "x":locX, "y":locY});
		
		addToLayer(layerName, image);
	}
	
	/**
	 * Adds a element to a layer
	 * @param	element The object that you want to add
	 * @param	layerName The name of the layer image will be added to
	 */
	
	public function addElement( element:BaseUI, layerName:String):Void
	{
		addToLayer(layerName, element);	
	}
 
    /**
	 * Draw a square
	 *
	 * @param	shapeName The name of the shape
	 * @param	layerName The name of the layer
	 * @param	locX The location on X axis
	 * @param	locY The location on Y axis
	 * @param	shapeWidth The width of the object
	 * @param	shapeHeight The height of the object
	 * @param	color The color
	 * @param	alpha The alpha from 0 to 1
	 * @param	image An image to fill the object with
	 * @param	tile the image that is being used
	 *
	 */
    
    public function addSquare( shapeName:String, layerName:String, locX:Int, locY:Int, shapeWidth : Int, shapeHeight : Int, color : Int, alpha : Float = 1, image : BitmapData = null, tileImage : Bool = true) : Void
    {
        var square : BaseUI = new BaseUI({"name":shapeName, "x":locX, "y":locY});
        
        if (null != image) 
            square.graphics.beginBitmapFill(image, null, tileImage, _smoothImage);
        else 
            square.graphics.beginFill(color, alpha);
        
        square.graphics.drawRect(0, 0, shapeWidth, shapeHeight);
        square.graphics.endFill();
        
		addToLayer(layerName, square);
    }
    
    /**
	 * Draw a rounded square
	 *
	 * @param	shapeName the name of the shape
	 * @param	layerName the name of the layer
	 * @param	locX The location on X axis
	 * @param	locY The location on Y axis
	 * @param	shapeWidth The width of the object
	 * @param	shapeHeight The height of the object
	 * @param	color The color
	 * @param	how arounded you want the square
	 * @param	alpha The alpha from 0 to 1
	 * @param	image An image to fill the object with
	 * @param	tileImage Repeact image with tile effect
	 *
	 */
    
    public function addRoundSquare(shapeName:String, layerName:String, locX:Int, locY:Int, shapeWidth : Int, shapeHeight : Int, color : Int, roundEdge : Int = 0, alpha : Float = 1, image : BitmapData = null, tileImage : Bool = true) : Void
    {
        var square : BaseUI = new BaseUI({"name":shapeName, "x":locX, "y":locY});
        
        if (null != image) 
            square.graphics.beginBitmapFill(image, null, tileImage, _smoothImage);
        else 
            square.graphics.beginFill(color, alpha);
        
        square.graphics.drawRoundRect(0, 0, shapeWidth, shapeHeight, roundEdge);
        square.graphics.endFill();
		
		addToLayer(layerName, square);

    }
    
    /**
	 * Draw a square will not fill color
	 *
	 * @param	shapeName the name of the shape
	 * @param	layerName the name of the layer
	 * @param	locX The location on X axis
	 * @param	locY The location on Y axis
	 * @param	shapeWidth The width of the object
	 * @param	shapeHeight The height of the object
	 * @param	outlineColor The color of the lines
	 * @param	thickness The thinkess of the lines
	 * @param	alpha The alpha from 0 to 1
	 *
	 */
    
    public function addSquareOutline(shapeName:String, layerName:String, locX:Int, locY:Int, shapeWidth : Int, shapeHeight : Int, outlineColor : Int, thickness : Int, alpha : Float = 1) : Void
    {
        var square : BaseUI = new BaseUI({"name":shapeName, "x":locX, "y":locY});
        
        square.graphics.lineStyle(thickness, outlineColor, alpha);
        square.graphics.drawRect(0, 0, shapeWidth, shapeHeight);
        square.graphics.endFill();
		
		addToLayer(layerName, square);
		
    }
	/**
	 * Draw circle
	 * 
	 * @param	shapeName the name of the shape
	 * @param	layerName the name of the layer
	 * @param	locX The location on X axis
	 * @param	locY The location on Y axis
	 * @param	radius How round the object will be
	 * @param	color The color
	 * @param	alpha The alpha from 0 to 1
	 * @param	image An image to fill the object with
	 * @param	tileImage Repeact image with tile effect
	 */
	
	public function addCircle(shapeName:String, layerName:String, locX:Int, locY:Int, radius:Float, color : Int, alpha : Float = 1, image : BitmapData = null, tileImage : Bool = true) : Void
	{
		var circle : BaseUI = new BaseUI({"name":shapeName, "x":locX, "y":locY});
		
		circle.graphics.beginFill(color, alpha);
		circle.graphics.drawCircle(0, 0, radius);
		circle.graphics.endFill();
		
		addToLayer(layerName, circle);
	}
	
	/**
	 * 
	 * @param	shapeName the name of the shape
	 * @param	layerName the name of the layer
	 * @param	locX The location on X axis
	 * @param	locY The location on Y axis
	 * @param	radius How round the object will be
	 * @param	outlineColor The color of the lines
	 * @param	thickness The thinkess of the lines
	 * @param	alpha The alpha from 0 to 1
	 */
	
	public function addCircleOutline(shapeName:String, layerName:String, locX:Int, locY:Int, radius:Float, outlineColor : Int, thickness : Int, alpha : Float = 1) : Void
	{
		var circle : BaseUI = new BaseUI({"name":shapeName, "x":locX, "y":locY});
		
		circle.graphics.lineStyle(thickness, outlineColor, alpha);
		circle.graphics.drawCircle(0, 0, radius);
		circle.graphics.endFill();
		
		addToLayer(layerName, circle);
	}
    
    /**
	 * Draws a line
	 *
	 * @param	shapeName the name of the shape
	 * @param	layerName the name of the layer
	 * @param	locX The location on X axis
	 * @param	locY The location on Y axis
	 * @param	startX Starting point X
	 * @param	startY Starting point Y
	 * @param	endX End point X
	 * @param	endY End point Y
	 * @param	color The color of the line
	 * @param	thickness The thinkess of the lines
	 * @param	alpha The alpha from 0 to 1
	 *
	 */
    
    public function addLine(shapeName:String, layerName:String, locX:Int, locY:Int, startX : Int, startY : Int, endX : Int, endY : Int, color : Int, thickness : Int, alpha : Float = 1, bitmapMode : Bool = false, bitmapSmoothing : Bool = false) : Void
    {
        var line : BaseUI = new BaseUI({"name":shapeName, "x":locX, "y":locY});
        
        line.graphics.lineStyle(thickness, color, alpha);
        line.graphics.moveTo(startX, startY);
        line.graphics.lineTo(endX, endY);
        line.graphics.endFill();
        
		addToLayer(layerName, line);
    }
	
	
	private function addToLayer(layerName:String, element:BaseUI ):Void
	{
		if (contentObject.getChildByName(layerName) != null)
			cast(contentObject.getChildByName(layerName), BaseUI).addChild(element);
	}
	
}