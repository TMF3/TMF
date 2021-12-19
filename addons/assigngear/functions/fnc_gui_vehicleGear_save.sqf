#include "\x\tmf\addons\assignGear\script_component.hpp"
/*
 * Name = TMF_assignGear_fnc_vehicleGear_save
 * Author = Head
 *
 * Arguments:
 * None.
 *
 * Return:
 * Data to store
 *
 * Description:
 * Internal Use Only
 */
params ["_ctrlGrp"];
private _lbCategory = _ctrlGrp controlsGroupCtrl IDC_VEHICLEGEAR_CATEGORY;
private _lbFaction = _ctrlGrp controlsGroupCtrl IDC_VEHICLEGEAR_FACTION;
private _lnbGear = _ctrlGrp controlsGroupCtrl IDC_VEHICLEGEAR_LIST;

private _category = _lbCategory lbData lbCurSel _lbCategory;
private _faction = _lbFaction lbData lbCurSel _lbFaction;
private _gear = _lnbGear getVariable [QGVAR(gear), createHashMap];

TRACE_3("Saving ammobox attribute data",_category,_faction,_gear);

// Filter out 0's
private _toDelete = [];
{
    if (_y isEqualTo 0) then {
        _toDelete pushBack _x;
    };
} forEach _gear;
{
    _gear deleteAt _x;
} forEach _toDelete;

// Do not keep the attribute if there is no gear
// This will reset the faction/category but will reduce the mission file size
if (count _gear == 0) exitWith {["","",createHashMap]};

[
    _category,
    _faction,
    _gear
]
