/*
 * Name = TMF_assignGear_fnc_helper
 * Author = Snippers
 *
 * Arguments:
 * 0: OBJECT. Unit
 * 1: ARRAY in the format of role, faction, side, enabled.
 *    0: STRING. Role
 *    1: STRING: Faction
 *    2: NUMBER: Side
 *    3: BOOLEAN: Enabled. must be true to assign
 *
 * Return:
 * None.
 *
 * Description:
 * Gives the unit the gear specified in the array.
 */
#include "\x\tmf\addons\assignGear\script_component.hpp"

//if (is3DEN) exitWith {};

params ["_unit","_input"];

if (_input isEqualType "") then {
    _input = call compile _input;
};

//NEW SPEC - ['r','',false]
//OLD SPEC - ['r','',-1,false]

if (count _input == 3) then {
    // New spec
    _input params ["_role","_faction","_enabled"];

    if (_enabled) then {
        [_unit, _faction, _role] call FUNC(assignGear);
    };
} else {
    //Backwards compatible
    _input params ["_role","_faction","_side","_enabled"];

    if (_enabled) then {
        [_unit, _faction, _role] call FUNC(assignGear);
    };
};
