import com.chaos.ui.chart.ChartBase;
import com.chaos.ui.chart.ChartData;
import com.chaos.ui.chart.RadialChartBase;
import com.chaos.ui.chart.BarColumnChartBase;
import com.chaos.ui.chart.LineSeriesBase;
import com.chaos.ui.chart.Heatmap;
import com.chaos.ui.UIBitmapManager;
import openfl.display.DisplayObject;
import openfl.display.DisplayObjectContainer;
import openfl.display.Sprite;
import openfl.display.BitmapData;
import openfl.geom.Point;
@:access(com.chaos.ui.chart.ChartBase)
@:access(openfl.events.EventDispatcher)
@:access(com.chaos.ui.UIBitmapManager)
class AcceptanceTests {
    static var checks:Int=0;
    static function check(ok:Bool,label:String):Void { if(!ok) throw "Phase 12: "+label; checks++; }
    public static function objects(object:DisplayObject):Int { var n=1; if(Std.isOfType(object,DisplayObjectContainer)) { var container:DisplayObjectContainer=cast object; for(i in 0...container.numChildren) n+=objects(container.getChildAt(i)); } return n; }
    public static function listeners(object:DisplayObject):Int {
        var n=0; if(object.__eventMap!=null) for(list in object.__eventMap) n+=list.length;
        if(Std.isOfType(object,DisplayObjectContainer)) { var container:DisplayObjectContainer=cast object; for(i in 0...container.numChildren) n+=listeners(container.getChildAt(i)); } return n;
    }
    static function watched(c:ChartBase):Bool { var list:com.chaos.data.DataProvider<com.chaos.ui.classInterface.IBaseUI>=Reflect.field(UIBitmapManager.watchList,"Chart"); return list!=null && list.getItemIndex(c)>=0; }
    static function textureCount(c:ChartBase):Int {
        if(Std.isOfType(c,BarColumnChartBase)) return (cast c:BarColumnChartBase).markTextureCount;
        if(Std.isOfType(c,LineSeriesBase)) return (cast c:LineSeriesBase).markerTextureCount;
        if(Std.isOfType(c,RadialChartBase)) return (cast c:RadialChartBase).sliceTextureCount;
        return (cast c:Heatmap).cellTextureCount;
    }
    public static function target(c:ChartBase):Dynamic {
        var local:Point=null;
        if(Std.isOfType(c,RadialChartBase)) { var radial:RadialChartBase=cast c; var s=radial.slices[0]; var angle=s.start+s.sweep/2; local=new Point(radial.centerX+Math.cos(angle)*radial.radius*0.75,radial.centerY+Math.sin(angle)*radial.radius*0.75); }
        else if(c.regions.length>0) { var r=c.regions[0].bounds; local=new Point(Math.max(1,Math.min(c.plotBounds.width-1,r.x+r.width/2)),Math.max(1,Math.min(c.plotBounds.height-1,r.y+r.height/2))); }
        if(local==null) throw "No gallery mark "+c.chartType;
        var expected=c.hitTestMark(local.x,local.y); if(expected==null) throw "No hit at gallery target "+c.chartType;
        var global=c.localToGlobal(new Point(c.plotBounds.x+local.x,c.plotBounds.y+local.y));
        return {type:c.chartType,x:global.x,y:global.y,pointId:expected.pointId};
    }
    static function pixel(c:ChartBase):Int { var bitmap=new BitmapData(Std.int(c.width),Std.int(c.height),false,0xFFFFFF); bitmap.draw(c); var color=bitmap.getPixel(3,3); bitmap.dispose(); return color; }
    public static function run(parent:Sprite):Int {
        checks=0; var evidence:Array<Dynamic>=[];
        for(type in ChartGalleryData.types) {
            var data=ChartGalleryData.sample(type); var c=ChartGalleryData.create(type,data); parent.addChild(c);
            check(c.chartType==type && c.normalizedPoints.length>0,type+" construct"); check(watched(c),type+" theme watcher registered");
            var saved=c.toChartData(); var restored=ChartGalleryData.create(type,haxe.Json.parse(haxe.Json.stringify(saved)));
            check(restored.chartType==type && haxe.Json.stringify(restored.normalizedPoints)==haxe.Json.stringify(c.normalizedPoints),type+" normalized round trip"); restored.destroy();
            c.setComponentData({Style:{CHART_BACKGROUND_COLOR:0x334455}}); check(pixel(c)==0x334455,type+" instance style");
            c.setComponentData({backgroundColor:0x556677}); c.reskin(); c.draw(); check(pixel(c)==0x556677,type+" explicit style precedence");
            c.setComponentData({visible:false,enabled:false}); check(!c.visible && !c.enabled,type+" visibility/disabled"); c.setComponentData({visible:true,enabled:true});
            for(size in [0,1,20,80]) { c.setComponentData({width:size,height:size,title:"A deliberately long title for a very small chart"}); check(c.plotBounds.width>=0 && c.plotBounds.height>=0 && c.plotBounds.right<=size+0.01 && c.plotBounds.bottom<=size+0.01,type+" small layout "+size); }
            c.setComponentData(data); check(target(c).type==type,type+" resize hit target");
            var longData=ChartData.copy(data); var longText=StringTools.lpad("Long label", "X", 180);
            for(field in ["categories","rows","columns"]) if(Reflect.hasField(longData,field)) { var entries:Array<Dynamic>=Reflect.field(longData,field); for(entry in entries) entry.label=longText; }
            if(Reflect.hasField(longData,"series")) { var entries:Array<Dynamic>=longData.series; for(entry in entries) entry.name=longText; }
            longData.title=longText; longData.width=200; longData.height=140; c.setComponentData(longData);
            check(c.plotBounds.right<=200 && c.plotBounds.bottom<=140 && pixel(c)>=0,type+" long-label small render");
            c.setComponentData(data);
            for(position in ["top","bottom","left","right"]) { c.setComponentData({legend:{position:position}}); check(c.plotBounds.width>=0 && c.plotBounds.height>=0 && pixel(c)>=0,type+" legend "+position); }
            c.setComponentData({legend:{position:"bottom"}});
            var attachedListeners=listeners(c); parent.removeChild(c); parent.addChild(c);
            check(watched(c) && listeners(c)==attachedListeners,type+" reattach listener stability");
            var source=new BitmapData(4,4,false,0x22AA66); var pending:Array<BitmapData->Void>=[]; var failed:Array<String->Void>=[];
            c.textureResolver=function(key,success,error){pending.push(success);failed.push(error);};
            c.setComponentData(ChartGalleryData.textured(type,data,"delayed")); check(pending.length==1 && textureCount(c)==1,type+" texture delay");
            pending[0](source); check(textureCount(c)==1 && source.getPixel(0,0)==0x22AA66,type+" texture success ownership");
            c.setComponentData(ChartGalleryData.textured(type,data,"failure")); failed[1]("Expected acceptance failure"); check(Lambda.exists(c.diagnostics,d->d.code=="texture"),type+" texture failure diagnostic");
            c.setComponentData(ChartGalleryData.textured(type,data,"replacement")); var obsolete=pending[2];
            c.setComponentData(ChartGalleryData.textured(type,data,"latest")); var renders=c.renderCount; obsolete(source); check(c.renderCount==renders,type+" replaced completion ignored"); pending[3](source);
            c.textureResolver=function(key,success,error){success(source);};
            for(i in 0...5) c.setComponentData(ChartGalleryData.textured(type,data,"warm"+(i%2)));
            var objectCount=objects(c); var listenerCount=listeners(c); var watchedBefore=watched(c);
            for(i in 0...40) { c.setComponentData(ChartGalleryData.textured(type,data,"warm"+(i%2))); c.reskin(); c.draw(); }
            check(objects(c)==objectCount && listeners(c)==listenerCount && textureCount(c)==1,type+" warmed children/listeners/textures stable");
            check(watchedBefore && watched(c),type+" repeated reskin preserves watcher");
            evidence.push({type:type,recursiveObjects:objectCount,recursiveListeners:listenerCount,ownedMarkTextures:textureCount(c)});
            c.textureResolver=function(key,success,error){pending.push(success);failed.push(error);}; var afterDispose=pending[pending.length-1]; var failAfter=failed[failed.length-1];
            parent.removeChild(c); check(!watched(c),type+" removed watcher"); c.destroy(); renders=c.renderCount; afterDispose(source); failAfter("late");
            check(c.numChildren==0 && textureCount(c)==0 && c.renderCount==renders && listeners(c)==0,type+" destroy removes listeners and ignores callbacks");
            c.destroy(); check(source.getPixel(0,0)==0x22AA66,type+" shared source survives destroy"); source.dispose();
        }
        #if js
        js.Syntax.code("window.acceptanceLifecycle={0}",evidence);
        var defaults:Array<Dynamic>=[]; for(type in ChartGalleryData.types) { var instance=ChartGalleryData.create(type,{}); defaults.push({type:type,defaults:instance.toChartData()}); instance.destroy(); }
        js.Syntax.code("window.chartDefaults={0}",defaults);
        #end
        var zeroColumn=new com.chaos.ui.chart.ColumnChart(ChartGalleryData.sample("ColumnChart"));
        zeroColumn.selection=zeroColumn.pointPayload(zeroColumn.points[0]); var zeroData=zeroColumn.toChartData(); zeroData.series[0].points[0].value=0;
        zeroColumn.setComponentData(zeroData); check(zeroColumn.selectedItem==null,"zero-height replacement clears rectangle selection"); zeroColumn.destroy();
        var zeroBin=new com.chaos.ui.chart.Histogram({data:[0,1,2,3,4],binCount:4});
        zeroBin.selection=zeroBin.pointPayload(zeroBin.points[1]); zeroBin.setComponentData({data:[0,2,3,4]});
        check(zeroBin.selectedItem==null,"empty interior bin clears retained selection"); zeroBin.destroy();
        return checks;
    }
    public static function performance():Void {
        var samples:Array<Dynamic>=[];
        for(type in ["ColumnChart","LineChart","ScatterPlot","Heatmap"]) {
            var data:Dynamic;
            if(type=="Heatmap") {
                var rows:Array<Dynamic>=[]; var columns:Array<Dynamic>=[]; var cells:Array<Dynamic>=[];
                for(i in 0...50) { rows.push({id:"r"+i,label:"Row "+i}); columns.push({id:"c"+i,label:"Column "+i}); }
                for(r in 0...50) for(col in 0...50) cells.push({id:r+"_"+col,rowId:"r"+r,columnId:"c"+col,value:r-col});
                data={width:800,height:600,rows:rows,columns:columns,data:cells,showLabels:false};
            } else if(type=="ColumnChart") {
                var categories:Array<Dynamic>=[]; var values:Array<Dynamic>=[];
                for(i in 0...100) { categories.push({id:"c"+i,label:"Category "+i}); values.push({id:"p"+i,categoryId:"c"+i,value:i%20-5}); }
                data={width:800,height:400,categories:categories,series:[{id:"s",points:values}],showLabels:false};
            } else {
                var points:Array<Dynamic>=[]; for(i in 0...1000) points.push({id:"p"+i,x:i,y:Math.sin(i/30)});
                data={width:800,height:400,xAxis:{scale:"linear"},series:[{id:"s",points:points}],showLabels:false};
            }
            var start=haxe.Timer.stamp(); var c=ChartGalleryData.create(type,data); var construction=(haxe.Timer.stamp()-start)*1000;
            for(i in 0...5) c.setComponentData(data);
            var count=objects(c); var listenerCount=listeners(c); var times:Array<Float>=[];
            for(i in 0...30) { start=haxe.Timer.stamp(); c.setComponentData(data); times.push((haxe.Timer.stamp()-start)*1000); }
            times.sort((a,b)->a<b?-1:a>b?1:0); var p95=times[28];
            check(construction<250 && p95<50,type+" construction/update budgets");
            check(objects(c)==count && listeners(c)==listenerCount,type+" benchmark lifecycle");
            samples.push({type:type,count:type=="Heatmap"?2500:type=="ColumnChart"?100:1000,constructionMs:construction,p50UpdateMs:times[15],p95UpdateMs:p95,maxUpdateMs:times[29],recursiveObjects:count,recursiveListeners:listenerCount}); c.destroy();
        }
        #if js
        js.Syntax.code("window.acceptancePerformance={0}",samples);
        #end
    }
}
