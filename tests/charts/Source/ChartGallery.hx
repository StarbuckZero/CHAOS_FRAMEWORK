import com.chaos.ui.chart.ChartBase;
import com.chaos.ui.event.ChartEvent;
import openfl.display.Sprite;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.events.MouseEvent;
class ChartGallery {
    var parent:Sprite;
    var root:Sprite;
    var charts:Array<ChartBase>=[];
    var states:Array<Dynamic>=[];
    public function new(parent:Sprite) { this.parent=parent; }
    public function show(page:Int):Array<Dynamic> {
        if(root!=null) { for(c in charts) c.destroy(); parent.removeChild(root); }
        for(i in 0...parent.numChildren) parent.getChildAt(i).visible=false;
        charts=[]; states=[]; root=new Sprite(); parent.addChild(root);
        var header=new TextField(); header.defaultTextFormat=new TextFormat("_sans",18,0x183047); header.text="CHAOS UI chart gallery — page "+(page+1)+" of 2"; header.width=600; header.height=30; header.x=24; header.y=10; root.addChild(header);
        for(p in 0...2) { var link=new TextField(); link.defaultTextFormat=new TextFormat("_sans",14,0x287ABD); link.text="Page "+(p+1); link.width=75; link.height=25; link.x=720+p*90; link.y=12; link.selectable=false; link.addEventListener(MouseEvent.CLICK,function(_){show(p);}); root.addChild(link); }
        var start=page==0?0:6; var end=page==0?6:11;
        for(i in start...end) {
            var type=ChartGalleryData.types[i]; var data=ChartGalleryData.sample(type); data.x=24+(i-start)%2*461; data.y=50+Std.int((i-start)/2)*280; data.height=255;
            var c=ChartGalleryData.create(type,data); root.addChild(c); charts.push(c);
            var state:Dynamic={type:type,clicks:0,changes:0,payload:null}; states.push(state);
            c.addEventListener(ChartEvent.CLICK,function(e:ChartEvent){state.clicks++;state.payload=e.payload;}); c.addEventListener(ChartEvent.CHANGE,function(_){state.changes++;});
        }
        return [for(c in charts) AcceptanceTests.target(c)];
    }
    public function state(index:Int):Dynamic { return states[index]; }
    public function configure(index:Int,patch:Dynamic):Dynamic { var c=charts[index]; c.setComponentData(patch); return AcceptanceTests.target(c); }
    public function clear(index:Int):Bool { var c=charts[index]; c.setComponentData(Reflect.hasField(c.toChartData(),"series")?{series:[]}:{data:[]}); return c.selectedItem==null; }
    public static function install(parent:Sprite):Void {
        #if js
        var gallery=new ChartGallery(parent);
        js.Syntax.code("window.showChartGallery={0}",gallery.show);
        js.Syntax.code("window.chartGalleryState={0}",gallery.state);
        js.Syntax.code("window.configureGalleryChart={0}",gallery.configure);
        js.Syntax.code("window.clearGalleryChart={0}",gallery.clear);
        var query:Dynamic=js.Syntax.code("new URLSearchParams(window.location.search).get('gallery')");
        if(query!=null) gallery.show(query=="1"?1:0);
        #end
    }
}
