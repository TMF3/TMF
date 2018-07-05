#include "\x\tmf\addons\safeStart\script_component.hpp"

params ["_logic","_duration"];

player allowDamage false;
// disable ace throwing!
ace_advanced_throwing_enabled = false;

// Add action to hijack shooting!
private _action = player addAction ["", {playSound3D ['a3\sounds_f\weapons\Other\dry9.wss', _this select 0]; 5412 cutRsc [QGVAR(refusefire),"PLAIN"]; }, "", 0, false, true, "DefaultAction", "true"];

// show safestart indicator
DIALOG_IDD cutRsc [QGVAR(dialog),"PLAIN"];

// EH code
_code = {
  deleteVehicle (_this select 6);
  if((_this select 1) == "Throw") then {
    player addMagazine (_this select 5);
    playSound3D ['a3\sounds_f\weapons\Other\dry9.wss', _this select 0];
    5412 cutRsc [QGVAR(refusefire),"PLAIN"];
  };
};

// Add EH
_eh = player addEventHandler ["fired",_code];

// save to player object
player setVariable [QGVAR(firedEH),_eh];
player setVariable [QGVAR(disableAction),_action];
player setVariable[QGVAR(duration),_duration];
if(_duration > 0) then {
    _condition = {
        params ["_params","_handle"];
        _params params ["_logic"];
        _duration = player getVariable [QGVAR(duration),-1];
        if(_duration > 0) then {
            _duration = _duration - 1;
            player setVariable [QGVAR(duration),_duration];
            private _minutes = floor (_duration / 60);
            private _seconds = floor (_duration - (_minutes * 60));
            if(_minutes < 10) then {_minutes = "0"+str _minutes }  else {_minutes = str _minutes};
            if(_seconds <10) then {_seconds = "0"+str _seconds} else {_seconds = str _seconds};
            ((uiNamespace getVariable [QGVAR(display),displayNull]) displayCtrl 101) ctrlSetText (format ["SAFESTART %1:%2", _minutes,_seconds]);
        };
        if(_duration <= 0 || !(_logic getVariable [QGVAR(enabled),false])) then {
            [_handle] call CBA_fnc_removePerFrameHandler;
            [] call FUNC(playerEnd);
        };
    };
    [_condition,1,[_logic]] call CBA_fnc_addPerFrameHandler;
} else {
    [{ !((_this select 0) getVariable [QGVAR(enabled),false]) },{[] call FUNC(playerEnd)},[_logic]] call CBA_fnc_waitUntilAndExecute;
};