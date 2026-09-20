package com.chaos.ui.chart;

import com.chaos.ui.BaseUI;
import com.chaos.ui.UIStyleManager;
import com.chaos.ui.UIBitmapManager;
import com.chaos.ui.UIBitmapManager.UIBitmapType;
import com.chaos.ui.chart.ChartTypes;
import com.chaos.ui.event.ChartEvent;
import openfl.Assets;
import openfl.display.BitmapData;
import openfl.display.Shape;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.geom.Rectangle;
import openfl.text.TextField;
import openfl.text.TextFormat;

/** Shared chart shell. Subclasses implement drawPlot and geometry-aware hit testing. */
class ChartBase extends BaseUI {
    public static inline var TYPE = "ChartBase";
    public var chartType(get, never):String;
    public var title(get, set):String;
    public var summary(get, set):String;
    public var diagnostics(get, never):Array<ChartDiagnostic>;
    public var normalizedPoints(get, never):Array<ChartPoint>;
    public var plotBounds(get, never):Rectangle;
    public var selectedItem(get, never):Dynamic;
    public var hoveredItem(get, never):Dynamic;
    public var textureResolver(get, set):ChartTextureResolver;
    public var renderCount(default, null):Int = 0;
    public var layoutCount(default, null):Int = 0;
    public var normalizationCount(default, null):Int = 0;

    var config:Dynamic;
    var points:Array<ChartPoint>;
    var issues:Array<ChartDiagnostic>;
    var bounds:Rectangle;
    var chromeBounds:Rectangle;
    var ready:Bool = false;
    var destroyed:Bool = false;
    var drawing:Bool = false;
    var batching:Bool = false;
    var layoutDirty:Bool = true;
    var visualDirty:Bool = true;
    var textureDirty:Bool = true;
    var watched:Bool = false;
    var resolver:ChartTextureResolver;
    var texture:ChartTexture;
    var textureMode:String = "stretch";
    var selection:Dynamic;
    var hover:Dynamic;
    var regions:Array<ChartHitRegion>;
    var background:Shape;
    var backgroundImage:Shape;
    var gridLayer:Sprite;
    var dataLayer:Sprite;
    var dataTextureLayer:Sprite;
    var overlayLayer:Sprite;
    var labelLayer:Sprite;
    var titleField:TextField;
    var emptyField:TextField;
    var legendFields:Array<TextField>;
    var legendSwatches:Shape;
    var overlay:Shape;

    public function new(data:Dynamic = null) { super(data); }
    function ensure():Void {
        if (config != null) return;
        config = {schemaVersion:1, title:"", summary:"", padding:16, showLegend:true, showLabels:true,
            emptyText:"No data", animationEnabled:false, legend:{position:"bottom",spacing:8}};
        points = []; issues = []; regions = []; legendFields = [];
        bounds = new Rectangle(); texture = new ChartTexture(); resolver = resolveTexture;
    }
    function get_chartType():String { return TYPE; }
    function get_title():String { return config.title; }
    function set_title(value:String):String { setComponentData({title:value}); return config.title; }
    function get_summary():String { return config.summary; }
    function set_summary(value:String):String { setComponentData({summary:value}); return config.summary; }
    function get_diagnostics():Array<ChartDiagnostic> { return cast ChartData.copy(issues); }
    function get_normalizedPoints():Array<ChartPoint> { return cast ChartData.copy(points); }
    function get_plotBounds():Rectangle { return bounds.clone(); }
    function get_selectedItem():Dynamic { return ChartData.copy(selection); }
    function get_hoveredItem():Dynamic { return ChartData.copy(hover); }
    function get_textureResolver():ChartTextureResolver { return resolver; }
    function set_textureResolver(value:ChartTextureResolver):ChartTextureResolver {
        ensure(); if (destroyed) return resolver;
        resolver = value == null ? resolveTexture : value;
        textureDirty = true; invalidateChart(false); draw(); return resolver;
    }
    public function toChartData():Dynamic {
        ensure();
        var result = ChartData.copy(config);
        result.name = name; result.x = x; result.y = y;
        result.width = width; result.height = height; result.visible = visible; result.enabled = enabled;
        return result;
    }
    /** Invalid common settings retain their prior value; structural failures reject the batch. */
    override public function setComponentData(data:Dynamic):Void {
        ensure(); if (destroyed || data == null) return;
        var validation:Array<ChartDiagnostic> = [];
        var patch:Dynamic;
        try {
            patch = ChartData.copy(data, validation);
            if (!ChartData.object(patch)) throw "Chart update must be an object";
        } catch (error:Dynamic) {
            issues = [{code:"structure",path:"",message:Std.string(error)}]; return;
        }
        for (field in Reflect.fields(patch)) {
            var v:Dynamic = Reflect.field(patch, field);
            var valid = true;
            switch field {
                case "width", "height", "padding", "borderThickness", "fontSize": valid = ChartData.finite(v) && v >= 0;
                case "x", "y": valid = ChartData.finite(v);
                case "backgroundColor", "borderColor", "titleColor", "labelColor", "emptyTextColor", "axisColor", "gridColor": valid = color(v);
                case "backgroundAlpha", "borderAlpha", "gridAlpha": valid = ChartData.finite(v) && v >= 0 && v <= 1;
                case "visible", "enabled", "showLegend", "showLabels", "drawOnResize", "imageSmoothing": valid = Std.isOfType(v, Bool);
                case "animationEnabled": valid = v == false;
                case "title", "summary", "emptyText", "font": valid = Std.isOfType(v, String);
                case "name": valid = Std.isOfType(v, String) && v != "";
                case "Style", "Bitmap": valid = v == null || ChartData.object(v);
                case "backgroundTexture": valid = validTexture(v);
                case "legend":
                    valid = ChartData.object(v);
                    if (valid) {
                        if (!Reflect.hasField(v,"position")) v.position = "bottom";
                        if (!Reflect.hasField(v,"spacing")) v.spacing = 8;
                        valid = ["top","bottom","left","right"].indexOf(v.position) >= 0 && ChartData.finite(v.spacing) && v.spacing >= 0;
                    }
                default:
            }
            if (!valid) {
                Reflect.deleteField(patch, field);
                ChartData.diagnostic(validation,"setting",field,"Invalid/unsupported setting; previous value retained");
            }
        }
        validateChartPatch(patch,validation);
        var inputChanged = Lambda.exists(Reflect.fields(patch), field -> ["series","data","categories","rows","columns","xAxis","yAxis"].indexOf(field) >= 0);
        var next = ChartData.normalize(config, patch, inputChanged ? null : points);
        if (next.accepted && !validateNormalizedData(next)) next.accepted = false;
        issues = validation.concat(next.diagnostics);
        if (!next.accepted) return;
        config = next.config; points = next.points; if (inputChanged) normalizationCount++;
        var needsLayout = false;
        for (field in Reflect.fields(patch)) {
            if (["backgroundColor","backgroundAlpha","borderColor","borderAlpha","borderThickness","titleColor","labelColor","emptyTextColor","axisColor","gridColor","gridAlpha","backgroundTexture","Bitmap","x","y","visible","enabled","imageSmoothing"].indexOf(field) < 0) needsLayout = true;
        }
        if (Reflect.hasField(patch,"backgroundTexture") || Reflect.hasField(patch,"Bitmap")) textureDirty = true;
        batching = true;
        super.setComponentData(patch);
        if (Reflect.hasField(patch,"visible")) visible = patch.visible;
        if (Reflect.hasField(patch,"drawOnResize")) drawOnResize = patch.drawOnResize;
        if (Reflect.hasField(patch,"imageSmoothing")) imageSmoothing = patch.imageSmoothing;
        if (!enabled) hover = null;
        selection = retained(selection); hover = retained(hover);
        batching = false;
        invalidateChart(needsLayout); draw();
    }
    function validateChartPatch(patch:Dynamic,validation:Array<ChartDiagnostic>):Void {}
    function validateNormalizedData(result:ChartNormalization):Bool { return true; }
    static function color(v:Dynamic):Bool { return ChartData.finite(v) && v >= 0 && v <= 0xFFFFFF && Math.floor(v) == v; }
    static function validTexture(v:Dynamic):Bool {
        if (v == null) return true;
        if (!ChartData.object(v) || !Std.isOfType(v.key,String)) return false;
        if (!Reflect.hasField(v,"mode")) v.mode = "stretch";
        return ["stretch","tile","fit","fill"].indexOf(v.mode) >= 0;
    }
    override public function initialize():Void {
        ensure(); if (ready || destroyed) return;
        background = new Shape(); background.name = "chartBackground"; addChild(background);
        backgroundImage = new Shape(); backgroundImage.name = "chartBackgroundTexture"; addChild(backgroundImage);
        gridLayer = layer("chartGrid"); dataLayer = layer("chartData"); dataTextureLayer = layer("chartTextures");
        overlayLayer = layer("chartInteraction"); labelLayer = layer("chartLabels");
        overlay = new Shape(); overlayLayer.addChild(overlay);
        legendSwatches = new Shape(); labelLayer.addChild(legendSwatches);
        titleField = textField(); emptyField = textField();
        addEventListener(Event.ADDED_TO_STAGE,onAdded);
        addEventListener(Event.REMOVED_FROM_STAGE,onRemoved);
        addEventListener(MouseEvent.MOUSE_MOVE,onPointer);
        addEventListener(MouseEvent.ROLL_OUT,onPointer);
        addEventListener(MouseEvent.MOUSE_DOWN,onPointer);
        addEventListener(MouseEvent.MOUSE_UP,onPointer);
        addEventListener(MouseEvent.CLICK,onPointer);
        drawOnResize = Reflect.hasField(config,"drawOnResize") ? config.drawOnResize : true;
        ready = true;
    }
    function layer(name:String):Sprite { var s = new Sprite(); s.name = name; s.mouseEnabled = false; s.mouseChildren = false; addChild(s); return s; }
    function textField():TextField {
        var t = new TextField(); t.selectable = false; t.mouseEnabled = false; labelLayer.addChild(t); return t;
    }
    override public function reskin():Void {
        super.reskin(); ensure(); if (destroyed) return;
        textureDirty = true; invalidateChart(true);
    }
    public function invalidateChart(layout:Bool = true):Void { if (destroyed) return; visualDirty = true; if (layout) layoutDirty = true; }
    /** Resolve an explicit property, then instance/shared style, then the built-in default. */
    function style(property:String, key:String, fallback:Dynamic):Dynamic {
        if (Reflect.hasField(config,property)) return Reflect.field(config,property);
        if (!hasResolvedStyle(key)) return fallback;
        var v = getResolvedStyle(key);
        if (Std.isOfType(fallback, String)) return Std.isOfType(v,String) ? v : fallback;
        if (property.indexOf("Color") >= 0) return color(v) ? v : fallback;
        return ChartData.finite(v) && v >= 0 && (property.indexOf("Alpha") < 0 || v <= 1) ? v : fallback;
    }
    public function seriesColor(index:Int, series:Dynamic = null, point:Dynamic = null):Int {
        if (point != null && color(point.color)) return point.color;
        if (series != null && color(series.color)) return series.color;
        var palette:Array<Int> = [0x0072B2,0xE69F00,0x009E73,0xCC79A7,0xD55E00,0x56B4E9,0xF0E442,0x000000];
        if (hasResolvedStyle(UIStyleManager.CHART_SERIES_COLORS)) {
            var value:Dynamic = getResolvedStyle(UIStyleManager.CHART_SERIES_COLORS);
            if (Std.isOfType(value,Array) && value.length > 0 && Lambda.foreach(cast(value,Array<Dynamic>), color)) palette = cast value;
        }
        return palette[(index < 0 ? 0 : index) % palette.length];
    }
    override public function draw():Void {
        if (!ready || destroyed || drawing || batching || (!visualDirty && !layoutDirty && !textureDirty)) return;
        drawing = true;
        _width = style("width",UIStyleManager.CHART_DEFAULT_WIDTH,500);
        _height = style("height",UIStyleManager.CHART_DEFAULT_HEIGHT,300);
        if (layoutDirty) { calculateLayout(); layoutCount++; }
        background.graphics.clear();
        if (_width > 0 && _height > 0) {
            background.graphics.beginFill(style("backgroundColor",UIStyleManager.CHART_BACKGROUND_COLOR,0xFFFFFF),style("backgroundAlpha",UIStyleManager.CHART_BACKGROUND_ALPHA,1));
            background.graphics.drawRect(0,0,_width,_height); background.graphics.endFill();
            var border:Float = style("borderThickness",UIStyleManager.CHART_BORDER_THICKNESS,1);
            border = Math.min(border, Math.min(_width,_height));
            if (border > 0) {
                background.graphics.lineStyle(border,style("borderColor",UIStyleManager.CHART_BORDER_COLOR,0xCCCCCC),style("borderAlpha",UIStyleManager.CHART_BORDER_ALPHA,1));
                background.graphics.drawRect(border/2,border/2,_width-border,_height-border);
            }
        }
        if (textureDirty) refreshTexture();
        texture.draw(backgroundImage.graphics,new Rectangle(0,0,_width,_height),textureMode,imageSmoothing);
        drawLabels();
        regions = []; dataLayer.graphics.clear(); dataTextureLayer.graphics.clear(); gridLayer.graphics.clear();
        clearPlot();
        if (bounds.width > 0 && bounds.height > 0) { drawGrid(); drawPlot(); }
        drawInteraction();
        layoutDirty = false; visualDirty = false; drawing = false; renderCount++;
    }
    /** Plot and mark geometry is intentionally absent in the shared shell. */
    function drawPlot():Void {}
    function drawGrid():Void {}
    function clearPlot():Void {}
    function legendItems():Array<Dynamic> {
        var series:Array<Dynamic> = Reflect.hasField(config,"series") ? config.series : [];
        return series;
    }
    function calculateLayout():Void {
        var padding:Float = config.padding;
        var x = Math.min(padding,_width/2); var y = Math.min(padding,_height/2);
        var w = Math.max(0,_width-2*x); var h = Math.max(0,_height-2*y);
        if (title != "") { var used = Math.min(30,h); y += used; h -= used; }
        if (config.showLegend && legendItems().length > 0) {
            var side = config.legend.position == "left" || config.legend.position == "right";
            var used = side ? Math.min(120,w/3) : Math.min(28,h/3);
            if (side) { w -= used; if (config.legend.position == "left") x += used; }
            else { h -= used; if (config.legend.position == "top") y += used; }
        }
        bounds.setTo(x,y,w,h);
        chromeBounds = bounds.clone();
        updatePlotLayers();
    }
    function updatePlotLayers():Void {
        for (layer in [gridLayer,dataLayer,dataTextureLayer,overlayLayer]) {
            layer.x = bounds.x; layer.y = bounds.y;
            layer.scrollRect = new Rectangle(0,0,bounds.width,bounds.height);
        }
    }
    function setText(field:TextField, text:String, color:Int, size:Float):Void {
        field.defaultTextFormat = new TextFormat(style("font",UIStyleManager.CHART_FONT,"_sans"),Std.int(size),color);
        field.text = text;
    }
    function drawLabels():Void {
        var fontSize:Float = style("fontSize",UIStyleManager.CHART_FONT_SIZE,12);
        var pad:Float = Math.min(config.padding, Math.min(_width,_height)/2);
        setText(titleField,title,style("titleColor",UIStyleManager.CHART_TITLE_COLOR,0x222222),fontSize+4);
        titleField.x = pad; titleField.y = pad; titleField.width = Math.max(0,_width-2*pad); titleField.height = Math.min(28,Math.max(0,_height-pad));
        titleField.visible = title != "";
        var hasData = Lambda.exists(points,p -> !p.gap);
        setText(emptyField,config.emptyText,style("emptyTextColor",UIStyleManager.CHART_EMPTY_TEXT_COLOR,0x666666),fontSize);
        emptyField.x = bounds.x; emptyField.y = bounds.y + Math.max(0,(bounds.height-24)/2);
        emptyField.width = bounds.width; emptyField.height = Math.min(24,bounds.height); emptyField.visible = !hasData;
        var items = legendItems();
        var side = config.legend.position == "left" || config.legend.position == "right";
        var available = side ? chromeBounds.height : chromeBounds.width;
        var step:Float = side ? 22+config.legend.spacing : 100+config.legend.spacing;
        var count = config.showLegend ? Std.int(Math.min(items.length, Math.floor(available/step))) : 0;
        // A bounded pool prevents unbounded text display objects for large series lists.
        count = Std.int(Math.min(count,100));
        while (legendFields.length < count) legendFields.push(textField());
        while (legendFields.length > count) labelLayer.removeChild(legendFields.pop());
        legendSwatches.graphics.clear();
        for (i in 0...count) {
            var field = legendFields[i]; var item = items[i];
            var x:Float = side ? (config.legend.position == "left" ? pad : chromeBounds.right+8) : chromeBounds.x+i*step;
            var y:Float = side ? chromeBounds.y+i*step : (config.legend.position == "top" ? chromeBounds.y-28 : chromeBounds.bottom+4);
            setText(field,Reflect.hasField(item,"name") ? Std.string(item.name) : item.id,style("labelColor",UIStyleManager.CHART_LABEL_COLOR,0x333333),fontSize);
            field.x = x+15; field.y = y; field.width = Math.max(0,Math.min(85,_width-field.x)); field.height = 22;
            legendSwatches.graphics.beginFill(seriesColor(i,item)); legendSwatches.graphics.drawRect(x,y+5,10,10); legendSwatches.graphics.endFill();
        }
        labelLayer.scrollRect = new Rectangle(0,0,_width,_height);
    }
    function refreshTexture():Void {
        textureDirty = false;
        var spec:Dynamic = Reflect.field(config,"backgroundTexture");
        var key:String = spec == null ? UIBitmapManager.CHART_BACKGROUND_IMAGE : spec.key;
        textureMode = spec == null ? "stretch" : spec.mode;
        if (spec == null && !hasResolvedBitmap(UIBitmapType.Chart,key) && !(Reflect.hasField(config,"Bitmap") && config.Bitmap != null && Reflect.hasField(config.Bitmap,key))) {
            texture.clear(); return;
        }
        texture.load(key,resolver,function() { invalidateChart(false); draw(); },function(message) {
            issues = issues.filter(issue -> issue.code != "texture" || issue.path != "backgroundTexture");
            ChartData.diagnostic(issues,"texture","backgroundTexture",message); invalidateChart(false); draw();
        });
    }
    function resolveTexture(key:String, complete:BitmapData->Void, failed:String->Void):Void {
        // Loaded instance overrides take precedence; serialized reference keys override the theme.
        var instanceLoaded = Reflect.hasField(_bitmapOverrides,key) && Reflect.field(_bitmapOverrides,key) != null;
        if (!instanceLoaded && Reflect.hasField(config,"Bitmap") && config.Bitmap != null && Std.isOfType(Reflect.field(config.Bitmap,key),String)) key = Reflect.field(config.Bitmap,key);
        if (hasResolvedBitmap(UIBitmapType.Chart,key)) {
            var owned = getResolvedBitmap(UIBitmapType.Chart,key);
            complete(owned); if (owned != null) owned.dispose(); return;
        }
        if (!Assets.exists(key,openfl.utils.AssetType.IMAGE)) { failed("Texture not found: " + key); return; }
        Assets.loadBitmapData(key).onComplete(complete).onError(error -> failed(Std.string(error)));
    }
    /** Regions are in plot-local coordinates; subclasses may override hitTestMark for nonrectangular geometry. */
    function setHitRegions(value:Array<ChartHitRegion>):Void { regions = value; }
    function hitTestMark(x:Float,y:Float):Dynamic {
        var i = regions.length;
        while (i-- > 0) if (regions[i].bounds.contains(x,y)) return regions[i].payload;
        return null;
    }
    function identity(payload:Dynamic):String {
        return payload == null ? "" : haxe.Json.stringify([payload.seriesId,payload.pointId]);
    }
    function retained(payload:Dynamic):Dynamic {
        if (payload == null) return null;
        for (p in points) if (!p.gap && p.id == payload.pointId && p.seriesId == payload.seriesId) return pointPayload(p);
        return null;
    }
    function pointPayload(point:ChartPoint):Dynamic {
        var series = legendItems();
        var payload:Dynamic = {chartName:name,chartType:chartType,pointId:point.id,dataIndex:point.dataIndex,
            seriesId:point.seriesId,seriesIndex:point.seriesIndex < 0 ? null : point.seriesIndex,
            seriesName:point.seriesIndex >= 0 && point.seriesIndex < series.length ? series[point.seriesIndex].name : null,
            label:point.label,value:point.value,xValue:point.x,yValue:point.y,metadata:Reflect.field(point.source,"metadata")};
        for (key in ["categoryId","rowId","columnId"]) if (Reflect.hasField(point.source,key)) Reflect.setField(payload,key,Reflect.field(point.source,key));
        return ChartData.copy(payload);
    }
    function onPointer(event:MouseEvent):Void {
        if (!enabled || destroyed) return;
        var point = globalToLocal(new openfl.geom.Point(event.stageX,event.stageY));
        var hit = event.type == MouseEvent.ROLL_OUT || !bounds.contains(point.x,point.y) ? null : hitTestMark(point.x-bounds.x,point.y-bounds.y);
        if (event.type == MouseEvent.MOUSE_MOVE || event.type == MouseEvent.ROLL_OUT) {
            if (identity(hover) != identity(hit)) {
                var old = hover; hover = ChartData.copy(hit);
                if (old != null) dispatchEvent(new ChartEvent(ChartEvent.ROLL_OUT,old));
                if (hover != null && enabled && !destroyed) dispatchEvent(new ChartEvent(ChartEvent.ROLL_OVER,hover));
                invalidateChart(false); draw();
            }
        } else if (hit != null) {
            var type = event.type == MouseEvent.CLICK ? ChartEvent.CLICK : event.type == MouseEvent.MOUSE_DOWN ? ChartEvent.MOUSE_DOWN : ChartEvent.MOUSE_UP;
            if (type == ChartEvent.CLICK) {
                var changed = identity(selection) != identity(hit); selection = ChartData.copy(hit);
                dispatchEvent(new ChartEvent(type,hit));
                if (changed && enabled && !destroyed && selection != null && identity(selection) == identity(hit)) dispatchEvent(new ChartEvent(ChartEvent.CHANGE,selection));
                invalidateChart(false); draw();
            } else dispatchEvent(new ChartEvent(type,hit));
        }
    }
    function drawInteraction():Void {
        overlay.graphics.clear();
        for (region in regions) {
            var selected = selection != null && identity(region.payload) == identity(selection);
            var hovered = hover != null && identity(region.payload) == identity(hover);
            if (!selected && !hovered) continue;
            var key = selected ? UIStyleManager.CHART_SELECTION_COLOR : UIStyleManager.CHART_ROLLOVER_COLOR;
            var c:Int = hasResolvedStyle(key) && color(getResolvedStyle(key)) ? getResolvedStyle(key) : 0x222222;
            overlay.graphics.lineStyle(selected ? 2 : 1,c);
            overlay.graphics.drawRect(region.bounds.x,region.bounds.y,region.bounds.width,region.bounds.height);
        }
    }
    function onAdded(event:Event):Void {
        if (destroyed || watched) return;
        watched = true; UIBitmapManager.watchElement(UIBitmapType.Chart,this); reskin(); draw();
    }
    function onRemoved(event:Event):Void {
        if (watched) UIBitmapManager.stopWatchElement(UIBitmapType.Chart,this);
        watched = false; hover = null;
    }
    override private function set_width(value:Float):Float {
        ensure(); if (destroyed || !Math.isFinite(value) || value < 0) return _width;
        config.width = value; invalidateChart(true); return super.set_width(value);
    }
    override private function set_height(value:Float):Float {
        ensure(); if (destroyed || !Math.isFinite(value) || value < 0) return _height;
        config.height = value; invalidateChart(true); return super.set_height(value);
    }
    override private function set_imageSmoothing(value:Bool):Bool {
        if (destroyed) return _smoothImage;
        var result = super.set_imageSmoothing(value); invalidateChart(false); draw(); return result;
    }
    override function set_enabled(value:Bool):Bool {
        if (destroyed) return _enabled;
        if (!value) hover = null;
        var result = super.set_enabled(value); invalidateChart(false); draw(); return result;
    }
    override public function setBitmapOverride(key:String, bitmap:BitmapData):Void { if (!destroyed) super.setBitmapOverride(key,bitmap); }
    override public function removeBitmapOverride(key:String):Void { if (!destroyed) super.removeBitmapOverride(key); }
    override public function destroy():Void {
        if (destroyed) return;
        destroyed = true;
        dispatchEvent(new ChartEvent(ChartEvent.DISPOSE, null));
        onRemoved(null);
        removeEventListener(Event.ADDED_TO_STAGE,onAdded); removeEventListener(Event.REMOVED_FROM_STAGE,onRemoved);
        for (type in [MouseEvent.MOUSE_MOVE,MouseEvent.ROLL_OUT,MouseEvent.MOUSE_DOWN,MouseEvent.MOUSE_UP,MouseEvent.CLICK]) removeEventListener(type,onPointer);
        texture.destroy(); resolver = null; selection = null; hover = null; regions = []; points = []; issues = [];
        if (ready) {
            background.graphics.clear(); backgroundImage.graphics.clear();
            for (layer in [gridLayer,dataLayer,dataTextureLayer,overlayLayer,labelLayer]) { layer.graphics.clear(); layer.removeChildren(); }
            overlay.graphics.clear(); legendSwatches.graphics.clear(); legendFields = [];
            removeChildren();
        }
        super.destroy(); ready = false;
    }
}
