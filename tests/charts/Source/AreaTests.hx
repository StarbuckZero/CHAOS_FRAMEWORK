import com.chaos.ui.chart.AreaChart;
import openfl.display.Sprite;
import openfl.display.BitmapData;
class AreaTests {
    static var count:Int;
    static function check(ok:Bool,label:String):Void { if(!ok) throw "Phase 7: "+label; count++; }
    public static function input():Dynamic { return {width:435,height:255,title:"Area: crossing zero",fillAlpha:0.4,markerSize:8,missingBehavior:"gap",yAxis:{},xAxis:{scale:"linear"},series:[{id:"s",name:"Trend",color:0x278FC0,points:[{id:"a",x:0,y:3},{id:"b",x:1,y:-2},{id:"c",x:2,y:4},{id:"gap",x:3,y:null},{id:"d",x:4,y:2},{id:"e",x:5,y:3}]}]}; }
    static function pixel(c:AreaChart,x:Float,y:Float):Int { var b=new BitmapData(Std.int(c.width),Std.int(c.height),false,0xFFFFFF); b.draw(c); var color=b.getPixel(Std.int(c.plotBounds.x+c.valueToX(x)),Std.int(c.plotBounds.y+c.valueToY(y))); b.dispose(); return color; }
    public static function run(parent:Sprite):Int {
        count=0; var empty=new AreaChart(); check(empty.fillPolygonCount==0,"empty construction"); empty.destroy();
        var c=new AreaProbe(input()); parent.addChild(c);
        check(c.chartType=="AreaChart" && c.fillPolygonCount==5 && c.lineSegmentCount==3,"crossing triangles and gap");
        var p=c.renderedPoints[1]; check(c.hit(p.x,p.y).baseline==0 && c.hit(p.x,p.y).value==-2,"point event baseline");
        c.setComponentData({missingBehavior:"connect"}); check(c.fillPolygonCount==6,"connect gap fills continuous path");
        c.setComponentData({baseline:5,fillAlpha:2,layout:"stacked"}); check(c.toChartData().baseline==0 && c.toChartData().fillAlpha==0.4 && c.diagnostics.length>0,"fixed baseline and alpha validation");
        var d:Dynamic={width:435,height:255,fillAlpha:1,lineWidth:0,markerSize:0,xAxis:{scale:"linear",minimum:0,maximum:10,showGrid:false},yAxis:{minimum:-10,maximum:10,showGrid:false,showZeroLine:false},series:[{id:"s",color:0x22AA66,points:[{id:"a",x:0,y:8},{id:"b",x:10,y:8}]}]}; c.setComponentData(d);
        check(pixel(c,5,4)==0x22AA66,"positive fill"); check(pixel(c,5,-4)!=0x22AA66,"positive excludes below baseline");
        d.series[0].points[0].y=-8; d.series[0].points[1].y=-8; c.setComponentData(d);
        check(pixel(c,5,-4)==0x22AA66 && pixel(c,5,4)!=0x22AA66,"negative fill");
        d.series[0].points[0].y=-8; d.series[0].points[1].y=8; c.setComponentData(d);
        check(pixel(c,2,-2)==0x22AA66 && pixel(c,8,2)==0x22AA66,"crossing-zero lobes");
        check(pixel(c,2,2)!=0x22AA66 && pixel(c,8,-2)!=0x22AA66,"crossing excludes opposite sides");
        d.yAxis={minimum:5,maximum:10,showGrid:false,showZeroLine:false}; d.series[0].points[0].y=0; d.series[0].points[1].y=10; c.setComponentData(d);
        check(pixel(c,8,6)==0x22AA66 && pixel(c,2,6)!=0x22AA66,"offscreen baseline clips original polygon");
        d.yAxis={minimum:-10,maximum:10,showGrid:false,showZeroLine:false}; d.series[0].points=[{id:"a",x:0,y:8},{id:"gap",x:5,y:null},{id:"b",x:10,y:8}]; d.missingBehavior="gap"; c.setComponentData(d);
        check(c.fillPolygonCount==0,"isolated samples have no area");
        d.missingBehavior="connect"; c.setComponentData(d); check(pixel(c,5,4)==0x22AA66,"connect explicit null");
        d.series.push({id:"top",color:0xDD1122,points:[{id:"a",x:0,y:6},{id:"b",x:10,y:6}]}); c.setComponentData(d);
        check(pixel(c,5,4)==0xDD1122 && pixel(c,5,7)==0x22AA66,"later series overlays without stacking");
        d.lineWidth=3; d.series[1].points[0].y=9; d.series[1].points[1].y=9; c.setComponentData(d);
        check(pixel(c,5,8)==0x22AA66,"all strokes stay above later area fills");
        d.lineWidth=0; d.series[1].points[0].y=6; d.series[1].points[1].y=6;
        d.series[1].fillAlpha=0.5; c.setComponentData(d); var blend=pixel(c,5,4); check(blend!=0xDD1122 && blend!=0x22AA66,"per-series alpha blend");
        var source=new BitmapData(4,2,false,0xA822CC); var pending:Array<BitmapData->Void>=[];
        c.textureResolver=function(key,success,failure){pending.push(success);}; d.series=[{id:"s",color:0x22AA66,texture:{key:"area",mode:"stretch"},points:[{id:"a",x:0,y:8},{id:"b",x:10,y:8}]}]; c.setComponentData(d);
        check(c.markerTextureCount==1 && pending.length==1 && pixel(c,5,4)==0x22AA66,"delayed fill retains solid"); pending[0](source);
        check(pixel(c,5,4)==0xA822CC && pixel(c,5,-4)!=0xA822CC,"texture clipped to fill");
        d.series[0].texture.mode="tile"; c.setComponentData(d); check(pixel(c,5,4)==0xA822CC,"tile fill");
        d.series[0].texture.mode="fill"; c.setComponentData(d); check(pixel(c,5,4)==0xA822CC,"cover fill");
        d.series[0].texture.mode="fit"; c.setComponentData(d); check(c.fillPolygonCount>0 && c.markerTextureCount==1,"fit uses cached texture");
        c.setComponentData({fillAlpha:0}); check(c.fillPolygonCount==0 && c.markerTextureCount==0,"hidden fill releases texture");
        c.setComponentData({fillAlpha:1}); var late=pending[pending.length-1]; c.setComponentData({series:[]}); late(source); check(c.fillPolygonCount==0 && c.markerTextureCount==0,"removed fill ignores stale callback");
        check(source.getPixel(0,0)==0xA822CC,"borrowed texture remains alive");
        c.setComponentData(input()); var saved=c.toChartData(); var restored=new AreaChart(haxe.Json.parse(haxe.Json.stringify(saved))); check(restored.fillPolygonCount==5 && restored.toChartData().fillAlpha==0.4,"JSON restore"); restored.destroy();
        var children=c.numChildren; c.width=600; check(c.fillPolygonCount==5,"resize regenerates fill");
        for(i in 0...20) c.setComponentData({fillAlpha:0.2+i%2*0.2}); check(c.numChildren==children && c.fillChildren()==1,"repeated updates keep bounded series layers");
        c.setComponentData({height:0}); check(c.fillPolygonCount==0 && c.fillChildren()==0,"zero-size clears fills"); parent.removeChild(c); c.destroy(); c.destroy(); check(c.numChildren==0,"idempotent cleanup"); source.dispose();
        var positive=new AreaChart({categories:[{id:"a",label:"A"},{id:"b",label:"B"}],series:[{id:"s",points:[{id:"a",categoryId:"a",value:2},{id:"b",categoryId:"b",value:4}]}]});
        check(positive.yScale.minimum==0 && positive.fillPolygonCount==1,"categorical area includes zero"); positive.destroy(); return count;
    }
}
class AreaProbe extends AreaChart {
    public function new(data:Dynamic) { super(data); }
    public function hit(x:Float,y:Float):Dynamic { return hitTestMark(x,y); }
    public function fillChildren():Int { return fills.numChildren; }
}


