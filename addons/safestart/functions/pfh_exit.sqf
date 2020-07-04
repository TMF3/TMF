#include "\x\tmf\addons\safeStart\script_component.hpp"

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
ace_advanced_throwing_enabled = GVAR(ace_throwing);
LOG("Reenabled Player");

// Hide safestart text
DIALOG_IDD cutFadeOut 0;
DIALOG_IDD cutFadeOut 1;

GVAR(instance) = nil; // Undefine safestart PFH object

if (GVAR(soundEnabled)) then {playSound "FD_Finish_F"}; // Play start sound

// End safestart locally
[QGVAR(ended)] call CBA_fnc_localEvent;
