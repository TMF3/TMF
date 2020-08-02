#include "\x\tmf\addons\assignGear\script_component.hpp"
/*
 * Name = TMF_assignGear_fnc_vehicleGear_save
 * Author = Head
 *
 * Arguments:
 * 0: ARRAY VehicleGear
 *
 * Return:
 * Data to store
 *
 * Description:
 * Internal Use Only
 */
params ['_value'];
private _ctrlGroup = uiNamespace getVariable[QGVAR(vehicleGear_control), controlNull];
private _categoryCtrl = _ctrlGroup controlsGroupCtrl IDC_VEHICLEGEAR_CATEGORY;
private _factionCtrl = _ctrlGroup controlsGroupCtrl IDC_VEHICLEGEAR_FACTION;
_value params [['_category', '', ['']], ['_faction', '', ['']], ['_cache', [ [], [], [] ], [], 3] ];
TRACE_1('Load', [_category, _faction, _cache]);
GVAR(vehicleGear_data) = [_category, _faction, _cache];
for [{ _i = 0 }, { _i < (lbSize  _categoryCtrl) }, { _i = _i + 1 }] do {
private _cat = _categoryCtrl lbData _i;
    if(_cat == _category) exitWith {
        _categoryCtrl lbSetCurSel _i;
    };
};
for [{ _i = 0 }, { _i < (lbSize  _factionCtrl) }, { _i = _i + 1 }] do {
    private _cat = _factionCtrl lbData _i;
    if(_cat == _faction) exitWith {
        _factionCtrl lbSetCurSel _i;
    };
};
['attributedLoaded', [ _ctrlGroup ]] call FUNC(gui_vehicleGear_selector);