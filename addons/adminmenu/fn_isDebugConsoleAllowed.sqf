#include "\x\tmf\addons\adminmenu\script_component.hpp"

if (isServer || serverCommandAvailable "#kick") exitWith {true};

private _authorizedByUID = (getPlayerUID player) in (("true" configClasses (configFile >> QGVAR(authorized_players))) apply {getText (_x >> "uid")});
if (_authorizedByUID) exitWith {true};

private _enableDebugConsole = [
    "DebugConsole",
    getMissionConfigValue ["enableDebugConsole", 0]
] call (missionNamespace getVariable "BIS_fnc_getParamValue");
if (_enableDebugConsole isEqualTo 2) exitWith {true};

false
