
TRACE_1("OrbatSettings orbatToggleButton",_params);
with uiNamespace do {
    private _ctrlToggle = OrbatSettings_ctrlGroup controlsGroupCtrl 101;
    if (OrbatSelection isEqualType east) then {
        private _idx = (OrbatSidesPresent find OrbatSelection) + 1;
        if (_idx >= (count OrbatSidesPresent)) then {
            _idx = 0;
        };
        OrbatSelection = (OrbatSidesPresent select _idx);
        private _string = OrbatSelection call EFUNC(common,sideToString);
        _ctrlToggle ctrlSetText format["< %1 >", _string];
    };
    if (OrbatSelection isEqualType "") then {
        private _idx = (OrbatFactionsPresent find OrbatSelection) + 1;
        if (_idx >= (count OrbatFactionsPresent)) then {
            _idx = 0;
        };
        OrbatSelection = (OrbatFactionsPresent select _idx);
        private _string = getText (configfile >> "CfgFactionClasses" >> OrbatSelection >> "displayName");
        _ctrlToggle ctrlSetText format["< %1 >", _string];
    };


    ["refreshTree"] call OrbatSettings_script;
};
