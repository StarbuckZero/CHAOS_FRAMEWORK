package com.chaos.ui.chart;

typedef ChartDiagnostic = { var code:String; var path:String; var message:String; }
typedef ChartPoint = {
    var id:String;
    var dataIndex:Int;
    var seriesId:Null<String>;
    var seriesIndex:Int;
    var label:String;
    var value:Null<Float>;
    var x:Dynamic;
    var y:Null<Float>;
    var gap:Bool;
    var source:Dynamic;
}
typedef ChartNormalization = {
    var config:Dynamic;
    var points:Array<ChartPoint>;
    var diagnostics:Array<ChartDiagnostic>;
    var accepted:Bool;
}
typedef ChartHitRegion = {
    var bounds:openfl.geom.Rectangle;
    var payload:Dynamic;
}
typedef ChartTextureResolver = String->(openfl.display.BitmapData->Void)->(String->Void)->Void;
