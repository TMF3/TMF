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

            [EFUNC(ai,spawnWave),[GVAR(adminEyeSelectedObj)]] call CBA_fnc_execNextFrame;

        } else {

            private _statements = triggerStatements GVAR(adminEyeSelectedObj);
            if (count _statements > 0) then { // isTrigger.
                [{
                    params ["_trigger"];
                    private _statements = triggerStatements _trigger;
                    
                    private _activation = triggerActivation _trigger;
                    _trigger setVariable ["tmf_trigger_serialised",[_statements,triggerTimeout _trigger, +_activation]];
                    
                    _activation set[2,false];
                    _trigger setTriggerActivation _activation;
                    _trigger setTriggerStatements ["true","[thisTrigger] call tmf_adminmenu_fnc_adminEye_restoreTrigger",""];
                }, [GVAR(adminEyeSelectedObj)]] call CBA_fnc_execNextFrame;
            };
        };
    };
};


