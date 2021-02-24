package com.chaos.engine;


/**
* Types for the engine to handle
* @author Erick Feiling
*/
class EngineTypes
{
    
    // Core Plugin
    public static inline var LAYER : String = "Layer";
    public static inline var SCREEN : String = "Screen";
    public static inline var ELEMENT : String = "Element";
    
    public static inline var GET_SCREEN : String = "GetScreen";
    public static inline var GET_ELEMENT : String = "GetElement";
    
    public static inline var REMOVE_ELEMENT : String = "RemoveElement";
    public static inline var REMOVE_SCREEN : String = "RemoveScreen";
    public static inline var REMOVE_LAYER : String = "RemoveLayer";
    
    public static inline var ADD_LAYER_ITEM : String = "AddLayerItem";
    
    public static inline var DATA_UPDATE : String = "DataUpdate";
    
    // UI & Theme Plugin
    public static inline var GET_ITEM : String = "GetItem";
    public static inline var REMOVE_ITEM : String = "RemoveItem";
    
    public static inline var LOAD_THEME : String = "LoadTheme";
    public static inline var SET_THEME : String = "SetTheme";
    
    // Media Plugin
    public static inline var GET_IMAGE : String = "GetImage";
    public static inline var ADD_IMAGE : String = "AddImage";
    public static inline var REMOVE_IMAGE : String = "RemoveImage";
    public static inline var DISPLAY_IMAGE : String = "DisplayImage";
    
    public static inline var VIDEO_LOAD : String = "VideoLoad";
    public static inline var VIDEO_PLAY : String = "VideoPlay";
    public static inline var VIDEO_PAUSE : String = "VideoPause";
    public static inline var VIDEO_STOP : String = "VideoStop";
    public static inline var VIDEO_SEEK : String = "VideoSeek";
    public static inline var VIDEO_VOLUME : String = "VideoVolume";
    
    public static inline var SOUND_LOAD : String = "SoundLoad";
    public static inline var SOUND_PLAY : String = "SoundPlay";
    public static inline var SOUND_PAUSE : String = "SoundPause";
    public static inline var SOUND_STOP : String = "SoundStop";
    public static inline var SOUND_SEEK : String = "SoundSeek";
    public static inline var SOUND_VOLUME : String = "SoundVolume";
    
    public static inline var PANORAMA : String = "Panorama";
        
    
    // Layouts
    public static inline var CONTAINER : String = "Container";
    public static inline var FIT_CONTAINER : String = "FitContainer";
    //public static const GRID_CONTAINER:String = "GridContainer";
    public static inline var HORIZONTAL_CONTAINER : String = "HorizontalContainer";
    public static inline var VERTICAL_CONTAINER : String = "VerticalContainer";
    
    public function new()
    {
    }
}

