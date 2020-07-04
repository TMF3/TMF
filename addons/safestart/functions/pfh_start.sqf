#include "\x\tmf\addons\safeStart\script_component.hpp"

// Set timer variable
_this setVariable ["timer", _this getVariable ["params", -1]];

player allowDamage false;
ace_advanced_throwing_enabled = false;

// Edge case
if (isNil QGVAR(ace_throwing_setting_eh)) then {
    GVAR(ace_throwing_setting_eh) = ["CBA_SettingChanged", {
        params ["_setting", "_value"];
        if (_setting == "ace_advanced_throwing_enabled") then {
            GVAR(ace_throwing) = _value;
            if ([] call FUNC(isActive)) then {
                ace_advanced_throwing_enabled = false;
            };
        };
    }] call CBA_fnc_addEventHandler;
};

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
