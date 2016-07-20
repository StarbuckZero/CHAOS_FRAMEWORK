package com.chaos.utils;

import com.chaos.utils.TempClass;


import flash.display.Loader;
import flash.display.LoaderInfo;
import flash.errors.IOError;
import flash.events.IOErrorEvent;

import flash.net.URLRequest;
import flash.events.Event;
import flash.display.Sprite;

import flash.system.ApplicationDomain;
import flash.system.SecurityDomain;

import flash.system.LoaderContext;

/**
	 * For loading instants of object or classes out of the loaded swf library.
	 * This is the class file name that is set when setting an item in the library to "Export for ActionScript".
	 *
	 * @author Erick Feiling
	 *
	 */

class DynamicLinkLibrary extends Sprite
{
    public var loader(get, never) : Loader;

    
    private var _loader : Loader;
    private var _loaded : Bool = false;
    
    public function new()
    {
        super();
        init();
    }
    
    private function init() : Void
    {
        
        _loader = new Loader();
        _loader.name = "linkLoader";
        
        // Just in case you want the file to be on the stage/display
        addChild(_loader);
    }
    
    /**
		 * The loader that is being used to load content.
		 */
    
    private function get_Loader() : Loader
    {
        return _loader;
    }
    
    /**
		 *  The file you want to load
		 *
		 * @param	strPath The swf file you want to load
		 */
    
    public function load(strPath : String) : Void
    {
        
        // If already loaded then unload the current item
        if (_loaded) 
            unload();
        
        var context : LoaderContext = new LoaderContext(true, new ApplicationDomain(ApplicationDomain.currentDomain));
        
        _loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
        _loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError);
        
        // Make sure the file is a swf
        if (strPath.indexOf(".swf") != -1) 
            _loader.load(new URLRequest(strPath), context);
    }
    
    /**
		 * Gets the class file that is stored inside the swf file
		 *
		 * @param	value
		 *
		 * @return Return a class file, if nothing was fount then reutrn null
		 */
    
    public function getClass(value : String) : Class<Dynamic>
    {
        if (_loader.contentLoaderInfo.applicationDomain.hasDefinition(value)) 
            return Type.getClass(_loader.contentLoaderInfo.applicationDomain.getDefinition(value));
        
        return null;
    }
    
    /**
		 * Gets an instance of the object that is stored inside the swf library
		 * @param	value
		 * @return
		 */
    public function getLibraryInstance(value : String) : Dynamic
    {
        // Check to see if it's there
        if (_loader.contentLoaderInfo.applicationDomain.hasDefinition(value)) 
        {
            // Get and return instance of class
            var tempClass : Class<Dynamic> = Type.getClass(_loader.contentLoaderInfo.applicationDomain.getDefinition(value));
            
            return Type.createInstance(tempClass, []);
        }
        
        return null;
    }
    
    /**
		 * Check to see if class is in libray
		 *
		 * @param	value The name of class
		 *
		 * @return Return true if class is in library and false if not
		 */
    public function hasClass(value : String) : Bool
    {
        return _loader.contentLoaderInfo.applicationDomain.hasDefinition(value);
    }
    
    /**
		 * Unload the current swf file
		 */
    
    public function unload() : Void
    {
        _loader.unloadAndStop();
        _loaded = false;
    }
    
    private function onComplete(event : Event) : Void
    {
        
        dispatchEvent(event);
        _loaded = true;
    }
    
    private function onError(event : IOErrorEvent) : Void
    {
        dispatchEvent(event);
    }
}

