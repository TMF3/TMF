#include "\x\tmf\addons\assignGear\script_component.hpp"
/*
 * Name = TMF_assignGear_fnc_helper
 * Author = Snippers
 *
 * Arguments:
 * 0: OBJECT. Unit
 * 1: ARRAY in the format of role, faction, enabled.
 *    0: STRING. Role
 *    1: STRING: Faction
 *    2: BOOLEAN: Enabled. must be true to assign
 *
 * Return:
 * None.
 *
 * Description:
 * Gives the unit the gear specified in the array.
 */

params ["_unit","_input"];

if (_input isEqualType "") then {
    _input = call compile _input;
};

if (count _input == 3) then {
    // New spec
    _input params ["_role","_faction","_enabled"];

    if (_enabled) then {
        if !(is3DEN && time < 1) then {
            [_unit, _faction, _role] call FUNC(assignGear);
        } else {
            [_unit, _faction, _role] spawn {
                waitUntil {time > 0;};
                [FUNC(assignGear), _this] call CBA_fnc_directCall;
            };
        };
    };
} else {
    //Backwards compatible
    _input params ["_role","_faction","_side","_enabled"];

    if (_enabled) then {
        WARNING_2("(%1) This syntax has been deprecated for this function: %2 (use: ['_unit',['_role','_faction','_enabled']])",QFUNC(helper),_this);
        [_unit, _faction, _role] call FUNC(assignGear);
    };
};
