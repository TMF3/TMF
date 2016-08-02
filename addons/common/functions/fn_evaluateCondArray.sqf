/*
 * Name: TMF_common_fnc_evaluateCondArray
 * Author: Snippers
 *
 * Arguments:
 * Object: Unit, Array: Conditions
 *
 * Return:
 * Boolean
 *
 * Description:
 * Use this function to see check if a unit matches any conditions in the arrays. Apropriate conditions are sides (Side type variables or scalars), factions (all strings are assumed factions), 
 */

params ["_unit", "_condArray"];
private _return = false;
{
	if ((_x isEqualType "") and {_x == (faction (leader _unitGroup))}) exitWith { _return = true; };
	if ((_x isEqualType 0) && {(_x call tmf_common_fnc_numToSide) == side _unit}) exitWith { _return = true; };
	if ((_x isEqualType east) && {_x == side _unit}) exitWith { _return = true;};
} forEach _condArray;

_return
