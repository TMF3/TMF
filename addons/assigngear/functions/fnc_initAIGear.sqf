#include "\x\tmf\addons\assignGear\script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: TMF_assigngear_fnc_initAIGear

Description:
    Initializes AIGear class eventhandler and if not already
    initialized, caches the AIGear config to the assigngear
    namespace.

Parameters:
    _faction - CfgFactionClass config name [String]
    _loadout - CfgLoadout config name [String]
    _retroactive - Whether to apply to units retroactively [Boolean]

Author:
    Freddo
---------------------------------------------------------------------------- */
params ["_faction","_loadout","_retroactive"];

private _namespace = [] call FUNC(initNamespace);

private _hash = _namespace getVariable ["AIGear_hash",[]];

if (_hash isEqualTo []) then {
    // Generate AI Gear Hash
    private _cfgAIGear = (missionConfigFile >> QGVARMAIN(AIGear));
    if (!isClass _cfgAIGear) then {
        _cfgAIGear = (configFile >> QGVARMAIN(AIGear))
    };

    private _cfgProperties = configProperties [_cfgAIGear];
    private _default = [];
    private _hasCode = false;
    {
        private _cfgName = toLower configName _x;
        private _value = _x call CFUNC(getCfgEntryFromPath);
        switch (_cfgName) do {
            case "code": {
                _hash pushBack [_cfgName, compile _value];
                _hasCode = true;
            };
            case "default": {
                _default = _value;
            };
            default {
                _hash pushBack [_cfgName, _value];
            };
        };
    } forEach _cfgProperties;

    // Fallback if no code defined
    if !(_hasCode) then {
        _hash pushBack [_cfgName, {([_this] call BIS_fnc_objectType) select 1}];
    };
    // Fallback if no default defined
    if (_default isEqualTo []) then {
        _default = ["r",1];
    };

    _hash = [_hash,_default] call CBA_fnc_hashCreate;
    _namespace setVariable ["AIGear_hash",_hash];
    TRACE_1("Initialized AIGear hash",_hash);
};

// Create class eventhandler
[
    "CAManBase",
    "initPost",
    compile format [
        '[FUNC(AIGearEH),[_this # 0,%1,%2]] call CBA_fnc_execNextFrame',
        str _faction,
        str _loadout
    ],
    true,
    [],
    _retroactive
] call CBA_fnc_addClassEventHandler;

TRACE_3("Initialized AIGear",_faction,_loadout,_retroactive);

nil
