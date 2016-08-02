/*
 * Author: Head
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
#include "\x\tmf\addons\spectator\script_component.hpp"
params ["_grp"];

disableSerialization;

private _twGrpMkr = [_x] call EFUNC(orbat,getGroupMarkerData);

private _grpName = groupID _grp;
private _icon = "\A3\ui_f\data\map\markers\nato\b_unknown.paa";
private _color = (side _x) call CFUNC(sideToColor);

if(count _twGrpMkr >= 3) then {
	_icon = _twGrpMkr select 0;
	_color = [1,1,1,1];
};

GVAR(groups) pushBackUnique _grp;

private _unitListControl = (uiNamespace getVariable [QGVAR(unitlist),controlNull]);

private _index = _unitListControl tvAdd [[],_grpName];
_unitListControl tvSetPicture [[_index],_icon];
_unitListControl tvSetData [[_index],netId (leader _grp)];
_unitListControl tvSetPictureColor [[_index],_color];


{
	if(alive _x) then {
		[_x,_index] call FUNC(createUnitNode);
	};
} forEach (units _x);
_index
