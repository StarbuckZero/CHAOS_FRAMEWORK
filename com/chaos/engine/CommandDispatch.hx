package com.chaos.engine;

import haxe.Constraints.Function;
import com.chaos.engine.event.EngineDispatchEvent;
import com.chaos.form.ui.classInterface.IFormUI;
import com.chaos.ui.event.MenuEvent;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.classInterface.ICheckBoxGroup;
import com.chaos.ui.classInterface.IComboBox;
import com.chaos.ui.classInterface.IGridPane;
import com.chaos.ui.classInterface.IItemPane;
import com.chaos.ui.classInterface.IListBox;
import com.chaos.ui.classInterface.IMenu;
import com.chaos.ui.classInterface.IProgressBar;
import com.chaos.ui.classInterface.IRadioButton;
import com.chaos.ui.classInterface.IRadioButtonGroup;
import com.chaos.ui.classInterface.ISlider;
import com.chaos.ui.classInterface.ITextInput;
import com.chaos.ui.classInterface.IToggleButton;
import com.chaos.utils.Debug;
import openfl.events.Event;
import openfl.events.EventDispatcher;

/**
* Event Dispatch system for the engine
* 
* @author Erick Feiling
*/
class CommandDispatch
{
    
    
    private static var eventList : Dynamic = {};
    private static var _eventDispatcher : EventDispatcher = new EventDispatcher();
    
    public function new()
    {
    }
    
    public static function dispatch(elementName : String, eventType : String, eventData : Dynamic) : Void
    {
        _eventDispatcher.dispatchEvent(new EngineDispatchEvent(EngineDispatchEvent.ENGINE_DISPATCH, elementName, eventType, eventData));
    }
    
    public static function addEngineListener(callBack : Dynamic->Void) : Void
    {
        _eventDispatcher.addEventListener(EngineDispatchEvent.ENGINE_EVENT, callBack);
    }
    
    public static function removeEngineListener(callBack : Dynamic->Void) : Void
    {
        _eventDispatcher.removeEventListener(EngineDispatchEvent.ENGINE_EVENT, callBack);
    }
    
    public static function attachEvent(element : IBaseUI, eventType : String) : Void
    {
        var eventObj : Dynamic;
        
        if (Reflect.hasField(eventList, element.name))
        {
            eventObj = Reflect.field(eventList, Std.string(element.name));
        }
        else
        {
            Reflect.setField(eventList, Std.string(element.name), {});
            eventObj = Reflect.field(eventList, Std.string(element.name));
        }
            
        
        // Check to see if even is already in list
        if (Reflect.hasField(eventObj, eventType))
        {
            Debug.print("[CommandDispatch::attachEvent] Event has already been set.");
            return;
        }
        
        Reflect.setField(eventObj, eventType, eventType);
        
        element.addEventListener(eventType, triggerEvent);
    }
    
    public static function removeEvent(element : IBaseUI, eventType : String) : Void
    {
        var eventObj : Dynamic;
        
        if (eventList.exists(element.name))
        {
            eventObj = Reflect.field(eventList, Std.string(element.name));
        }
        else
        {
            Reflect.setField(eventList, Std.string(element.name), {});
            eventObj = Reflect.field(eventList, Std.string(element.name));
        }
        
        element.removeEventListener(eventType, triggerEvent);
        Reflect.deleteField(eventObj, eventType);
    }
    
    public static function removeAllEvents(element : IBaseUI) : Void
    {
        for (index in Reflect.fields(eventList))
        {
            var eventObj : Dynamic = Reflect.field(eventList, index);
            
            for (subIndex in Reflect.fields(eventObj))
            {
                element.removeEventListener(subIndex, triggerEvent);
                Reflect.deleteField(eventObj, subIndex);
            }
        }
    }
    
    private static function triggerEvent(event : Event) : Void
    {
        var eventData : Dynamic = {};
        
        // Special cases based on type
        if (Std.is(event.currentTarget, IToggleButton))
        {
            Reflect.setField(eventData, "selected", cast(event.currentTarget, IToggleButton).selected);
        }
        else if (Std.is(event.currentTarget, IRadioButtonGroup))
        {
            var radioBtn : IRadioButton = cast(event.currentTarget, IRadioButtonGroup).getSelected();
            Reflect.setField(eventData, "radioButtonName", radioBtn.name);
            Reflect.setField(eventData, "groupName", radioBtn.groupName);
        }
        else if (Std.is(event.currentTarget, ICheckBoxGroup))
        {
            Reflect.setField(eventData, "selectedItems", cast(event.currentTarget, ICheckBoxGroup).getSelected());
        }
        else if (Std.is(event.currentTarget, IComboBox))
        {
            Reflect.setField(eventData, "selectedText", cast(event.currentTarget, IComboBox).getSelected().text);
            Reflect.setField(eventData, "selectedValue", cast(event.currentTarget, IComboBox).getSelected().value);
            Reflect.setField(eventData, "selectedIndex", cast(event.currentTarget, IComboBox).selectedIndex);
        }
        else if (Std.is(event.currentTarget, IListBox))
        {
            var tempList : IListBox = cast(event.currentTarget, IListBox);
            Reflect.setField(eventData, "selectedValue", tempList.getSelected().value);
            Reflect.setField(eventData, "selectedText", tempList.getSelected().text);
            Reflect.setField(eventData, "selectedIndex", tempList.selectIndex());
            
            if (tempList.allowMultipleSelection)
                Reflect.setField(eventData, "selectedItems", tempList.getSelectedList());
        }
        else if (Std.is(event.currentTarget, IItemPane))
        {
            var tempItemPane : IItemPane = cast(event.currentTarget, IItemPane);
            
            Reflect.setField(eventData, "selectedValue", tempItemPane.getSelected().value);
            Reflect.setField(eventData, "selectedText", tempItemPane.getSelected().text);
            Reflect.setField(eventData, "selectedIndex", tempItemPane.selectIndex);
            
            if (tempItemPane.allowMultipleSelection)
                Reflect.setField(eventData, "selectedItems", tempItemPane.getSelectedList());
        }
        else if (Std.is(event.currentTarget, ITextInput))
        {
            Reflect.setField(eventData, "text", cast(event.currentTarget, ITextInput).text);
        }
        else if (Std.is(event.currentTarget, ISlider))
        {
            Reflect.setField(eventData, "percent", cast(event.currentTarget, ISlider).percent);
        }
        else if (Std.is(event.currentTarget, IGridPane))
        {
            var formObj : IFormUI = cast(event.currentTarget, IGridPane).getSelectedElement();
            
            Reflect.setField(eventData, "selectedRow", cast(event.currentTarget, IGridPane).selectedRow);
            Reflect.setField(eventData, "selectedCol", cast(event.currentTarget, IGridPane).selectedCol);
            
            if (null != formObj)
                Reflect.setField(eventData, "cellValue", formObj.getValue());
        }
        else if (Std.is(event.currentTarget, IMenu) && Std.is(event, MenuEvent))
        {
            if (null != cast(event, MenuEvent).menuItem)
                Reflect.setField(eventData, "selectedButton", cast(event, MenuEvent).menuItem.name);
        }
        else if (Std.is(event.currentTarget, IProgressBar))
        {
            Reflect.setField(eventData, "percent", cast(event.currentTarget, IProgressBar).percent);
        }
        
        dispatch(cast(event.currentTarget,IBaseUI).name, event.type, eventData);
    }
}

