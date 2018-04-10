/*
 * Name: TMF_common_fnc_sideToString
 * Author: Snippers
 *
 * Arguments:
 * side
 *
 * Return:
 * string: Nice string
 *
 * Description:
 * Will return a text label for the side that is suitable to display.
 */

if (_this == west) exitWith {  "BLUFOR";};
if (_this == east) exitWith {  "OPFOR"; };
if (_this == independent) exitWith {"Independent"};
if (_this == civilian) exitWith {  "Civilian";};
if (_this == sideLogic) exitWith { "Logic";};
"Unknown"