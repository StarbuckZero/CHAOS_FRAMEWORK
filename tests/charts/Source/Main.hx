import com.chaos.ui.ProgressBar;
import openfl.Assets;
import openfl.display.Sprite;
import openfl.text.TextField;
import openfl.text.TextFormat;

/** Independent UI-only harness. Replace/add chart demos in their implementation phases. */
class Main extends Sprite {
    public function new() {
        super();
        var status = new TextField();
        status.defaultTextFormat = new TextFormat("_sans", 18, 0x183047);
        status.width = 900; status.height = 260; status.x = 24; status.y = 24;
        addChild(status);
        try {
            var phase1Checks = ChartBaseTests.run(this);
            var fixtureCount = FixtureChecks.catalog(Assets.getText("fixtures/catalog.json"));
            var caseCount = FixtureChecks.cases(Assets.getText("fixtures/cases.json"));
            var bar = new ProgressBar({name:"baseline",width:420,height:36,percent:25,showLabel:false});
            bar.x = 24; bar.y = 300;
            addChild(bar);
            check(bar.width == 420 && bar.height == 36 && bar.percent == 25, "construction");
            bar.setComponentData({percent:75}); bar.draw();
            check(bar.percent == 75 && bar.width == 420, "partial update preserves width");
            bar.drawOnResize = true; bar.width = 500;
            check(bar.width == 500, "resize");
            var children = bar.numChildren;
            for (i in 0...25) { bar.setComponentData({percent:i}); bar.draw(); }
            check(bar.numChildren == children, "stable display children");
            removeChild(bar); bar.destroy();
            check(bar.numChildren == 0, "destroy removes children");
            // Leave a live representative component visible after checking cleanup.
            var sample = new ProgressBar({width:500,height:36,percent:75,showLabel:false});
            sample.x = 24; sample.y = 300; addChild(sample);
            var shell = new com.chaos.ui.chart.ChartBase({name:"emptyShell",x:24,y:365,width:435,height:235,title:"ChartBase - empty state",summary:"Phase 1 standalone shell"});
            addChild(shell);
            var fixture = new ChartBaseTests.TestChart({name:"fixture",x:485,y:365,width:435,height:235,title:"ChartBase - test marks",categories:[{id:"a",label:"A"}],series:[{id:"s",name:"Fixture series",points:[{id:"p",categoryId:"a",value:4}]}]});
            addChild(fixture);
            #if js
            var target = fixture.localToGlobal(new openfl.geom.Point(fixture.plotBounds.x+10,fixture.plotBounds.y+10));
            js.Syntax.code("window.chartHarnessPointer = {x:{0},y:{1},clicks:0,changes:0}",target.x,target.y);
            fixture.addEventListener(com.chaos.ui.event.ChartEvent.CLICK, e -> js.Syntax.code("window.chartHarnessPointer.clicks++"));
            fixture.addEventListener(com.chaos.ui.event.ChartEvent.CHANGE, e -> js.Syntax.code("window.chartHarnessPointer.changes++"));
            #end
            status.text = 'CHAOS chart harness — Phase 1\n\nPASS: $fixtureCount chart fixture shapes/round trips\nPASS: $caseCount future-case documents parsed\nPASS: existing ProgressBar lifecycle (5 checks)\n\nPASS: $phase1Checks shared ChartBase checks. Axes/types follow later.';
            #if js
            js.Syntax.code("window.chartHarnessResult = {ok:true,fixtures:{0},futureCases:{1},baselineChecks:5,phase1Checks:{2}}", fixtureCount, caseCount, phase1Checks);
            #end
        } catch (error:Dynamic) {
            status.text = "FAIL: " + Std.string(error);
            #if js
            js.Syntax.code("window.chartHarnessResult = {ok:false,error:{0}}", Std.string(error));
            #end
            throw error;
        }
    }
    static function check(ok:Bool, label:String):Void {
        if (!ok) throw "ProgressBar baseline: " + label;
    }
}




