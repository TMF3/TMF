/*
 * Name = TMF_assignGear_fnc_initNamespace
 * Author = Fredoo
 *
 * Arguments:
 * None
 *
 * Return:
 * Location. Namespace
 *
 * Description:
 * Initializes the TMF assigngear namespace
 */
#include "\x\tmf\addons\assignGear\script_component.hpp"

if (!isNil QGVAR(namespace)) exitWith {GVAR(namespace)};

// Check if there is a saved namespace in uiNamespace
private _cachedLoadoutsHashmap = uiNamespace getVariable QGVAR(cachedNamespace);
if !(isNil "_cachedLoadoutsHashmap") then {
    GVAR(namespace) = [_cachedLoadoutsHashmap, true] call CBA_fnc_deserializeNamespace;
} else {
    GVAR(namespace) = true call CBA_fnc_createNamespace;
};

// Save namespace to uiNamespace once mission ends
addMissionEventHandler ["Ended", {
    uiNamespace setVariable [QGVAR(cachedNamespace), GVAR(namespace) call CBA_fnc_serializeNamespace];
}];

publicVariable QGVAR(namespace);

LOG_1("Initialized namespace", GVAR(namespace));

GVAR(namespace)
