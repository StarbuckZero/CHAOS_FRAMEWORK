import com.chaos.ui.chart.ColumnChart;
import com.chaos.ui.chart.RectangleLayout;
import openfl.display.BitmapData;
import openfl.display.Sprite;
class ColumnTests {
    static var count:Int;
    static function check(ok:Bool,label:String):Void { if (!ok) throw "Phase 3: "+label; count++; }
    static function near(a:Float,b:Float):Bool { return Math.abs(a-b)<0.001; }
    public static function input():Dynamic { return {width:435,height:255,title:"Columns: positive, negative, zero",showLabels:true,categories:[{id:"a",label:"Alpha"},{id:"b",label:"Beta"},{id:"c",label:"Zero"}],series:[{id:"s",name:"Values",color:0x287ABD,points:[{id:"p1",categoryId:"a",value:12,color:0x27A887},{id:"p2",categoryId:"b",value:-4},{id:"p3",categoryId:"c",value:0}]}]}; }
    static function pixel(c:ColumnChart,index:Int):Int {
        var r=c.rectangles[index].rectangle; var b=c.plotBounds;
        var image=new BitmapData(Std.int(c.width),Std.int(c.height),false,0xFFFFFF); image.draw(c);
        var value=image.getPixel(Std.int(b.x+r.x+r.width/2),Std.int(b.y+r.y+r.height/2)); image.dispose(); return value;
    }
    public static function run(parent:Sprite):Int {
        count=0;
        var r=RectangleLayout.segment(50,40,100,20,0.2);
        check(near(r.x,34)&&near(r.height,80)&&near(r.width,32),"vertical geometry");
        r=RectangleLayout.segment(50,40,20,100,0.2,"horizontal");
        check(near(r.y,34)&&near(r.width,80)&&near(r.height,32),"horizontal primitive");
        check(RectangleLayout.segment(0,10,0,1,1)==null,"invalid gap");
        check(RectangleLayout.segment(Math.NaN,10,0,1)==null,"nonfinite geometry");
        var c=new ColumnChart(input()); parent.addChild(c);
        check(c.chartType=="ColumnChart" && c.orientation=="vertical","public type");
        check(c.rectangles.length==2,"zero has no rectangle");
        check(c.yScale.minimum==-4 && c.yScale.maximum==12,"mixed-sign domain");
        var a=c.rectangles[0].rectangle; var b=c.rectangles[1].rectangle;
        check(near(a.y+a.height,c.valueToY(0)) && near(b.y,c.valueToY(0)),"shared zero baseline");
        check(near(a.x+a.width/2,c.valueToX("a")),"category centers");
        var copy=c.rectangles; copy[0].rectangle.x=999;
        check(c.rectangles[0].rectangle.x!=999,"defensive geometry snapshot");
        c.setComponentData({showLabels:false});
        check(pixel(c,0)==0x27A887,"point color precedence"); check(pixel(c,1)==0x287ABD,"series color precedence");
        var builds=c.scaleBuildCount; c.width=600;
        check(c.scaleBuildCount==builds && c.rectangles[0].rectangle.width>a.width,"resize updates rectangles without rebuilding domains");
        c.setComponentData({title:"Rejected",series:[{id:"a",points:[]},{id:"b",points:[]}]});
        check(c.title!="Rejected" && c.rectangles.length==2 && c.diagnostics.length>0,"multi-series atomic rejection");
        c.setComponentData({series:[{id:"s",points:[{id:"xy",x:1,y:2}]}]});
        check(c.rectangles.length==2 && c.diagnostics.length>0,"XY input rejected");
        c.setComponentData({layout:"unsupported",groupGap:1,xAxis:{scale:"linear"}});
        check(c.toChartData().layout=="single" && c.toChartData().groupGap==0.2 && c.xAxis.scale=="categorical","unsupported settings retain valid state");
        c.setComponentData({series:[{id:"s",points:[{id:"gap",categoryId:"a",value:null},{id:"good",categoryId:"a",value:5},{id:"duplicate",categoryId:"a",value:8},{id:"bad",categoryId:"b",value:cast "7"},{id:"unknown",categoryId:"z",value:2}]}]});
        check(c.rectangles.length==1 && c.rectangles[0].point.id=="good","first valid category value wins");
        check(c.yScale.minimum==0,"positive domain includes zero");
        c.setComponentData({series:[{id:"s",points:[{id:"n",categoryId:"a",value:-8}]}]});
        check(c.yScale.maximum==0,"negative domain includes zero");
        c.setComponentData({yAxis:{minimum:2,maximum:4},series:[{id:"s",points:[{id:"large",categoryId:"a",value:1e300}]}]});
        check(near(c.rectangles[0].rectangle.height,c.plotBounds.height),"huge value clipped in data space");
        c.setComponentData({series:[]}); check(c.rectangles.length==0,"empty clears marks");
        c.setComponentData(input()); c.setComponentData({yAxis:{},showLabels:false});
        var source=new BitmapData(4,4,false,0xFF8800); var requests=0;
        var pending:Array<BitmapData->Void>=[];
        c.textureResolver=function(key,success,failure) { requests++; pending.push(success); };
        var data=input(); data.series[0].texture={key:"test",mode:"stretch"}; data.showLabels=false;
        c.setComponentData(data);
        check(c.markTextureCount==1 && requests==1,"shared series texture requested once");
        check(pixel(c,0)==0x27A887,"pending texture preserves solid color");
        pending[0](source);
        check(pixel(c,0)==0xFF8800 && pixel(c,1)==0xFF8800,"textures append across multiple rectangles");
        data.series[0].points[0].texture={key:"",mode:"tile"}; c.setComponentData(data);
        check(pixel(c,0)==0x27A887 && pixel(c,1)==0xFF8800,"point empty texture suppresses series texture");
        c.setComponentData({width:0,height:0}); check(c.markTextureCount==0 && c.rectangles.length==0,"zero-size releases mark resources");
        c.setComponentData(data); check(c.markTextureCount==1 && requests==2,"restore reloads released texture");
        var late=pending[1]; c.setComponentData({series:[]}); late(source);
        check(c.markTextureCount==0 && c.rectangles.length==0,"late removed texture ignored");
        check(source.getPixel(0,0)==0xFF8800,"caller bitmap remains owned by caller");
        c.setComponentData(input());
        var saved=c.toChartData(); var restored=new ColumnChart(haxe.Json.parse(haxe.Json.stringify(saved)));
        check(restored.rectangles.length==2 && restored.toChartData().groupGap==0.2,"JSON round trip"); restored.destroy();
        var children=c.numChildren; for (i in 0...30) c.setComponentData(input());
        check(c.numChildren==children && c.rectangles.length==2,"updates do not accumulate marks or layers");
        parent.removeChild(c); c.destroy(); c.destroy();
        check(c.numChildren==0 && c.markTextureCount==0,"idempotent cleanup"); source.dispose();
        return count;
    }
}



