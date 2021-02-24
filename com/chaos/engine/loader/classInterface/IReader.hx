package com.chaos.engine.loader.classInterface;


/**
* Interface for Reader
* @author Erick Feiling
*/
interface IReader
{
    

    /**
	* If true main thread is locked and false if not
	*/
    var lock(get, set) : Bool;    
    
    /**
	* Send object data
	*/

    var onDataParse(get, set) : Dynamic->Void;    
    
    /**
	* If there is something wrong the item being created
	*/
    
    var onError(get, set) : Dynamic->Void;

    
    /**
	* Loads data from a given source
	* 
	* @param	fileURL The URL path to the file that will be loaded
	*/
    
    function load(fileURL : String) : Void;
    
    /**
	* Set the data being used for the reader
	* @param	data The raw data format for the reader
	*/
    function setData(data : Dynamic) : Void;
    
    /**
	* The main thread for reading data
	*/
    
    function thread(value : Dynamic) : Void;
}

