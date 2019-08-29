package com.chaos.drawing;

import com.chaos.ui.BaseUI;

import openfl.display.Shape;

/**
 * Draws a basic Hexagon shape
 */

class Hexagon extends BaseUI
{
	public var color : Int;
	public var fill : Int;
	public var thick : Int;
	
	/**
	 * Creates an Hexagon shape on the fly
	 */
	
	public function new( data:Dynamic = null)
	{
		super(data);
		
		// set defaults
		color = 0x000000; thick = 1;
		fill = 0x666666;
	}
	
	override public function setComponentData(data:Dynamic):Void 
	{
		super.setComponentData(data);
	}

	/**
	 * Set color
	 *
	 * @param _color The color as a hex string
	 */
	
	public function setColor(_color : String) : Void
	{
		color = _color;
	}

	/**
	 * Set the thinkness of the object
	 * @param	_thick The thinkness of the size
	 */

	public function setThick(_thick : Float) : Void
	{
		thick = _thick;
	}
	/**
	 * Set the fill size
	 * @param	_fill The color you want to object to be
	 */
	public function setFill(_fill : String) : Void 
	{
		fill = _fill;
	}

	

	/**
	 *
	 *
	 *
	 * @param	r
	 * @param	x
	 * @param	y
	 * @param	styleMaker
	 */
	
	public function drawHelix(r : Float, x : Float, y : Float, styleMaker : Float) : Void
	{
		graphics.moveTo(x + r, y);
		graphics.lineStyle(thick, color);
		
		var style : Float = Math.tan(styleMaker * Math.PI / 180);
		var angle : Float = 45;

		while (angle <= 360)
		{
			var endX : Float = r * Math.cos(angle * Math.PI / 180);
			var endY : Float = r * Math.sin(angle * Math.PI / 180);
			var cX : Float = endX + r * style * Math.cos(angle - 90 * Math.PI / 180);
			var cY : Float = endY + r * style * Math.sin(angle - 90 * Math.PI / 180);
			graphics.curveTo(cX + x, cY + y, endX + x, endY + y);
			angle += 45;
		}
	}

	/**
	 *
	 * @param	r
	 * @param	x
	 * @param	y
	 * @param	styleMaker
	 */
	public function fillHelix(r : Float, x : Float, y : Float, styleMaker : Float) : Void
	{
		graphics.clear();
		
		graphics.moveTo(x + r, y);
		graphics.lineStyle(thick, color);
		graphics.beginFill(fill);
		
		var style : Float = Math.tan(styleMaker * Math.PI / 180);
		var angle : Float = 45;

		while (angle <= 360)
		{
			var endX : Float = r * Math.cos(angle * Math.PI / 180);
			var endY : Float = r * Math.sin(angle * Math.PI / 180);
			var cX : Float = endX + r * style * Math.cos(angle - 90 * Math.PI / 180);
			var cY : Float = endY + r * style * Math.sin(angle - 90 * Math.PI / 180);
			
			graphics.curveTo(cX + x, cY + y, endX + x, endY + y);
			angle += 45;
		}

		graphics.endFill();
	}
	
	/**
	 *
	 * @param	hexRadius
	 * @param	startX
	 * @param	startY
	 */

	public function drawHexagon(hexRadius : Float, startX:Float, startY:Float) : Void
	{
		var sideC : Float = hexRadius;
		var sideA : Float = 0.5 * sideC;
		var sideB : Float = Math.sqrt(hexRadius * hexRadius - 0.5 * hexRadius * 0.5 * hexRadius);
		

		graphics.lineStyle(thick, color, 100);
		graphics.moveTo(startX, startY);
		graphics.lineTo(startX, sideC + startY);
		graphics.lineTo(sideB + startX, startY + sideA + sideC);

		// bottom point
		graphics.lineTo(2 * sideB + startX, startY + sideC);
		graphics.lineTo(2 * sideB + startX, startY);
		graphics.lineTo(sideB + startX, startY - sideA);
		graphics.lineTo(startX, startY);
	}

	/**
	 *
	 * @param	hexRadius
	 * @param	startX
	 * @param	startY
	 */
	public function fillHexagon(hexRadius : Float, startX:Float, startY:Float) : Void
	{
		var sideC : Float = hexRadius;
		var sideA : Float = 0.5 * sideC;
		var sideB : Float = Math.sqrt(hexRadius * hexRadius - 0.5 * hexRadius * 0.5 * hexRadius);

		graphics.lineStyle(thick, color, 100);
		graphics.beginFill(fill);
		graphics.moveTo(startX, startY);
		graphics.lineTo(startX, sideC + startY);
		graphics.lineTo(sideB + startX, startY + sideA + sideC);

		// bottom point
		graphics.lineTo(2 * sideB + startX, startY + sideC);
		graphics.lineTo(2 * sideB + startX, startY);
		graphics.lineTo(sideB + startX, startY - sideA);
		graphics.lineTo(startX, startY);
		graphics.endFill();
	}
}