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
            if (GVAR(soundEnabled) && TIMER - CBA_missionTime <= 4) then {
                playSound "FD_Timer_F";
            };
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
        private _fn_leftClick = {
            LOG("Attempted for fire during safestart");
            5412 cutRsc [QGVAR(refusefire),"PLAIN"];
            if (GVAR(triggerSound)) then {
                playSound3D ['a3\sounds_f\weapons\Other\dry9.wss', _this select 0];
            };
        };
        if !(isNil "ace_interaction_fnc_showMouseHint") then {
            // Use ACE function
            _playerAction = [
                player,
                "DefaultAction",
                {isNull (uiNamespace getVariable ["ace_interaction_mouseHint", displayNull])},
                _fn_leftClick
            ] call ace_common_fnc_addActionEventHandler;
        } else {
            // Use CBA function
            _playerAction = [
                [
                    "",
                    _fn_leftClick,
                    "",
                    0,
                    false,
                    true,
                    "DefaultAction",
                    "true"
                ]
            ] call CBA_fnc_addPlayerAction;
        };

        // Delete fired projectiles
        _firedEH = player addEventHandler ["fired",{
            deleteVehicle (_this select 6);
            if((_this select 1) == "Throw") then {
                LOG("Attempted to throw grenade during safestart");
                player addMagazine (_this select 5);

                5412 cutRsc [QGVAR(refusefire),"PLAIN"];

                if (GVAR(triggerSound)) then {
                    playSound3D ['a3\sounds_f\weapons\Other\dry9.wss', _this select 0];
                };
            };
        }];

        // Handle AI
        if (GVAR(handleAI)) then {
            {
                private _eh = _x addEventHandler ["fired",{deleteVehicle (_this select 6)}];
                _x setVariable [QGVAR(aiEH), _eh, true];
                _x disableAI "TARGET";
                _x disableAI "AUTOTARGET";
                _x allowDamage false;
            } forEach (allUnits select {local _x && !isPlayer _x});
        };

        [QGVAR(started)] call CBA_fnc_localEvent;
    },
    /* Function executed when PFH is deleted */
    {
        INFO_1("Safestart Ended, Mission time: %1", CBA_missionTime);

        // Handle AI
        if (GVAR(handleAI)) then {
            {
                TRACE_1("Reenabled AI", _x);
                private _EH = _x getVariable [QGVAR(aiEH),-1];
                _x removeEventHandler ["fired",_EH];
                _x enableAI "TARGET";
                _x enableAI "AUTOTARGET";
                _x allowDamage true;
            } forEach (allUnits select {local _x && !isPlayer _x});
        };

        // Handle player
        player removeEventHandler ["fired",_firedEH];
        if !(isNil "ace_interaction_fnc_showMouseHint") then {
            [player,"DefaultAction",_playerAction] call ace_common_fnc_removeActionEventHandler;
        } else {
            [_playerAction] call CBA_fnc_removePlayerAction;
        };
        player allowDamage true;
        ace_advanced_throwing_enabled = true;
        LOG("Reenabled Player");

        // Hide text
        DIALOG_IDD cutFadeOut 0;
        DIALOG_IDD cutFadeOut 1;

        ADDON = nil;

        if (GVAR(soundEnabled)) then {playSound "FD_Finish_F"};

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
