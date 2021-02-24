package com.chaos.engine.event;

import flash.events.Event;

/**
	 * ...
	 * @author Erick Feiling
	 */
class EngineDispatchEvent extends Event
{
    public var elementName(get, never) : String;
    public var eventType(get, never) : String;
    public var eventData(get, never) : Dynamic;

    public static inline var ENGINE_EVENT : String = "engine_event";
    public static inline var ENGINE_DISPATCH : String = "engine_dispatch";
    
    private var _elementName : String;
    private var _eventType : String;
    private var _eventData : Dynamic;
    
    public function new(engineEvent : String, elementName : String, eventType : String, eventData : Dynamic, bubbles : Bool = false, cancelable : Bool = false)
    {
        _elementName = elementName;
        _eventType = eventType;
        _eventData = eventData;
        
        super(ENGINE_EVENT, bubbles, cancelable);
    }
    
    override public function clone() : Event
    {
        return new EngineDispatchEvent(type, _elementName, _eventType, _eventData, bubbles, cancelable);
    }
    
    override public function toString() : String
    {
        return formatToString("EngineDispatchEvent", "type", "elementName", "bubbles", "cancelable", "eventPhase");
    }
    
    /**
		 * The name of the object
		 */
    
    private function get_elementName() : String
    {
        return _elementName;
    }
    
    /**
		 * The type of event
		 */
    private function get_eventType() : String
    {
        return _eventType;
    }
    
    /**
		 * The data object
		 */
    
    private function get_eventData() : Dynamic
    {
        return _eventData;
    }
}

