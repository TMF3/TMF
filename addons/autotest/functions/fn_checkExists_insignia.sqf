#include "\x\tmf\addons\autotest\script_component.hpp"

params ["_insignias","_faction","_role"];

private _output = [];

{
    if ((_x != "") and (_x != "default")) then {
        if !(isClass (configFile >> "CfgUnitInsignia" >> _x) || {isClass (missionConfigFile >> "CfgUnitInsignia" >> _x)}) then {
            _output pushBack [0,format["Missing insignia classname: %1 (for: %2 - %3)", _x,_faction,_role]];
        };
    };
} forEach _insignias;

_output
