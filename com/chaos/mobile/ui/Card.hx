package com.chaos.mobile.ui;

import com.chaos.ui.ButtonBase;
import com.chaos.ui.classInterface.IButtonBase;
import com.chaos.ui.classInterface.IBaseUI;

import openfl.display.Sprite;

class Card extends ButtonBase implements IBaseUI {

    public var content(get, set):Sprite;
    
    private var _content:Sprite = new Sprite();

     /**
      * UI Component 
      * @param	data The proprieties that you want to set on component.
      */
     
      public function new( data:Dynamic = null )
      {
        super(data);
      }
        
     override function setComponentData(data:Dynamic) {
        super.setComponentData(data);

        if (Reflect.hasField(data, "content"))
            _content.addChild(Reflect.field(data, "content"));
            
     }
  
    override function initialize() {

        super.initialize();

        addChild(_content);
    }
  
    override function destroy() {
        super.destroy();

        removeChild(_content);
    } 
       
    private function get_content():Sprite {
        return _content;
    }
    
    private function set_content(value:Sprite):Sprite {

        _content = value;
        return _content;
    }     

}