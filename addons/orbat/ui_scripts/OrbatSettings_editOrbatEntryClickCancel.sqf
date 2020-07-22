TRACE_1("OrbatSettings editOrbatEntryClickCancel",_params);
with uiNamespace do {
    {(OrbatSettings_ctrlGroup controlsGroupCtrl _x) ctrlShow true;} forEach (MAIN_IDCS);
    {(OrbatSettings_ctrlGroup controlsGroupCtrl _x) ctrlShow false;} forEach (EDIT_IDCS);
    {(OrbatSettings_ctrlGroup controlsGroupCtrl _x) ctrlShow false;} forEach (MOVE_IDCS);
    OrbatSettingsCurrentEntity = nil;
};
