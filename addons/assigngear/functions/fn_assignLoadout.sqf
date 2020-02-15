/*
 * Name = TMF_assignGear_fnc_assignLoadout
 * Author = Freddo
 *
 * Arguments:
 * 0: Object. Unit to assign loadout to
 * 1: String (optional). Which faction to use. Defaults to current unit faction
 * 2: String (optional). Which role to use. Defaults to current unit loadout
 *
 * Return:
 * None
 *
 * Description:
 * Same as TMF_assignGear_fnc_assignGear, but caches the loadout as a function
 * using instructions from CfgLoadoutsParser.
 */
#include "\x\tmf\addons\assignGear\script_component.hpp"

params [["_unit", player]];

if !(local _unit) exitWith {};

(_this - [_unit]) params [
    ["_faction", _unit getVariable [QGVAR(role), "r"]],
    ["_role", _unit getVariable [QGVAR(faction), toLower faction _unit]]
];

private _namespace = GVARMAIN(namespace);
private _loadout = ("loadout_" + _faction + "_" + _role);

if !(_namespace getVariable [_loadout, {}] isEqualTo {}) then {
    _unit call (_namespace getVariable _loadout);
} else {
    _unit call ([_faction, _role] call FUNC(cacheLoadout));
};
