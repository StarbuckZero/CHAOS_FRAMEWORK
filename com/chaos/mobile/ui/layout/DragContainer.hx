package com.chaos.mobile.ui.layout;

import com.chaos.mobile.ui.classInterface.IDragContainer;
import openfl.geom.Point;
import openfl.events.MouseEvent;
import openfl.events.Event;
import openfl.display.Sprite;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.layout.BaseContainer;
import com.chaos.ui.layout.classInterface.IBaseContainer;

/**
 * Container that has a Header, Footer and areas for menu systems on the left and right hand side.
 *
 * @author Erick Feiling
 */
class DragContainer extends BaseContainer implements IDragContainer implements IBaseContainer implements IBaseUI {

	public var lockX(get, set):Bool;
	public var lockY(get, set):Bool;

	/**
	* Let you know if the user is moving
	**/

	public var isMoving(get, never):Bool;	

	/**
	* Has ever moved
    **/
        
    public var hasMoved(get, never):Bool;    	

	private var _mask : Sprite;

	private var _defaultMousePos : Point;

	private var _velocity : Int = 0;
	private var _lag : Int = 10;
	private var _offSet : Float = 10;
	private var _target : Point;

	private var _lockX : Bool = false;
	private var _lockY : Bool = false;

	private var _isMoving : Bool = false;
	private var _hasMoved : Bool = false;

	private var _contentBlock : Sprite;

	/**
	 * UI Component
	 * @param	data The proprieties that you want to set on component.
	 */

	public function new(data:Dynamic = null) {
		super(data);
	}

	override function setComponentData(data:Dynamic) {
		super.setComponentData(data);


		if(Reflect.hasField(data,"lockX"))
			_lockX = Reflect.field(data,"lockX");

		if(Reflect.hasField(data,"lockY"))
			_lockY = Reflect.field(data,"lockY");		
	}

	override function initialize() {
		super.initialize();

		_mask = new Sprite();
		_contentBlock = new Sprite();

		mask = _mask;
		addChild(_mask);

		addEventListener(MouseEvent.MOUSE_DOWN, onStartTracking, false, 0, true);

		addEventListener(Event.ADDED_TO_STAGE, onAddToStage, false, 0, true);
		addEventListener(Event.REMOVED_FROM_STAGE, onRemoveToStage, false, 0, true);		
	}

	private function onAddToStage(event:Event) {
		stage.addEventListener(MouseEvent.MOUSE_UP, onStopTracking, false, 0, true);
	}

	private function onRemoveToStage(event:Event) {
		stage.removeEventListener(MouseEvent.MOUSE_UP, onStopTracking);
	}	

	override function draw() {
		super.draw();

		_contentBlock.graphics.clear();
		_contentBlock.graphics.beginFill(0);
		_contentBlock.graphics.drawRect(0,0,_width,_height);
		_contentBlock.graphics.endFill();

		_mask.graphics.clear();
		_mask.graphics.beginFill(0);
		_mask.graphics.drawRect(0,0,_width,_height);
		_mask.graphics.endFill();
		
	}

	private function get_isMoving():Bool
	{
		return _isMoving;
	}	

	private function get_hasMoved():Bool
	{
		return _hasMoved;
	}	
	
	private function set_lockX(value:Bool):Bool {
		
		_lockX = value;
		return _lockX;
	}	
	
	private function get_lockX():Bool{

		return _lockX;
		
	}

	private function set_lockY(value:Bool):Bool {
		
		_lockY = value;
		return _lockY;
	}	
	
	private function get_lockY():Bool{

		return _lockY;
		
	}	

	private function onStartTracking(event:MouseEvent):Void {
		_defaultMousePos = new Point(this.mouseX,this.mouseY);
		addEventListener(Event.ENTER_FRAME, trackMovement, false, 0, true);
		_hasMoved = false;
		_isMoving = false;
	}

	private function onStopTracking(event:MouseEvent):Void {
		removeEventListener(Event.ENTER_FRAME, trackMovement);
		_isMoving = false;
	}	
	
	private function trackMovement(event:Event = null):Void {

		// If click an drag left it's moving right
		if(!_lockX && _content.width > _width) {

			if(this.mouseX < (_defaultMousePos.x - _offSet )) {

				_hasMoved = _isMoving = true; 

				// Move content left
				if(_content.x > (_width - _content.width))
					_content.x = Math.round(_content.x + (_defaultMousePos.x - (_width / 2)) / -_lag);
				else
					_content.x = (_width - _content.width);

			}
			else if(this.mouseX > (_defaultMousePos.x + _offSet))  {

				_hasMoved = _isMoving = true;

				// move content right
				if( _content.x < 0)
				 _content.x = Math.round(_content.x - (_defaultMousePos.x - (_width / 2)) / _lag);
				else
					_content.x = 0;
			 }
			 else 
			{
				_isMoving = false;
			}

		}


		// If click an drag up it's moving down
		if(!_lockY && _content.height > _height) {

			if(this.mouseY < (_defaultMousePos.y - _offSet )) {
				
				_hasMoved = _isMoving = true; 

				// Move content down
				if(_content.y > (_height - _content.height))
					_content.y = Math.round(_content.y + (_defaultMousePos.y - (_height / 2)) / -_lag);
				else
					_content.y = (_height - _content.height);
			}
			else if(this.mouseY > (_defaultMousePos.y + _offSet))  {

				_hasMoved = _isMoving = true;

				// move content up
				if(_content.y < 0)
					_content.y = Math.round(_content.y - (_defaultMousePos.y - (_height / 2)) / _lag);
				else
					_content.y = 0;
			 }
			 else
			{
				_isMoving = false;
			}

		}
	}
}
