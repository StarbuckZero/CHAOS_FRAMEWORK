import haxe.Json;
import sys.io.File;

class ContractTest {
    static function main() {
        var text = File.getContent("fixtures/catalog.json");
        var count = FixtureChecks.catalog(text);
        var cases = FixtureChecks.cases(File.getContent("fixtures/cases.json"));
        var rejected = 0;
        for (mutation in 0...3) {
            var catalog:Dynamic = Json.parse(text);
            switch mutation {
                case 0: Reflect.setField(catalog.components[0], "extra", {});
                case 1: catalog.components[0].ColumnChart.series[0].points[0].categoryId = "missing";
                case 2: catalog.components[0].ColumnChart.series[0].points[1].id = "p1";
            }
            try { FixtureChecks.catalog(Json.stringify(catalog)); }
            catch (_:Dynamic) { rejected++; }
        }
        if (rejected != 3) throw "Fixture validator accepted invalid wrappers/references/IDs";
        Sys.println('PASS: $count chart fixture shapes and JSON round trips; $rejected malformed catalog mutations rejected.');
        Sys.println('PASS: $cases future behavior cases parse; expected chart outcomes are NOT executed in Phase 0.');
    }
}
