
TRACE_1("OrbatSettings orbatBinChanged",_params);
if ((_params select 1)==0)then { //side
    with uiNamespace do {
        OrbatSelection = OrbatSidesPresent select 0;
    };
} else {
    with uiNamespace do {
        OrbatSelection = OrbatFactionsPresent select 0;
    };
};
with uiNamespace do {

    OrbatSettings_Array = [    [OrbatSelection,[]]    ];

    //ERASE ATTRIBUTES
    {
        private _attrValue = (_x get3DENAttribute "TMF_OrbatParent") select 0;
        if (_attrValue == _val) then { _x set3DENAttribute ["TMF_OrbatParent", -1]; };
        {
            private _attrValue = (_x get3DENAttribute "TMF_OrbatParent") select 0;
            if (_attrValue == _val) then { _x set3DENAttribute ["TMF_OrbatParent", -1]; }
        } forEach (units _x);
    } forEach (cacheAllPlayerGroups);

    private _ctrlToggle = OrbatSettings_ctrlGroup controlsGroupCtrl 101;

    {(OrbatSettings_ctrlGroup controlsGroupCtrl _x) ctrlShow true;} forEach (MAIN_IDCS);
    {(OrbatSettings_ctrlGroup controlsGroupCtrl _x) ctrlShow false;} forEach (EDIT_IDCS);
    {(OrbatSettings_ctrlGroup controlsGroupCtrl _x) ctrlShow false;} forEach (MOVE_IDCS);
    private _string = "";
    if (OrbatSelection isEqualType east) then {
        _string = OrbatSelection call EFUNC(common,sideToString);
    };
    if (OrbatSelection isEqualType "") then {
        _string = getText (configfile >> "CfgFactionClasses" >> OrbatSelection >> "displayName");
    };

    _ctrlToggle ctrlSetText format["< %1 >", _string];
    ["refreshTree"] call OrbatSettings_script;
};
