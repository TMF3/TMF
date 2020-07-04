/*
 * Name: TMF_common_fnc_checkVersionArray
 * Author: Snippers
 *
 * Arguments:
 *  Array - Input version
 *  Array - Required version.
 *
 * Return:
 * Boolean
 *
 * Description:
 * Checks if the input version is greater or equal to the required version
 */
#include "\x\tmf\addons\common\script_component.hpp"

params [
    ["_input",[0,0,0]],
    ["_required",[1,0,0]]
];

_input params ["_i0","_i1","_i2"];
_required params ["_r0","_r1","_r2"];

if (_i0 > _r0) exitWith {true};
if (_i0 < _r0) exitWith {false};
if (_i1 > _r1) exitWith {true};
if (_i1 < _r1) exitWith {false};
if (_i2 < _r2) exitWith {false};

true;