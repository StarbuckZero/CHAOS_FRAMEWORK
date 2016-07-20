package com.chaos.utils;


/**
 * Helps run task in the background
 *
 * @author Erick Feiling
 */

import com.chaos.data.DataProvider;
import com.chaos.utils.classInterface.ITask;
import com.chaos.utils.TaskManager;

import openfl.display.DisplayObject;
import openfl.display.Stage;
import openfl.events.Event;
import openfl.utils.Dictionary;

import com.chaos.utils.Debug;

@:final class ThreadManager
{
    public static var stage(get, set) : Stage;

    
    public static inline var PROCESS_QUEUE_MODE : String = "queue";
    public static inline var PROCESS_STACK_MODE : String = "stack";
    
    public static inline var THREAD_TYPE_TIMER : String = "timer";
    public static inline var THREAD_TYPE_EVENT : String = "event";
    
    private static var _stage : Stage = null;
    private static var eventCollection : DataProvider = new DataProvider();
    private static var taskCollection : Dictionary<String,TaskManager> = new Dictionary<String,TaskManager>(true);
    
    /**
	 * Used for background task and a main place to store events for the framework. This keeps all ENTER_FRAME events in one place for the framework.
	 */
    
    public function new()
    {
        
    }
    
    /**
	 * Set the stage that will be used for running task on timer
	 */
    
    private static function set_stage(stage : Stage) : Stage
    {
        // If already set then do nothing
        if (null != _stage) 
            return null;  
        
        
        // Set stage
        _stage = stage;
        return stage;
    }
    
    /**
	 * Return the stage if not set then should be null
	 */
    
    private static function get_stage() : Stage
    {
        return _stage;
    }
    
    /**
	 *  The function in a timer based on a enter frame event.
	 * @param	func The function you want to add event list
	 */
    
    public static function addEventTimer(func : haxe.Constraints.Function) : Void
    {
        // If value passed in wasn't null then setup event
        if (null == _stage) 
        {
            Debug.print("[ThreadManager::addEventTimer] Must set the stage property in order to use this. For example ThreadManager.stage = myDis.stage!");
            return;
        }
        
        eventCollection.addItem(func);
        
        // Start up timer
        if (eventCollection.length > 0) 
            _stage.addEventListener(Event.ENTER_FRAME, updateEnterFrame);
    }
    
    /**
	 * Remove the function out of the event timer list
	 * @param	func The function you want to remove.
	 */
    
    public static function removeEventTimer(func : haxe.Constraints.Function) : Void
    {
        
        // If value passed in wasn't null then setup event
        if (null == _stage) 
        {
            return;
            Debug.print("[ThreadManager::removeEventTimer] Must set the stage property in order to use this. For example \"ThreadManager.stage = myDis.stage\"!");
        }
        
		// Stop timer
        if (eventCollection.getItemIndex(func) != -1) 
            eventCollection.removeItem(func);
        
        
        
        if (eventCollection.length == 0) 
            _stage.removeEventListener(Event.ENTER_FRAME, updateEnterFrame);
    }
    
    /**
	 *
	 * This creates a new task manager. This is used to run functions or task in the background.
	 *
	 * @param	id The id or name of the task manager
	 * @param	disObj The display object. This is used for the event or "ENTER_FRAME" mode.
	 * @param	threadType  Set the thread mode "timer" which is interval basse or "event" which is based on Event.ENTER_FRAME
	 * @param	processMode This could be set to "queue" (First In – First Out) remove task from the bottom or "stack" (First In – Last Out) remove task from the top
	 *
	 * @return Returns the task manager that was created.
	 */
    
    public static function createTaskManager(id : String, disObj : DisplayObject = null, threadType : String = "timer", processMode : String = "queue") : TaskManager
    {
        if (null == Reflect.field(taskCollection, id)) 
            Reflect.setField(taskCollection, id, new TaskManager(disObj, threadType, processMode));
        
        return Reflect.field(taskCollection, id);
    }
    
    /**
	 *
	 * Remove a TaskManager
	 *
	 * @param	id The TakeManager you want to remove
	 * @param	flush If this is true then it will run all the task.
	 *
	 */
    
    public static function removeTaskManager(id : String, flush : Bool = false) : Void
    {
        var taskManager : TaskManager = Reflect.field(taskCollection, id);
        
        if (flush) 
        {
            taskManager.flush();
        }
        else 
        {
            taskManager.dump();
        }
    }
    
    /**
	 *
	 * Set the given TaskManager to queue or stack mode
	 *
	 * @param	id The TaskManager
	 * @param	mode This could be set to "queue" (First In – First Out) remove task from the bottom or "stack" (First In – Last Out) remove task from the top
	 */
    
    public static function setProcessMode(id : String, mode : String = "queue") : Void
    {
		var taskManager:TaskManager = Reflect.field(taskCollection, id);
		
        if (null == taskManager) 
		{
			Debug.print("[ThreadManager::setProcessMode] Could find " + id);
			return;
		}
		
		taskManager.threadType = mode;
    }
    
    /**
	 *
	 * This is the timer rate used for the "timer" mode.
	 *
	 * @param	id The TaskmManager to set
	 * @param	timerRate  Set the time between when the next thread will run. This only applies if threadMode is set to "timer"
	 */
    public static function setTimerRate(id : String, timerRate : Int = 100) : Void
    {
		var taskManager:TaskManager = Reflect.field(taskCollection, id);
		
        if (null == taskManager) 
		{
			Debug.print("[ThreadManager::setTimerRate] Could find " + id);
			return;
		}
			
		taskManager.timerRate = timerRate;
    }
    
    /**
	 * Adds a task to a given TaskManager
	 *
	 * @param	id The TaskManager you want to use.
	 * @param	task The task you want to turn
	 */
    
    public static function addTask(id : String, task : ITask) : Void
    {
        var taskManager:TaskManager = Reflect.field(taskCollection, id);
		
        if (null == taskManager) 
		{
			Debug.print("[ThreadManager::addTask] Could find " + id);
			return;
		}
		
		taskManager.add(task);
    }
    
    /**
	 *	Turn a task out of the TaskManager
	 *
	 * @param	id The TaskManager
	 * @param	task The task you want to remove
	 */
    
    public static function removeTask(id : String, task : ITask) : Void
    {
		var taskManager:TaskManager = Reflect.field(taskCollection, id);
		
        if (null == taskManager) 
		{
			Debug.print("[ThreadManager::removeTask] Could find " + id);
			return;
		}
		
		taskManager.remove(task);
    }
    
    public static function getTaskManager(id : String) : TaskManager
    {
        var taskManager:TaskManager = Reflect.field(taskCollection, id);
		
        if (null == taskManager) 
        {
            Debug.print("[ThreadManager::getTaskManager] Could find " + id);
			
            return null;
        }
		
        
        return taskManager;
    }
    
    private static function updateEnterFrame(event : Event) : Void
    {
        for (i in 0...eventCollection.length)
		{
            eventCollection.getItemAt(i)();
        }
    }
}

