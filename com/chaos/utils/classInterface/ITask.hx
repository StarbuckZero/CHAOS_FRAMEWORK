package com.chaos.utils.classInterface;



/**
 * This is used to go into a queue or stack for the TaskManager
 *
 * @author Erick Feiling
 */

interface ITask
{
    
    /** The id for the task*/
    
    
    /** Return the id */
    var id(get, set) : String;    
    
    /** Start point for sub task */
    var start(get, never) : Int;    
    
    /** End point for sub task*/
    var end(get, never) : Int;    
    
    /** The current index value */
    
    
    /** The current index value */
    var index(get, set) : Int;

    
    /** Runs function*/
    function run() : Void;
    
    /** Clear out task object*/
    function clear() : Void;
}

