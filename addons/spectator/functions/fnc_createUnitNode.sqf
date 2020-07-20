/*
 * Author: Head, Snippers
 * Creates a unit node for units tree node
 *
 * Arguments:
 * 0: _unit - a unit
 * 1: _parentIndex - parent index for the treeview group node
 *
 * Return Value:
 * Index <NUMBER>
 *
 * Example:
 * [group player] call tmf_spectator_fnc_createUnitNode
 *
 * Public: No
 */
#include "\x\tmf\addons\spectator\script_component.hpp"
params["_unit","_parentIndex"];

disableSerialization;

private _name = name _unit;
private _unitListControl = (uiNamespace getVariable [QGVAR(unitlist),controlNull]);
private _index = _unitListControl tvAdd [[_parentIndex],_name];
_unitListControl tvSetData [[_parentIndex,_index], _unit call BIS_fnc_netId];

private _icon = getText (configFile >> "CfgVehicles" >> typeof (vehicle _unit) >> "icon");
if (isText (configfile >> "CfgVehicleIcons" >> _icon )) then {
    _icon = getText (configfile >> "CfgVehicleIcons" >> _icon );
};
_unitListControl tvSetPicture [[_parentIndex,_index],_icon];
