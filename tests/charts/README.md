# Standalone chart development harness

Phase 0 scaffolding only. The harness directly constructs the existing `ProgressBar` as a framework regression baseline. It does not construct charts until their implementation phases. It has no CHAOS_ENGINE, authoring-runtime, Angular, or Studio dependency. `project.xml` uses the UI source directory explicitly, so this harness does not depend on a global chaos-framework haxelib mapping.

## Run from this directory

```powershell
haxe contracts.hxml
lime build html5 -debug
```

The first command checks all eleven canonical fixture shapes and JSON round trips and rejects three deliberate malformed catalog mutations. It also verifies that future behavior cases are well-formed. It does NOT execute future chart algorithms. The second command produces `Export/html5/bin/index.html` and `ChartHarness.js`.

To run the browser checks with an existing Playwright installation:

```powershell
$env:PLAYWRIGHT_MODULE = 'C:\Users\erick\.cache\codex-runtimes\codex-primary-runtime\dependencies\node\node_modules\playwright'
$env:BROWSER_CHANNEL = 'msedge'
node browser-smoke.cjs
```

The module path is the verified local bundled dependency, not a portable project requirement. Elsewhere use an installed `playwright` module or set PLAYWRIGHT_MODULE to its absolute path. BROWSER_CHANNEL may select another installed channel; unset it to use Playwright Chromium if installed. No browser download or dependency install is required on the verified workstation. The script starts a temporary loopback-only HTTP server, runs a headless browser, checks the result and uncaught errors, captures `Export/html5/bin/phase0-baseline.png`, then closes browser and server.

For interactive inspection, serve `Export/html5/bin` using your existing local static server. The page displays fixture counts and a real ProgressBar. Do not open generated HTML via file:// because assets need HTTP loading.

## Structure and phase handoff

- `Source/Main.hx`: standalone OpenFL startup, visible baseline, and five ProgressBar lifecycle assertions.
- `Source/FixtureChecks.hx`: shared fixture checks for interpreter and browser. This is test scaffolding, not the production chart normalizer or exhaustive schema validator.
- `Source/ContractTest.hx`: interpreter entry point, including negative fixture-integrity checks.
- `fixtures/catalog.json`: canonical saved examples for all eleven public chart types.
- `fixtures/cases.json`: expected update/geometry/error scenarios for implementation phases. Port these to tests against real component helpers as each phase is implemented; do not mark their expected results as passed from the Phase 0 parse check.
- `../../docs/charts/CONTRACT.md`: version 1 decisions; authoritative over illustrative examples in the parent plan.
- `../../docs/charts/PHASE_0_REPORT.md`: discovery, baseline evidence, and limitations.

Add real ChartBase fixtures in phase 1, Cartesian fixtures in phase 2, and ColumnChart in phase 3. Keep the existing component regression check. Later event tests use direct Haxe listeners. Keep all engine/IDE integration out of this harness until the planned integration phases.

Build artifacts and screenshots are ignored through this directory's `.gitignore`.
