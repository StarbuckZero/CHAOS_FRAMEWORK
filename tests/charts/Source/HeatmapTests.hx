import com.chaos.ui.chart.Heatmap;
import com.chaos.ui.chart.HeatmapScale;
import openfl.display.Sprite;
import openfl.display.BitmapData;
class HeatmapTests {
    static var count:Int;
    static function check(ok:Bool,label:String):Void { if(!ok) throw "Phase 11: "+label; count++; }
    public static function input():Dynamic { return {width:435,height:255,title:"Heatmap: values and missing cells",rows:[{id:"r1",label:"North"},{id:"r2",label:"South"}],columns:[{id:"a",label:"Alpha"},{id:"b",label:"Beta"},{id:"c",label:"Gamma"}],data:[{id:"p1",rowId:"r1",columnId:"a",value:-5},{id:"p2",rowId:"r1",columnId:"b",value:0},{id:"p3",rowId:"r2",columnId:"a",value:5},{id:"p4",rowId:"r2",columnId:"c",value:2.5}]}; }
    public static function run(parent:Sprite):Int {
        count=0; check(HeatmapScale.color(0,0,5,10,0,0x808080,0xFFFFFF)==0,"low endpoint");
        check(HeatmapScale.color(5,0,5,10,0,0x808080,0xFFFFFF)==0x808080,"mid endpoint");
        check(HeatmapScale.color(10,0,5,10,0,0x808080,0xFFFFFF)==0xFFFFFF,"high endpoint");
        check(HeatmapScale.color(2.5,0,5,10,0,0x808080,0xFFFFFF)==0x404040,"RGB interpolation");
        var empty=new Heatmap(); check(empty.cells.length==0,"empty construction"); empty.destroy();
        var c=new HeatProbe(input()); parent.addChild(c);
        check(c.chartType=="Heatmap" && c.cells.length==6 && c.xAxis.scale=="categorical" && c.yAxis.scale=="categorical","categorical grid");
        check(c.colorDomain.minimum==-5 && c.colorDomain.midpoint==0 && c.colorDomain.maximum==5,"automatic domain");
        check(c.cells[2].value==null && c.cells[2].color==15132390,"missing cell color");
        var rect=c.cells[2].bounds; check(c.hit(rect.x+rect.width/2,rect.y+rect.height/2)==null,"missing cell has no event");
        rect=c.cells[0].bounds; var hit=c.hit(rect.x+rect.width/2,rect.y+rect.height/2); check(hit.rowId=="r1" && hit.columnId=="a" && hit.pointId=="p1" && hit.value==-5,"cell identity");
        check(c.cells[0].bounds.y<c.cells[3].bounds.y && c.cells[0].bounds.x<c.cells[1].bounds.x,"stable row/column order");
        c.setComponentData({data:[{id:"first",rowId:"r1",columnId:"a",value:2},{id:"second",rowId:"r1",columnId:"a",value:9},{id:"bad",rowId:"unknown",columnId:"a",value:3}]});
        check(c.cells[0].value==2 && c.diagnostics.length>0,"first duplicate wins, unknown reference skipped");
        check(c.colorDomain.minimum==2 && c.colorDomain.maximum==2 && c.cells[0].color==7040715,"constant domain uses middle color");
        c.setComponentData({colorScale:{minimum:0,midpoint:2,maximum:10},minColor:0,midColor:0x808080,maxColor:0xFFFFFF});
        check(c.valueColor(-1)==0 && c.valueColor(20)==0xFFFFFF && c.valueColor(2)==0x808080,"explicit domain clamps endpoints");
        c.setComponentData({colorScale:{minimum:Math.NEGATIVE_INFINITY,maximum:10}}); check(c.colorDomain.minimum==0 && c.diagnostics.length>0,"nonfinite explicit domain retains previous scale");
        c.setComponentData({title:"reject",colorScale:{minimum:2,midpoint:2,maximum:4}}); check(c.title!="reject" && c.colorDomain.maximum==10,"invalid domain rejects atomically");
        c.setComponentData({colorScale:null,data:[]}); check(c.cells.length==6 && c.cells[0].value==null,"empty dataset preserves missing grid");
        c.setComponentData({title:"reject",data:[1,2]}); check(c.title!="reject" && c.cells[0].value==null,"raw observations rejected");
        var d:Dynamic=input(); d.showLabels=false; d.colorScale={minimum:-5,midpoint:0,maximum:5}; d.minColor=0; d.midColor=0x808080; d.maxColor=0xFFFFFF; c.setComponentData(d);
        var image=new BitmapData(435,255,false,0xFFFFFF); image.draw(c); rect=c.cells[0].bounds; check(image.getPixel(Std.int(c.plotBounds.x+rect.x+rect.width/2),Std.int(c.plotBounds.y+rect.y+rect.height/2))==0,"cell color pixel"); image.dispose();
        check(c.hit(rect.right+0.25,rect.y+rect.height/2)==null,"cell gap excluded");
        var old=c.cells[0].bounds.width; c.width=600; check(c.cells[0].bounds.width>old && c.cells.length==6,"resize preserves grid identities");
        c.setComponentData({cellGap:10000}); check(c.cells.length==0,"oversized gap safely hides cells");
        c.setComponentData({cellGap:1,width:435});
        var source=new BitmapData(2,2,false,0xFF0000); var pending:Array<BitmapData->Void>=[]; c.textureResolver=function(key,success,failure){pending.push(success);}; c.setComponentData({texture:{key:"cells",mode:"stretch"}});
        check(c.cellTextureCount==1 && pending.length==1,"shared overlay texture"); pending[0](source);
        image=new BitmapData(435,255,false,0xFFFFFF); image.draw(c); rect=c.cells[0].bounds; var pixel=image.getPixel(Std.int(c.plotBounds.x+rect.x+rect.width/2),Std.int(c.plotBounds.y+rect.y+rect.height/2)); check(pixel!=0 && pixel!=0xFF0000,"texture alpha preserves base encoding"); image.dispose();
        c.setComponentData({textureAlpha:0}); check(c.cellTextureCount==0,"hidden overlay releases texture"); c.setComponentData({textureAlpha:0.2}); var late=pending[pending.length-1]; c.setComponentData({height:0}); late(source); check(c.cellTextureCount==0 && c.cells.length==0,"zero-size and stale callback");
        c.setComponentData(d); var saved=c.toChartData(); Reflect.deleteField(saved,"texture"); var restored=new Heatmap(haxe.Json.parse(haxe.Json.stringify(saved))); check(restored.cells.length==6 && restored.colorDomain.maximum==5,"JSON restore"); restored.destroy();
        parent.removeChild(c); c.destroy(); check(c.numChildren==0 && source.getPixel(0,0)==0xFF0000,"cleanup ownership"); source.dispose();
        var rows:Array<Dynamic>=[]; var columns:Array<Dynamic>=[]; var data:Array<Dynamic>=[];
        for(i in 0...50) { rows.push({id:"r"+i,label:"R"+i}); columns.push({id:"c"+i,label:"C"+i}); }
        for(r in 0...50) for(col in 0...50) data.push({id:r+"_"+col,rowId:"r"+r,columnId:"c"+col,value:r-col});
        var start=haxe.Timer.stamp(); var large=new Heatmap({width:800,height:600,rows:rows,columns:columns,data:data,showLabels:false}); var create=(haxe.Timer.stamp()-start)*1000;
        check(large.cells.length==2500 && large.numChildren==7,"2500 cells use shared display layers");
        start=haxe.Timer.stamp(); for(i in 0...10) large.setComponentData({cellGap:i%2}); var update=(haxe.Timer.stamp()-start)*100;
        check(large.cells.length==2500 && large.numChildren==7,"large updates stable");
        #if js
        js.Syntax.code("window.heatmapMeasurements={cells:2500,createMs:{0},meanVisualUpdateMs:{1},children:7}",create,update);
        #end
        large.destroy(); return count;
    }
}
class HeatProbe extends Heatmap { public function new(data:Dynamic){super(data);} public function hit(x:Float,y:Float):Dynamic{return hitTestMark(x,y);} }

