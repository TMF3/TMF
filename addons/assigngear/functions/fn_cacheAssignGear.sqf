/*
 * Name = TMF_assignGear_fnc_cacheAssignGear
 * Author = Freddo
 *
 * Arguments:
 * 0: String (optional). CfgLoadouts faction
 * 1: String (optional). CfgLoadouts role
 *
 * Return:
 * Code. Compiled loadout function
 *
 * Description:
 * Caches a loadout from uiNamespace to TMF namespace
 * If it isn't present, then it loads it from config
 */
#include "\x\tmf\addons\assignGear\script_component.hpp"
#define CFGROLE (_cfg >> "CfgLoadouts" >> _faction >> _role)

params ["_faction", "_role"];
private ["_loadoutArray"];

private _cfg = if (isClass (missionConfigFile >> "CfgLoadouts" >> _faction >> _role)) then [{missionConfigFile}, {configFile}];

ASSERT_TRUE(isClass CFGROLE, format [ARR_3("Loadout not present: %1 %2", _faction, _role)]);

private _loadout = format ["loadout_%1_%2", _faction, _role];

if (_cfg isEqualTo missionConfigFile) then {
    _loadoutArray = [_faction, _role, _cfg] call FUNC(loadAssignGear);
    GVAR(namespace) setVariable [_loadout, _loadoutArray];
    TRACE_2("Cached loadout to TMF namespace",_faction,_loadout);
} else {
    private _loadoutsHash = uiNamespace getVariable [QGVAR(loadoutsHash), [[], []] call CBA_fnc_hashCreate];
    private _hash = [_loadoutsHash, _loadout] call CBA_fnc_hashGet;
    if (_hash isEqualTo []) then {
        _loadoutArray = [_faction, _role, _cfg] call FUNC(loadAssignGear);
        _loadoutsHash = [_loadoutsHash, _loadout, _loadoutArray] call CBA_fnc_hashSet;
        uiNamespace setVariable [QGVAR(loadoutsHash), _loadoutsHash];
        TRACE_2("Cached loadout to uiNamespace",_faction,_loadout);
    } else {
        _loadoutArray = _hash;
        TRACE_2("Loaded loadout from uiNamespace",_faction,_loadout);
    };
};

_loadoutArray