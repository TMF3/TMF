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

if (isNil "_insignias" || {(count _insignias) isEqualTo 0} || {isNil "_unit"}) exitWith {};

if (time > 5 || {is3DEN}) then
{
    [_unit, selectRandom _insignias] call BIS_fnc_setUnitInsignia;
}
else
{
    // Wait until game has started to overwrite player insignias
    [_unit, _insignias] spawn
    {
        params ["_unit", "_insignias"];
        // Needs a delay for units to load in before applying insignia
        waitUntil {time > 5};
        [_unit, selectRandom _insignias] call BIS_fnc_setUnitInsignia;
    };
};