params ["_duration"];
_duration = _duration - time;
#include "\x\tmf\addons\safeStart\script_component.hpp"
ace_advanced_throwing_enabled = false;
private _action = player addAction ["", {playSound3D ['a3\sounds_f\weapons\Other\dry9.wss', _this select 0]; 5412 cutRsc [QGVAR(refusefire),"PLAIN"]; }, "", 0, false, true, "DefaultAction", "true"];
5413 cutRsc [QGVAR(dialog),"PLAIN"];
_eh = player addEventHandler ["fired",{
  deleteVehicle (_this select 6);
  if((_this select 1) == "Throw") then {
    player addMagazine (_this select 5);
    playSound3D ['a3\sounds_f\weapons\Other\dry9.wss', _this select 0];
    5412 cutRsc [QGVAR(refusefire),"PLAIN"];
  };
  }];
while {_duration > 0} do {
    uiSleep 1;
    _duration = _duration - 1;
    if(_action >= 0) then {
    private _minutes = floor (_duration / 60);
    private _seconds = floor (_duration - (_minutes * 60));
    if(_minutes < 10) then {_minutes = "0"+str _minutes }  else {_minutes = str _minutes};
    if(_seconds <10) then {_seconds = "0"+str _seconds} else {_seconds = str _seconds};
      ((uiNamespace getVariable [QGVAR(display),displayNull]) displayCtrl 101) ctrlSetText (format ["SAFESTART %1:%2", _minutes,_seconds]);
  };
};
player removeEventHandler ["fired",_eh];
ace_advanced_throwing_enabled = true;
player removeAction _action;
5412 cutFadeOut 0;
5413 cutFadeOut 1;
