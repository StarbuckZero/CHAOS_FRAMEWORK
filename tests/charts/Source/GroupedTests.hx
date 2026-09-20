import com.chaos.ui.chart.BarChart;
import com.chaos.ui.chart.ColumnChart;
import com.chaos.ui.chart.GroupedBarChart;
import com.chaos.ui.chart.BarColumnChartBase;
import com.chaos.ui.chart.RectangleLayout;
import openfl.display.Sprite;
import openfl.display.BitmapData;
class GroupedTests {
    static var count:Int;
    static function check(ok:Bool,label:String):Void { if (!ok) throw "Phase 4: "+label; count++; }
    static function near(a:Float,b:Float):Bool { return Math.abs(a-b)<0.001; }
    public static function input():Dynamic { return {width:435,height:255,title:"Grouped bars",showLabels:true,categories:[{id:"a",label:"Same"},{id:"b",label:"Same"},{id:"empty",label:"Missing"}],series:[{id:"s1",name:"First",color:0x268AC0,points:[{id:"p1",categoryId:"b",value:-4},{id:"p2",categoryId:"a",value:8}]},{id:"s2",name:"Second",color:0xE38A25,points:[{id:"p3",categoryId:"a",value:6}]}]}; }
    public static function run(parent:Sprite):Int {
        count=0;
        var slot=RectangleLayout.groupSlot(100,100,2,0,0.2);
        check(near(slot.center,80) && near(slot.band,40),"group slot math");
        check(RectangleLayout.groupSlot(0,10,0,0,0.2)==null,"empty groups safe");
        var single=ColumnTests.input(); single.title="Horizontal bars";
        var bar=new BarChart(single); parent.addChild(bar);
        check(bar.chartType=="BarChart" && bar.orientation=="horizontal","bar identity");
        check(bar.xAxis.scale=="linear" && bar.yAxis.scale=="categorical","bar axes");
        check(bar.valueToY("a")<bar.valueToY("b"),"categories follow top-to-bottom input order");
        var r=bar.rectangles[0].rectangle; var negative=bar.rectangles[1].rectangle;
        check(near(r.x,bar.valueToX(0)) && near(negative.x+negative.width,bar.valueToX(0)),"horizontal mixed-sign baseline");
        check(near(r.y+r.height/2,bar.valueToY("a")),"horizontal category center");
        bar.setComponentData({orientation:"vertical"}); check(bar.orientation=="horizontal" && bar.diagnostics.length>0,"fixed orientation");
        parent.removeChild(bar); bar.destroy();
        var g=new GroupProbe(input()); parent.addChild(g);
        check(g.chartType=="GroupedBarChart" && g.toChartData().layout=="grouped","grouped default at construction");
        check(g.rectangles.length==3,"missing categories and series values create no marks");
        var first=g.rectangles[1].rectangle; var second=g.rectangles[2].rectangle;
        check(first.y+first.height<second.y,"series slots separated");
        check(near(first.height,g.yScale.bandWidth*0.8/2*0.9),"group and bar gaps compose");
        check(near(g.rectangles[0].rectangle.y-first.y,g.yScale.bandWidth),"out-of-order points align by category ID");
        check(g.valueToY("a")!=g.valueToY("b"),"duplicate labels retain distinct IDs");
        var payload=g.hit(second.x+second.width/2,second.y+second.height/2);
        check(payload.chartType=="GroupedBarChart" && payload.seriesId=="s2" && payload.categoryId=="a" && payload.pointId=="p3" && payload.dataIndex==0,"grouped event identity");
        check(g.hit(second.x+second.width/2,first.y+first.height+0.1)==null,"gap does not hit");
        g.setComponentData({layout:"single",barGap:-1});
        check(g.toChartData().layout=="grouped" && g.toChartData().barGap==0.1,"grouped type cannot switch semantics");
        g.setComponentData({barGap:0,groupGap:0}); check(near(g.rectangles[1].rectangle.height,g.yScale.bandWidth/2),"zero gaps");
        var d=input(); var series:Array<Dynamic>=d.series; series.reverse(); g.setComponentData(d);
        check(g.rectangles[0].point.seriesId=="s2" && g.rectangles[0].rectangle.y<g.rectangles[2].rectangle.y,"series reorder updates slots");
        var builds=g.scaleBuildCount; g.height=400;
        check(g.scaleBuildCount==builds && g.rectangles[0].rectangle.height>first.height,"resize recomputes thickness");
        var snapshot=g.toChartData(); var restored=new GroupedBarChart(haxe.Json.parse(haxe.Json.stringify(snapshot)));
        check(restored.rectangles.length==3 && restored.chartType==g.chartType && restored.toChartData().layout=="grouped","grouped round trip"); restored.destroy();
        var source=new BitmapData(2,2,false,0xAA22CC); var calls=0;
        g.textureResolver=function(key,success,failure) { calls++; success(source); };
        d=input(); d.showLabels=false; d.series[0].texture={key:"shared",mode:"tile"}; d.series[1].texture={key:"shared",mode:"fill"};
        g.setComponentData(d); check(calls==1 && g.markTextureCount==1,"grouped textures reuse asset");
        var image=new BitmapData(435,255,false,0xFFFFFF); image.draw(g);
        for (mark in g.rectangles) { var rect=mark.rectangle; check(image.getPixel(Std.int(g.plotBounds.x+rect.x+rect.width/2),Std.int(g.plotBounds.y+rect.y+rect.height/2))==0xAA22CC,"texture within each grouped mark"); }
        image.dispose(); g.setComponentData({series:[]}); check(g.markTextureCount==0 && g.rectangles.length==0,"empty grouped cleanup");
        parent.removeChild(g); g.destroy(); check(source.getPixel(0,0)==0xAA22CC,"grouped cleanup preserves borrowed source"); source.dispose();
        d=input(); d.layout="grouped";
        var c=new ColumnChart(d);
        check(c.rectangles.length==3 && c.toChartData().layout=="grouped","column grouped construction");
        first=c.rectangles[1].rectangle; second=c.rectangles[2].rectangle;
        check(first.x+first.width<second.x && near(first.width,c.xScale.bandWidth*0.8/2*0.9),"vertical group geometry");
        c.setComponentData({layout:"single"}); check(c.toChartData().layout=="grouped" && c.diagnostics.length>0,"single switch rejects retained multiple series");
        c.setComponentData({layout:"single",series:[d.series[0]]}); check(c.toChartData().layout=="single" && c.rectangles.length==2,"atomic switch to single with replacement");
        c.setComponentData(d); check(c.rectangles.length==3,"switch back to grouped");
        var children=c.numChildren; for(i in 0...25) c.setComponentData(d);
        check(c.numChildren==children && c.rectangles.length==3,"group updates keep stable layers"); c.destroy();
        var b=new BarChart(d); check(b.toChartData().layout=="grouped" && b.rectangles.length==3,"BarChart grouped mode"); b.destroy();
        return count;
    }
}
class GroupProbe extends GroupedBarChart {
    public function new(data:Dynamic) { super(data); }
    public function hit(x:Float,y:Float):Dynamic { return hitTestMark(x,y); }
}
