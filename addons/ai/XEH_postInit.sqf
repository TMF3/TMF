#include "\x\tmf\addons\ai\script_component.hpp"
// Intended for Server and HCs.

if (hasInterface) exitWith {};

// Hotfix for: DisableAi not being populated everywhere.
["CAManBase", "init", {
    (_this select 0) addEventHandler ["Local",{
        params ["_entity", "_isLocal"];
        if (_isLocal && {(group _entity) getVariable [QGVAR(garrisonGroup),false]}) then {
            _entity disableAI "Path";
            _entity setUnitPos "UP";
        };
    }];
},true,[],true] call CBA_fnc_addClassEventHandler;
