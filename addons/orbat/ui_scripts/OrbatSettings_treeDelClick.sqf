
TRACE_1("OrbatSettings treeDelClick",_params);
with uiNamespace do {
    private _ctrlTree = OrbatSettings_ctrlGroup controlsGroupCtrl 102;
    private _treeSel = tvCurSel _ctrlTree;

    if (count _treeSel == 0) exitWith {};
    private _value =  OrbatTree_Data select (_ctrlTree tvValue _treeSel);

    if (_value isEqualType 0) then {
        //find it.
        private _idx = -1;
        {
            if ((_x select 0) isEqualTo OrbatSelection) exitWith { _idx = _forEachIndex;};
        } forEach OrbatSettings_Array;
        private _entry = (OrbatSettings_Array select _idx) select 1;

        fn_delEntryHelper = {
            params["_entry", "_value"];
            private _children = _entry select 1;
            {
                _x params ["_data","_entryChildren"];

                if ((_data select 0) == _value) exitWith {
                    _children append _entryChildren;
                    _children deleteAt _forEachIndex;
                };
                [_x, _value] call fn_delEntryHelper;
            } forEach _children;
        };
        [_entry, _value] call fn_delEntryHelper;

        //Ensure all attributes and purged from groups/units with the attribute.
        {
            private _attrValue = (_x get3DENAttribute "TMF_OrbatParent") select 0;
            if (_attrValue == _val) then { _x set3DENAttribute ["TMF_OrbatParent", -1]; };
            {
                private _attrValue = (_x get3DENAttribute "TMF_OrbatParent") select 0;
                if (_attrValue == _val) then { _x set3DENAttribute ["TMF_OrbatParent", -1]; }
            } forEach (units _x);
        } forEach (cacheAllPlayerGroups);
    };

    ["refreshTree"] call OrbatSettings_script;
};
