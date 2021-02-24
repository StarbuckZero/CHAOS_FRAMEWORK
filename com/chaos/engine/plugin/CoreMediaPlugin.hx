package com.chaos.engine.plugin;

import com.chaos.engine.CommandDispatch;
import com.chaos.engine.event.CoreEngineEvent;
import com.chaos.engine.Global;
import com.chaos.media.DisplayImage;
import com.chaos.media.DisplayVideo;
import com.chaos.engine.CommandCentral;
import com.chaos.engine.EngineTypes;
import com.chaos.media.event.DisplayVideoEvent;
import com.chaos.media.event.SoundStatusEvent;
import com.chaos.media.classInterface.IPanorama;
import com.chaos.media.classInterface.ISoundManager;
import com.chaos.media.Panorama;
import com.chaos.utils.Debug;
import com.chaos.media.SoundManager;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.utils.Utils;

import openfl.events.IOErrorEvent;
import openfl.events.Event;
import openfl.events.EventDispatcher;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.display.DisplayObject;
import openfl.media.SoundTransform;

/**
* ...
* @author Erick Feiling
*/
class CoreMediaPlugin
{
    private static var images : Dynamic = {};
    
    private static var soundManager : ISoundManager = new SoundManager();
    private static var _eventDispatcher : EventDispatcher = new EventDispatcher();
    
    public function new()
    {
    }
    
    public static function initialize() : Void
    {
        CommandCentral.addCommand(EngineTypes.ADD_IMAGE, addImage);
        CommandCentral.addCommand(EngineTypes.REMOVE_IMAGE, removeImage);
        CommandCentral.addCommand(EngineTypes.GET_IMAGE, getImage);
        CommandCentral.addCommand(EngineTypes.DISPLAY_IMAGE, displayImage);
        
        CommandCentral.addCommand(EngineTypes.VIDEO_LOAD, loadVideo);
        CommandCentral.addCommand(EngineTypes.VIDEO_PLAY, playVideo);
        CommandCentral.addCommand(EngineTypes.VIDEO_PAUSE, pauseVideo);
        CommandCentral.addCommand(EngineTypes.VIDEO_STOP, stopVideo);
        CommandCentral.addCommand(EngineTypes.VIDEO_SEEK, videoSeek);
        CommandCentral.addCommand(EngineTypes.VIDEO_VOLUME, videoVolume);
        
        CommandCentral.addCommand(EngineTypes.SOUND_LOAD, loadSound);
        CommandCentral.addCommand(EngineTypes.SOUND_PLAY, playSound);
        CommandCentral.addCommand(EngineTypes.SOUND_PAUSE, pauseSound);
        CommandCentral.addCommand(EngineTypes.SOUND_STOP, stopSound);
        CommandCentral.addCommand(EngineTypes.SOUND_SEEK, seekSound);
        CommandCentral.addCommand(EngineTypes.SOUND_VOLUME, soundVolume);
        
        CommandCentral.addCommand(EngineTypes.PANORAMA, createPano);
    }
    
    private static function createPano(data : Dynamic) : Dynamic
    {
        var displayObj : DisplayObject = Utils.getNestedChild(Global.mainDisplyArea, Reflect.field(data,"name") );
        
        if (displayObj != null && Std.is(displayObj, Panorama))
        {
            setPano(data, cast(displayObj, Panorama));

            return displayObj;
        }
        else
        {
            if(!Reflect.hasField(data,"width"))
                Reflect.setField(data,"width", 800);

            if(!Reflect.hasField(data,"height"))
                Reflect.setField(data,"height", 600);

            if (Reflect.hasField(data,"screen"))
                Reflect.setField(data,"source", CoreCommandPlugin.getScreen(Reflect.field(data,"screen")));
            
            if (Reflect.hasField(data,"image"))
                Reflect.setField(data," image", CoreCommandPlugin.getImage(Reflect.field(data,"image")));            

            var pano : Panorama = new Panorama(data);
            
            CoreCommandPlugin.displayUpdate(pano, data);

            return pano;
        }

        return null;
    }
    
    private static function loadSound(data : Dynamic) : Dynamic
    {
        if (Reflect.hasField(data,"url") && Reflect.hasField(data,"name"))
        {
            var autoStart : Bool = Reflect.field(data,"autoStart") ? Reflect.field(data,"autoStart") : false;
            
            if (Reflect.hasField(data,"async") || !Reflect.field(data,"async"))
            {
                soundManager.addEventListener(SoundStatusEvent.SOUND_LOADED, onSoundLoad);
                Global.pause = true;
            }
            
            soundManager.load( Reflect.field(data,"name"), Reflect.field(data,"url"), autoStart);
        }
        else
        {
            Debug.print("[CoreMediaPlugin::loadSound] Was unable to load sound.");
        }
        
        return null;
    }
    
    private static function playSound(data : Dynamic) : Dynamic
    {
        if (Reflect.hasField(data,"name"))
            soundManager.playSound(Reflect.field(data,"name"));
        else
            Debug.print("[CoreMediaPlugin::playSound] Sound was not found.");

        return null;
    }
    
    private static function pauseSound(data : Dynamic) : Dynamic
    {
        if (Reflect.hasField(data,"name"))
            soundManager.pauseSound(Reflect.field(data,"name"));
        else
            Debug.print("[CoreMediaPlugin::pauseSound] Sound was not found.");

        return null;
    }
    
    private static function stopSound(data : Dynamic) : Dynamic
    {
        if (Reflect.hasField(data,"name"))
            soundManager.stopSound(Reflect.field(data,"name"));
        else
            Debug.print("[CoreMediaPlugin::stopSound] Sound was not found.");

        return null;
    }
    
    
    
    private static function seekSound(data : Dynamic) : Dynamic
    {
        if (Reflect.hasField(data,"name") && Reflect.hasField(data,"position"))
            soundManager.setPosition( Reflect.field(data,"name"), Reflect.field(data,"position") );
        else
            Debug.print("[CoreMediaPlugin::seekSound] Sound was not found.");

        return null;
    }
    
    private static function soundVolume(data : Dynamic) : Bool
    {
        if ( Reflect.hasField(data,"name") && Reflect.hasField(data,"volume") )
        {
            soundManager.setVolume(Reflect.field(data,"name"), Reflect.field(data,"volume"));
            return true;
        }
        else
            Debug.print("[CoreMediaPlugin::volumeSound] Sound was not found.");

        return false;
    }
    
    private static function loadVideo(data : Dynamic) : Dynamic
    {
        if (Reflect.hasField(data,"name"))
        {
            var autoStart : Bool = Reflect.hasField(data,"autoStart") ? Reflect.field(data,"autoStart") : false;
            var video : DisplayVideo;
            var buffer : Bool = ((data.exists("buffer"))) ? data.buffer : false;
            var displayObj : DisplayObject = Utils.getNestedChild( CoreCommandPlugin.getDisplayObject(data), Reflect.field(data,"name") );
            
            
            if (null != displayObj && Std.is(displayObj, DisplayVideo))
            {
                video = cast(displayObj, DisplayVideo);
                video.setComponentData(data);
            }
            else
                video = new DisplayVideo(data);
            
            CoreCommandPlugin.displayUpdate(video, data);
            
            return video;
        }
        
        
        Debug.print("[CoreMediaPlugin::loadVideo] Unable to load video.");
        
        return null;
    }
    
    private static function playVideo(data : Dynamic) : Dynamic
    {
        if (Reflect.hasField(data,"name"))
        {
            var displayObj : DisplayObject = Utils.getNestedChild( CoreCommandPlugin.getDisplayObject(data), Reflect.field(data,"name"));
            
            if (Std.is(displayObj, DisplayVideo))
                cast(displayObj, DisplayVideo).play();
        }
        else
        {
            Debug.print("[CoreMediaPlugin::playVideo] Unable to find video.");
        }

        return null;
    }
    
    private static function pauseVideo(data : Dynamic) : Dynamic
    {
        if (Reflect.hasField(data,"name"))
        {
            var displayObj : DisplayObject = Utils.getNestedChild( CoreCommandPlugin.getDisplayObject(data), Reflect.field(data,"name"));
            
            if (Std.is(displayObj, DisplayVideo))
                cast(displayObj, DisplayVideo).pause();
        }
        else
        {
            Debug.print("[CoreMediaPlugin::pauseVideo] Unable to find video.");
        }

        return null;
    }
    
    private static function stopVideo(data : Dynamic) : Dynamic
    {
        if (Reflect.hasField(data,"name"))
        {
            var displayObj : DisplayObject = Utils.getNestedChild( CoreCommandPlugin.getDisplayObject(data), Reflect.field(data,"name"));
            
            if (Std.is(displayObj, DisplayVideo))
                cast(displayObj, DisplayVideo).stop();
        }
        else
        {
            Debug.print("[CoreMediaPlugin::stopVideo] Unable to find video.");
        }

        return null;
    }
    
    private static function videoSeek(data : Dynamic) : Dynamic
    {
        if (Reflect.hasField(data,"name") && Reflect.hasField(data,"position"))
        {
            var displayObj : DisplayObject = Utils.getNestedChild( CoreCommandPlugin.getDisplayObject(data), Reflect.field(data,"name"));

            if (Std.is(displayObj, DisplayVideo))
                cast(displayObj, DisplayVideo).netStream.seek(Reflect.field(data,"position"));
        }
        else
        {
            Debug.print("[CoreMediaPlugin::stopVideo] Unable to find video.");
        }

        return null;
    }
    
    private static function videoVolume(data : Dynamic) : Dynamic
    {
        if (Reflect.hasField(data,"name") && Reflect.hasField(data,"volume"))
        {
            var displayObj : DisplayObject = Utils.getNestedChild(Global.mainDisplyArea, data.name);
            
            if (Std.is(displayObj, DisplayVideo))
            {
                var newVolume : SoundTransform = new SoundTransform( Reflect.field(data,"volume") / 100);
                cast(displayObj, DisplayVideo).netStream.soundTransform = newVolume;
            }
        }
        else
        {
            Debug.print("[CoreMediaPlugin::videoVolume] Unable to find video.");
        }

        return null;
    }
    
    private static function addImage(data : Dynamic) : Dynamic
    {
        if (Reflect.hasField(data,"url")  && Reflect.hasField(data,"name"))
        {
            var displayImage : DisplayImage = new DisplayImage(data);
            
            if (!Reflect.hasField(data,"async") || !Reflect.field(data,"async"))
                Global.pause = true;
            
            displayImage.addEventListener(Event.COMPLETE, onImageLoadComplete, false, 0, true);
            displayImage.addEventListener(IOErrorEvent.IO_ERROR, onImageError, false, 0, true);
            
            displayImage.load(Std.string(Reflect.field(data,"url")));

            return displayImage;
        }
        else
        {
            Debug.print("[CoreMediaPlugin::addImage] Must have url for image and name.");
        }

        return null;
    }
    
    private static function displayImage(data : Dynamic) : DisplayImage
    {
        if ( Reflect.hasField(data,"name") && Reflect.hasField(data,"image") && null != Reflect.field(images, Reflect.field(data,"image")))
        {
            
            var displayObj : DisplayObject = Utils.getNestedChild( CoreCommandPlugin.getDisplayObject(data), Reflect.field(data,"name") );
            var displayImage : DisplayImage;
            
            // Update or create new image
            if (null != displayObj && Std.is(displayObj, DisplayImage))
                displayImage = cast(displayObj, DisplayImage);
            else
                displayImage = new DisplayImage(data);
            
            if (null != displayImage)
                CoreCommandPlugin.displayUpdate(displayImage, data);
            
            return displayImage;
        }
        
        Debug.print("[CoreMediaPlugin::displayImage] Couldn't find image " + Reflect.field(data,"image"));
        return null;
    }
    
    private static function getImage(data : Dynamic) : BitmapData
    {
        if (Reflect.hasField(data,"name") && Reflect.field(images, Reflect.field(data,"name")))
            return cast(Reflect.field(images, Std.string(data.name)),DisplayImage).image;
        
        Debug.print("[CoreMediaPlugin::getImage] Couldn't find image " + Reflect.field(data,"image"));
        return null;
    }
    
    private static function removeImage(data : Dynamic) : Bool
    {
        if (Reflect.hasField(data,"name") && Reflect.field(images,Reflect.field(data,"name")))
            return Reflect.deleteField(images, Reflect.field(images,Reflect.field(data,"name")));

        return false;
    }
    
    private static function setPano(data : Dynamic, UIObject : Panorama) : Void
    {
        if (Reflect.hasField(data,"screen"))
            Reflect.setField(data,"source", CoreCommandPlugin.getScreen(Reflect.field(data,"screen")));
        
        if (Reflect.hasField(data,"image"))
            Reflect.setField(data," image", CoreCommandPlugin.getImage(Reflect.field(data,"image")));
        
        UIObject.setComponentData(data);
    }


    private static function onImageLoadComplete(event : Event) : Void {

        var displayImage:DisplayImage = cast(event.currentTarget, DisplayImage);

        Reflect.setField(images, displayImage.name, displayImage.image);
        Global.pause = false;
        
        _eventDispatcher.dispatchEvent(new CoreEngineEvent(CoreEngineEvent.ITEM_LOAD_COMPLETE));
    }

    private static function onImageError(event : IOErrorEvent) : Void {

        Global.pause = false;
        Debug.print("[CoreMediaPlugin::addImage] Fail to load image");

        _eventDispatcher.dispatchEvent(new CoreEngineEvent(CoreEngineEvent.ITEM_LOAD_FAIL));
    }

    private static function onSoundLoad(event : Event) : Void {

        Global.pause = false;
        soundManager.removeEventListener(SoundStatusEvent.SOUND_LOADED, onSoundLoad);
            
        CommandDispatch.dispatch("Sound", SoundStatusEvent.SOUND_LOADED, {});
    }
}