#include "\x\tmf\addons\assignGear\script_component.hpp"
/*
 * Name = TMF_assignGear_fnc_vehicleGear_load
 * Author = Head
 *
 * Arguments:
 * 0: CONTROL Attribute Control
 * 1: ARRAY VehicleGear
 *
 * Return:
 * Data to store
 *
 * Description:
 * Internal Use Only
 */
params ['_ctrlGroup', '_value'];

private _categoryCtrl = _ctrlGroup controlsGroupCtrl IDC_VEHICLEGEAR_CATEGORY;
private _factionCtrl = _ctrlGroup controlsGroupCtrl IDC_VEHICLEGEAR_FACTION;
private _gearCtrl = _ctrlGroup controlsGroupCtrl IDC_VEHICLEGEAR_LIST;
_value params [
    ['_category', '', ['']],
    ['_faction', '', ['']],
    ['_gear', createHashMap, [[], createHashMap]]
];

// Backwards compatibility
if (_gear isEqualType []) then {
    TRACE_1("Converting legacy ammobox array to hashmap",_gear);
    private _hashArray = [];
    {
        _hashArray append _x;
    } forEach _gear;
    _hashArray = _hashArray apply {[
        toLower (_x # 0),
        _x # 1
    ]};
    _gear = createHashMapFromArray _hashArray;
    TRACE_1("Converted legacy ammobox array to hashmap",_gear);
};

TRACE_5('Attribute Load',_category,_faction,_gear,_ctrlGroup,_value);

_gearCtrl setVariable [QGVAR(gear), _gear];

for "_i" from 0 to ((lbSize  _categoryCtrl)-1) do {
    private _cat = _categoryCtrl lbData _i;
    if(_cat == _category) exitWith {
        _categoryCtrl lbSetCurSel _i;

    };
};

for "_i" from 0 to ((lbSize  _factionCtrl)-1) do {
    private _cat = _factionCtrl lbData _i;
    if(_cat == _faction) exitWith {
        _factionCtrl lbSetCurSel _i;
    };
};
