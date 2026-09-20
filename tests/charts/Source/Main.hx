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
        status.defaultTextFormat = new TextFormat("_sans", 12, 0x183047);
        status.width = 900; status.height = 300; status.x = 24; status.y = 24;
        addChild(status);
        try {
            var phase3Checks = ColumnTests.run(this);
            var phase4Checks = GroupedTests.run(this);
            var phase5Checks = StackTests.run(this);
            var phase6Checks = LineTests.run(this);
            var phase7Checks = AreaTests.run(this);
            var phase8Checks = ScatterTests.run(this);
            var phase9Checks = RadialTests.run(this);
            var phase10Checks = HistogramTests.run(this);
            var phase11Checks = HeatmapTests.run(this);
            var phase12Checks = AcceptanceTests.run(this); AcceptanceTests.performance();
            var phase1Checks = ChartBaseTests.run(this);
            var phase2Math = ScaleTests.run();
            var phase2Checks = CartesianTests.run(this);
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
            var groupData=StackTests.input(); groupData.x=24; groupData.y=365; groupData.height=235;
            var shell = new com.chaos.ui.chart.StackedBarChart(groupData);
            addChild(shell);
            var fixture = new ChartBaseTests.TestChart({name:"fixture",x:485,y:365,width:435,height:235,title:"ChartBase - test marks",categories:[{id:"a",label:"A"}],series:[{id:"s",name:"Fixture series",points:[{id:"p",categoryId:"a",value:4}]}]});
            addChild(fixture);
            #if js
            var target = fixture.localToGlobal(new openfl.geom.Point(fixture.plotBounds.x+10,fixture.plotBounds.y+10));
            js.Syntax.code("window.chartHarnessPointer = {x:{0},y:{1},clicks:0,changes:0}",target.x,target.y);
            fixture.addEventListener(com.chaos.ui.event.ChartEvent.CLICK, e -> js.Syntax.code("window.chartHarnessPointer.clicks++"));
            fixture.addEventListener(com.chaos.ui.event.ChartEvent.CHANGE, e -> js.Syntax.code("window.chartHarnessPointer.changes++"));
            #end
            var columnData=ColumnTests.input(); columnData.x=24; columnData.y=620;
            var categoryAxes = new com.chaos.ui.chart.ColumnChart(columnData); addChild(categoryAxes);
            #if js
            js.Syntax.code("window.columnHarnessDisable={0}",function() { categoryAxes.enabled=false; });
            js.Syntax.code("window.columnHarnessReplace={0}",function() { categoryAxes.enabled=true; categoryAxes.setComponentData({series:[]}); return categoryAxes.selectedItem==null; });
            var mark=categoryAxes.rectangles[0].rectangle;
            var columnTarget=categoryAxes.localToGlobal(new openfl.geom.Point(categoryAxes.plotBounds.x+mark.x+mark.width/2,categoryAxes.plotBounds.y+mark.y+mark.height/2));
            js.Syntax.code("window.columnHarnessPointer={x:{0},y:{1},clicks:0,payload:null}",columnTarget.x,columnTarget.y);
            categoryAxes.addEventListener(com.chaos.ui.event.ChartEvent.CLICK,function(e:com.chaos.ui.event.ChartEvent) { js.Syntax.code("window.columnHarnessPointer.clicks++; window.columnHarnessPointer.payload={0}",e.payload); });
            #end
            var lineData=HeatmapTests.input(); lineData.x=485; lineData.y=620;
            var lineDemo=new com.chaos.ui.chart.Heatmap(lineData); addChild(lineDemo);
            #if js
            js.Syntax.code("window.scatterDisable={0}",function(){lineDemo.enabled=false;});
            js.Syntax.code("window.scatterReplace={0}",function(){lineDemo.enabled=true;lineDemo.setComponentData({data:[]});return lineDemo.selectedItem==null;});
            var binMark=lineDemo.cells[0].bounds;
            var lglobal=lineDemo.localToGlobal(new openfl.geom.Point(lineDemo.plotBounds.x+binMark.x+binMark.width/2,lineDemo.plotBounds.y+binMark.y+binMark.height/2));
            js.Syntax.code("window.linePointer={x:{0},y:{1},payload:null}",lglobal.x,lglobal.y);
            lineDemo.addEventListener(com.chaos.ui.event.ChartEvent.CLICK,function(e:com.chaos.ui.event.ChartEvent){js.Syntax.code("window.linePointer.payload={0}",e.payload);});
            #end
            #if js
            var gr=shell.rectangles[2].rectangle;
            var gp=shell.localToGlobal(new openfl.geom.Point(shell.plotBounds.x+gr.x+gr.width/2,shell.plotBounds.y+gr.y+gr.height/2));
            js.Syntax.code("window.groupHarnessPointer={x:{0},y:{1},payload:null}",gp.x,gp.y);
            shell.addEventListener(com.chaos.ui.event.ChartEvent.CLICK,function(e:com.chaos.ui.event.ChartEvent) { js.Syntax.code("window.groupHarnessPointer.payload={0}",e.payload); });
            #end
            status.text = 'CHAOS chart harness — Phase 12\n\nPASS: $fixtureCount chart fixture shapes/round trips\nPASS: $caseCount future-case documents parsed\nPASS: existing ProgressBar lifecycle (5 checks)\n\nPASS: $phase1Checks shared ChartBase checks.\nPASS: $phase2Math math + $phase2Checks Cartesian checks.\nPASS: $phase3Checks ColumnChart checks.\nPASS: $phase4Checks bar/grouped checks.\nPASS: $phase5Checks stacked checks.\nPASS: $phase6Checks line checks.\nPASS: $phase7Checks area checks.\nPASS: $phase8Checks scatter checks.\nPASS: $phase9Checks radial checks.\nPASS: $phase10Checks histogram checks.\nPASS: $phase11Checks heatmap checks.\nPASS: $phase12Checks common acceptance checks.';
            #if js
            js.Syntax.code("window.chartHarnessResult = {ok:true,phase:12,fixtures:{0},futureCases:{1},baselineChecks:5,phase1Checks:{2},phase2Math:{3},phase2Checks:{4},phase3Checks:{5},phase4Checks:{6},phase5Checks:{7},phase6Checks:{8},phase7Checks:{9},phase8Checks:{10},phase9Checks:{11},phase10Checks:{12},phase11Checks:{13},phase12Checks:{14}}", fixtureCount, caseCount, phase1Checks, phase2Math, phase2Checks, phase3Checks, phase4Checks, phase5Checks, phase6Checks, phase7Checks, phase8Checks, phase9Checks, phase10Checks, phase11Checks, phase12Checks);
            #end
            ChartGallery.install(this);
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
