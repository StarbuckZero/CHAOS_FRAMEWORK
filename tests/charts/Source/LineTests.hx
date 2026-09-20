import com.chaos.ui.chart.LineChart;
import com.chaos.ui.chart.LineGeometry;
import com.chaos.ui.chart.MarkerGeometry;
import openfl.display.Sprite;
import openfl.display.BitmapData;
class LineTests {
    static var count:Int;
    static function check(ok:Bool,label:String):Void { if(!ok) throw "Phase 6: "+label; count++; }
    public static function input():Dynamic { return {width:435,height:255,title:"Lines: gaps and markers",markerSize:10,xAxis:{scale:"linear"},series:[{id:"s",name:"Trend",color:0x278FC0,points:[{id:"p1",x:-2.5,y:-2},{id:"p2",x:0,y:4},{id:"gap",x:1,y:null},{id:"p3",x:2,y:1},{id:"p4",x:4,y:5}]}]}; }
    public static function run(parent:Sprite):Int {
        count=0; var empty=new LineChart(); check(empty.renderedPoints.length==0,"empty construction"); empty.destroy();
        var c=new LineProbe(input()); parent.addChild(c);
        check(c.chartType=="LineChart" && c.renderedPoints.length==4 && c.lineSegmentCount==2,"explicit gap geometry");
        check(c.xScale.minimum==-2.5 && c.yScale.minimum==-2 && c.yScale.maximum==5,"decimal negative domain");
        c.setComponentData({missingBehavior:"connect"}); check(c.lineSegmentCount==3,"connect opt-in");
        c.setComponentData({missingBehavior:"invalid",markerShape:"bad",markerSize:-1}); check(c.toChartData().missingBehavior=="connect" && c.toChartData().markerShape=="circle" && c.toChartData().markerSize==10,"invalid settings retained");
        var d:Dynamic=input(); d.series=[{id:"s",points:[{id:"last",x:5,y:2},{id:"first",x:0,y:1},{id:"equal1",x:3,y:3},{id:"equal2",x:3,y:3}]}]; c.setComponentData(d);
        check(c.renderedPoints[0].point.id=="first" && c.renderedPoints[3].point.id=="last","numeric sorting");
        check(c.renderedPoints[1].point.id=="equal1" && c.renderedPoints[2].point.id=="equal2","stable repeated coordinates");
        var p=c.renderedPoints[2]; var hit=c.hit(p.x,p.y);
        check(hit.pointId=="equal2" && hit.dataIndex==3 && hit.seriesId=="s","last overlapping point and original index");
        check(c.hit(p.x+3,p.y+3)!=null && c.hit(p.x+5,p.y+5)==null,"circular marker hit geometry");
        c.setComponentData({markerShape:"diamond"}); p=c.renderedPoints[2]; check(c.hit(p.x+3,p.y+3)==null,"diamond rejects corner");
        c.setComponentData({markerShape:"square"}); check(c.hit(p.x+4,p.y+4)!=null,"square accepts corner");
        c.setComponentData({markerSize:0,lineWidth:0}); check(c.renderedPoints.length==4 && c.lineSegmentCount==0 && c.hit(p.x+3,p.y)!=null,"invisible markers retain minimum point target");
        c.setComponentData({title:"reject",series:[{id:"s",points:[{id:"p",categoryId:"a",value:1}]}]}); check(c.title!="reject" && c.renderedPoints.length==4,"wrong shape rejects atomically");
        d={width:435,height:255,categories:[{id:"a",label:"Same"},{id:"b",label:"Same"},{id:"c",label:"Third"}],xAxis:{scale:"categorical"},series:[{id:"s",points:[{id:"c",categoryId:"c",value:3},{id:"a",categoryId:"a",value:1}]}],markerSize:12,lineWidth:2,missingBehavior:"gap"}; c.setComponentData(d);
        check(c.lineSegmentCount==0 && c.renderedPoints[0].point.id=="a","absent category gap and category ordering");
        c.setComponentData({missingBehavior:"connect"}); check(c.lineSegmentCount==1,"connect absent category");
        c.setComponentData({series:[{id:"s",points:[{id:"a",categoryId:"a",value:2},{id:"b",categoryId:"b",value:3}]},{id:"t",points:[{id:"t",categoryId:"a",value:2}]}]});
        check(c.renderedPoints.length==3 && c.lineSegmentCount==1,"multiple independent series"); p=c.renderedPoints[2]; check(c.hit(p.x,p.y).seriesId=="t","last series overlap");
        var before=c.renderedPoints[1].x; var builds=c.scaleBuildCount; c.width=600; check(c.renderedPoints[1].x>before && c.scaleBuildCount==builds,"resize reuses domain");
        var restored=new LineChart(haxe.Json.parse(haxe.Json.stringify(c.toChartData()))); check(restored.renderedPoints.length==3 && restored.toChartData().missingBehavior=="connect","JSON restore"); restored.destroy();
        var source=new BitmapData(2,2,false,0xA822CC); var pending:Array<BitmapData->Void>=[];
        c.textureResolver=function(key,success,failure){pending.push(success);};
        d={width:435,height:255,xAxis:{scale:"linear",minimum:0,maximum:4},yAxis:{minimum:0,maximum:4},markerSize:20,markerShape:"circle",series:[{id:"s",color:0x22AA66,texture:{key:"shared",mode:"stretch"},points:[{id:"a",x:1,y:2,color:0xFF8800,texture:null},{id:"b",x:3,y:2,color:0x22AA66,texture:{key:"",mode:"tile"}}]}]}; c.setComponentData(d);
        check(c.markerTextureCount==1 && pending.length==1,"marker texture requested once");
        var image=new BitmapData(435,255,false,0xFFFFFF); image.draw(c); p=c.renderedPoints[0];
        check(image.getPixel(Std.int(c.plotBounds.x+p.x),Std.int(c.plotBounds.y+p.y))==0xFF8800,"point color fallback while pending"); image.dispose(); pending[0](source);
        image=new BitmapData(435,255,false,0xFFFFFF); image.draw(c);
        check(image.getPixel(Std.int(c.plotBounds.x+p.x),Std.int(c.plotBounds.y+p.y))==0xA822CC,"marker texture rendered");
        check(image.getPixel(Std.int(c.plotBounds.x+p.x+9),Std.int(c.plotBounds.y+p.y+9))!=0xA822CC,"texture respects circle boundary");
        p=c.renderedPoints[1]; check(image.getPixel(Std.int(c.plotBounds.x+p.x),Std.int(c.plotBounds.y+p.y))==0x22AA66,"point empty key suppresses texture"); image.dispose();
        d.series.push({id:"top",points:[{id:"overlap",x:1,y:2,color:0xDD1122}]}); c.setComponentData(d);
        image=new BitmapData(435,255,false,0xFFFFFF); image.draw(c); p=c.renderedPoints[0];
        check(image.getPixel(Std.int(c.plotBounds.x+p.x),Std.int(c.plotBounds.y+p.y))==0xDD1122 && c.hit(p.x,p.y).seriesId=="top","last solid marker covers earlier texture and owns hit"); image.dispose();
        c.setComponentData({series:[]}); check(c.markerTextureCount==0 && c.renderedPoints.length==0,"empty releases marker resources");
        c.setComponentData(d); var late=pending[pending.length-1]; c.setComponentData({width:0,height:0}); late(source); check(c.markerTextureCount==0 && c.renderedPoints.length==0,"zero-size and stale texture completion");
        parent.removeChild(c); c.destroy(); check(source.getPixel(0,0)==0xA822CC,"borrowed source survives destruction"); source.dispose();
        var clipped=LineGeometry.clip(-100,50,200,50,100,100); check(clipped!=null && clipped[0]==0 && clipped[2]==100,"line segment clipping");
        check(LineGeometry.clip(-2,-2,-1,-1,100,100)==null,"outside segment rejected");
        var data:Array<Dynamic>=[]; for(i in 0...1000) data.push({id:"p"+i,x:i,y:Math.sin(i/30)});
        var start=haxe.Timer.stamp(); var large=new LineChart({width:800,height:300,xAxis:{scale:"linear"},series:[{id:"large",points:data}]}); var createMs=(haxe.Timer.stamp()-start)*1000;
        check(large.renderedPoints.length==1000 && large.lineSegmentCount==999 && large.numChildren==7,"1000-point shared layers");
        start=haxe.Timer.stamp(); for(i in 0...10) large.setComponentData({markerSize:4+i%2}); var updateMs=(haxe.Timer.stamp()-start)*100;
        check(large.numChildren==7 && large.renderedPoints.length==1000,"repeated 1000-point updates stable");
        #if js
        js.Syntax.code("window.lineMeasurements={createMs:{0},meanVisualUpdateMs:{1},points:1000,children:7}",createMs,updateMs);
        #end
        large.destroy(); return count;
    }
}
class LineProbe extends LineChart {
    public function new(data:Dynamic) { super(data); }
    public function hit(x:Float,y:Float):Dynamic { return hitTestMark(x,y); }
}


