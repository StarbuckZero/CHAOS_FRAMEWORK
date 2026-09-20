import com.chaos.ui.chart.PieChart;
import com.chaos.ui.chart.DonutChart;
import com.chaos.ui.chart.RadialGeometry;
import openfl.display.Sprite;
import openfl.display.BitmapData;
class RadialTests {
    static var count:Int;
    static function check(ok:Bool,label:String):Void { if(!ok) throw "Phase 9: "+label; count++; }
    public static function input():Dynamic { return {width:435,height:255,title:"Pie: slice percentages",data:[{id:"a",label:"Alpha",value:3,color:0x278FC0},{id:"b",label:"Beta",value:1,color:0xE38A25}]}; }
    static function pixel(c:PieChart,x:Float,y:Float):Int { var image=new BitmapData(435,255,false,0xFFFFFF); image.draw(c); var color=image.getPixel(Std.int(c.plotBounds.x+x),Std.int(c.plotBounds.y+y)); image.dispose(); return color; }
    public static function run(parent:Sprite):Int {
        count=0; var empty=new PieChart(); check(empty.slices.length==0,"empty pie"); empty.destroy();
        var c=new PieProbe(input()); parent.addChild(c);
        check(c.total==4 && c.slices.length==2 && c.chartType=="PieChart","pie totals");
        check(Math.abs(c.slices[0].fraction-0.75)<1e-9 && Math.abs(c.slices[1].sweep-Math.PI/2)<1e-9,"fractions and angles");
        var h=c.hit(c.centerX+c.radius/2,c.centerY); check(h.pointId=="a" && h.fraction==0.75 && h.seriesId==null,"radial event identity");
        check(c.hit(c.centerX+c.radius+1,c.centerY)==null,"outside radius excluded");
        c.setComponentData({startAngle:0,clockwise:false}); check(c.hit(c.centerX+c.radius/2,c.centerY+c.radius/2).pointId=="b","counterclockwise start angle");
        c.setComponentData({startAngle:360000,clockwise:true}); check(Math.abs(c.slices[0].start)<1e-9,"large start angle normalized");
        c.setComponentData({startAngle:null,clockwise:"bad"}); check(c.toChartData().startAngle==360000 && c.toChartData().clockwise==true,"invalid settings retained");
        c.setComponentData({title:"reject",data:[1,2]}); check(c.title!="reject" && c.slices.length==2,"raw observations rejected");
        c.setComponentData({data:[{id:"negative",value:-2},{id:"zero",value:0},{id:"null",value:null},{id:"good",value:2}]});
        check(c.total==2 && c.slices.length==1 && c.diagnostics.length>0,"invalid negatives and zero omitted");
        check(c.hit(c.centerX-c.radius/2,c.centerY).pointId=="good" && c.hit(c.centerX+c.radius/2,c.centerY).pointId=="good","full circle hits both halves");
        c.setComponentData({data:[{id:"zero",value:0}]}); check(c.total==0 && c.slices.length==0 && c.hit(c.centerX,c.centerY)==null,"zero total empty");
        c.setComponentData({data:[{id:"tiny",value:0.000001},{id:"large",value:1}]}); var tiny=c.slices[0]; var angle=tiny.start+tiny.sweep/2;
        check(c.hit(c.centerX+Math.cos(angle)*c.radius/2,c.centerY+Math.sin(angle)*c.radius/2).pointId=="tiny","tiny slice analytic hit");
        c.setComponentData({data:[{id:"a",value:1.7e308},{id:"b",value:1.7e308}]}); check(c.slices[0].point.id=="tiny" && c.diagnostics.length>0,"overflow total atomic rejection");
        var source=new BitmapData(4,2,false,0xAB22CC); var pending:Array<BitmapData->Void>=[];
        c.textureResolver=function(key,success,failure){pending.push(success);}; var d:Dynamic=input(); d.showLabels=false; d.startAngle=-90; d.clockwise=true; d.data[0].texture={key:"slice",mode:"stretch"}; d.data[1].texture={key:"slice",mode:"tile"}; c.setComponentData(d);
        check(c.sliceTextureCount==1 && pending.length==1,"shared slice texture"); check(pixel(c,c.centerX+c.radius/2,c.centerY)==0x278FC0,"solid while pending"); pending[0](source);
        check(pixel(c,c.centerX+c.radius/2,c.centerY)==0xAB22CC && pixel(c,c.centerX-c.radius/2,c.centerY-c.radius/2)==0xAB22CC,"texture covers both slices");
        check(pixel(c,c.centerX+c.radius+2,c.centerY)!=0xAB22CC,"texture masked outside circle");
        d.data[1].texture={key:"",mode:"fill"}; c.setComponentData(d); check(pixel(c,c.centerX-c.radius/2,c.centerY-c.radius/2)==0xE38A25,"empty key restores slice color");
        d.data[0].texture.mode="fit"; c.setComponentData(d); check(c.sliceTextureCount==1,"fit reuses texture");
        c.setComponentData({height:0}); check(c.slices.length==0 && c.sliceTextureCount==0,"zero-size releases textures"); c.setComponentData(d); var late=pending[pending.length-1]; c.setComponentData({data:[]}); late(source); check(c.sliceTextureCount==0,"removed slices ignore late completion");
        c.setComponentData(input()); var restored=new PieChart(haxe.Json.parse(haxe.Json.stringify(c.toChartData()))); check(restored.total==4 && restored.slices.length==2,"pie restore"); restored.destroy();
        parent.removeChild(c); c.destroy(); check(c.numChildren==0 && source.getPixel(0,0)==0xAB22CC,"cleanup source ownership"); source.dispose();
        var donut=new DonutProbe(input()); check(donut.chartType=="DonutChart" && donut.toChartData().innerRadius==0.5,"donut defaults");
        check(donut.hit(donut.centerX,donut.centerY)==null && donut.hit(donut.centerX+donut.radius*0.25,donut.centerY)==null,"donut hole excluded");
        check(donut.hit(donut.centerX+donut.radius*0.75,donut.centerY)!=null,"donut ring hits");
        donut.setComponentData({innerRadius:1,centerText:4}); check(donut.toChartData().innerRadius==0.5 && donut.toChartData().centerText=="","invalid donut settings retained");
        donut.setComponentData({innerRadius:0.7,centerText:"Total 4",showLabels:false,data:[{id:"full",value:4,color:0x278FC0}]});
        var bitmap=new BitmapData(435,255,false,0xFFFFFF); bitmap.draw(donut);
        check(bitmap.getPixel(Std.int(donut.plotBounds.x+donut.centerX),Std.int(donut.plotBounds.y+donut.centerY+donut.radius*0.4))==0xFFFFFF,"full donut renders open hole"); bitmap.dispose();
        var old=donut.radius; donut.height=400; check(donut.radius>old && donut.hit(donut.centerX,donut.centerY)==null,"resize recomputes ring");
        var saved=donut.toChartData(); var copy=new DonutChart(haxe.Json.parse(haxe.Json.stringify(saved))); check(copy.toChartData().innerRadius==0.7 && copy.toChartData().centerText=="Total 4","donut restore"); copy.destroy();
        var children=donut.numChildren; for(i in 0...20) donut.setComponentData({startAngle:i*10}); check(donut.numChildren==children && donut.slices.length==1,"bounded repeated updates"); donut.destroy(); donut.destroy(); check(donut.numChildren==0,"donut idempotent cleanup"); return count;
    }
}
class PieProbe extends PieChart { public function new(data:Dynamic){super(data);} public function hit(x:Float,y:Float):Dynamic{return hitTestMark(x,y);} }
class DonutProbe extends DonutChart { public function new(data:Dynamic){super(data);} public function hit(x:Float,y:Float):Dynamic{return hitTestMark(x,y);} }
