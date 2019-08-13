package com.chaos.drawing;

import openfl.display.Shape;
/**
 * Draws a basic Hexagon shape
 *
 * @author Erick Feiling
 * @date August 2007
 */

class Hexagon
{
	public var canvas : Shape;
	public var color : Int;
	public var fill : Int;
	public var thick : Int;
	/**
	 * Creates an Hexagon shape on the fly
	 */
	public function new()
	{
		canvas = new Shape();

		// set defaults
		color = 0x000000; thick = 1;
		fill = 0x666666;
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
	 * Change the swap depth
	 * @param	_depth
	 */
	public function changeDepth(_depth : Int) : Void
	{
		canvas.swapDepths(_depth);
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
		canvas.graphics.moveTo(x + r, y);
		canvas.graphics.lineStyle(thick, color);
		var style : Float = Math.tan(styleMaker * Math.PI / 180);
		var angle : Float = 45;

		while (angle <= 360)
		{
			var endX : Float = r * Math.cos(angle * Math.PI / 180);
			var endY : Float = r * Math.sin(angle * Math.PI / 180);
			var cX : Float = endX + r * style * Math.cos(angle - 90 * Math.PI / 180);
			var cY : Float = endY + r * style * Math.sin(angle - 90 * Math.PI / 180);
			canvas.graphics.curveTo(cX + x, cY + y, endX + x, endY + y);
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
		canvas.graphics.moveTo(x + r, y);
		canvas.graphics.lineStyle(thick, color);
		canvas.graphics.beginFill(fill);
		var style : Float = Math.tan(styleMaker * Math.PI / 180);
		var angle : Float = 45;

		while (angle <= 360)
		{
			var endX : Float = r * Math.cos(angle * Math.PI / 180);
			var endY : Float = r * Math.sin(angle * Math.PI / 180);
			var cX : Float = endX + r * style * Math.cos(angle - 90 * Math.PI / 180);
			var cY : Float = endY + r * style * Math.sin(angle - 90 * Math.PI / 180);
			canvas.graphics.curveTo(cX + x, cY + y, endX + x, endY + y);
			angle += 45;
		}

		canvas.graphics.endFill();
	}
	/**
	 *
	 * @param	hexRadius
	 * @param	startX
	 * @param	startY
	 */

	public function drawHexagon(hexRadius : Float, startX startY) : Void
	{
		var sideC : Float = hexRadius;
		var sideA : Float = 0.5 * sideC;
		var sideB : Float = Math.sqrt(hexRadius * hexRadius - 0.5 * hexRadius * 0.5 * hexRadius);

		canvas.graphics.lineStyle(thick, color, 100);
		canvas.graphics.moveTo(startX, startY);
		canvas.graphics.lineTo(startX, sideC + startY);
		canvas.graphics.lineTo(sideB + startX, startY + sideA + sideC);

		// bottom point
		canvas.graphics.lineTo(2 * sideB + startX, startY + sideC);
		canvas.graphics.lineTo(2 * sideB + startX, startY);
		canvas.graphics.lineTo(sideB + startX, startY - sideA);
		canvas.graphics.lineTo(startX, startY);
	}

	/**
	 *
	 * @param	hexRadius
	 * @param	startX
	 * @param	startY
	 */
	public function fillHexagon(hexRadius : Float, startX startY) : Void
	{
		var sideC : Float = hexRadius;
		var sideA : Float = 0.5 * sideC;
		var sideB : Float = Math.sqrt(hexRadius * hexRadius - 0.5 * hexRadius * 0.5 * hexRadius);

		canvas.graphics.lineStyle(thick, color, 100);
		canvas.graphics.beginFill(fill);
		canvas.graphics.moveTo(startX, startY);
		canvas.graphics.lineTo(startX, sideC + startY);
		canvas.graphics.lineTo(sideB + startX, startY + sideA + sideC);

		// bottom point
		canvas.graphics.lineTo(2 * sideB + startX, startY + sideC);
		canvas.graphics.lineTo(2 * sideB + startX, startY);
		canvas.graphics.lineTo(sideB + startX, startY - sideA);
		canvas.graphics.lineTo(startX, startY); canvas.graphics.endFill();
	}
}