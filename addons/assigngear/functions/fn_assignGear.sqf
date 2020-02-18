/*
 * Name = TMF_assignGear_fnc_assignGear
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
 * Assigns a loadout defined in CfgLoadouts to a unit.
 */
#include "\x\tmf\addons\assignGear\script_component.hpp"

params [["_unit", player]];

if !(local _unit) exitWith {};

(_this - [_unit]) params [
    ["_faction", _unit getVariable [QGVAR(faction), toLower faction _unit]],
    ["_role", _unit getVariable [QGVAR(role), "r"]]
];

// Sometimes in editor this function is run before preInit, this should make sure that the namespace exists
private _namespace = missionNamespace getVariable [QGVAR(namespace), [FUNC(initNamespace)] call CBA_fnc_directCall];
private _loadout = ("loadout_" + _faction + "_" + _role);

// Check if loadout if cached, if not then cache it
if !(_namespace getVariable [_loadout, {}] isEqualTo {}) then {
    _unit call (_namespace getVariable _loadout);
} else {
    _unit call ([_faction, _role] call FUNC(cacheAssignGear));
};
_unit setVariable [QGVAR(faction), _faction];
_unit setVariable [QGVAR(role), _role];
_unit setVariable [QGVAR(done),true,true];

[QGVAR(assignedLoadout), [_unit, _faction, _role]] call CBA_fnc_localEvent;
