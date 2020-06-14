#include "\x\tmf\addons\safeStart\script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: TMF_safestart_fnc_init

Description:
    Initializes Safestart CBA perFrameHandler object.

Parameters:
    _duration - Target time before ending safestart. <= 0 for infinite [Number, default -1]

Returns:
    Created CBA perFrameHandler object [Namespace]

Examples:
    (begin example)
        TMF_safestart = [CBA_missionTime + 50] call TMF_safestart_fnc_init;
    (end)

Author:
    Freddo
---------------------------------------------------------------------------- */
params [["_duration", -1]];

// https://cbateam.github.io/CBA_A3/docs/files/common/fnc_createPerFrameHandlerObject-sqf.html
#define TIMER (_this getVariable ["timer",-1])
private _logic = [
    /*
        This code will execute every cycle.
        _textCtrl is a listed in the serialized variables array
        at the bottom, which means that it is a local variable
        that will be stored between runs.
    */
    {
        if (TIMER > 0) then {
            // Timer is counting down
            private _text = "SAFESTART " + ([TIMER - CBA_missionTime, "MM:SS"] call BIS_fnc_secondsToString);
            _textCtrl ctrlSetText _text;

            // Play ticks for the final countdown
            if (GVAR(soundEnabled) && TIMER - CBA_missionTime <= 4) then {
                playSound "FD_Timer_F";
            };
        } else {
            // Timer is set to infinite
            if !(ctrlText _textCtrl isEqualTo "SAFESTART ACTIVE") then {
                _textCtrl ctrlSetText "SAFESTART ACTIVE";
            };
        };
    },
    /*
        Delay in seconds between executions
    */
    1,
    /*
        Parameters stored in _this getVariable "params"
        Used to set the initial timer below
    */
    _duration,
    /*
        This code will execute once, to initialize the safestart PFH and variables.
    */
    {
        // Set timer variable
        _this setVariable ["timer", _this getVariable ["params", -1]];

        // Disable damage and ACE throwing
        player allowDamage false;
        ace_advanced_throwing_enabled = false;

        // Show Safestart text
        DIALOG_IDD cutRsc [QGVAR(dialog),"PLAIN"];
        _textCtrl = (uiNamespace getVariable [QGVAR(display),displayNull]) displayCtrl 101; // This variable is serialized

        // Disable left click
        private _fn_leftClick = {
            LOG("Attempted for fire during safestart");
            5412 cutRsc [QGVAR(refusefire),"PLAIN"];
            if (GVAR(triggerSound)) then {
                playSound3D ['a3\sounds_f\weapons\Other\dry9.wss', _this select 0];
            };
        };
        if !(isNil "ace_interaction_fnc_showMouseHint") then {

            // Use ACE function, as it otherwise collides with
            // ACE dragging, fortify, placing explosives, etc.
            _playerAction = [ // This variable is serialized
                player,
                "DefaultAction",
                // Only disable left click while the ACE mouse hint isn't visible
                {isNull (uiNamespace getVariable ["ace_interaction_mouseHint", displayNull])},
                _fn_leftClick
            ] call ace_common_fnc_addActionEventHandler;
        } else {

            // ACE not present, register as a CBA player action instead
            _playerAction = [ // This variable is serialized
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

        // In case the above fails or the user throws a grenade
        // Delete the projectile
        _firedEH = player addEventHandler ["fired",{ // This variable in serialized
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

        // Disable AI targetting and damage on local units
        if (GVAR(handleAI)) then {
            {
                private _eh = _x addEventHandler ["fired",{deleteVehicle (_this select 6)}];
                _x setVariable [QGVAR(aiEH), _eh, true]; // Broadcasted in case AI ownership is transferred.
                _x disableAI "TARGET";
                _x disableAI "AUTOTARGET";
                _x allowDamage false;
            } forEach (allUnits select {local _x && !isPlayer _x});
        };

        [QGVAR(started)] call CBA_fnc_localEvent;
    },
    /*
        This code will execute once, when the PFH object is deleted via
        <CBA_fnc_removePlayerAction>, or the deletion condition is true,
        see below.
    */
    {
        INFO_1("Safestart Ended, Mission time: %1", CBA_missionTime);

        // Reenable AI targetting and damage on local units
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

        // Remove fired eventhandler, left click action
        player removeEventHandler ["fired",_firedEH];
        if !(isNil "ace_interaction_fnc_showMouseHint") then {
            [player,"DefaultAction",_playerAction] call ace_common_fnc_removeActionEventHandler;
        } else {
            [_playerAction] call CBA_fnc_removePlayerAction;
        };
        // Reenable player damage, ACE throwing.
        player allowDamage true;
        ace_advanced_throwing_enabled = true;
        LOG("Reenabled Player");

        // Hide safestart text
        DIALOG_IDD cutFadeOut 0;
        DIALOG_IDD cutFadeOut 1;

        GVAR(instance) = nil; // Undefine safestart PFH object

        if (GVAR(soundEnabled)) then {playSound "FD_Finish_F"}; // Play start sound

        // End safestart locally
        [QGVAR(ended)] call CBA_fnc_localEvent;
    },
    /*
        Condition to run the PFH.
        In this case, always true.
    */
    {true},
    /*
        Condition to delete the PFH.
        When this is true the PFH object will be deleted
        and the deletion code will be executed.
    */
    {TIMER > 0 && CBA_missionTime > TIMER},
    /*
        Serialized local variables
        These variables will be serialized and deserialized between runs
        allowing local variables to be used.
    */
    ["_firedEH","_playerAction","_textCtrl"]
] call CBA_fnc_createPerFrameHandlerObject;

_logic
