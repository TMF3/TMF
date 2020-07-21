
TRACE_1("OrbatSettings treeAddClick",_params);
with uiNamespace do {
    private _ctrlTree = OrbatSettings_ctrlGroup controlsGroupCtrl 102;
    if ( count (tvCurSel _ctrlTree) == 0 ) exitWith {};

    private _treeSel = tvCurSel _ctrlTree;
    private _value = OrbatTree_Data select (_ctrlTree tvValue _treeSel);
    if ((_value isEqualType grpNull) or (_value isEqualType objNull)) exitWith {};
    {(OrbatSettings_ctrlGroup controlsGroupCtrl _x) ctrlShow false;} forEach (MAIN_IDCS);
    {(OrbatSettings_ctrlGroup controlsGroupCtrl _x) ctrlShow true;} forEach (EDIT_IDCS);
    {(OrbatSettings_ctrlGroup controlsGroupCtrl _x) ctrlShow false;} forEach (MOVE_IDCS);

    private _ctrlIconToolbox = OrbatSettings_ctrlGroup controlsGroupCtrl 111;
    private _ctrlColourToolBox = OrbatSettings_ctrlGroup controlsGroupCtrl 113;
    private _ctrlNameEdit = OrbatSettings_ctrlGroup controlsGroupCtrl 115;
    private _ctrlSize = OrbatSettings_ctrlGroup controlsGroupCtrl 117;
    private _ctrlFullNameEdit = OrbatSettings_ctrlGroup controlsGroupCtrl 123;

    _ctrlColourToolBox lbsetcursel 0;
    _ctrlIconToolbox lbsetcursel 0;
    _ctrlSize lbsetcursel 0;
    _ctrlNameEdit ctrlSetText "";
    _ctrlFullNameEdit ctrlSetText "";

    OrbatEditMode = 0; // 0 for add

    private _idx = -1;
    {
        if ((_x select 0) isEqualTo OrbatSelection) exitWith { _idx = _forEachIndex;};
    } forEach OrbatSettings_Array;
    private _entry = (OrbatSettings_Array select _idx) select 1;

    fn_editSearchHelper = {
        params["_entry", "_value"];
        _entry params ["_data","_children"];
        if ((_data select 0) == _value) exitWith {
            OrbatSettingsCurrentEntity = _entry;
            true
        };
        {
            if ([_x, _value] call fn_editSearchHelper) exitWith {};
        } forEach _children;
        false
    };
    [_entry, _value] call fn_editSearchHelper;

};
