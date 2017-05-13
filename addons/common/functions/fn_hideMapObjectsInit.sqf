/*
 * Name: TMF_common_fnc_hideMapObjectsInit
 * Author: Nick
 *
 * Arguments:
 * None
 *
 * Return:
 * nil
 *
 * Description:
 * Init for map objects hider
 *
 */
#include "\x\tmf\addons\common\script_component.hpp"
params ["_logic"];

private _ints = [];
_ints append lineIntersectsObjs [AGLToASL(_logic modelToWorld [-2,0,0]), AGLToASL(_logic modelToWorld [2,0,0]), objNull, _logic, true, 32];
_ints append lineIntersectsObjs [AGLToASL(_logic modelToWorld [0,-2,0]), AGLToASL(_logic modelToWorld [0,2,0]), objNull, _logic, true, 32];
_ints append lineIntersectsObjs [AGLToASL(_logic modelToWorld [0,0,-2]), AGLToASL(_logic modelToWorld [0,0,2]), objNull, _logic, true, 32];

_ints = _ints select {str(_x) find ".p3d" > 0};
_ints = _ints arrayIntersect _ints;
{
	_x hideObject true;
	_x setPosATL ((getPosATL _x) vectorAdd [0,0,-1000]);
} forEach _ints;

deleteVehicle _logic;