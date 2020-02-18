#include "script_component.hpp"

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
