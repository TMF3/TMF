/*
 * Name: TMF_common_fnc_initGroupVar
 * Author: Snippers
 *
 * Arguments:
 * 0: GROUP: Target group
 * 1: STRING: Variable name
 * 2: ANY: Variable Value
 *
 * Return:
 * none
 *
 * Description:
 * Group variables will not be broadcast globally during init. Calling this function during init can be used to bypass this limitation;
 */

#include "\x\tmf\addons\common\script_component.hpp"

// Setting a group variable to true on init doesn't syncrhonize in MP. Here we delay by a frame.

params ["_entity", "_str", "_val"];

_entity setVariable [_str, _val]; // for Eden

[{
    params["_entity", "_str", "_val"];
    _entity setVariable [_str, _val, true];
}, [_entity,_str,_val]] call CBA_fnc_execNextFrame;
