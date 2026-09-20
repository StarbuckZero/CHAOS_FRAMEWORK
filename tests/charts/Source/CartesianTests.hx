import com.chaos.ui.chart.CartesianChartBase;
import com.chaos.ui.chart.ChartScale;
import openfl.display.BitmapData;
import openfl.display.Sprite;

class CartesianTests {
    static var count:Int;
    static function check(ok:Bool,message:String):Void { if (!ok) throw "Phase 2 Cartesian: " + message; count++; }
    static function near(a:Null<Float>,b:Float):Bool { return a != null && Math.abs(a-b) < 1e-6; }
    static function input():Dynamic { return {width:500,height:300,title:"Axes",categories:[{id:"a",label:"Alpha"},{id:"b",label:"Beta"}],series:[{id:"s",name:"Values",points:[{id:"p1",categoryId:"a",value:-5},{id:"p2",categoryId:"b",value:15}]}],xAxis:{title:"Category"},yAxis:{title:"Value"}}; }
    public static function run(parent:Sprite):Int {
        count = 0;
        var chart = new CartesianProbe(input()); parent.addChild(chart);
        check(chart.xAxis.scale == "categorical" && chart.yAxis.scale == "linear","default axes");
        check(chart.yScale.minimum == -5 && chart.yScale.maximum == 15,"data domain");
        check(near(chart.valueToX("a"),chart.plotBounds.width/4) && near(chart.valueToY(15),0),"coordinate conversion");
        check(chart.xToValue(chart.valueToX("b")) == "b" && near(chart.yToValue(chart.valueToY(0)),0),"inverse conversion");
        check(chart.valueToX("missing") == null,"unknown category returns null");
        check(chart.plotBounds.x > 16 && chart.plotBounds.bottom < chart.chromeBottom(),"axis margins reserved");
        check(chart.axisLabelCount() > 2 && chart.axisLabelCount() <= 402,"bounded tick labels and titles");
        var builds = chart.scaleBuildCount; var layouts = chart.layoutCount;
        chart.setComponentData({gridColor:0xCCCCCC,gridAlpha:0.4});
        check(chart.scaleBuildCount == builds && chart.layoutCount == layouts,"visual update reuses scales/layout");
        chart.width = 640;
        check(chart.scaleBuildCount == builds && chart.plotBounds.right <= 640,"resize reuses domain");
        check(near(chart.valueToX("a"),chart.plotBounds.width/4),"resized pixel range");
        chart.setComponentData({yAxis:{minimum:-10,maximum:20,interval:5,format:{kind:"number",decimals:0}}});
        check(chart.yScale.minimum == -10 && chart.yScale.maximum == 20 && chart.yScale.ticks().length == 7,"explicit axis bounds and interval");
        check(chart.yAxis.title == "","axis object replacement restores omitted defaults");
        chart.setComponentData({title:"Kept",yAxis:{minimum:2,maximum:1}});
        check(chart.yScale.minimum == -10 && chart.title == "Kept" && chart.diagnostics.length > 0,"invalid bounds retain previous axis");
        chart.setComponentData({yAxis:{minimum:ChartScale.MAX_VALUE}});
        check(chart.yAxis.minimum == -10 && chart.diagnostics.length > 0,"unrepresentable one-sided bound retains prior axis");
        chart.setComponentData({yAxis:{interval:0}}); check(chart.yAxis.interval == 5,"invalid interval retained");
        chart.setComponentData({yAxis:{minimum:Math.POSITIVE_INFINITY}}); check(chart.yAxis.minimum == -10,"nonfinite axis rejected before null coercion");
        chart.setComponentData({xAxis:{scale:"categorical",minimum:5,interval:-1}});
        check(chart.xAxis.minimum == null && chart.xAxis.interval == null && chart.diagnostics.length > 0,"categorical numeric options ignored");
        var snapshot = chart.xAxis; snapshot.title = "Mutation"; check(chart.xAxis.title != "Mutation","axis getter snapshot");
        chart.setComponentData({yAxis:{format:{kind:"percent",decimals:1}},xAxis:{showLabels:false},showLegend:false});
        check(chart.yAxis.format.kind == "percent" && !chart.xAxis.showLabels,"format and visibility update");
        var saved = chart.toChartData(); var restored = new CartesianProbe(haxe.Json.parse(haxe.Json.stringify(saved)));
        check(restored.yAxis.format.kind == "percent" && restored.plotBounds.width > 0,"axis round trip"); restored.destroy();
        var categories:Array<Dynamic> = [];
        for (i in 0...1000) categories.push({id:"c"+i,label:"A very long category name " + i});
        chart.setComponentData({width:200,height:120,title:"",categories:categories,series:[],xAxis:{title:"Long title"},yAxis:{title:"Values"}});
        check(chart.xScale.ticks().length <= 200 && chart.axisLabelCount() <= 402,"large categories bounded");
        check(chart.labelsInside(),"crowded labels stay within component");
        for (size in [0,1,10,40,80]) {
            chart.setComponentData({width:size,height:size});
            check(chart.plotBounds.width >= 0 && chart.plotBounds.height >= 0 && chart.labelsInside(),"tiny layout " + size);
        }
        chart.setComponentData(input());
        var labelCount = chart.axisLabelCount();
        for (i in 0...30) chart.setComponentData({yAxis:{minimum:-10,maximum:20,interval:5}});
        check(chart.axisLabelCount() <= labelCount+5 && chart.numChildren == 7,"repeated axis updates do not accumulate children");
        parent.removeChild(chart); chart.destroy(); chart.destroy(); check(chart.numChildren == 0,"Cartesian cleanup");
        var numeric = new CartesianProbe({xAxis:{scale:"linear"},series:[{id:"s",points:[{id:"a",x:-2.5,y:1.2},{id:"b",x:7.5,y:9.2}]}]});
        check(numeric.xScale.minimum == -2.5 && numeric.xScale.maximum == 7.5,"numeric X range");
        numeric.setComponentData({series:[{id:"s",points:[{id:"a",x:0,y:1.0},{id:"gap",x:20,y:null}]}]});
        check(numeric.xScale.maximum == 20,"numeric X includes intentional gap coordinates");
        var scaleBuilds = numeric.scaleBuildCount; numeric.invalidateScales(); numeric.draw();
        check(numeric.scaleBuildCount == scaleBuilds+1,"subclasses can invalidate domain policies");
        numeric.setComponentData({series:[{id:"s",points:[{id:"a",x:5,y:5},{id:"b",x:5,y:5}]}]});
        check(numeric.xScale.minimum == 4 && numeric.yScale.maximum == 6,"constant ranges"); numeric.destroy();
        var zero = new ZeroProbe({series:[{id:"s",points:[{id:"a",value:4},{id:"b",value:8}]}]});
        check(zero.yScale.minimum == 0,"subclass zero-baseline policy"); zero.destroy();
        var clip = new ClipProbe({width:200,height:160,emptyText:"",xAxis:{showLabels:false,showGrid:false},yAxis:{showLabels:false,showGrid:false}});
        var bitmap = new BitmapData(200,160,false,0xFFFFFF); bitmap.draw(clip);
        var b = clip.plotBounds;
        check(bitmap.getPixel(Std.int(b.x+5),Std.int(b.y+5)) == 0xCC1122,"plot fixture rendered");
        check(bitmap.getPixel(Std.int(b.x-3),Std.int(b.y+5)) != 0xCC1122,"marks clipped to plot bounds");
        bitmap.dispose(); clip.destroy();
        var grid = new CartesianProbe({width:300,height:200,emptyText:"",gridColor:0x00FF00,gridAlpha:1,yAxis:{minimum:0,maximum:10,interval:5,showZeroLine:false}});
        var gx = Std.int(grid.plotBounds.x+20); var gy = Std.int(grid.plotBounds.y+grid.valueToY(5));
        var image = new BitmapData(300,200,false,0xFFFFFF); image.draw(grid);
        check(image.getPixel(gx,gy) != 0xFFFFFF,"grid draws at mapped tick"); image.dispose();
        grid.setComponentData({yAxis:{minimum:0,maximum:10,interval:5,showZeroLine:false,showGrid:false}});
        image = new BitmapData(300,200,false,0xFFFFFF); image.draw(grid);
        check(image.getPixel(gx,gy) == 0xFFFFFF,"grid visibility removes lines"); image.dispose();
        grid.setComponentData({yAxis:{minimum:-10,maximum:10,showGrid:false,showZeroLine:true}});
        gx = Std.int(grid.plotBounds.x+20); gy = Std.int(grid.plotBounds.y+grid.valueToY(0));
        image = new BitmapData(300,200,false,0xFFFFFF); image.draw(grid);
        check(image.getPixel(gx,gy) != 0xFFFFFF,"zero baseline draws independently of grid"); image.dispose(); grid.destroy();
        return count;
    }
}
class CartesianProbe extends CartesianChartBase {
    public function new(data:Dynamic) { super(data); }
    public function axisLabelCount():Int { return axisLabels.length; }
    public function chromeBottom():Float { return chromeBounds.bottom; }
    public function labelsInside():Bool {
        for (field in axisLabels) if (field.visible && field.text != "") {
            var b = field.getBounds(this);
            if (b.x < -0.1 || b.y < -0.1 || b.right > width+0.1 || b.bottom > height+0.1) return false;
        }
        return true;
    }
}
class ZeroProbe extends CartesianProbe {
    public function new(data:Dynamic) { super(data); }
    override function includeZero(axis:String):Bool { return axis == "y"; }
}
class ClipProbe extends CartesianProbe {
    public function new(data:Dynamic) { super(data); }
    override function drawPlot():Void {
        dataLayer.graphics.beginFill(0xCC1122); dataLayer.graphics.drawRect(-100,-100,1000,1000); dataLayer.graphics.endFill();
    }
}
