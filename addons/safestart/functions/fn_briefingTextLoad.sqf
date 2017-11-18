#include "\x\tmf\addons\safeStart\script_component.hpp"

disableSerialization;

private _control = uiNamespace getVariable ['TMF_safestart_text',controlNull];

private _logics = (allMissionObjects "TMF_safestart_module") params [["_logic",objNull]];

//TODO - check if actually in units of module.

if (isNull _logic) exitWith {
    _control ctrlSetText "";
};

private _duration = _logic getVariable ["Duration",120];
private _minutes = floor (_duration / 60);
private _seconds = floor (_duration - (_minutes * 60));
if(_minutes < 10) then {_minutes = "0"+str _minutes }  else {_minutes = str _minutes};
if(_seconds < 10) then {_seconds = "0"+str _seconds} else {_seconds = str _seconds};

_control ctrlSetText (format ["SAFESTART %1:%2", _minutes,_seconds]);
