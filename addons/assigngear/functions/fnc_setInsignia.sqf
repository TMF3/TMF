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
params ["_unit",["_insignia","default"]];

if (_insignia == "default") exitWith {};

[_unit, _insignia] call BIS_fnc_setUnitInsignia;

_unit setVariable [QGVAR(insignia),_insignia];
