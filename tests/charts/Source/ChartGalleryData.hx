import com.chaos.ui.chart.ChartBase;
import com.chaos.ui.chart.ChartData;
import com.chaos.ui.chart.ColumnChart;
import com.chaos.ui.chart.BarChart;
import com.chaos.ui.chart.GroupedBarChart;
import com.chaos.ui.chart.StackedBarChart;
import com.chaos.ui.chart.LineChart;
import com.chaos.ui.chart.AreaChart;
import com.chaos.ui.chart.ScatterPlot;
import com.chaos.ui.chart.PieChart;
import com.chaos.ui.chart.DonutChart;
import com.chaos.ui.chart.Histogram;
import com.chaos.ui.chart.Heatmap;
class ChartGalleryData {
    public static var types=["ColumnChart","BarChart","GroupedBarChart","StackedBarChart","LineChart","AreaChart","ScatterPlot","PieChart","DonutChart","Histogram","Heatmap"];
    public static function create(type:String,data:Dynamic):ChartBase {
        return switch(type) {
            case "ColumnChart":new ColumnChart(data); case "BarChart":new BarChart(data);
            case "GroupedBarChart":new GroupedBarChart(data); case "StackedBarChart":new StackedBarChart(data);
            case "LineChart":new LineChart(data); case "AreaChart":new AreaChart(data); case "ScatterPlot":new ScatterPlot(data);
            case "PieChart":new PieChart(data); case "DonutChart":new DonutChart(data); case "Histogram":new Histogram(data); case "Heatmap":new Heatmap(data);
            default:throw "Unknown gallery chart "+type;
        }
    }
    public static function sample(type:String):Dynamic {
        var data:Dynamic=switch(type) {
            case "ColumnChart","BarChart":ColumnTests.input();
            case "GroupedBarChart":GroupedTests.input(); case "StackedBarChart":StackTests.input();
            case "LineChart":LineTests.input(); case "AreaChart":AreaTests.input(); case "ScatterPlot":ScatterTests.input();
            case "PieChart","DonutChart":RadialTests.input(); case "Histogram":HistogramTests.input(); default:HeatmapTests.input();
        };
        data=ChartData.copy(data); data.title=type; data.width=435; data.height=250;
        if(type=="DonutChart") data.centerText="Total 4";
        return data;
    }
    public static function textured(type:String,data:Dynamic,key:String):Dynamic {
        var patch=ChartData.copy(data); var spec={key:key,mode:"stretch"};
        if(type=="Histogram" || type=="Heatmap") patch.texture=spec;
        else if(type=="PieChart" || type=="DonutChart") { var values:Array<Dynamic>=patch.data; for(p in values) p.texture=spec; }
        else { var series:Array<Dynamic>=patch.series; for(s in series) s.texture=spec; }
        return patch;
    }
}
