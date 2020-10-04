#include "\x\tmf\addons\assignGear\script_component.hpp"
/*
 * Name = TMF_assignGear_fnc_setGoggles
 * Author = Bear
 *
 * Arguments:
 * 0: Object. Unit
 * 1: ARRAY. Array of goggles to choose from
 *
 * Description:
 * Will set a units goggles to a randomly chosen one from the supplied list.
 */

params ["_unit", "_goggles"];

private _curGoggles = goggles _unit;
if (_curGoggles isEqualTo "") then { // Don't respect no-goggles profile in skip check
    _curGoggles = "givemegoggles";
};

// Skip if loadout allows profile glasses OR profile glasses part of loadout
if ("default" in _goggles || _curGoggles in _goggles) exitWith {};

private _newGoggles = "";
if (_goggles isNotEqualTo []) then {
    _newGoggles = selectRandom _goggles;
};

if (_newGoggles isEqualTo "") then {
    removeGoggles _unit;
} else {
    _unit addGoggles _newGoggles;
};
