import com.chaos.ui.chart.ScatterPlot;
import openfl.display.Sprite;
import openfl.display.BitmapData;
class ScatterTests {
    static var count:Int;
    static function check(ok:Bool,label:String):Void { if(!ok) throw "Phase 8: "+label; count++; }
    public static function input():Dynamic {
        var samples:Array<Dynamic>=[{id:"a",x:2.5,y:2},{id:"b",x:-2.5,y:-1},{id:"c",x:0,y:1},{id:"top",x:0,y:1,color:0xE38A25,metadata:{recordId:"record-top"}}];
        return {width:435,height:255,title:"Scatter: overlapping samples",markerSize:14,xAxis:{minimum:-4,maximum:4},yAxis:{minimum:-4,maximum:4},series:[{id:"s",name:"Samples",color:0x278FC0,points:samples}]};
    }
    public static function run(parent:Sprite):Int {
        count=0; var empty=new ScatterPlot(); check(empty.renderedPoints.length==0 && empty.xAxis.scale=="linear","empty numeric defaults"); empty.destroy();
        var c=new ScatterProbe(input()); parent.addChild(c);
        check(c.chartType=="ScatterPlot" && c.lineSegmentCount==0 && c.renderedPoints.length==4,"scatter identity and no strokes");
        check(c.renderedPoints[0].point.id=="a" && c.renderedPoints[1].point.id=="b","input order retained");
        var p=c.renderedPoints[3]; var hit=c.hit(p.x,p.y);
        check(hit.pointId=="top" && hit.dataIndex==3 && hit.metadata.recordId=="record-top","overlap identity and metadata");
        check(hit.xValue==0 && hit.yValue==1 && hit.value==1,"XY event values");
        c.setComponentData({lineWidth:4,xAxis:{scale:"categorical"},yAxis:{scale:"categorical"}});
        check(c.lineSegmentCount==0 && c.xAxis.scale=="linear" && c.yAxis.scale=="linear" && c.diagnostics.length>0,"fixed numeric marker-only semantics");
        c.setComponentData({markerShape:"diamond"}); p=c.renderedPoints[3]; check(c.hit(p.x+5,p.y+5)==null,"diamond corner excluded");
        c.setComponentData({markerShape:"square"}); check(c.hit(p.x+5,p.y+5)!=null,"square corner included");
        c.setComponentData({markerSize:0}); check(c.hit(p.x+3,p.y)!=null,"minimum invisible point target");
        var d:Dynamic=input(); d.series=[{id:"s",points:[{id:"good",x:-1.5,y:2.25},{id:"null",x:1000,y:null},{id:"bad",x:0,y:cast "2"},{id:"infinite",x:1,y:Math.POSITIVE_INFINITY}]}]; c.setComponentData(d);
        check(c.renderedPoints.length==1 && c.diagnostics.length>0,"invalid and null observations skipped");
        c.setComponentData({xAxis:{},yAxis:{}}); check(c.xScale.maximum<1000,"invalid Y does not affect X domain");
        c.setComponentData({title:"reject",series:[{id:"s",points:[{id:"bad",categoryId:"a",value:1}]}]}); check(c.title!="reject" && c.renderedPoints.length==1,"category shape rejected atomically");
        d=input(); d.series.push({id:"later",name:"Later",points:[{id:"last",x:0,y:1,markerSize:20,markerShape:"square",color:0xDD1122}]}); c.setComponentData(d); p=c.renderedPoints[4];
        check(c.hit(p.x,p.y).seriesId=="later" && p.radius==10 && p.shape=="square","later series and point marker overrides");
        var image=new BitmapData(435,255,false,0xFFFFFF); image.draw(c); check(image.getPixel(Std.int(c.plotBounds.x+p.x),Std.int(c.plotBounds.y+p.y))==0xDD1122,"overlap pixel agrees with hit order"); image.dispose();
        var before=c.renderedPoints[0].x; var builds=c.scaleBuildCount; c.width=600; check(c.renderedPoints[0].x>before && c.scaleBuildCount==builds,"resize reuses domains");
        var restored=new ScatterPlot(haxe.Json.parse(haxe.Json.stringify(c.toChartData()))); check(restored.renderedPoints.length==5 && restored.renderedPoints[0].point.id=="a","round trip order and marker settings"); restored.destroy();
        c.setComponentData({xAxis:{minimum:-1,maximum:1},yAxis:{minimum:0,maximum:2}}); check(c.renderedPoints.length==3,"outside centers clipped");
        var source=new BitmapData(2,2,false,0xA822CC); var pending:Array<BitmapData->Void>=[];
        c.textureResolver=function(key,success,failure){pending.push(success);}; d=input(); d.series[0].texture={key:"dots",mode:"stretch"}; c.setComponentData(d);
        check(c.markerTextureCount==1 && pending.length==1,"one texture clone per key"); pending[0](source); p=c.renderedPoints[3]; image=new BitmapData(435,255,false,0xFFFFFF); image.draw(c);
        check(image.getPixel(Std.int(c.plotBounds.x+p.x),Std.int(c.plotBounds.y+p.y))==0xA822CC,"scatter texture pixel"); image.dispose();
        c.setComponentData({series:[]}); check(c.markerTextureCount==0 && c.renderedPoints.length==0,"empty clears resources"); c.setComponentData(d); var late=pending[pending.length-1]; c.setComponentData({height:0}); late(source); check(c.markerTextureCount==0,"zero-size rejects stale completion");
        parent.removeChild(c); c.destroy(); c.destroy(); check(c.numChildren==0 && source.getPixel(0,0)==0xA822CC,"cleanup preserves source"); source.dispose();
        var values:Array<Dynamic>=[]; for(i in 0...1000) values.push({id:"p"+i,x:(i*37)%1000,y:Math.sin(i)*100});
        var start=haxe.Timer.stamp(); var large=new ScatterPlot({width:800,height:300,series:[{id:"large",points:values}]}); var createMs=(haxe.Timer.stamp()-start)*1000;
        check(large.renderedPoints.length==1000 && large.numChildren==7 && large.lineSegmentCount==0,"1000 points with shared layers");
        start=haxe.Timer.stamp(); for(i in 0...10) large.setComponentData({markerSize:4+i%2}); var updateMs=(haxe.Timer.stamp()-start)*100;
        check(large.numChildren==7 && large.renderedPoints[1].point.id=="p1","large updates preserve layers and input order");
        #if js
        js.Syntax.code("window.scatterMeasurements={createMs:{0},meanVisualUpdateMs:{1},points:1000,children:7}",createMs,updateMs);
        #end
        large.destroy(); return count;
    }
}
class ScatterProbe extends ScatterPlot {
    public function new(data:Dynamic) { super(data); }
    public function hit(x:Float,y:Float):Dynamic { return hitTestMark(x,y); }
}

