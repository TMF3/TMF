#include "\x\tmf\addons\adminmenu\script_component.hpp"

private _enableDebugConsole =
// 0 - not allowed
// 1 - allowed for server host and logged in admin
// 2 - allowed always
[
    "DebugConsole",
    getMissionConfigValue ["enableDebugConsole", 0]
]
call (missionNamespace getVariable "BIS_fnc_getParamValue");

// IN ANY MODE
if (_enableDebugConsole isEqualTo 2 || isServer) exitWith {true};

if ((getPlayerUID player) in (getArray (configFile >> QGVAR(authorized_uids))) || serverCommandAvailable "#kick") exitWith {true};

false
