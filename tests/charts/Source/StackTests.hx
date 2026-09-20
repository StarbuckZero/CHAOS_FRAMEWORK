import com.chaos.ui.chart.StackedBarChart;
import com.chaos.ui.chart.ColumnChart;
import com.chaos.ui.chart.StackLayout;
import openfl.display.Sprite;
import openfl.display.BitmapData;
class StackTests {
    static var count:Int;
    static function check(ok:Bool,label:String):Void { if(!ok) throw "Phase 5: "+label; count++; }
    static function near(a:Float,b:Float):Bool { return Math.abs(a-b)<0.00001; }
    public static function input():Dynamic { return {width:435,height:255,title:"Stacked bars",showLabels:true,categories:[{id:"a",label:"Alpha"},{id:"b",label:"Beta"},{id:"zero",label:"Zero"}],series:[
        {id:"s1",name:"First",color:0x268AC0,points:[{id:"p1",categoryId:"a",value:6},{id:"p2",categoryId:"b",value:-2},{id:"z",categoryId:"zero",value:0}]},
        {id:"s2",name:"Second",color:0xE38A25,points:[{id:"p3",categoryId:"a",value:4},{id:"p4",categoryId:"b",value:-6}]},
        {id:"s3",name:"Third",color:0x2AA27A,points:[{id:"p5",categoryId:"a",value:-5}]}]}; }
    public static function run(parent:Sprite):Int {
        count=0; var empty=new StackedBarChart(); check(empty.rectangles.length==0,"empty constructor"); empty.destroy(); var c=new StackProbe(input()); parent.addChild(c);
        check(c.chartType=="StackedBarChart" && c.toChartData().layout=="stacked","fixed stacked type");
        check(c.rectangles.length==5,"missing and zero segments skipped");
        check(c.xScale.minimum==-8 && c.xScale.maximum==10,"raw cumulative domain");
        var r=c.rectangles; var first=r[0].rectangle; var second=r[2].rectangle;
        check(near(first.x+first.width,second.x),"positive segments contiguous");
        check(near(r[3].rectangle.x+r[3].rectangle.width,r[1].rectangle.x),"negative segments contiguous");
        check(near(r[4].rectangle.x+r[4].rectangle.width,c.valueToX(0)),"mixed category negative starts at zero");
        var p=c.hit(second.x+second.width/2,second.y+second.height/2);
        check(p.seriesId=="s2" && p.pointId=="p3" && p.categoryId=="a","segment hit identity");
        check(p.rawValue==4 && near(p.normalizedValue,0.4) && p.positiveTotal==10 && p.negativeTotal==-5 && p.signedTotal==5,"raw and normalized payload totals");
        p.positiveTotal=999; check(c.hit(second.x+second.width/2,second.y+second.height/2).positiveTotal==10,"payload snapshot");
        c.setComponentData({stackMode:"percent"});
        check(near(c.xScale.minimum,-1) && near(c.xScale.maximum,1),"mode-only change rebuilds domain");
        r=c.rectangles; check(near(r[0].rectangle.width,c.plotBounds.width*0.3),"positive percent segment");
        check(near(r[1].rectangle.width,c.plotBounds.width*0.125),"negative percent denominator");
        second=r[2].rectangle; p=c.hit(second.x+second.width/2,second.y+second.height/2);
        check(p.value==4 && p.rawValue==4 && near(p.normalizedValue,0.4) && p.signedTotal==5,"percent payload retains raw totals");
        c.setComponentData({stackMode:"bad",layout:"grouped"}); check(c.toChartData().stackMode=="percent" && c.toChartData().layout=="stacked","invalid mode and layout retained");
        c.setComponentData({stackMode:"raw",xAxis:{minimum:2,maximum:8}}); r=c.rectangles;
        check(r.length==2 && near(r[0].rectangle.width,c.plotBounds.width*4/6) && near(r[1].rectangle.width,c.plotBounds.width*2/6),"explicit range clips each accumulated segment");
        c.setComponentData({xAxis:{}});
        var before=c.toChartData(); c.setComponentData({title:"overflow",series:[{id:"a",points:[{id:"a",categoryId:"a",value:1.7e308}]},{id:"b",points:[{id:"b",categoryId:"a",value:1.7e308}]}]});
        check(c.title!="overflow" && c.rectangles.length==5 && c.diagnostics.length>0,"overflow total rejects atomically");
        var d:Dynamic=input(); d.series=[{id:"s",points:[{id:"z",categoryId:"zero",value:0}]}]; d.stackMode="percent"; c.setComponentData(d);
        check(c.rectangles.length==0 && Math.isFinite(c.xScale.minimum) && Math.isFinite(c.xScale.maximum),"all-zero percent safe");
        d=input(); d.series=[{id:"s",points:[{id:"a",categoryId:"a",value:4}]},{id:"t",points:[{id:"b",categoryId:"a",value:-4}]}]; c.setComponentData(d);
        r=c.rectangles; p=c.hit(r[0].rectangle.x+r[0].rectangle.width/2,r[0].rectangle.y+r[0].rectangle.height/2);
        check(p.signedTotal==0 && p.positiveTotal==4 && p.negativeTotal==-4 && c.rectangles.length==2,"net-zero category retains both sides");
        d=input(); d.series=[{id:"s",points:[{id:"a",categoryId:"a",value:3}]},{id:"t",points:[{id:"b",categoryId:"a",value:null},{id:"c",categoryId:"b",value:2}]}]; d.stackMode="percent"; c.setComponentData(d);
        check(c.rectangles.length==2 && c.xScale.minimum==0 && c.xScale.maximum==1,"positive-only percent and null segment");
        d.series=[{id:"s",points:[{id:"a",categoryId:"a",value:-3}]}]; c.setComponentData(d);
        check(c.xScale.minimum==-1 && c.xScale.maximum==0,"negative-only percent domain");
        var source=new BitmapData(2,2,false,0xAB22CD); var calls=0;
        c.textureResolver=function(key,success,failure) { calls++; success(source); };
        d=input(); d.stackMode="raw"; d.showLabels=false; d.series[0].texture={key:"shared",mode:"stretch"}; d.series[1].texture={key:"shared",mode:"tile"}; d.series[1].points[0].texture={key:"",mode:"fill"}; c.setComponentData(d);
        check(c.markTextureCount==1 && calls==1,"stack shared texture");
        var image=new BitmapData(435,255,false,0xFFFFFF); image.draw(c); r=c.rectangles;
        for(i in [0,1,3]) { var mark=r[i].rectangle; check(image.getPixel(Std.int(c.plotBounds.x+mark.x+mark.width/2),Std.int(c.plotBounds.y+mark.y+mark.height/2))==0xAB22CD,"textured stacked segment"); }
        var mark=r[2].rectangle; check(image.getPixel(Std.int(c.plotBounds.x+mark.x+mark.width/2),Std.int(c.plotBounds.y+mark.y+mark.height/2))==0xE38A25,"point texture suppression"); image.dispose();
        c.setComponentData({series:[]}); check(c.rectangles.length==0 && c.markTextureCount==0,"empty stack releases textures");
        parent.removeChild(c); c.destroy(); check(source.getPixel(0,0)==0xAB22CD,"borrowed texture survives destruction"); source.dispose();
        d=input(); d.layout="stacked"; d.stackMode="percent";
        var columns=new ColumnChart(d); check(columns.rectangles.length==5 && columns.yScale.minimum==-1 && columns.yScale.maximum==1,"vertical percent stacks");
        r=columns.rectangles; check(near(r[2].rectangle.y+r[2].rectangle.height,r[0].rectangle.y),"vertical cumulative geometry");
        columns.setComponentData({layout:"grouped"}); check(columns.yScale.maximum==6 && columns.yScale.minimum==-6,"layout-only change restores grouped domain");
        columns.setComponentData({layout:"stacked",stackMode:"raw"}); check(columns.yScale.maximum==10 && columns.yScale.minimum==-8,"raw vertical cumulative domain");
        var restored=new ColumnChart(haxe.Json.parse(haxe.Json.stringify(columns.toChartData()))); check(restored.rectangles.length==5 && restored.toChartData().layout=="stacked","stack round trip"); restored.destroy();
        var old=columns.rectangles[0].rectangle.height; columns.height=400; check(columns.rectangles[0].rectangle.height>old,"stack resize");
        var children=columns.numChildren; for(i in 0...20) columns.setComponentData({stackMode:i%2==0?"raw":"percent"});
        check(columns.numChildren==children && columns.rectangles.length==5,"mode updates keep stable layers"); columns.destroy();
        return count;
    }
}
class StackProbe extends StackedBarChart {
    public function new(data:Dynamic) { super(data); }
    public function hit(x:Float,y:Float):Dynamic { return new com.chaos.ui.event.ChartEvent(com.chaos.ui.event.ChartEvent.CLICK,hitTestMark(x,y)).payload; }
}



