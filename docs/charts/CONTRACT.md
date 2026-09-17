# Chart contracts — version 1

Status: Phase 0 design contract. Fixtures describe future chart behavior; no chart implementation exists yet. This contract resolves proposals in the parent plan. All eleven types must pass standalone component acceptance before engine or Studio integration.

## Source conventions and ownership

The framework root is CHAOS_UI_HX (its own Git repository), not the parent _FRAMEWORK directory. Existing components live in com/chaos/ui; proposed chart classes will live in com/chaos/ui/chart, with a shared ChartEvent in com/chaos/ui/event. Existing component events use this singular event package.

BaseUI.new calls reskin, setComponentData, initialize, then draw. Overrides must tolerate calls before display children exist. BaseUI owns _width/_height and drawOnResize; direct width/height assignment draws only when drawOnResize is true. setComponentData applies supplied fields, retaining omitted properties. Chart configuration updates will normalize the whole supplied batch, set dirty flags, and draw once when initialized (before initialization only mark dirty). Explicit draw remains supported and must be cheap when clean. The existing engine helper additionally calls draw only when redraw:true; phase 13 must preserve compatibility without duplicate expensive work. destroy is the cleanup method, not dispose.

UIStyleManager stores values and does not populate default chart styles. Charts require built-in fallbacks when no theme keys exist. BaseUI supports instance Style and Bitmap maps. Supplying either map replaces its contents; null clears it. Numeric RGB colors and borderThickness match existing components; sample #hex colors and borderSize in the original plan are superseded here.

UIBitmapManager.getUIElement returns a clone, as does BaseUI.getResolvedBitmap for an instance override. The consumer owns these returned clones and disposes them on replacement/destroy. BaseUI owns its internal override clones and disposes them itself. Never dispose someone else's source or the manager's stored bitmap. Texture tokens/requests need generation guards so old completions cannot overwrite newer settings or resurrect destroyed components. Reuse manager watchElement/stopWatchElement conventions; extend UIBitmapType for charts in phase 1. Core media/project reference resolution belongs to phase 13, not to the standalone UI library.

## Common configuration and defaults

A saved component has exactly one wrapper key, for example {"ColumnChart":{...}}. Direct Haxe construction receives the inner object. schemaVersion:1 lives inside the wrapper. This is the first chart schema; reject unsupported versions with a diagnostic rather than interpreting them silently.

| Field | Default / behavior |
| --- | --- |
| name | Required nonempty instance name in saved fixtures; direct unnamed instances may use OpenFL naming |
| x, y | 0; finite numbers |
| width, height | 500, 300; finite nonnegative numbers; no plot if available plot dimensions are <= 0 |
| visible, enabled | true; explicitly handle visible since BaseUI.setComponentData does not apply it |
| title, summary | Empty strings; summary is host-readable text, not a claim of DOM accessibility |
| padding | 16; nonnegative pixels |
| backgroundColor, backgroundAlpha | 16777215, 1 |
| borderColor, borderThickness, borderAlpha | 13421772, 1, 1; thickness 0 hides border |
| showLegend, showLabels | true, true; labels may be culled when crowded |
| emptyText | No data |
| animationEnabled | false; true is unsupported in v1 and produces a diagnostic |
| categories, series, data, rows, columns | Only fields applicable to the family below; default empty arrays |
| xAxis, yAxis | Full config objects: scale per family, title:"", minimum:null, maximum:null, interval:null, showGrid:true, format:{kind:"number",decimals:2} |
| legend | {position:"bottom",spacing:8}; showLegend controls visibility |
| backgroundTexture | null (no explicit texture override) |

Colors are integers 0..16777215; alpha is a finite number in 0..1. Style precedence: explicit chart/point property, instance Style override, shared UIStyleManager key, built-in fallback. Point color/texture overrides series, then palette/default. Use the chart style keys in the plan, but CHART_BORDER_THICKNESS replaces CHART_BORDER_SIZE. Bitmap background key: CHART_BACKGROUND_IMAGE with manager value "chart_background_image". Use an accessible default palette such as [0x0072B2,0xE69F00,0x009E73,0xCC79A7,0xD55E00,0x56B4E9,0xF0E442,0x000000]. Preserve explicit choices over later reskin operations.

Texture value: {key:"asset-or-manager-key",mode:"stretch"}; allowed modes stretch, tile, fit, fill. null removes the explicit override and allows the next fallback; {key:"",mode:"stretch"} suppresses a fallback texture. References remain strings in JSON. In the standalone harness, resolve keys to preloaded OpenFL assets/manager entries, not a new network loader. Dynamic point/series bitmap slots derive from stable IDs, not labels or array positions. Backgrounds and rectangular/radial/area marks support textures; line/scatter textures apply only to markers. Fills/marks retain the underlying solid color.

For horizontal bar types xAxis is linear and yAxis categorical; ColumnChart reverses these. Line/Area use their declared xAxis scale and linear yAxis; scatter is linear on both. Histogram uses numeric bin boundaries on x and count on y. Heatmap uses column/row categories. Radial charts have no axes.

## Canonical family inputs

Use only one source for values: series[].points for Cartesian series, data for radial/histogram/heatmap. Do not accept both competing sources. Series entries have id, name, optional color/texture, and points. Points have id, family-specific coordinates, optional color/texture, and optional JSON-safe metadata. Renderers must not interpret metadata.

| Public type | Canonical input | Fixed/default behavior |
| --- | --- | --- |
| ColumnChart | categories:[{id,label}], series:[{id,name,points:[{id,categoryId,value}]}] | vertical; layout:single/grouped/stacked, default single; stackMode:raw/percent |
| BarChart | Same category-series shape | horizontal, single; at most one series |
| GroupedBarChart | Same category-series shape | horizontal, grouped |
| StackedBarChart | Same category-series shape | horizontal, stacked; stackMode:raw/percent |
| LineChart | xAxis.scale:categorical plus categories and points:{id,categoryId,value}; or scale:linear and points:{id,x,y} | categorical by default; straight lines, missingBehavior:gap |
| AreaChart | Same as LineChart | fill to data-space baseline 0, multiple overlaid series |
| ScatterPlot | series points:{id,x,y} | both axes linear |
| PieChart | data:[{id,label,value,color?,texture?,metadata?}] | one nonnegative value collection |
| DonutChart | Same as PieChart | innerRadius:0.5, clamped to 0.1..0.9 with diagnostic; centerText:"" |
| Histogram | data:[finite number,...] | raw observations; binCount or binWidth or automatic; count output |
| Heatmap | rows:[{id,label}], columns:[{id,label}], data:[{id,rowId,columnId,value,...}] | categorical axes, color legend |

IDs must be nonempty and unique within their collection; point IDs are unique within each series. Invalid/duplicate IDs are configuration errors. A standalone input without IDs receives deterministic index-based IDs once during normalization; export these IDs, and preserve them on reordering. Index-generated identities cannot preserve selection across arbitrary replacement without caller-supplied IDs. Studio will create persistent IDs. Labels need not be unique. Array order defines category/series/row/column and radial order. Reject unknown category/row/column references with a diagnostic for the affected mark. One point per series/category and one heatmap cell per row/column: first valid occurrence wins, later duplicates are skipped with diagnostics. Missing categories produce no mark and contribute zero to stack totals; line/area missing entries create gaps. Never combine duplicate labels.

## Updates and validation

Creation applies defaults plus the inner configuration. setComponentData is a partial update: omitted top-level fields remain unchanged, arrays replace atomically (no index merging), and supplied nested chart configuration objects replace their prior object with supplied values plus defaults. Style/Bitmap retain BaseUI replacement semantics. Clear data with [], not null. null is valid only for nullable fields (axis bounds/interval, binCount/binWidth, textures, metadata and line/area gap values); invalid null elsewhere retains the prior field/default and reports a diagnostic. A new instance built from a saved full configuration is the replacement/restore path.

Validate references against the combined post-update state. Reject structural batches (wrong family shape, duplicate IDs, conflicting histogram settings, unsupported schema) atomically, keeping the previous valid configuration. Accept a valid-shaped dataset containing invalid marks: preserve its JSON-safe input for authoring/diagnostics, skip invalid marks during normalization, and never send nonfinite values to Graphics. Finite numbers only; strings including "42" are invalid values, not coercions. JSON cannot represent NaN/Infinity; direct-Haxe nonfinite inputs produce diagnostics and export as null, never invalid JSON. null line/area samples are intentional gaps, not zero; connect behavior is available only when explicitly requested. Invalid settings retain prior valid values/defaults. Diagnostics are runtime-only records {code,path,message}; they are not saved, thrown as uncaught exceptions, or treated as user actions.

Save only input configuration, IDs, and JSON-safe metadata. Do not serialize normalized geometry, diagnostics, selected/hovered runtime objects, BitmapData, listeners, functions, or cyclic values. Public export API proposed for phase 1: toChartData():Dynamic returning a defensive snapshot of inner input configuration (a chart-specific API, not a new requirement for every BaseUI).

## Deterministic geometry decisions

- Category-series domain follows category order; numeric line/area points are stably sorted by x for rendering while preserving input indices/IDs. Equal x values retain original order. Scatter retains input order.
- Automatic bar/column/area/count domains include zero; line/scatter auto domains follow finite extrema. Empty input shows empty state. For equal numeric extrema v, expand by max(abs(v)*0.05,1). Explicit minimum must be < maximum and interval must be >0; invalid bound batches retain the previous valid axis. Formatting kind is number/percent, decimals integer 0..10. Percent formatter multiplies fractional inputs by 100.
- Tick default: approximately five intervals, using 1/2/5 times powers of ten. Do not use an unbounded tick loop; cap ticks to 200. Categorical axes ignore numeric bounds/interval with diagnostics. Clip marks to the plot; nonpositive plot dimensions draw only safe background/empty state.
- Stacks accumulate positive and negative sums separately. Percent stacks divide positives by their positive total and negatives by the magnitude of their negative total, giving domains -1..1. Percentage labels multiply by 100; no division by zero. signedTotal is the algebraic total, negativeTotal remains negative. Do not confuse signedTotal with absolute mass.
- Area baseline stays 0 even outside explicit axes; clip the polygon rather than replacing baseline with the viewport edge.
- Histogram automatic bin count is ceil(sqrt(validObservationCount)), at least 1; independent of pixel dimensions. Equal-value data makes one bin [v-0.5,v+0.5]. Otherwise count-based edges subdivide [min,max] equally. Width-based edges start at min and use ceil((max-min)/width) bins, with the final edge >=max. Bins are [lower,upper), except final bin includes upper. Invalid/nonpositive/noninteger binCount or nonpositive binWidth is rejected; both settings together are a structural error. Changing mode must explicitly clear the other nullable setting. Cap bins at 10000 with a diagnostic/rejected config, never silently allocate unbounded arrays. Bin events include bounds, count, and original observation indices.
- Pie/donut skip negative values with diagnostics; zeros have no slice; zero total is empty. startAngle defaults -90 degrees, clockwise true. Donut hole never hits a slice. Radial percentages use sum of accepted positive values.
- Heatmap: linear interpolation minColor to midColor to maxColor with midpoint default halfway between domain bounds. Clamp out-of-range values to endpoint colors. Constant domains use midColor. Missing cells use missingColor; missing cells have no data event. Defaults: minColor 16250871, midColor 7040715, maxColor 545908, missingColor 15132390, cellGap 1. Domain derives from valid cell values unless supplied; require min<=mid<=max, allowing equal only for a constant domain.
- Rectangle gap defaults: groupGap 0.2 and barGap 0.1 as fractions in [0,1). Line defaults: lineWidth 2, markerShape circle, markerSize 6, missingBehavior gap. Area defaults: fillAlpha 0.3 and baseline 0. Marker shapes: circle, square, diamond. Radius/marker sizes are pixels; invalid finite settings follow validation above.

## Interaction contract

Phase 1 will define a ChartEvent with payload and clone support; mark-level event types are chartRollOver, chartRollOut, chartMouseDown, chartMouseUp, chartClick, and change. Distinct chart-prefixed pointer events avoid emitting a second ordinary OpenFL mouse event on the component. Phase 13 maps these to existing authoring names Rollover/Rollout/MouseDown/MouseUp/Clicked/OnChange using the event capability registry; it must not double-register both raw and chart-level events. No plugin change in phases 0–12.

Payload: chartName, chartType, seriesId/seriesIndex/seriesName (null for nonseries), pointId, dataIndex (original input index), label, value, xValue, yValue, metadata. Add categoryId for category charts; rowId/columnId for heatmaps; baseline for area; lowerBound/upperBound/count/observationIndices for histogram; rawValue/normalizedValue/positiveTotal/negativeTotal/signedTotal for stacks. Radial data adds fraction. Return immutable snapshots, not internal points. Overlap picks the last drawn mark among candidates within marker bounds (including a 4px minimum hit radius). A click changes selection; repeated clicks on the same ID do not emit change. Data replacement retains selection only when the stable ID still denotes a valid mark, otherwise clear it silently; no authoring action should fire just from loading data. Disabled components clear hover and emit no mark interaction. Editor object selection remains a separate later concern.

## Phase 0 evidence versus future tests

Fixtures in tests/charts/fixtures/catalog.json cover every type and are executable parse/shape/round-trip checks now. cases.json records expected algorithm/update/error results for future phases; those results are specifications, not passing renderer tests. Phase 0 creates no chart classes or registrations. See tests/charts/README.md for verified commands and the Phase 0 report for baseline results.

