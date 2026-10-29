# DatePicker

`com.chaos.ui.DatePicker` is an OpenFL calendar input built from framework Buttons and Labels. It is registered as the `DatePicker` engine command and available in Studio under UI > Date Picker.

```json
{"DatePicker":{"name":"dueDate","width":200,"height":30,"enabled":true,"selectedDate":"2026-10-21","minDate":"2026-01-01","maxDate":"2026-12-31","firstDayOfWeek":0,"placeholder":"Select date"}}
```

- `selectedDate`: selected date, or an empty string for no selection.
- `minDate`, `maxDate`: inclusive limits; an empty string removes the limit.
- `firstDayOfWeek`: 0 for Sunday, 1 for Monday.
- `placeholder`: caption shown when no date is selected.
- Inherits BaseUI dimensions, position, enabled state and resize behavior.

All dates are local date-only `YYYY-MM-DD` strings, with supported years 0100–9999. Impossible dates and inverted ranges are rejected. Updating limits clears an existing selection outside the new range. Programmatic changes do not emit a user change event.

Click the field to open the calendar. Use previous/next month buttons, Today, or Clear. Enter/Space opens the calendar; arrow keys move the focused date and Enter/Space selects it. Escape or a click outside dismisses it. The popup attaches to the stage to avoid clipping by its parent container and is removed when the control leaves the stage or is destroyed.

Listen to `openfl.events.Event.CHANGE` for user selection changes. Engine OnChange actions receive `selectedDate` in their event data. Studio exposes selected/minimum/maximum date editors, week start, placeholder, and the usual BaseUI panel. Preview selections are runtime state; use the Properties panel to set the saved initial date.

Validation from the Studio directory: `node scripts/check-date-picker.cjs`. This checks the compiled control shipped with Studio. Both authoring and runtime HTML5 builds must be refreshed when the Haxe sources change; published runtimes must be rebuilt before declaring DatePicker support in their manifests.

## Shape and themes

`dayShape` accepts `circle`, `square`, or `theme` (default). Studio exposes it in Date Picker Properties. `theme` uses `DATEPICKER_DAY_SHAPE` (circle when unset); an explicit instance shape overrides that style.

UIStyleManager keys (also supported in an instance `Style` object):

- `DATEPICKER_BACKGROUND_COLOR`, `DATEPICKER_NORMAL_COLOR`, `DATEPICKER_OVER_COLOR`, `DATEPICKER_DOWN_COLOR`, `DATEPICKER_DISABLE_COLOR`, `DATEPICKER_SELECTED_COLOR`
- `DATEPICKER_SELECTION_BORDER_COLOR`, `DATEPICKER_TEXT_COLOR`, `DATEPICKER_HEADER_COLOR`
- `DATEPICKER_FONT`, `DATEPICKER_FONT_SIZE`, `DATEPICKER_PANEL_ROUNDED`, `DATEPICKER_DAY_SHAPE`

UIBitmapManager uses `UIBitmapType.DatePicker` with these keys (also supported through instance `Bitmap` overrides):

- `datepicker_background`: calendar panel texture, stretched and clipped to the rounded panel.
- `datepicker_trigger_normal`, `datepicker_trigger_over`, `datepicker_trigger_down`, `datepicker_trigger_disable`: field button states.
- `datepicker_day_normal`, `datepicker_day_over`, `datepicker_day_down`, `datepicker_day_disable`: calendar button states.
- `datepicker_day_selected`: selected day texture; falls back to the normal texture when unset.

Missing textures use the style colors. Cached bitmap clones are owned by the picker and released during reskin/destroy. The same keys are registered in Studio's theme editors and routed by both the authoring and runtime theme systems.
