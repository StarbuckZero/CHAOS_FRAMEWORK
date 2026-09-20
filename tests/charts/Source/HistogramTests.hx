import com.chaos.ui.chart.Histogram;
import com.chaos.ui.chart.HistogramBins;
import openfl.display.Sprite;
import openfl.display.BitmapData;
class HistogramTests {
    static var count:Int;
    static function check(ok:Bool,label:String):Void { if(!ok) throw "Phase 10: "+label; count++; }
    public static function input():Dynamic { return {width:435,height:255,title:"Histogram: observations",binCount:5,color:0x278FC0,data:[-3.,-2.,-1.,-1.,0.,0.,0.,1.,1.,2.,3.],xAxis:{title:"Value"},yAxis:{title:"Count",interval:1,format:{decimals:0}}}; }
    public static function run(parent:Sprite):Int {
        count=0; var empty=new Histogram(); check(empty.bins.length==0,"empty construction"); empty.destroy();
        var c=new HistogramProbe({width:435,height:255,binCount:2,data:[0,1,2,3,4]}); parent.addChild(c);
        check(c.chartType=="Histogram" && c.bins.length==2 && c.bins[0].count==2 && c.bins[1].count==3,"interior edge belongs to next bin, final edge included");
        check(c.bins[0].lowerBound==0 && c.bins[1].upperBound==4 && c.xScale.minimum==0 && c.xScale.maximum==4,"numeric bin domain");
        check(c.rectangles.length==2 && Math.abs(c.rectangles[0].rectangle.width-c.plotBounds.width/2)<0.001,"bin width geometry");
        var r=c.rectangles[1].rectangle; var p=c.hit(r.x+r.width/2,r.y+r.height/2);
        check(p.count==3 && p.lowerBound==2 && p.upperBound==4 && p.observationIndices.join(",")=="2,3,4","bin event bounds and source indices");
        var exported=c.toChartData(); check(exported.data.join(",")=="0,1,2,3,4" && !Reflect.hasField(exported,"series"),"raw observations preserved without synthetic series");
        c.setComponentData({binCount:null}); check(c.bins.length==3,"automatic square-root bins");
        c.setComponentData({binCount:2}); check(c.bins.length==2,"bin count only rebuilds bins and domains");
        c.setComponentData({title:"reject",binWidth:1}); check(c.title!="reject" && c.bins.length==2,"conflicting bin modes reject atomically");
        c.setComponentData({binCount:null,binWidth:1.5}); check(c.bins.length==3 && c.bins[2].upperBound==4.5,"width bins extend to cover max");
        c.setComponentData({binWidth:0}); check(c.toChartData().binWidth==1.5 && c.diagnostics.length>0,"invalid width retained");
        c.setComponentData({binWidth:0.000001}); check(c.bins.length==3 && c.diagnostics.length>0,"excessive bins reject");
        c.setComponentData({binWidth:null,binCount:10001}); check(c.toChartData().binCount==null && c.diagnostics.length>0,"bin count capped");
        c.setComponentData({binCount:7,data:[2.5,2.5,2.5]}); check(c.bins.length==1 && c.bins[0].lowerBound==2 && c.bins[0].upperBound==3 && c.bins[0].count==3,"equal observations one expanded bin");
        var data:Array<Dynamic>=[-2.5,null,"2",0,1.5,Math.POSITIVE_INFINITY]; c.setComponentData({binCount:2,data:data});
        check(c.bins[0].count+c.bins[1].count==3 && c.bins[1].observationIndices.join(",")=="3,4","invalid samples skipped, original indices preserved");
        check(c.toChartData().data.length==6 && c.toChartData().data[5]==null,"JSON-safe raw data retained");
        c.setComponentData({title:"reject",data:[{id:"a",value:2}]}); check(c.title!="reject" && c.bins.length==2,"record data rejected");
        c.setComponentData({data:[]}); check(c.bins.length==0 && c.rectangles.length==0,"empty clears bins");
        c.setComponentData({data:[0,0,4,4],binCount:4}); check(c.bins.length==4 && c.rectangles.length==2 && c.bins[1].count==0,"empty bins retained without interactive rectangles");
        var old=c.rectangles[0].rectangle.width; c.width=600; check(c.bins.length==4 && c.rectangles[0].rectangle.width>old,"resize keeps data bins");
        c.setComponentData({xAxis:{minimum:0.5,maximum:3.5}}); check(c.rectangles.length==2 && Math.abs(c.rectangles[0].rectangle.width-c.plotBounds.width/6)<0.001,"explicit X clips bin boundaries");
        c.setComponentData({yAxis:{minimum:0,maximum:3,interval:1,format:{decimals:0}},xAxis:{showLabels:false}});
        check(c.countAxisLabels()>=4,"single-digit count labels visible");
        var source=new BitmapData(2,2,false,0xAB22CC); var calls=0; c.textureResolver=function(key,success,failure){calls++;success(source);};
        c.setComponentData({width:435,xAxis:{},showLabels:false,texture:{key:"bins",mode:"stretch"}});
        check(c.markTextureCount==1 && calls==1,"one texture for all bins");
        var bitmap=new BitmapData(435,255,false,0xFFFFFF); bitmap.draw(c); r=c.rectangles[0].rectangle;
        check(bitmap.getPixel(Std.int(c.plotBounds.x+r.x+r.width/2),Std.int(c.plotBounds.y+r.y+r.height/2))==0xAB22CC,"textured histogram pixel"); bitmap.dispose();
        var saved=c.toChartData(); Reflect.deleteField(saved,"texture"); var restored=new Histogram(haxe.Json.parse(haxe.Json.stringify(saved))); check(restored.bins.length==4 && restored.bins[3].count==2,"round trip recalculates bins"); restored.destroy();
        c.setComponentData({height:0}); check(c.markTextureCount==0 && c.rectangles.length==0,"zero-size releases resources");
        parent.removeChild(c); c.destroy(); check(c.numChildren==0 && source.getPixel(0,0)==0xAB22CC,"cleanup ownership"); source.dispose();
        var maximum=HistogramBins.calculate([0,1],10000,null); check(maximum.length==10000 && maximum[9999].value==1,"maximum supported bin count");
        return count;
    }
}
class HistogramProbe extends Histogram { public function new(data:Dynamic){super(data);} public function hit(x:Float,y:Float):Dynamic{return hitTestMark(x,y);} public function countAxisLabels():Int { return axisLabels.filter(f->f.visible && f.text!="").length; } }

