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

if (isClass (missionConfigFile >> "CfgLoadouts")) then {
    // Remove duplicate loadouts
    private _cfg = (missionConfigFile >> "CfgLoadouts");
    private _missionLoadouts = [];

    {
        private _faction = configName _x;
        {
            _missionLoadouts pushBack format ["loadout_%1_%2", _faction, configName _x];
        } forEach ("true" configClasses _x);
    } forEach ("true" configClasses _cfg);

    private _conflictingLoadouts = allVariables GVAR(namespace) arrayIntersect _missionLoadouts;
    {
        GVAR(namespace) setVariable [_x, nil, true];
    } forEach _conflictingLoadouts;
};

GVAR(loadoutsToPurge) = [];
addMissionEventHandler ["Ended", {
    // Purge mission loadouts from namespace
    {GVAR(namespace) setVariable [_x, nil, true]} forEach (missionNamespace getVariable [QGVAR(loadoutsToPurge), []]);
    // Save namespace to uiNamespace once mission ends
    uiNamespace setVariable [QGVAR(cachedNamespace), GVAR(namespace) call CBA_fnc_serializeNamespace];
}];

publicVariable QGVAR(namespace);

LOG_1("Initialized namespace", GVAR(namespace));

GVAR(namespace)
