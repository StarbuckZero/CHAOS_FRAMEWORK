package com.chaos.ui.chart;
import com.chaos.ui.chart.ChartTypes;
import openfl.geom.Rectangle;
import openfl.geom.Matrix;
import openfl.text.TextField;
import openfl.text.TextFormat;
import com.chaos.ui.UIStyleManager;
typedef RadialSlice={var point:ChartPoint; var start:Float; var sweep:Float; var fraction:Float;}
class RadialChartBase extends ChartBase {
    /** Copies of the currently rendered radial slices. */
    public var slices(get,never):Array<RadialSlice>;
    /** Radius of the rendered chart. */
    public var radius(default,null):Float=0;
    /** Horizontal coordinate of the rendered chart center. */
    public var centerX(default,null):Float=0;
    /** Vertical coordinate of the rendered chart center. */
    public var centerY(default,null):Float=0;
    /** Sum of values represented by rendered slices. */
    public var total(default,null):Float=0;
    /** Number of cached slice textures. */
    public var sliceTextureCount(get,never):Int;
    var segments:Array<RadialSlice>;
    var textures:Map<String,ChartTexture>;
    var labels:Array<TextField>;
    /** Creates a radial chart with optional configuration. */
    public function new(data:Dynamic=null) { super(data); }
    function get_slices():Array<RadialSlice> { return cast ChartData.copy(segments); }
    function get_sliceTextureCount():Int { var n=0; for(_ in textures) n++; return n; }
    function hole():Float { return 0; }
    function ensureRadial():Void { if(segments==null) segments=[]; if(textures==null) textures=new Map(); if(labels==null) labels=[]; }
    /** Initializes radial data, angles, and slice defaults. */
    override public function initialize():Void {
        ensureRadial(); super.initialize();
        if(!Reflect.hasField(config,"data")) config.data=[];
        if(!Reflect.hasField(config,"startAngle")) config.startAngle=-90;
        if(!Reflect.hasField(config,"clockwise")) config.clockwise=true;
    }
    override function validateChartPatch(patch:Dynamic,diagnostics:Array<ChartDiagnostic>):Void {
        super.validateChartPatch(patch,diagnostics);
        for(field in ["startAngle","clockwise"]) if(Reflect.hasField(patch,field)) {
            var v:Dynamic=Reflect.field(patch,field); var valid=field=="startAngle"?ChartData.finite(v):Std.isOfType(v,Bool);
            if(!valid) { Reflect.deleteField(patch,field); ChartData.diagnostic(diagnostics,"setting",field,"Invalid radial setting; previous retained"); }
        }
        if(Std.isOfType(patch.data,Array)) { var values:Array<Dynamic>=patch.data; for(p in values) if(ChartData.object(p)) {
            if(Reflect.hasField(p,"color") && p.color!=null && !ChartBase.color(p.color)) { Reflect.deleteField(p,"color"); ChartData.diagnostic(diagnostics,"setting","data.color","Invalid slice color"); }
            if(Reflect.hasField(p,"texture") && !ChartBase.validTexture(p.texture)) { Reflect.deleteField(p,"texture"); ChartData.diagnostic(diagnostics,"setting","data.texture","Invalid slice texture"); }
        } }
    }
    override function validateNormalizedData(result:ChartNormalization):Bool {
        var c=result.config;
        for(field in ["series","categories","rows","columns"]) if(Reflect.hasField(c,field)) { ChartData.diagnostic(result.diagnostics,"structure",field,"Radial charts require record data"); return false; }
        var data:Array<Dynamic>=c.data==null?[]:c.data;
        for(p in data) if(!ChartData.object(p) || !Reflect.hasField(p,"value") || Reflect.hasField(p,"x") || Reflect.hasField(p,"y") || Reflect.hasField(p,"categoryId") || Reflect.hasField(p,"rowId") || Reflect.hasField(p,"columnId")) { ChartData.diagnostic(result.diagnostics,"structure","data","Expected radial value records"); return false; }
        var valid:Array<ChartPoint>=[]; var sum=0.;
        for(p in result.points) {
            if(p.gap || p.value<0) { ChartData.diagnostic(result.diagnostics,"value","data["+p.dataIndex+"]","Radial values must be nonnegative and finite"); continue; }
            if(p.value==0) continue; sum+=p.value; valid.push(p);
        }
        if(!Math.isFinite(sum)) { ChartData.diagnostic(result.diagnostics,"structure","data","Radial total exceeds finite numeric range"); return false; }
        result.points=valid; total=sum; return true;
    }
    override function legendItems():Array<Dynamic> { return [for(p in points) {id:p.id,name:p.label,color:seriesColor(p.dataIndex,null,p.source)}]; }
    override function calculateLayout():Void { super.calculateLayout(); centerX=bounds.width/2; centerY=bounds.height/2; radius=Math.max(0,Math.min(bounds.width,bounds.height)/2-1); }
    override function clearPlot():Void {
        ensureRadial(); segments=[]; for(field in labels) labelLayer.removeChild(field); labels=[];
        if(bounds.width<=0 || bounds.height<=0) releaseTextures();
    }
    override function drawPlot():Void {
        var used=new Map<String,Bool>(); var hit:Array<ChartHitRegion>=[]; var occupied:Array<Rectangle>=[];
        var angle=RadialGeometry.normalize(config.startAngle%360*Math.PI/180); var direction=config.clockwise?1:-1; var accumulated=0.;
        for(i in 0...points.length) {
            var p=points[i]; var fraction=p.value/total; var sweep=direction*(i==points.length-1?Math.max(0,1-accumulated):fraction)*RadialGeometry.TAU;
            accumulated+=fraction; if(sweep==0 || radius<=0) continue;
            segments.push({point:p,start:angle,sweep:sweep,fraction:fraction});
            var polygon=RadialGeometry.polygon(centerX,centerY,radius,hole(),angle,sweep); var g=dataLayer.graphics;
            g.beginFill(seriesColor(p.dataIndex,null,p.source)); AreaGeometry.draw(g,polygon); g.endFill();
            var spec=p.source.texture;
            if(spec!=null && spec.key!="") {
                used.set(spec.key,true); var texture=useTexture(spec.key); var bitmap=texture.bitmap;
                if(bitmap!=null) {
                    var sx=radius*2/bitmap.width; var sy=radius*2/bitmap.height; var tx=centerX-radius; var ty=centerY-radius; var matrix=new Matrix();
                    if(spec.mode!="tile") {
                        if(spec.mode=="fit" || spec.mode=="fill") { var scale=spec.mode=="fit"?Math.min(sx,sy):Math.max(sx,sy); sx=scale; sy=scale; }
                        tx=centerX-bitmap.width*sx/2; ty=centerY-bitmap.height*sy/2; matrix.scale(sx,sy);
                    }
                    matrix.translate(tx,ty); g.beginBitmapFill(bitmap,matrix,spec.mode=="tile",imageSmoothing);
                    AreaGeometry.draw(g,spec.mode=="fit"?AreaGeometry.clip(polygon,tx,ty,tx+bitmap.width*sx,ty+bitmap.height*sy):polygon); g.endFill();
                }
            }
            hit.push({bounds:new Rectangle(centerX-radius,centerY-radius,radius*2,radius*2),payload:pointPayload(p)});
            if(config.showLabels && labels.length<100) {
                var labelRadius=(radius+hole())/2; var middle=angle+sweep/2; var field=new TextField(); field.mouseEnabled=false; field.selectable=false;
                field.defaultTextFormat=new TextFormat(style("font",UIStyleManager.CHART_FONT,"_sans"),style("fontSize",UIStyleManager.CHART_FONT_SIZE,12),style("labelColor",UIStyleManager.CHART_LABEL_COLOR,0x333333));
                field.text=ChartFormat.format(fraction,"percent",1); field.width=field.textWidth+5; field.height=field.textHeight+4;
                field.x=bounds.x+centerX+Math.cos(middle)*labelRadius-field.width/2; field.y=bounds.y+centerY+Math.sin(middle)*labelRadius-field.height/2;
                var box=new Rectangle(field.x,field.y,field.width,field.height);
                if(field.width<Math.abs(sweep)*labelRadius && field.height<radius-hole() && bounds.containsRect(box) && !Lambda.exists(occupied,r->r.intersects(box))) { labels.push(field); labelLayer.addChild(field); occupied.push(box); }
            }
            angle+=sweep;
        }
        setHitRegions(hit);
        var obsolete=[for(key in textures.keys()) if(!used.exists(key)) key]; for(key in obsolete) { textures.get(key).destroy(); textures.remove(key); }
    }
    override function hitTestMark(x:Float,y:Float):Dynamic {
        var i=segments.length; while(i-->0) { var s=segments[i]; if(RadialGeometry.contains(x-centerX,y-centerY,radius,hole(),s.start,s.sweep)) return pointPayload(s.point); } return null;
    }
    override function pointPayload(point:ChartPoint):Dynamic { var payload=super.pointPayload(point); payload.fraction=total>0?point.value/total:0; return payload; }
    override function drawInteraction():Void {
        overlay.graphics.clear();
        for(s in segments) if((selection!=null && identity(selection)==identity(pointPayload(s.point))) || (hover!=null && identity(hover)==identity(pointPayload(s.point)))) {
            overlay.graphics.lineStyle(2,style("selectionColor",UIStyleManager.CHART_SELECTION_COLOR,0x222222)); AreaGeometry.draw(overlay.graphics,RadialGeometry.polygon(centerX,centerY,radius,hole(),s.start,s.sweep));
        }
    }
    function useTexture(key:String):ChartTexture {
        if(!textures.exists(key)) { var texture=new ChartTexture(); textures.set(key,texture); texture.load(key,textureResolver,function(){invalidateChart(false);draw();},function(message){issues=issues.filter(d->d.path!="slice.texture["+key+"]"); ChartData.diagnostic(issues,"texture","slice.texture["+key+"]",message);invalidateChart(false);draw();}); }
        return textures.get(key);
    }
    function releaseTextures():Void { ensureRadial(); for(t in textures) t.destroy(); textures=new Map(); }
    /** Releases cached slice textures before applying shared styles. */
    override public function reskin():Void { releaseTextures(); super.reskin(); }
    override function set_textureResolver(value:ChartTextureResolver):ChartTextureResolver { if(!destroyed) releaseTextures(); return super.set_textureResolver(value); }
    /** Releases slice textures, geometry, and labels. */
    override public function destroy():Void { if(destroyed) return; releaseTextures(); segments=[]; labels=[]; super.destroy(); }
}
