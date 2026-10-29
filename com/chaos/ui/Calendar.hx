package com.chaos.ui;

/** Always-visible date selection, sharing DatePicker validation, interaction and skins. */
class Calendar extends DatePicker {
    public function new(data:Dynamic = null) { super(data); }
    override private function isInline():Bool return true;
}
