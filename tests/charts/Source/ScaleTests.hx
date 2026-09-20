import com.chaos.ui.chart.ChartScale;
import com.chaos.ui.chart.ChartFormat;
import com.chaos.ui.chart.ChartAxis;

class ScaleTests {
    static var count:Int;
    static function check(ok:Bool,message:String):Void { if (!ok) throw "Phase 2 math: " + message; count++; }
    static function near(a:Null<Float>,b:Float):Bool { return a != null && Math.abs(a-b) <= Math.max(1e-9,Math.abs(b)*1e-12); }
    public static function run():Int {
        count = 0;
        var scale = ChartScale.linear([-10,0,30]).withRange(0,400);
        check(near(scale.map(-10),0) && near(scale.map(30),400),"linear endpoints");
        check(near(scale.map(0),100) && near(scale.invert(100),0),"zero and inverse");
        check(scale.map("10") == null && scale.map(Math.NaN) == null,"reject nonnumeric input");
        check(near(scale.withRange(400,0).map(0),300),"reversed numeric range");
        var constant = ChartScale.linear([5,5]); check(constant.minimum == 4 && constant.maximum == 6,"constant-axis fixture");
        var positive = ChartScale.linear([4,8],null,null,true); check(positive.minimum == 0 && positive.maximum == 8,"include zero");
        var negative = ChartScale.linear([-8,-4],null,null,true); check(negative.minimum == -8 && negative.maximum == 0,"negative include zero");
        var empty = ChartScale.linear([]); check(empty.minimum == 0 && empty.maximum == 1,"empty range");
        var explicit = ChartScale.linear([2,8],-5,15); check(explicit.minimum == -5 && explicit.maximum == 15,"explicit bounds");
        var half = ChartScale.linear([0,5],10,null); check(half.minimum == 10 && half.maximum > 10,"one-sided explicit bound");
        var categories = ChartScale.categorical([{id:"a",label:"Same"},{id:"b",label:"Same"}]).withRange(0,200);
        check(categories.bandWidth == 100 && near(categories.map("a"),50) && near(categories.map("b"),150),"category centers and duplicate labels");
        check(categories.invert(25) == "a" && categories.invert(125) == "b" && categories.invert(200) == null,"category inverse bounds");
        check(categories.map("unknown") == null,"unknown category");
        check(ChartScale.categorical([]).map("a") == null,"empty category range");
        var ticks = ChartScale.linear([0,10]).ticks();
        check(ticks.length == 6 && ticks[1].value == 2,"nice 1/2/5 ticks");
        ticks = ChartScale.linear([0,1],null,null,false,0.25).ticks(); check(ticks.length == 5 && ticks[3].value == 0.75,"explicit ticks");
        ticks = ChartScale.linear([-1,1],null,null,false,1e-300).ticks(); check(ticks.length <= 200 && ticks.length > 1,"bounded dense interval");
        var huge = ChartScale.linear([-1e308,1e308]).withRange(0,100);
        check(near(huge.map(0),50) && near(huge.invert(50),0),"overflow-safe conversion");
        check(huge.ticks().length <= 200 && huge.ticks().length > 1,"overflow-safe ticks");
        check(huge.ticks()[huge.ticks().length-1].value == 1e308,"huge tick endpoint avoids intermediate overflow");
        check(near(ChartScale.linear([0,100]).withRange(-1e308,1e308).invert(0),50),"overflow-safe inverse pixel range");
        check(ChartScale.linear([1],1.79e308,null).maximum > 1.79e308,"one-sided extreme finite bound");
        var tiny = ChartScale.linear([1e-300,2e-300]).withRange(0,100); check(near(tiny.map(1.5e-300),50),"tiny range");
        check(ChartScale.linear([1e308,1e308]).maximum > 1e308,"large constant expansion");
        var caught = 0;
        try { ChartScale.linear([],1,1); } catch (_:Dynamic) { caught++; }
        try { ChartScale.linear([],null,null,false,0); } catch (_:Dynamic) { caught++; }
        try { ChartScale.categorical([{id:"a",label:"A"},{id:"a",label:"B"}]); } catch (_:Dynamic) { caught++; }
        check(caught == 3,"reject invalid domain/interval/identity");
        check(ChartFormat.format(12.345,"number",2) == "12.35","decimal rounding");
        check(ChartFormat.format(-0.0001,"number",2) == "0.00","negative zero suppressed");
        check(ChartFormat.format(0.125,"percent",2) == "12.50%","percentage formatting");
        check(ChartFormat.format(4,"number",3) == "4.000","decimal padding");
        check(ChartFormat.format(1e308).indexOf("e+308") > 0,"large scientific formatting");
        check(ChartFormat.format(1e308,"percent").indexOf("e+310%") > 0,"percent overflow avoided");
        check(ChartFormat.format(1e-8).indexOf("e-8") > 0,"tiny scientific formatting");
        check(ChartFormat.format(0.000001,"number",8) == "0.00000100","small fixed decimals");
        var axis = ChartAxis.parse({title:"Y",format:{kind:"percent"}},"linear");
        check(axis.format.decimals == 2 && axis.showGrid && axis.minimum == null,"axis defaults");
        caught = 0;
        for (bad in ([{interval:0},{minimum:2,maximum:1},{format:{decimals:11}},{showGrid:"yes"},{scale:"log"}]:Array<Dynamic>))
            try { ChartAxis.parse(bad,"linear"); } catch (_:Dynamic) { caught++; }
        check(caught == 5,"axis validation");
        return count;
    }
    static function main():Void { trace("PASS: " + run() + " Phase 2 scale/axis/format checks"); }
}
