package com.chaos.ui.chart;
import com.chaos.ui.chart.ChartTypes;
import openfl.geom.Rectangle;
import openfl.text.TextField;
import openfl.text.TextFormat;
import com.chaos.ui.UIStyleManager;
typedef HeatCell={var rowId:String; var columnId:String; var value:Null<Float>; var color:Int; var bounds:Rectangle;}
class Heatmap extends CartesianChartBase {
    /** Type identifier for heatmaps. */
    public static inline var TYPE:String="Heatmap";
    /** Copies of the currently rendered heatmap cells. */
    public var cells(get,never):Array<HeatCell>;
    /** Current minimum, midpoint, and maximum values for color mapping. */
    public var colorDomain(get,never):Dynamic;
    /** Number of cached cell textures. */
    public var cellTextureCount(get,never):Int;
    var rendered:Array<HeatCell>;
    var minimum:Float=0; var midpoint:Float=0.5; var maximum:Float=1;
    var textures:Map<String,ChartTexture>;
    var cellLabels:Array<TextField>;
    var scaleLabels:Array<TextField>;
    /** Creates a heatmap with optional configuration. */
    public function new(data:Dynamic=null) { super(data); }
    override function get_chartType():String { return TYPE; }
    function get_cells():Array<HeatCell> { return [for(c in rendered) {rowId:c.rowId,columnId:c.columnId,value:c.value,color:c.color,bounds:c.bounds.clone()}]; }
    function get_colorDomain():Dynamic { return {minimum:minimum,midpoint:midpoint,maximum:maximum}; }
    function get_cellTextureCount():Int { var n=0; for(_ in textures) n++; return n; }
    function ensureHeatmap():Void { if(rendered==null) rendered=[]; if(textures==null) textures=new Map(); if(cellLabels==null) cellLabels=[]; }
    override function defaultAxisScale(axis:String):String { return "categorical"; }
    /** Initializes row, column, cell, and color defaults. */
    override public function initialize():Void {
        ensureHeatmap(); super.initialize();
        for(field in ["rows","columns","data"]) if(!Reflect.hasField(config,field)) Reflect.setField(config,field,[]);
        var defaults:Dynamic={minColor:16250871,midColor:7040715,maxColor:545908,missingColor:15132390,cellGap:1,textureAlpha:0.2};
        for(field in Reflect.fields(defaults)) if(!Reflect.hasField(config,field)) Reflect.setField(config,field,Reflect.field(defaults,field));
        scaleLabels=[]; for(i in 0...3) { var field=new TextField(); field.mouseEnabled=false; field.selectable=false; scaleLabels.push(field); labelLayer.addChild(field); }
    }
    override function validateChartPatch(patch:Dynamic,diagnostics:Array<ChartDiagnostic>):Void {
        super.validateChartPatch(patch,diagnostics);
        if(Lambda.exists(diagnostics,d->d.code=="number" && StringTools.startsWith(d.path,".colorScale."))) { Reflect.deleteField(patch,"colorScale"); ChartData.diagnostic(diagnostics,"setting","colorScale","Nonfinite domain rejected; previous retained"); }
        for(axis in ["xAxis","yAxis"]) if(Reflect.hasField(patch,axis) && Reflect.field(patch,axis).scale!="categorical") { Reflect.deleteField(patch,axis); ChartData.diagnostic(diagnostics,"axis",axis,"Heatmap requires categorical axes"); }
        for(field in ["minColor","midColor","maxColor","missingColor","cellGap","textureAlpha","texture"]) if(Reflect.hasField(patch,field)) {
            var v:Dynamic=Reflect.field(patch,field); var valid=field=="texture"?ChartBase.validTexture(v):field=="cellGap"?ChartData.finite(v)&&v>=0:field=="textureAlpha"?ChartData.finite(v)&&v>=0&&v<=1:ChartBase.color(v);
            if(!valid) { Reflect.deleteField(patch,field); ChartData.diagnostic(diagnostics,"setting",field,"Invalid heatmap setting; previous retained"); }
        }
        if(Std.isOfType(patch.data,Array)) { var values:Array<Dynamic>=patch.data; for(p in values) if(ChartData.object(p) && Reflect.hasField(p,"texture") && !ChartBase.validTexture(p.texture)) { Reflect.deleteField(p,"texture"); ChartData.diagnostic(diagnostics,"setting","data.texture","Invalid cell texture"); } }
    }
    override function validateNormalizedData(result:ChartNormalization):Bool {
        var c=result.config; if(Reflect.hasField(c,"series") || Reflect.hasField(c,"categories")) { ChartData.diagnostic(result.diagnostics,"structure","","Heatmap requires rows, columns and cell data"); return false; }
        var data:Array<Dynamic>=c.data==null?[]:c.data;
        for(p in data) if(!ChartData.object(p) || !Reflect.hasField(p,"rowId") || !Reflect.hasField(p,"columnId") || !Reflect.hasField(p,"value") || Reflect.hasField(p,"x") || Reflect.hasField(p,"y") || Reflect.hasField(p,"categoryId")) { ChartData.diagnostic(result.diagnostics,"structure","data","Expected rowId/columnId/value cells"); return false; }
        var rows:Array<Dynamic>=c.rows==null?[]:c.rows; var columns:Array<Dynamic>=c.columns==null?[]:c.columns;
        if(rows.length*1.0*columns.length>100000) { ChartData.diagnostic(result.diagnostics,"structure","rows/columns","Grid exceeds 100000 cells"); return false; }
        var valid=result.points.filter(p->!p.gap); var low=valid.length==0?0:valid[0].value; var high=valid.length==0?1:valid[0].value;
        for(p in valid) { low=Math.min(low,p.value); high=Math.max(high,p.value); }
        if(c.colorScale!=null) {
            if(!ChartData.object(c.colorScale)) { ChartData.diagnostic(result.diagnostics,"structure","colorScale","Expected domain object"); return false; }
            for(field in ["minimum","midpoint","maximum"]) if(Reflect.hasField(c.colorScale,field) && Reflect.field(c.colorScale,field)!=null && !ChartData.finite(Reflect.field(c.colorScale,field))) { ChartData.diagnostic(result.diagnostics,"structure","colorScale","Domain bounds must be finite"); return false; }
            if(c.colorScale.minimum!=null) low=c.colorScale.minimum; if(c.colorScale.maximum!=null) high=c.colorScale.maximum;
        }
        var mid=c.colorScale!=null && c.colorScale.midpoint!=null?c.colorScale.midpoint:low/2+high/2;
        if(low>high || (low==high?mid!=low:mid<=low || mid>=high)) { ChartData.diagnostic(result.diagnostics,"structure","colorScale","Require min < mid < max, or a constant domain"); return false; }
        minimum=low; midpoint=mid; maximum=high; result.points=valid; return true;
    }
    /** Maps a numeric value to the current heatmap color gradient. */
    public function valueColor(value:Float):Int { return HeatmapScale.color(value,minimum,midpoint,maximum,config.minColor,config.midColor,config.maxColor); }
    override function legendItems():Array<Dynamic> { return [{id:"min"},{id:"mid"},{id:"max"}]; }
    override function drawLabels():Void {
        super.drawLabels(); legendSwatches.graphics.clear(); for(f in legendFields) f.visible=false;
        if(scaleLabels==null) return; for(f in scaleLabels) f.visible=false;
        if(!config.showLegend) return;
        var side=config.legend.position=="left" || config.legend.position=="right";
        var x=side?(config.legend.position=="left"?config.padding:chromeBounds.right+8):chromeBounds.x;
        var y=side?chromeBounds.y:(config.legend.position=="top"?chromeBounds.y-28:chromeBounds.bottom+3);
        var length=side?Math.min(120,chromeBounds.height):chromeBounds.width;
        if(length<48) return;
        for(i in 0...64) { var t=i/63; var value=minimum*(1-t)+maximum*t; legendSwatches.graphics.beginFill(valueColor(value)); if(side) legendSwatches.graphics.drawRect(x,y+i*length/64,10,length/64+0.2); else legendSwatches.graphics.drawRect(x+i*length/64,y,length/64+0.2,8); legendSwatches.graphics.endFill(); }
        var values=[minimum,midpoint,maximum];
        for(i in 0...3) { var f=scaleLabels[i]; f.defaultTextFormat=new TextFormat(style("font",UIStyleManager.CHART_FONT,"_sans"),10,style("labelColor",UIStyleManager.CHART_LABEL_COLOR,0x333333)); f.text=ChartFormat.format(values[i],"number",2); f.width=side?70:Math.min(80,length/3); f.height=16; var fraction=minimum==maximum?0.5:(values[i]/2-minimum/2)/(maximum/2-minimum/2); f.x=side?x+14:Math.max(x,Math.min(x+length-f.width,x+length*fraction-f.width/2)); f.y=side?y+(length-16)*fraction:y+8; f.visible=(minimum!=maximum || i==1) && f.x>=0 && f.y>=0 && f.x+f.width<=width && f.y+16<=height; if(i==1 && minimum!=maximum && (fraction*length<80 || (1-fraction)*length<80)) f.visible=false; }
    }
    override function clearPlot():Void { ensureHeatmap(); rendered=[]; for(f in cellLabels) labelLayer.removeChild(f); cellLabels=[]; if(bounds.width<=0 || bounds.height<=0) releaseTextures(); dataTextureLayer.alpha=config.textureAlpha; }
    override function drawPlot():Void {
        var indexed=new Map<String,ChartPoint>(); for(p in points) indexed.set(haxe.Json.stringify([p.source.rowId,p.source.columnId]),p);
        var used=new Map<String,Bool>(); var hits:Array<ChartHitRegion>=[];
        var rows:Array<Dynamic>=config.rows; var columns:Array<Dynamic>=config.columns;
        var w=Math.max(0,xScale.bandWidth-config.cellGap); var h=Math.max(0,yScale.bandWidth-config.cellGap);
        if(w>0 && h>0) for(row in rows) for(column in columns) {
            var p=indexed.get(haxe.Json.stringify([row.id,column.id])); var color=p==null?config.missingColor:valueColor(p.value);
            var rect=new Rectangle(valueToX(column.id)-w/2,valueToY(row.id)-h/2,w,h);
            rendered.push({rowId:row.id,columnId:column.id,value:p==null?null:p.value,color:color,bounds:rect});
            dataLayer.graphics.beginFill(color); dataLayer.graphics.drawRect(rect.x,rect.y,w,h); dataLayer.graphics.endFill();
            if(p==null) continue;
            hits.push({bounds:rect,payload:pointPayload(p)});
            var spec=p.source.texture!=null?p.source.texture:config.texture;
            if(config.textureAlpha>0 && spec!=null && spec.key!="") { used.set(spec.key,true); useTexture(spec.key).draw(dataTextureLayer.graphics,rect,spec.mode,imageSmoothing,false); }
            if(config.showLabels && cellLabels.length<100) {
                var f=new TextField(); f.mouseEnabled=false; f.selectable=false; var luminance=((color>>16)&255)*0.299+((color>>8)&255)*0.587+(color&255)*0.114;
                f.defaultTextFormat=new TextFormat(style("font",UIStyleManager.CHART_FONT,"_sans"),style("fontSize",UIStyleManager.CHART_FONT_SIZE,12),luminance<150?0xFFFFFF:0x222222,null,null,null,null,null,"center"); f.text=ChartFormat.format(p.value,"number",2); f.width=w; f.height=f.textHeight+4;
                if(f.textWidth+4<=w && f.height<=h) { f.x=bounds.x+rect.x; f.y=bounds.y+rect.y+(h-f.height)/2; labelLayer.addChild(f); cellLabels.push(f); }
            }
        }
        setHitRegions(hits); var obsolete=[for(key in textures.keys()) if(!used.exists(key)) key]; for(key in obsolete) { textures.get(key).destroy(); textures.remove(key); }
    }
    function useTexture(key:String):ChartTexture { if(!textures.exists(key)) { var t=new ChartTexture(); textures.set(key,t); t.load(key,textureResolver,function(){invalidateChart(false);draw();},function(message){issues=issues.filter(d->d.path!="cell.texture["+key+"]");ChartData.diagnostic(issues,"texture","cell.texture["+key+"]",message);invalidateChart(false);draw();}); } return textures.get(key); }
    function releaseTextures():Void { ensureHeatmap(); for(t in textures) t.destroy(); textures=new Map(); }
    /** Releases cached cell textures before applying shared styles. */
    override public function reskin():Void { releaseTextures(); super.reskin(); }
    override function set_textureResolver(value:ChartTextureResolver):ChartTextureResolver { if(!destroyed) releaseTextures(); return super.set_textureResolver(value); }
    /** Releases cell textures, labels, and rendered cell data. */
    override public function destroy():Void { if(destroyed) return; releaseTextures(); rendered=[]; cellLabels=[]; scaleLabels=[]; super.destroy(); }
}

