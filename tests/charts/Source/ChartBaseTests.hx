import com.chaos.ui.chart.ChartBase;
import com.chaos.ui.chart.ChartData;
import com.chaos.ui.chart.ChartTexture;
import com.chaos.ui.chart.ChartTypes;
import com.chaos.ui.event.ChartEvent;
import com.chaos.ui.UIStyleManager;
import com.chaos.ui.UIBitmapManager;
import com.chaos.ui.UIBitmapManager.UIBitmapType;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.geom.Rectangle;

class ChartBaseTests {
    static var count:Int;
    static function check(ok:Bool, message:String):Void {
        if (!ok) throw "Phase 1: " + message;
        count++;
    }
    static function sample():Dynamic { return {name:"chart",title:"Test",categories:[{id:"a",label:"A"}],series:[{id:"s",name:"Series",points:[{id:"p",categoryId:"a",value:4,metadata:{record:1}}]}]}; }
    static function pixel(chart:ChartBase,x:Int,y:Int):Int {
        var bitmap = new BitmapData(Std.int(chart.width),Std.int(chart.height),true,0);
        bitmap.draw(chart); var color = bitmap.getPixel(x,y); bitmap.dispose(); return color;
    }
    public static function run(parent:Sprite):Int {
        count = 0;
        var chart = new TestChart(sample()); parent.addChild(chart);
        check(chart.width == 500 && chart.height == 300 && chart.numChildren == 7,"defaults and ordered layers");
        check(chart.getChildAt(0).name == "chartBackground" && chart.getChildAt(6).name == "chartLabels","layer order");
        check(chart.normalizedPoints.length == 1 && chart.normalizedPoints[0].value == 4,"normalization");
        var renders = chart.renderCount; var layouts = chart.layoutCount; var normalizations = chart.normalizationCount;
        chart.setComponentData({backgroundColor:0xCC1122,backgroundAlpha:1});
        check(chart.renderCount == renders+1 && chart.layoutCount == layouts,"visual-only update batches one draw");
        check(chart.normalizationCount == normalizations,"visual updates reuse normalized data");
        check(pixel(chart,5,5) == 0xCC1122,"solid color renders without texture");
        renders = chart.renderCount; chart.imageSmoothing = false;
        check(chart.renderCount == renders+1 && chart.layoutCount == layouts,"direct smoothing update redraws without layout");
        renders = chart.renderCount; chart.draw(); check(chart.renderCount == renders,"clean draw is a no-op");
        chart.setComponentData({width:640});
        check(chart.title == "Test" && chart.normalizedPoints[0].id == "p" && chart.width == 640,"partial update retains data/title");
        chart.width = 400; check(chart.plotBounds.right <= 400 && chart.toChartData().width == 400,"direct resize and export");
        var copy = chart.toChartData(); copy.series[0].points[0].value = 99;
        var pointCopy = chart.normalizedPoints; pointCopy[0].source.metadata.record = 99;
        check(chart.normalizedPoints[0].value == 4 && chart.toChartData().series[0].points[0].metadata.record == 1,"defensive configuration/point snapshots");
        var restored = new TestChart(haxe.Json.parse(haxe.Json.stringify(chart.toChartData())));
        check(restored.title == chart.title && restored.width == chart.width && restored.normalizedPoints[0].id == "p","serialize and restore"); restored.destroy();
        chart.setComponentData({schemaVersion:2,title:"Bad"}); check(chart.title == "Test" && chart.diagnostics[0].code == "structure","schema rejection is atomic");
        chart.setComponentData({title:"Bad",series:[{id:"s",points:[{id:"p",value:1},{id:"p",value:2}]}]});
        check(chart.title == "Test" && chart.normalizedPoints[0].value == 4,"duplicate IDs reject complete batch");
        chart.setComponentData({data:[1]}); check(!Reflect.hasField(chart.toChartData(),"data"),"competing data source rejected");
        chart.setComponentData({width:-1,padding:null,title:"Valid"}); check(chart.width == 400 && chart.title == "Valid" && chart.diagnostics.length == 2,"invalid settings retain previous values");
        chart.setComponentData({series:null}); check(chart.normalizedPoints.length == 1 && chart.diagnostics.length > 0,"null array does not clear");
        chart.setComponentData({series:[]}); check(chart.normalizedPoints.length == 0,"empty array clears");
        var cyclic:Dynamic = {}; cyclic.self = cyclic;
        chart.setComponentData({metadata:cyclic}); check(chart.diagnostics[0].code == "structure","cyclic input rejected without throwing");
        var invalidPoints:Array<Dynamic> = [{value:Math.NaN},{value:"42"},{value:3}];
        chart.setComponentData({series:[{points:invalidPoints}]});
        check(chart.normalizedPoints.filter(p -> !p.gap).length == 1 && chart.toChartData().series[0].points[0].value == null,"nonfinite/string values never become marks");
        check(chart.toChartData().series[0].id != null && chart.toChartData().series[0].points[2].id != null,"generated IDs persist in export");
        chart.setComponentData({width:0,height:0}); check(chart.plotBounds.width == 0 && chart.plotBounds.height == 0,"zero size safe");
        parent.removeChild(chart); chart.destroy(); chart.destroy(); check(chart.numChildren == 0,"idempotent destroy");

        UIStyleManager.setStyle(UIStyleManager.CHART_BACKGROUND_COLOR,0x112233);
        var themed = new ChartBase({width:100,height:80,borderThickness:0}); parent.addChild(themed);
        check(pixel(themed,2,2) == 0x112233,"shared style fallback");
        themed.setComponentData({Style:{CHART_BACKGROUND_COLOR:0x334455}}); check(pixel(themed,2,2) == 0x334455,"instance style wins");
        themed.setComponentData({backgroundColor:0x556677}); themed.reskin(); themed.draw();
        check(pixel(themed,2,2) == 0x556677,"explicit value survives reskin");
        check(themed.seriesColor(0,{color:0x111111},{color:0x222222}) == 0x222222,"point color precedence");
        themed.destroy(); parent.removeChild(themed); UIStyleManager.removeStyle(UIStyleManager.CHART_BACKGROUND_COLOR);

        var source = new BitmapData(2,1,false,0x0033CC); source.setPixel(1,0,0x00CC33);
        var callbacks = new Map<String,BitmapData->Void>(); var failures = new Map<String,String->Void>();
        var texture = new ChartTexture(); var changed = 0; var failed = 0;
        var loader:ChartTextureResolver = function(key,complete,error) { callbacks.set(key,complete); failures.set(key,error); };
        texture.load("old",loader,() -> changed++,message -> failed++);
        texture.load("new",loader,() -> changed++,message -> failed++);
        callbacks.get("old")(source); failures.get("old")("stale");
        check(texture.bitmap == null && changed == 0 && failed == 0,"stale completion/failure ignored");
        callbacks.get("new")(source); check(texture.bitmap != source && changed == 1,"texture owns a clone");
        var owned = texture.bitmap; texture.clear(); check(owned.width == 0 && source.width == 2,"owned clone disposed, source retained");
        texture.load("late",loader,() -> changed++,message -> failed++); texture.destroy(); callbacks.get("late")(source);
        check(texture.bitmap == null && changed == 1 && source.width == 2,"post-destroy completion ignored");
        var textured = new ChartBase({width:100,height:80,borderThickness:0,backgroundColor:0xCC1122,emptyText:""}); parent.addChild(textured);
        textured.textureResolver = loader; textured.setComponentData({backgroundTexture:{key:"delayed",mode:"stretch"}});
        check(pixel(textured,1,1) == 0xCC1122,"solid background remains during load");
        layouts = textured.layoutCount; callbacks.get("delayed")(source);
        check(pixel(textured,1,1) == 0x0033CC && textured.layoutCount == layouts,"completion draws texture without relayout");
        for (mode in ["tile","fit","fill","stretch"]) {
            textured.setComponentData({backgroundTexture:{key:mode,mode:mode}}); callbacks.get(mode)(source);
            var expected = mode == "fit" ? 0xCC1122 : 0x0033CC;
            check(pixel(textured,0,0) == expected,"texture mode " + mode);
        }
        textured.setComponentData({backgroundTexture:{key:"missing"}}); failures.get("missing")("Missing");
        check(textured.diagnostics.length > 0 && pixel(textured,1,1) == 0xCC1122,"failure preserves solid layer");
        textured.setComponentData({backgroundTexture:null}); check(pixel(textured,1,1) == 0xCC1122,"clear texture");
        parent.removeChild(textured); textured.destroy();
        UIBitmapManager.setUIElement(UIBitmapType.Chart,UIBitmapManager.CHART_BACKGROUND_IMAGE,source,false);
        var managed = new ChartBase({width:100,height:80,borderThickness:0,emptyText:""}); parent.addChild(managed);
        check(pixel(managed,1,1) == 0x0033CC,"bitmap manager background");
        var alternate = new BitmapData(2,2,false,0xABCDEF);
        UIBitmapManager.setUIElement(UIBitmapType.Chart,"alternate",alternate,false);
        managed.setComponentData({Bitmap:{chart_background_image:"alternate"}});
        check(pixel(managed,1,1) == 0xABCDEF,"instance texture reference wins over theme background");
        managed.setComponentData({Bitmap:null});
        managed.setBitmapOverride(UIBitmapManager.CHART_BACKGROUND_IMAGE,alternate);
        check(pixel(managed,1,1) == 0xABCDEF,"loaded instance bitmap override");
        managed.removeBitmapOverride(UIBitmapManager.CHART_BACKGROUND_IMAGE);
        check(pixel(managed,1,1) == 0x0033CC && alternate.width == 2,"instance clear returns to theme without disposing source");
        UIBitmapManager.removeUIElement(UIBitmapType.Chart,"alternate"); alternate.dispose();
        managed.setComponentData({backgroundTexture:{key:""}}); check(pixel(managed,1,1) == 0xFFFFFF,"explicit empty texture suppresses fallback");
        managed.setComponentData({backgroundTexture:null}); check(pixel(managed,1,1) == 0x0033CC,"null texture restores fallback");
        var renderBefore = managed.renderCount; managed.destroy(); parent.removeChild(managed);
        UIBitmapManager.updateUIElement(UIBitmapType.Chart);
        check(managed.renderCount == renderBefore && source.width == 2,"destroy removes manager watcher and preserves source");
        UIBitmapManager.removeUIElement(UIBitmapType.Chart,UIBitmapManager.CHART_BACKGROUND_IMAGE); source.dispose();

        var interactive = new TestChart(sample()); parent.addChild(interactive);
        var clicks = 0; var changes = 0;
        interactive.addEventListener(ChartEvent.CLICK,function(event:ChartEvent) { clicks++; var payload = event.payload; payload.metadata.record = 99; });
        interactive.addEventListener(ChartEvent.CHANGE,function(event:ChartEvent) { changes++; });
        var rect = interactive.plotBounds;
        interactive.dispatchEvent(new MouseEvent(MouseEvent.CLICK,true,false,rect.x+5,rect.y+5));
        interactive.dispatchEvent(new MouseEvent(MouseEvent.CLICK,true,false,rect.x+5,rect.y+5));
        check(clicks == 2 && changes == 1 && interactive.selectedItem.pointId == "p","click events and stable selection");
        check(interactive.selectedItem.metadata.record == 1,"event snapshot protects selected metadata");
        interactive.enabled = false;
        interactive.dispatchEvent(new MouseEvent(MouseEvent.CLICK,true,false,rect.x+5,rect.y+5));
        check(clicks == 2,"disabled chart suppresses events");
        interactive.enabled = true; interactive.setComponentData({series:[]}); check(interactive.selectedItem == null && changes == 1,"data removal clears selection silently");
        interactive.setComponentData(sample());
        var rollovers = 0; var rollouts = 0; var downs = 0; var ups = 0;
        interactive.addEventListener(ChartEvent.ROLL_OVER, e -> rollovers++);
        interactive.addEventListener(ChartEvent.ROLL_OUT, e -> rollouts++);
        interactive.addEventListener(ChartEvent.MOUSE_DOWN, e -> downs++);
        interactive.addEventListener(ChartEvent.MOUSE_UP, e -> ups++);
        interactive.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_MOVE,true,false,rect.x+5,rect.y+5));
        interactive.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN,true,false,rect.x+5,rect.y+5));
        interactive.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP,true,false,rect.x+5,rect.y+5));
        interactive.dispatchEvent(new MouseEvent(MouseEvent.ROLL_OUT,true,false,0,0));
        check(rollovers == 1 && rollouts == 1 && downs == 1 && ups == 1,"hover and mouse payload events");
        interactive.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_MOVE,true,false,rect.x+5,rect.y+5));
        interactive.setComponentData({enabled:false});
        check(interactive.hoveredItem == null,"disable through JSON clears hover");
        interactive.setComponentData({enabled:true});
        var children = interactive.numChildren;
        for (i in 0...60) interactive.setComponentData({title:"Update " + i,series:[{id:"s",name:"Series",points:[{id:"p",value:i}]}]});
        check(interactive.numChildren == children && interactive.labelChildren() <= 4,"bounded display list across updates");
        var evt = new ChartEvent(ChartEvent.CLICK,{metadata:{n:1}}); var payload = evt.payload; payload.metadata.n = 2;
        var cloned:ChartEvent = cast evt.clone(); check(cloned.payload.metadata.n == 1,"cloned event isolates payload");
        parent.removeChild(interactive); interactive.destroy();
        check(!interactive.hasEventListener(MouseEvent.CLICK),"destroy removes internal pointer listeners");
        var cases:Dynamic = haxe.Json.parse(openfl.Assets.getText("fixtures/cases.json"));
        var entries:Array<Dynamic> = cases.cases;
        for (entry in entries) if (entry.phase == 1) {
            var input:Dynamic = entry.input;
            if (entry.id == "invalid-number") input = {data:entry.input.values};
            var fixture = new ChartBase(input);
            if (Reflect.hasField(entry,"patch")) fixture.setComponentData(entry.patch);
            var saved = fixture.toChartData();
            switch entry.id {
                case "partial-update": check(saved.width == entry.expected.width && saved.title == entry.expected.title && saved.series[0].id == "s","fixture partial-update");
                case "clear-array": check(saved.data.length == 0,"fixture clear-array");
                case "null-array-rejected": check(saved.data.length == 2 && fixture.diagnostics.length > 0,"fixture null-array-rejected");
                case "invalid-number": check(fixture.normalizedPoints.length == 1 && fixture.normalizedPoints[0].value == 3,"fixture invalid-number");
                case "empty-series": check(fixture.normalizedPoints.length == 0,"fixture empty-series");
                default: throw "Unimplemented Phase 1 fixture " + entry.id;
            }
            fixture.destroy();
        }
        return count;
    }
}

class TestChart extends ChartBase {
    public function new(data:Dynamic) { super(data); }
    override function drawPlot():Void {
        var all = normalizedPoints;
        var hit:Array<ChartHitRegion> = [];
        for (i in 0...all.length) if (!all[i].gap) {
            var rect = new Rectangle(i*45,0,40,40);
            dataLayer.graphics.beginFill(seriesColor(i)); dataLayer.graphics.drawRect(rect.x,rect.y,rect.width,rect.height); dataLayer.graphics.endFill();
            hit.push({bounds:rect,payload:pointPayload(all[i])});
        }
        setHitRegions(hit);
    }
    public function labelChildren():Int { return labelLayer.numChildren; }
}




