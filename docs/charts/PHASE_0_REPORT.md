# Phase 0 — Discovery and baseline report

Status: complete. No chart classes, engine registrations, Studio factories, or panels have been implemented.

## Repository and toolchain discovery

- `_FRAMEWORK` is an umbrella directory, not a Git repository. Its `CHAOS_UI_HX` and `CHAOS_ENGINE` children are independent repositories.
- Both child repositories had clean working trees at the start of Phase 0. Baseline commits: UI `44a6aa5` (Code clean up), engine `1c4121a` (Add Media Evcent to support sound.). Existing parent planning documents were preserved.
- No AGENTS.md files were found in the inspected ancestor locations or within the UI/engine trees.
- Haxe 4.2.3; active libraries: OpenFL 9.5.2, Lime 8.3.2, Actuate 1.9.0. Global chaos-framework dev mapping points at this local CHAOS_UI_HX checkout. The new harness uses an explicit local source path regardless.
- No existing UI-library test project was found. The authoring runtime has browser tests, but those depend on the engine. The new isolated test project borrows only the convention of using Playwright for HTML5 smoke checks.

## Verified source findings

- `com/chaos/ui/BaseUI.hx`: constructor ordering, partial field updates, Style/Bitmap replacement maps, instance bitmap cloning, size setters, drawOnResize, destroy.
- `com/chaos/ui/ProgressBar.hx`: representative direct-Haxe component construction, numeric colors, borderThickness, stage bitmap watchers, draw and destroy behavior.
- `com/chaos/ui/UIStyleManager.hx`: style storage and lookup; charts need explicit built-in defaults when no theme value exists.
- `com/chaos/ui/UIBitmapManager.hx`: getUIElement clones returned bitmaps; UIBitmapType currently has no chart entry; watcher mechanism is reusable.
- `com/chaos/ui/event/SliderEvent.hx`: singular event package and existing change event naming.
- Engine `CoreUIFrameworkPlugin.hx` and `CoreCommandPlugin.hx`: wrapped creation/update routing; helper only explicitly draws when redraw:true. This is a compatibility constraint, not permission to integrate early.
- Studio `src/app/data/chaos-ui-lib.ts`: existing JSON factory location. It was inspected read-only; no IDE dependency was introduced.

## Contract decisions delivered

See CONTRACT.md for canonical family shapes, numeric colors, stable identity, partial updates, structural errors versus skipped marks, zero/null behavior, texture ownership/precedence, shared style defaults, axes, stacking, binning, heatmaps, selection, and chart event mapping. Save raw configuration rather than display state. The parent plan's illustrative data/series ambiguity, #hex examples, and borderSize naming are superseded by this contract.

## Validation evidence

Working directory for all commands: `CHAOS_UI_HX/tests/charts`.

| Command/check | Result |
| --- | --- |
| `haxe contracts.hxml` | PASS: 11 chart fixture shapes and JSON round trips; 3 invalid wrapper/reference/ID mutations rejected |
| Future-case fixture parsing | PASS: 19 expected-behavior cases parse; algorithm assertions deliberately deferred to their phases |
| `lime build html5 -debug` | PASS, exit 0; independent HTML5 bundle generated with local UI source and no engine |
| `node browser-smoke.cjs` with installed Edge and bundled Playwright | PASS: fixtures 11, futureCases 19, baselineChecks 5; no uncaught browser errors |
| ProgressBar baseline | PASS: construction, partial update retains width, resize, stable child count over 25 updates, destroy removes children |

Screenshot output: `tests/charts/Export/html5/bin/phase0-baseline.png`. Captured by the browser test; not visually inspected because the local image-reader sandbox helper failed. Automated startup and lifecycle checks passed; this is not chart-rendering visual acceptance.

Initial infrastructure failures: the standard shell sandbox helper could not start, so approved escalated commands were used. Playwright's default Chromium binary was absent; selecting installed Edge resolved the browser run without installing anything. These were environment issues, not framework failures. No remaining blocker for phase 1.

## Next phase

Implement only phase 1: shared ChartBase, normalization/models, styles/bitmap support and event scaffolding, with real component tests in this harness. Maintain constructor safety and owned-clone disposal. Add tests of the recorded update/error cases against the actual implementation. Axis implementation starts in phase 2 and ColumnChart in phase 3. Engine work starts in phase 13 and IDE work in phase 14.
