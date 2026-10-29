# Calendar

`com.chaos.ui.Calendar` is the always-visible version of DatePicker. In Studio select **UI > Calendar**, then click the canvas to place it. Calendar Properties exposes the selected date, inclusive date limits, first day of week, and theme/circle/square day shape. Width and height resize the inline calendar; the default is 360 by 496.

```json
{"Calendar":{"name":"calendar","width":360,"height":496,"enabled":true,"selectedDate":"2026-10-21","minDate":"","maxDate":"","firstDayOfWeek":0,"dayShape":"theme"}}
```

Dates use YYYY-MM-DD. Calendar supports month navigation, Today, Clear, and keyboard date selection. Selecting a date or pressing Escape does not dismiss it. Disabled calendars ignore interaction. The fixed six-row layout keeps its authored bounds stable across months.

Calendar shares DatePicker rendering, validation, UIStyleManager `DATEPICKER_*` keys, and UIBitmapManager `datepicker_*` keys (`UIBitmapType.DatePicker`). These keys are available under Calendar in Studio's Style and Bitmap editors. See DatePicker.md for the key list.

User selection emits `openfl.events.Event.CHANGE`; Studio OnChange actions receive `selectedDate`. Programmatic property updates do not emit user change events. Preview selections are runtime state; use Calendar Properties to save the initial date.

Run `node scripts/check-date-picker.cjs` from Studio for the shared DatePicker and standalone Calendar regression checks.
