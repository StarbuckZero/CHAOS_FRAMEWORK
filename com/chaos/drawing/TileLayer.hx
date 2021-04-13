package com.chaos.drawing;

import openfl.net.URLRequest;
import openfl.net.URLLoader;
import openfl.events.Event;
import com.chaos.media.DisplayImage;
import haxe.Json;

import openfl.display.Shape;
import openfl.display.Tile;
import openfl.display.Tilemap;
import openfl.display.Tileset;
import openfl.geom.Rectangle;
import openfl.geom.Point;
import openfl.utils.Assets;
import openfl.display.BitmapData;

import com.chaos.utils.Debug;
import com.chaos.ui.BaseUI;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.utils.CompositeManager;



/**
 * A 2D Layer filled with bitmap images based on data files
 *
 * @author Erick Feiling
 */



class TileLayer extends BaseUI implements IBaseUI
{

    private var _tileData:Dynamic;
    private var _tileMapData:Dynamic;

    private var _tileWidth:Int = 0;
    private var _tileHeight:Int = 0;
    private var _tileCount:Int = 0;

    private var _tileImageWidth:Int = 0;
    private var _tileImageHeight:Int = 0;
    private var _tileImageCount:Int = 0;

    private var _mapWidth:Int = -1;
    private var _mapHeight:Int = -1;

    private var _row:Int = 0;
    private var _column:Int = 0;

    private var _index:Int = 0;
    private var _colIndex:Int = 0;
    
    private var _tileBufferAmount:Int = 1;

    private var _tiles:Array<Dynamic>;
    private var _layers:Array<Dynamic>;
    private var _layerLength:Int = 0;

    private var _tileImage:BitmapData;

    private var _cache:Map<String,BitmapData>;
    private var _enableCache:Bool = false;

    private var _lazyLoading:Bool = false;

    /* Adjust the offset of the id number. This is for when items get exported in the Tiled Program.*/
    private var _idOffset:Int = -1;

    private var _content:Shape;

    private var _assetPrefix:String = "assets/";

    private var _tileMapLoaded:Bool = false;
    private var _tileAssetDataLoaded:Bool = false;

    private var _tileLoadCount:Int = 0;


    public function new(data:Dynamic = null)
    {
        super(data);
    }

    override function setComponentData(data:Dynamic) {

        super.setComponentData(data);

        if(Reflect.hasField(data,"index"))
            _index = Reflect.field(data,"index");

        if(Reflect.hasField(data,"tileBufferAmount"))
            _tileBufferAmount = Reflect.field(data,"tileBufferAmount");

        if(Reflect.hasField(data,"enableCache"))
            _enableCache = Reflect.field(data,"enableCache");

        // Load files based off Asset Libray
        if(Reflect.hasField(data,"tileFile") && Reflect.hasField(data,"tileMap") && Assets.exists(Reflect.field(data,"tileFile")) && Assets.exists(Reflect.field(data,"tileMap")))
            loadTileAssetLibrary(Reflect.field(data,"tileFile"), Reflect.field(data,"tileMap"));
        else if(Reflect.hasField(data,"tileFile") && Reflect.hasField(data,"tileMap"))
            loadTileFromPath(Reflect.field(data,"tileFile"), Reflect.field(data,"tileMap"));

    }

    override function initialize() {
        super.initialize();

        
        if(_enableCache)
            _cache = new Map<String,BitmapData>();

        _content = new Shape();

        addChild(_content);
    }


    public function left( redraw:Bool = true ) {

        if(_index > (_mapHeight * _colIndex))
            _index--;

        if(redraw)
            draw();
    }

    public function right( redraw:Bool = true ) {

        
        if(_index < (_mapWidth * (_colIndex + 1)) - _row)
            _index++;

        if(redraw)
            draw();
    }

    public function up( redraw:Bool = true ) {

        if(_index >= _mapHeight) {
            _colIndex--;
            _index -= _mapHeight;
        }
        
        if(redraw)
            draw();
    }

    public function down( redraw:Bool = true ) { 

        
        if(_index < (_layerLength - _mapHeight)) {
            _colIndex++;
            _index += _mapHeight;
        }
            

        if(redraw)
            draw();        
    }

    public function loadTileAssetLibrary( tileAsset:String, tileMap:String ):Void {

        setupTileMap( Json.parse(Assets.getText(tileAsset)), Json.parse(Assets.getText(tileMap)) );
    }

    public function loadTileFromPath(tileAssetURL:String, tileMapURL:String):Void {

        // Force lazy loading and caching
        _enableCache = _lazyLoading = true;
        
        var tileAssetLoader:URLLoader = new URLLoader();
        var tileMapLoader:URLLoader = new URLLoader();

        tileAssetLoader.addEventListener(Event.COMPLETE, onTileAssetDataLoad, false, 0, true);
        tileAssetLoader.load(new URLRequest(tileAssetURL));

        tileMapLoader.addEventListener(Event.COMPLETE, onTileMapDataLoad, false, 0, true);
        tileMapLoader.load(new URLRequest(tileMapURL));
    }

    private function setupTileMap(tileDataObj:Dynamic, tileMapDataObj:Dynamic):Void {
        
        // Tile Assets
        if(Reflect.hasField(tileDataObj,"tilewidth"))
            _tileWidth = Reflect.field(tileDataObj,"tilewidth"); 

        if(Reflect.hasField(tileDataObj,"tileheight"))
            _tileHeight = Reflect.field(tileDataObj,"tileheight");

        if(Reflect.hasField(tileDataObj,"tilecount"))
            _tileCount = Reflect.field(tileDataObj,"tilecount");

        if(Reflect.hasField(tileDataObj,"tiles"))
            _tiles = Reflect.field(tileDataObj,"tiles");

        // Tile Image
        if(Reflect.hasField(tileDataObj,"imagewidth"))
            _tileImageWidth = Reflect.field(tileDataObj,"imagewidth");

        if(Reflect.hasField(tileDataObj,"imageheight"))
            _tileImageHeight = Reflect.field(tileDataObj,"imageheight");

        if(Reflect.hasField(tileDataObj,"columns"))
            _tileImageCount = Reflect.field(tileDataObj,"columns");        

        if(Reflect.hasField(tileDataObj,"image"))
            _tileImage = Assets.getBitmapData( _assetPrefix + Reflect.field(tileDataObj,"image"));
        

        // Map 
        if(Reflect.hasField(tileMapDataObj,"width"))
            _mapWidth = Reflect.field(tileMapDataObj,"width");

        if(Reflect.hasField(tileMapDataObj,"height"))
            _mapHeight = Reflect.field(tileMapDataObj,"height");
        
        // Layers
        if(Reflect.hasField(tileMapDataObj,"layers"))
            _layers = Reflect.field(tileMapDataObj,"layers");
        

        if(_mapWidth < 0 || _mapHeight < 0)
            Debug.print("[TileLayer::setupTileMap] The tileWidth and tileHeight must be set in order to draw anything");


    }

    override function draw() {
        super.draw();

        if(_mapWidth < 0 || _mapHeight < 0)
            return;

        _content.graphics.clear();

        var layerCount:Int = 0;

        // Start drawing layer
        for(i in 0 ... _layers.length)
        {

            var layer:Dynamic = _layers[i]; 
            var layerMap:Array<Int> = Reflect.field(layer,"data");
            var tileIndex:Int = _index;

            _row = Std.int(_width / _tileWidth) + _tileBufferAmount;
            _column = Std.int(_height / _tileHeight) + _tileBufferAmount;

            var rowCount:Int = 0;
            var colCount:Int = 0;

            if(layerCount <= 0)
                layerCount = layerMap.length;
            
            _content.graphics.moveTo(0,0);

            while(rowCount < _row && colCount < _column) {
                
                var image:BitmapData = getTile(layerMap[tileIndex + rowCount]);

                if(image != null)
                {
                    _content.graphics.beginBitmapFill(image);
                    _content.graphics.drawRect(rowCount * _tileWidth, colCount * _tileHeight, image.width, image.height);
                    _content.graphics.endFill();         
                }
                
                rowCount++;

                if(rowCount == _row)
                {
                    rowCount = 0;
                    tileIndex = tileIndex + _mapWidth;

                    colCount++;
                }
            }

        } 

        _layerLength = layerCount;

    }
    

    private function getTile( id:Int ):BitmapData
    {

        if(_tiles != null && _tiles.length > 0)
        {
            // filter down tiles to return just one
            var tile:Array<Dynamic> = _tiles.filter(function(tileData:Dynamic) {return Reflect.field(tileData,"id") == (id + _idOffset);});

            // If found then grab that image
            if(tile.length > 0) {

                var image:BitmapData = null;

                if(_enableCache && _cache.exists(Reflect.field(tile[0],"image")))
                    return _cache.get(Reflect.field(tile[0],"image"));

                if(!_lazyLoading)
                    image = Assets.getBitmapData( _assetPrefix + Reflect.field(tile[0],"image"));
                else
                {
                    _tileLoadCount++;

                    var displayImage:DisplayImage = new DisplayImage();
                    displayImage.addEventListener(Event.COMPLETE,onComplete,false,0,true);

                    displayImage.load(_assetPrefix + Reflect.field(tile[0],"image"));
                    displayImage.name = Reflect.field(tile[0],"image");
                }
                    

                if(_enableCache) 
                    _cache.set(Reflect.field(tile[0],"image"),image);

                return image;
            }
                
        }
        else if(_tileImage != null) {

            if(id > 0 )
                return getFromSpritesheet(id + _idOffset);
        }


        return null;

    }

    public function getFromSpritesheet(tileNumber:Int):BitmapData
    {
        var rowLength:Int = Std.int(_tileImage.width / _tileWidth);

        var canvasBitmapData = new BitmapData(_tileWidth,_tileHeight);
        canvasBitmapData.copyPixels(_tileImage, new Rectangle(Std.int(tileNumber % rowLength) * _tileWidth, Std.int(tileNumber / rowLength) * _tileHeight, _tileWidth, _tileHeight), new Point(0, 0));
        
        return canvasBitmapData.clone();
    }

    private function onTileAssetDataLoad(event:Event):Void {

        var urlFile:URLLoader = cast(event.target, URLLoader);

        _tileAssetDataLoaded = true;
        _tileData = Json.parse(urlFile.data);

        if(_tileMapLoaded && _tileAssetDataLoaded)
            setupTileMap(_tileData, _tileMapData);
    }

    private function onTileMapDataLoad(event:Event):Void {

        var urlFile:URLLoader = cast(event.target, URLLoader);

        _tileMapData = Json.parse(urlFile.data);
        _tileMapLoaded = true;

        if(_tileMapLoaded && _tileAssetDataLoaded)
            setupTileMap(_tileData, _tileMapData);
    }

    private function onComplete(event:Event):Void {

        var displayImage:DisplayImage = cast(event.target, DisplayImage);

        _cache.set(displayImage.name,displayImage.image);
        _tileLoadCount--;

        if(_tileLoadCount == 0)
        draw();
    }
}