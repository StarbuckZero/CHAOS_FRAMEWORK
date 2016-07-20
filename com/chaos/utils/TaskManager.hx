package com.chaos.utils;



/**
 * This takes a threads and run them in a queue(remove from bottom) or stack(remove from top)
 *
 * @author Erick Feiling
 */


import com.chaos.data.DataProvider;
import com.chaos.utils.classInterface.ITask;
import com.chaos.utils.event.TaskManagerEvent;

import openfl.display.DisplayObject;
import openfl.display.Stage;

import openfl.events.EventDispatcher;
import openfl.events.Event;
import openfl.events.MouseEvent;

import openfl.utils.Timer;
import openfl.events.TimerEvent;

class TaskManager
{
    public var timerRate(never, set) : Int;
    public var threadType(get, set) : String;
    public var processMode(get, set) : String;
    public var runAllSubThreads(never, set) : Bool;

    
    private static inline var PROCESS_QUEUE_MODE : String = "queue";
    private static inline var PROCESS_STACK_MODE : String = "stack";
    
    private static inline var THREAD_TYPE_TIMER : String = "timer";
    private static inline var THREAD_TYPE_EVENT : String = "event";
    
    private var _processMode : String = "queue";
    private var _threadType : String = "timer";
    
    private var _threadArray : DataProvider;
    private var _subThreadArray : DataProvider;
    
    private var _runAllSubThreads : Bool = true;
    
    private var _timerRate : Int = 100;
    private var _timer : Timer;
    private var _displayObject : DisplayObject;
    
    public var dispatch : EventDispatcher;
    
    /**
	 *
	 * Creates the TaskManger for running threads in background
	 *
	 * @param	displayObj The display object to attach events
	 * @param	threadMode Set the thread mode "timer" which is interval base or "event" which is based on Event.ENTER_FRAME
	 * @param	processMode This could be set to "queue" (First In – First Out) remove task from the bottom or "stack" (First In – Last Out) remove task from the top
	 */
    
    public function new(displayObj : DisplayObject, threadType : String = "timer", processMode : String = "queue")
    {
        
        dispatch = new EventDispatcher();
        
        _threadArray = new DataProvider();
        _subThreadArray = new DataProvider();
        
        _threadType = threadType;
        _processMode = processMode;
        
        // Setting up timer but don't start it
        _timer = new Timer(_timerRate);
        _timer.addEventListener(TimerEvent.TIMER, runTask);
        
        _displayObject = displayObj;
    }
    
    /**
	 * Set the time between when the next thread will run. This only applies if threadMode is set to "timer"
	 */
    
    private function set_timerRate(value : Int) : Int
    {
        _timerRate = value;
		_timer.delay = _timerRate;
		
        return value;
    }
    
    /**
	 * Set the thread mode "timer" which is interval basse or "event" which is based on Event.ENTER_FRAME
	 */
    
    private function set_threadType(value : String) : String
    {
        _threadType = value;
        return value;
    }
    
    /**
	 * Return the the mode
	 */
    
    private function get_threadType() : String
    {
        return _threadType;
    }
    
    /**
	 * Set the "queue" or "stack" mode
	 */
    
    private function set_processMode(value : String) : String
    {
        _processMode = value;
        return value;
    }
    
    /**
	 * Return the mode
	 */
    
    private function get_processMode() : String
    {
        return _processMode;
    }
    
    /**
	 * If true run all the background task at once. If false run only one background task until completion before moving on to the next task.
	 */
    
    private function set_runAllSubThreads(value : Bool) : Bool
    {
        _runAllSubThreads = value;
        return value;
    }
    
    /**
	 * The task that will be running in the background
	 *
	 * @param	thread The task that will be running in the background
	 */
    
    public function add(thread : ITask) : Void
    {
        
        // If there is nothing in the list then start up timer
        if (_threadArray.length == 0 && _subThreadArray.length == 0) 
        {
            // Add in thread object
            _threadArray.addItem(thread);
            
            // If event based then attach enter frame to the display object
            if (_threadType == THREAD_TYPE_EVENT) 
            {
                // If null then don't do anything
                if (null == _displayObject) 
                    return  // Make sure not to attach the event again if already running  ;
                
                
                
                if (!_displayObject.hasEventListener(Event.ENTER_FRAME)) 
                    _displayObject.addEventListener(Event.ENTER_FRAME, runTask);
            }
            // If timer base then just start timer
            else 
            {
                if (!_timer.hasEventListener(TimerEvent.TIMER)) 
                    _timer.addEventListener(TimerEvent.TIMER, runTask);
                
                _timer.start();
            }
            
            dispatch.dispatchEvent(new TaskManagerEvent(TaskManagerEvent.TASK_WAKE));
        }
        else 
        {
            // Add in thread object
            _threadArray.addItem(thread);
        }
    }
    
    /**
	 *
	 * This will remove the task if it's in the list
	 *
	 * @param	thread The task you want to remove from the list
	 */
    
    public function remove(thread : ITask) : Void
    {
        
        // Checking main and sub thread for item
        var index : Int = _threadArray.getItemIndex(thread);
        var indexSub : Int = _subThreadArray.getItemIndex(thread);
        
        // Remove out of the
        if (index != -1) 
        {
            _threadArray.removeItem(thread);
        }
        else if (indexSub != -1) 
        {
            _subThreadArray.removeItem(thread);
        }
    }
    
    /**
	 * This will run all the task that are stored
	 */
    
    public function flush() : Void
    {
        
        removeTimerAndEvent();
        
        var i : Int;
        
        // Flush all of the main thread
        while (_threadArray.length > 0)
        {
            runTask();
        }  // Flush sub threads if there are still some left  
        
        
        
        while (_subThreadArray.length > 0)
        {
            runBackgroundTask();
        }
    }
    
    /**
	 * This will remove all the task without running them
	 */
    
    public function dump() : Void
    {
        removeTimerAndEvent();
        
        var i : Int;
        
        // Flush all of the main thread
        while (_threadArray.length > 0)
        {
            if (_processMode == PROCESS_QUEUE_MODE) 
            {
                (try cast(_threadArray.getItemAt(0), ITask) catch(e:Dynamic) null).clear();
                (try cast(_threadArray.removeItemAt(0), ITask) catch(e:Dynamic) null);
            }
            else if (_processMode == PROCESS_STACK_MODE) 
            {
                (try cast(_threadArray.getItemAt(_threadArray.length - 1), ITask) catch(e:Dynamic) null).clear();
                _threadArray.removeItemAt(_threadArray.length - 1);
            }
        }  
        
        
        // Flush sub threads if there are still some left  
        while (_subThreadArray.length > 0)
        {
            if (_processMode == PROCESS_QUEUE_MODE) 
            {
                (try cast(_subThreadArray.getItemAt(0), ITask) catch(e:Dynamic) null).clear();
                (try cast(_subThreadArray.removeItemAt(0), ITask) catch(e:Dynamic) null);
            }
            else if (_processMode == PROCESS_STACK_MODE) 
            {
                (try cast(_subThreadArray.getItemAt(_subThreadArray.length - 1), ITask) catch(e:Dynamic) null).clear();
                _subThreadArray.removeItemAt(_subThreadArray.length - 1);
            }
        }
    }
    
    public function hasEventListener(type : String) : Bool
    {
        return dispatch.hasEventListener(type);
    }
    
    public function addEventListener(type : String, listener : Dynamic->Void, useCapture : Bool = false, priority : Int = 0, useWeakReference : Bool = false) : Void
    {
        dispatch.addEventListener(type, listener, useCapture, priority, useWeakReference);
    }
    
    public function removeEventListener(type : String, listener : Dynamic->Void, useCapture : Bool = false) : Void
    {
        dispatch.removeEventListener(type, listener, useCapture);
    }
    
    /**
	 * This runs all the main task then the sub task
	 *
	 * @param	event
	 *
	 * @private
	 */
    
    private function runTask(event : Event = null) : Void
    {
        var currentTask : ITask;
        
        // Queue
        if (_processMode == PROCESS_QUEUE_MODE && _threadArray.length > 0) 
        {
            // Removes the first item in the list
            currentTask = try cast(_threadArray.getItemAt(0), ITask) catch(e:Dynamic) null;
            
            // Check to see to make this a sub task
            if (currentTask.end != currentTask.start) 
            {
                _subThreadArray.addItem(currentTask);
            }
            else 
            {
                currentTask.run();
            }
            
			// Once all done if there is no more in list then remove event
            _threadArray.removeItemAt(0);
        }
        else if (_processMode == PROCESS_STACK_MODE && _threadArray.length > 0)  // Stack
        {
   
            // Removes the item at the end
            currentTask = try cast(_threadArray.getItemAt(_threadArray.length - 1), ITask) catch(e:Dynamic) null;
            
            // Check to see to make this a sub task
            if (currentTask.end != currentTask.start) 
            {
                _subThreadArray.addItem(currentTask);
            }
            else 
            {
                currentTask.run();
            }
            
            _threadArray.removeItemAt(_threadArray.length - 1);
        }
        
        
        
        if (_threadType == THREAD_TYPE_EVENT && _threadArray.length == 0 && _subThreadArray.length == 0) 
        {
            // If null then don't do anything
            if (null == _displayObject) 
                return;
            
            _displayObject.removeEventListener(Event.ENTER_FRAME, runTask);
            dispatch.dispatchEvent(new TaskManagerEvent(TaskManagerEvent.TASK_SLEEP));
        }
        // If there are still more threads/task in the list restart timer again
        else if (_threadType == THREAD_TYPE_TIMER && _threadArray.length > 0 && _subThreadArray.length > 0) 
        {
            _timer.start();
        }
        else if (_threadType == THREAD_TYPE_TIMER && _threadArray.length == 0 && _subThreadArray.length == 0) 
        {
			// Remove timer if there are not task left
			// Run all the background process now that current one happen
			
            if (_timer.hasEventListener(TimerEvent.TIMER)) 
                _timer.removeEventListener(TimerEvent.TIMER, runTask);
            
            dispatch.dispatchEvent(new TaskManagerEvent(TaskManagerEvent.TASK_SLEEP));
        }
        
        
        
        runBackgroundTask();
    }
    
    /**
	 * Run any background task that needs to be ran
	 *
	 * @private
	 */
    private function runBackgroundTask() : Void
    {
        
        var currentTask : ITask;
        var i : Int;
        var direction : Int = 1;
        var first : Int = 0;
        var last : Int = _subThreadArray.length;
        
        if (_processMode == PROCESS_STACK_MODE) 
        {
            direction = -1;
            first = last;
            last = 0;
        }
        
        i = first;
        while (i != last){
            // Get the current task
            currentTask = try cast(_subThreadArray.getItemAt(i), ITask) catch(e:Dynamic) null;
            
            if (null == currentTask) 
                {i += direction;continue;
            };
            
            updateBackgroundTask(currentTask);
            
            // Run task
            currentTask.run();
            
            // Removes the first item in the list
            if (currentTask.index == currentTask.end) 
                _subThreadArray.removeItem(currentTask);
				
				
			// Stop current loop
            if (!_runAllSubThreads) 
                break;
            i += direction;
        }
    }
    
    private function updateBackgroundTask(currentTask : ITask) : Void
    {
        if (currentTask.index < currentTask.end) 
        {
            currentTask.index++;
        }
        else if (currentTask.index > currentTask.end) 
        {
            currentTask.index--;
        }
    }
    
    private function removeTimerAndEvent() : Void
    {
        // Stop timers
        _timer.stop();
        
        // If null then don't do anything
        if (null != _displayObject) 
        {
            // Remove event
            if (_displayObject.hasEventListener(Event.ENTER_FRAME)) 
                _displayObject.removeEventListener(Event.ENTER_FRAME, runTask);
        }
    }
}

