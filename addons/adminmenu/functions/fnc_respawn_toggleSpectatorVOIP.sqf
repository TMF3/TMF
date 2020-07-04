#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_display"];

if (isClass(configFile >> "CfgPatches" >> "acre_main")) then {
    private _isSpectator = [player] call acre_api_fnc_isSpectator;
    [!_isSpectator] call acre_api_fnc_setSpectator;
    if (_isSpectator) then {
        hint "ACRE: Spectator mode de-activated";  
    } else {
        hint "ACRE: Spectator mode activated";  
    };
};
