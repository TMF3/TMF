/*
 * Name = TMF_assignGear_fnc_setInsignia
 * Author = Freddo
 *
 * Arguments:
 * 0: Object. Unit
 * 1: ARRAY. Array of insignia to choose from
 *
 * Return:
 * 0: Nothing
 *
 * Description:
 * Will set a units insignia to a randomly chosen one from the supplied list.
 * 
 * Note:
 * Thanks @Bear and @Nick for helping
 */
 #include "\x\tmf\addons\assignGear\script_component.hpp"
params ["_unit","_insignias"];

if (isNil "_unit" || isNil "_insignias") exitWith {};

if (count _insignias > 0) then {
    [_unit, selectRandom _insignias] call BIS_fnc_setUnitInsignia;
};
