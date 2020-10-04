#include "\x\tmf\addons\assignGear\script_component.hpp"
/*
 * Name = TMF_assignGear_fnc_setInsignia
 * Author = Freddo
 *
 * Arguments:
 * 0: Object. Unit
 * 1: String. Insignia class name
 *
 * Return:
 * 0: Nothing
 *
 * Description:
 * Sets a units insignia
 *
 * Note:
 * Thanks @Bear and @Nick for helping
 */
params ["_unit","_insignia"];

if (time > 5 || {is3DEN}) then
{
    [_unit, _insignia] call BIS_fnc_setUnitInsignia;
}
else
{
    // Wait until game has started to overwrite player insignias
    [
        BIS_fnc_isLoading,
        BIS_fnc_setUnitInsignia,
        [_unit, _insignia],
        5
    ] call CBA_fnc_waitUntilAndExecute;
};
