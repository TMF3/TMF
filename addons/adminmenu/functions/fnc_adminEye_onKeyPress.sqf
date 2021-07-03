#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;

params["","_type"];
//20 = T Key
if (_type == 20) then {
    if (isNull GVAR(adminEyeSelectedObj)) then {
        hint "Nothing selected to Trigger";

    } else {
        if (typeOf GVAR(adminEyeSelectedObj) == "tmf_ai_wavespawn") then {
            // Wave spawner trigger.
            TRACE_1("Admin Eye triggered wave", GVAR(adminEyeSelectedObj));
            [{
                params ["_waveSpawner"];
                [_waveSpawner] remoteExecCall [QEFUNC(ai,spawnWave), _waveSpawner];
            }, GVAR(adminEyeSelectedObj)] call CBA_fnc_execNextFrame;
        } else {
            private _trigger = GVAR(adminEyeSelectedObj);

            if (local _trigger) then {
                [_trigger] call FUNC(adminEye_fireTrigger);
            } else {
                [_trigger] remoteExecCall [QFUNC(adminEye_fireTrigger), 2];
            };
        };
    };
};


