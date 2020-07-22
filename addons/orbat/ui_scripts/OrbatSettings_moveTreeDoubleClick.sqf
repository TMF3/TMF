
TRACE_1("OrbatSettings moveTreeDoubleClick",_params);
with uiNamespace do {

    //Find entry to move and remove it
    private _ctrlTree = OrbatSettings_ctrlGroup controlsGroupCtrl 102;
    private _value = (_ctrlTree tvValue (tvCurSel _ctrlTree));
    _value = (OrbatTree_Data select _value);

    if (_value isEqualType 0) then {
        private _idx = -1;
        {
            if ((_x select 0) isEqualTo OrbatSelection) exitWith { _idx = _forEachIndex;};
        } forEach OrbatSettings_Array;
        if (_idx == -1) then {
            _idx = OrbatSettings_Array pushBack [OrbatSelection,[]];
        };

        private _rootEntry = (OrbatSettings_Array select _idx) select 1;

        OrbatSettingsDesiredEntry = [];
        fn_findEntryHelper = {
            params["_entry", "_value"];
            private _children = _entry select 1;
            {
                _x params ["_data","_entryChildren"];
                if ((_data select 0) == _value) exitWith {
                    OrbatSettingsDesiredEntry = _x;
                    _children deleteAt _forEachIndex;
                };
                [_x, _value] call fn_findEntryHelper;
            } forEach _children;
        };
        [_rootEntry, _value] call fn_findEntryHelper;

        //Push Entry...
        if (count OrbatSettingsDesiredEntry > 0) then {
            _ctrlTree = OrbatSettings_ctrlGroup controlsGroupCtrl 108;
            _value = (_ctrlTree tvValue (tvCurSel _ctrlTree));
            fn_orbatSearchHelper = {
                params["_entry", "_value"];
                _entry params ["_data","_children"];
                if ((_data select 0) == _value) exitWith {
                    _children pushBack OrbatSettingsDesiredEntry;
                    true
                };
                {
                    if ([_x, _value] call fn_orbatSearchHelper) exitWith {true};
                } forEach _children;
                false
            };
            [_rootEntry, _value] call fn_orbatSearchHelper;
        };
        OrbatSettingsDesiredEntry = nil;
    };
    if (_value isEqualType grpNull || {_value in vehicles}) then {
        _ctrlTree = OrbatSettings_ctrlGroup controlsGroupCtrl 108;
        _value set3DENAttribute ["TMF_OrbatParent", (_ctrlTree tvValue (tvCurSel _ctrlTree))];
    };

    {(OrbatSettings_ctrlGroup controlsGroupCtrl _x) ctrlShow true;} forEach (MAIN_IDCS);
    {(OrbatSettings_ctrlGroup controlsGroupCtrl _x) ctrlShow false;} forEach (EDIT_IDCS);
    {(OrbatSettings_ctrlGroup controlsGroupCtrl _x) ctrlShow false;} forEach (MOVE_IDCS);
    ["refreshTree"] call OrbatSettings_script;
};
