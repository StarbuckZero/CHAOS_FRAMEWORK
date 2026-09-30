package com.chaos.ui.chart;
import com.chaos.ui.chart.ChartTypes;
import openfl.text.TextField;
import openfl.text.TextFormat;
class DonutChart extends RadialChartBase {
    /** Type identifier for donut charts. */
    public static inline var TYPE:String="DonutChart";
    var centerLabel:TextField;
    /** Creates a donut chart with optional configuration. */
    public function new(data:Dynamic=null) { super(data); }
    override function get_chartType():String { return TYPE; }
    override function initialize():Void {
        super.initialize(); if(!Reflect.hasField(config,"innerRadius")) config.innerRadius=0.5; if(!Reflect.hasField(config,"centerText")) config.centerText="";
        centerLabel=new TextField(); centerLabel.mouseEnabled=false; centerLabel.selectable=false; labelLayer.addChild(centerLabel);
    }
    override function hole():Float { return radius*config.innerRadius; }
    override function validateChartPatch(patch:Dynamic,diagnostics:Array<ChartDiagnostic>):Void {
        super.validateChartPatch(patch,diagnostics);
        for(field in ["innerRadius","centerText"]) if(Reflect.hasField(patch,field)) {
            var value:Dynamic=Reflect.field(patch,field); var valid=field=="centerText"?Std.isOfType(value,String):ChartData.finite(value) && value>=0 && value<1;
            if(!valid) { Reflect.deleteField(patch,field); ChartData.diagnostic(diagnostics,"setting",field,"Invalid donut setting; previous retained"); }
        }
    }
    override function clearPlot():Void { super.clearPlot(); if(centerLabel!=null) centerLabel.visible=false; }
    override function drawPlot():Void {
        super.drawPlot(); var size=hole()*1.4; centerLabel.defaultTextFormat=new TextFormat(style("font",com.chaos.ui.UIStyleManager.CHART_FONT,"_sans"),style("fontSize",com.chaos.ui.UIStyleManager.CHART_FONT_SIZE,12),style("labelColor",com.chaos.ui.UIStyleManager.CHART_LABEL_COLOR,0x333333),null,null,null,null,null,"center");
        centerLabel.text=config.centerText; centerLabel.width=size; centerLabel.height=Math.min(size,24); centerLabel.x=bounds.x+centerX-size/2; centerLabel.y=bounds.y+centerY-centerLabel.height/2;
        centerLabel.visible=size>=16 && centerLabel.textWidth+4<=size;
    }
}

