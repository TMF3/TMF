
TRACE_1("OrbatSettings treeMoveClick",_params);
with uiNamespace do {
    private _ctrlTree = OrbatSettings_ctrlGroup controlsGroupCtrl 102;
    if ( count (tvCurSel _ctrlTree) == 0 ) exitWith {};
    {(OrbatSettings_ctrlGroup controlsGroupCtrl _x) ctrlShow false;} forEach (MAIN_IDCS);
    {(OrbatSettings_ctrlGroup controlsGroupCtrl _x) ctrlShow false;} forEach (EDIT_IDCS);
    {(OrbatSettings_ctrlGroup controlsGroupCtrl _x) ctrlShow true;} forEach (MOVE_IDCS);

    private _value = OrbatTree_Data select (_ctrlTree tvValue (tvCurSel _ctrlTree));
    if (!(_value isEqualType 0)) then { _value = -1};
    _ctrlTree = OrbatSettings_ctrlGroup controlsGroupCtrl 108;
    tvClear _ctrlTree;

    private _idx = -1;
    {
        if ((_x select 0) isEqualTo OrbatSelection) exitWith { _idx = _forEachIndex;};
    } forEach OrbatSettings_Array;
    if (_idx == -1) then {
        _idx = OrbatSettings_Array pushBack [OrbatSelection,[]];
    };

    private _rootEntry = (OrbatSettings_Array select _idx) select 1;

    if (count _rootEntry == 0) then {
        _rootEntry pushBack [call fn_findNextFreeId, "", "", ""];
        _rootEntry pushBack [];
    };

    fn_processTreeEntry2 = {
        params ["_entry", "_location", "_value"];

        if (count _entry == 0) exitWith {}; // nothing to process

        _entry params ["_data", "_children"];
        _data params ["_id","_name","_tex1","_tex2",["_fName",""]];

        if (_id != _value) then {
            private _string = _fName;
            if (_name != "") then {
                _string = format["%1 (Marker: %2)", _fName, _name];
            };
            private _myLocation = _location + [_ctrlTree tvAdd [_location, _string]];
            _ctrlTree tvSetPicture [_myLocation, _tex1];
            _ctrlTree tvSetValue [_myLocation, _id];
            _ctrlTree tvExpand _myLocation;

            {
                [_x, _myLocation, _value] call fn_processTreeEntry2;
            } forEach _children;
        };
    };

    [_rootEntry, [], _value] call fn_processTreeEntry2;

};
