#include "\x\tmf\addons\safeStart\script_component.hpp"

params [["_duration", -1]];

// https://cbateam.github.io/CBA_A3/docs/files/common/fnc_createPerFrameHandlerObject-sqf.html
#define TIMER (_this getVariable ["timer",-1])
private _logic = [
    /* Function executed every cycle */
    {
        if (TIMER > 0) then {
            // Update timer
            private _text = "SAFESTART " + ([TIMER - CBA_missionTime, "MM:SS"] call BIS_fnc_secondsToString);
            _textCtrl ctrlSetText _text;
            TRACE_1("Safestart Active, time remaining", TIMER - CBA_missionTime);
        } else {
            // Indefinite timer
            if !(ctrlText _textCtrl isEqualTo "SAFESTART ACTIVE") then {
                _textCtrl ctrlSetText "SAFESTART ACTIVE";
            };
        };
    },
    /* Delay is seconds between executions */
    1,
    /* Parameters stored in _this getVariable "params" */
    [_duration],
    /* Function executed when PFH is created */
    {
        // Set timer variable
        _this setVariable ["timer", (_this getVariable ["params", [-1]]) select 0];

        // Handle player
        player allowDamage false;
        ace_advanced_throwing_enabled = false;
        DIALOG_IDD cutRsc [QGVAR(dialog),"PLAIN"];
        _textCtrl = (uiNamespace getVariable [QGVAR(display),displayNull]) displayCtrl 101;
        // Disable left click
        _playerAction = [
            [
                "",
                {5412 cutRsc [QGVAR(refusefire),"PLAIN"]; },
                "",
                0,
                false,
                true,
                "DefaultAction",
                "true"
            ]
        ] call CBA_fnc_addPlayerAction;
        // Delete fired projectiles
        _firedEH = player addEventHandler ["fired",{
            deleteVehicle (_this select 6);
            if((_this select 1) == "Throw") then {
                player addMagazine (_this select 5);

                5412 cutRsc [QGVAR(refusefire),"PLAIN"];
            };
        }];

        // Handle AI
        {
            private _eh = _x addEventHandler ["fired",{deleteVehicle (_this select 6)}];
            _x setVariable [QGVAR(aiEH), _eh, true];
            _x disableAI "TARGET";
            _x disableAI "AUTOTARGET";
            _x allowDamage false;
        } forEach (allUnits select {local _x && !isPlayer _x});

        [QGVAR(started)] call CBA_fnc_localEvent;
    },
    /* Function executed when PFH is deleted */
    {
        INFO_1("Safestart Ended, Mission time: %1", CBA_missionTime);

        // Handle AI
        {
            TRACE_1("Reenabled AI", _x);
            private _EH = _x getVariable [QGVAR(aiEH),-1];
            _x removeEventHandler ["fired",_EH];
            _x enableAI "TARGET";
            _x enableAI "AUTOTARGET";
            _x allowDamage true;
        } forEach (allUnits select {local _x && !isPlayer _x});

        // Handle player
        player removeEventHandler ["fired",_firedEH];
        [_playerAction] call CBA_fnc_removePlayerAction;
        player allowDamage true;
        ace_advanced_throwing_enabled = true;
        LOG("Reenabled Player");

        // Hide text
        DIALOG_IDD cutFadeOut 0;
        DIALOG_IDD cutFadeOut 1;

        ADDON = nil;

        // End safestart locally
        [QGVAR(ended)] call CBA_fnc_localEvent;
    },
    /* Condition to run the PFH */
    {true},
    /* Condition to delete the PFH */
    {TIMER > 0 && CBA_missionTime > TIMER},
    /* Serialized local variables */
    ["_firedEH","_playerAction","_textCtrl"]
] call CBA_fnc_createPerFrameHandlerObject;

_logic
