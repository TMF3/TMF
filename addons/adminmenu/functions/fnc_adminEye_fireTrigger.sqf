#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;

params ["_trigger"];

private _statements = triggerStatements _trigger;
if (count _statements > 0) then { // isTrigger.
    [{
        params ["_trigger"];
        TRACE_1("Admin Eye triggered trigger", _trigger);
        private _statements = triggerStatements _trigger;
        private _activation = triggerActivation _trigger;
        private _interval = triggerInterval _trigger;

        _trigger setVariable [QGVAR(serialised_trigger),[_statements,triggerTimeout _trigger, +_activation,_interval]];
        TRACE_4("Admin Eye serialised trigger",_statements,triggerTimeout _trigger,+_activation,_interval)

        _activation set[2,false];
        _trigger setTriggerActivation _activation;
        _trigger setTriggerTimeout [0,0,0,false];

        private _tempStatements = [
            "true",
            format [QUOTE(call {%1}; [thisTrigger] call FUNC(adminEye_restoreTrigger);), _statements # 1],
            _statements # 2
        ];
        _trigger setTriggerStatements _tempStatements;
        _trigger setTriggerInterval 0;
    }, [_trigger]] call CBA_fnc_execNextFrame;
};
