import haxe.Json;

/** Checks fixture integrity only. Does not implement or test chart rendering. */
class FixtureChecks {
    public static final types = ["ColumnChart", "BarChart", "GroupedBarChart", "StackedBarChart", "LineChart", "AreaChart", "ScatterPlot", "PieChart", "DonutChart", "Histogram", "Heatmap"];
    static function require(ok:Bool, message:String):Void {
        if (!ok) throw message;
    }
    static function array(value:Dynamic, label:String):Array<Dynamic> {
        require(Std.isOfType(value, Array), label + " must be an array");
        return cast value;
    }
    static function ids(items:Array<Dynamic>, label:String):Void {
        var seen = new Map<String, Bool>();
        for (item in items) {
            var id:Dynamic = Reflect.field(item, "id");
            require(Std.isOfType(id, String) && id.length > 0, label + " needs IDs");
            require(!seen.exists(id), label + " duplicate ID " + id);
            seen.set(id, true);
        }
    }
    static function numeric(value:Dynamic):Bool {
        return (Std.isOfType(value, Int) || Std.isOfType(value, Float)) && Math.isFinite(value);
    }
    public static function catalog(text:String):Int {
        var parsed:Dynamic = Json.parse(text);
        require(parsed.schemaVersion == 1, "catalog version");
        var components = array(parsed.components, "components");
        require(components.length == types.length, "all eleven types required");
        var seen = new Map<String, Bool>();
        for (wrapper in components) {
            var keys = Reflect.fields(wrapper);
            require(keys.length == 1, "single-key component wrapper required");
            var type = keys[0];
            require(types.indexOf(type) >= 0 && !seen.exists(type), "unknown/duplicate type " + type);
            seen.set(type, true);
            var config:Dynamic = Reflect.field(wrapper, type);
            require(config.schemaVersion == 1 && Std.isOfType(config.name, String) && config.name.length > 0, "name/version");
            var hasSeries = Reflect.hasField(config, "series");
            require(hasSeries != Reflect.hasField(config, "data"), "one canonical value source");
            if (hasSeries) {
                var series = array(config.series, "series");
                ids(series, "series");
                var categorical = type != "ScatterPlot" && !(Reflect.hasField(config, "xAxis") && config.xAxis.scale == "linear");
                var categories:Array<Dynamic> = categorical ? array(config.categories, "categories") : [];
                ids(categories, "categories");
                for (s in series) {
                    var points = array(s.points, "points");
                    ids(points, "points");
                    for (point in points) {
                        var value:Dynamic = categorical ? point.value : point.y;
                        require(numeric(value) || (value == null && (type == "LineChart" || type == "AreaChart")), "numeric value or intentional gap");
                        if (categorical) {
                            require(Lambda.exists(categories, c -> c.id == point.categoryId), "unknown category");
                        } else require(numeric(point.x), "numeric x");
                    }
                }
            } else {
                var data = array(config.data, "data");
                if (type == "Histogram") {
                    for (value in data) require(numeric(value), "raw numeric observation");
                } else {
                    ids(data, "data");
                    for (point in data) require(numeric(point.value), "numeric cell/slice");
                    if (type == "Heatmap") {
                        var rows = array(config.rows, "rows");
                        var columns = array(config.columns, "columns");
                        ids(rows, "rows"); ids(columns, "columns");
                        for (point in data) {
                            require(Lambda.exists(rows, r -> r.id == point.rowId), "unknown row");
                            require(Lambda.exists(columns, c -> c.id == point.columnId), "unknown column");
                        }
                    }
                }
            }
            var encoded = Json.stringify(wrapper);
            require(Json.stringify(Json.parse(encoded)) == encoded, "JSON round trip " + type);
        }
        return components.length;
    }
    public static function cases(text:String):Int {
        var parsed:Dynamic = Json.parse(text);
        require(parsed.schemaVersion == 1, "case version");
        var entries = array(parsed.cases, "cases");
        require(entries.length > 0, "case fixtures required");
        ids(entries, "cases");
        for (entry in entries) {
            require(entry.phase >= 1 && entry.phase <= 12, "component phase");
            require(Reflect.hasField(entry, "input") && Reflect.hasField(entry, "expected"), "case input/expected required");
        }
        return entries.length;
    }
}
