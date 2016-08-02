#include "\x\tmf\addons\autotest\script_component.hpp"

private _output = [];

// Check if endings are set.

private _i = 0;
private _config = missionConfigFile >> "CfgDebriefing";
private _count = count _config;

if (_count != 3) exitWith {}; //default template

while {_i < _count} do {
    if (configName (_config select _i) == "CustomEnding1") exitWith {
        _output pushBack [1,"CustomEnding1 is still present. Mission endings are probably not configured."];  
    };
    _i = _i + 1;
};

_output;