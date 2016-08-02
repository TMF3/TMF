// TMF_OrbatRenamer_ctrlGroup

disableSerialization;
private _ctrlGroup = uiNamespace getVariable "TMF_OrbatRenamer_ctrlGroup";

private _toReplace = ctrlText (_ctrlGroup controlsGroupCtrl 100);
private _replaceWith = ctrlText (_ctrlGroup controlsGroupCtrl 101);



collect3DENHistory {
    {
        (_x get3DENAttribute "groupid") params ["_groupid"];
        private _str = [_groupid, _toReplace, _replaceWith] call CBA_fnc_replace;
        _x set3DENAttribute ["groupid",_str];
        
        {
            (_x get3DENAttribute "description") params ["_description"];
            private _str = [_description, _toReplace, _replaceWith] call CBA_fnc_replace;
            _x set3DENAttribute ["description",_str];
        } forEach (units _x);
    } forEach allGroups;
    
    with uiNamespace do {
        ["refreshTree"] call OrbatSettings_script;
    };
};

