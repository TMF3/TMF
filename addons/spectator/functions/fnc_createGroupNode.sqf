#include "\x\tmf\addons\spectator\script_component.hpp"
/*
 * Author: Head, Snippers
 * Creates a group node for units tree node
 *
 * Arguments:
 * 0: _grp <Group>
 *
 * Return Value:
 * Index <NUMBER>
 *
 * Example:
 * [group player] call tmf_spectator_fnc_createGroupNode
 *
 * Public: Not really
 */
params ["_grp"];

disableSerialization;

private _twGrpMkr = [_grp] call EFUNC(orbat,getGroupMarkerData);

private _grpName = groupID _grp;
private _icon = "\A3\ui_f\data\map\markers\nato\b_unknown.paa";
private _color = (side _grp) call CFUNC(sideToColor);

if (count _twGrpMkr >= 3) then {
    _icon = _twGrpMkr select 0;
    _color = [1,1,1,1];
};

private _unitListControl = (uiNamespace getVariable [QGVAR(unitlist),controlNull]);

private _index = _unitListControl tvAdd [[],_grpName];
_unitListControl tvSetPicture [[_index], _icon];
_unitListControl tvSetData [[_index], _grp call BIS_fnc_netId];
_unitListControl tvSetPictureColor [[_index], _color];

{
    if (alive _x) then {
        [_x, _index] call FUNC(createUnitNode);
    };
} forEach (units _grp);

if({isPlayer _x} count (units _grp) > 0) then {
    _unitListControl tvExpand [_index];
};

_index
