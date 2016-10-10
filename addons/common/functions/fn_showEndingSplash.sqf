#include "\x\tmf\addons\common\script_component.hpp"
if(!hasInterface) exitWith {};
params ["_endName",["_isVictory",true],["_fadeType", "PLAIN", [""]]];
showHUD false;
private _title = "";
private _subtitle = "";
private _set = false;
if(isClass (missionConfigFile >> "CfgDebriefing" >> _endName)) then {
    _title = getText (missionConfigFile >> "CfgDebriefing" >> _endName >> "title");
    _subtitle = getText (missionConfigFile >> "CfgDebriefing" >> _endName >> "subtitle");
    _set = true;
};
if(isClass (configFile >> "CfgDebriefing" >> _endName) && !_set) then {
    _title = getText (configFile >> "CfgDebriefing" >> _endName >> "title");
    _subtitle = getText (configFile >> "CfgDebriefing" >> _endName >> "subtitle");
};
if(!_set) then {
    if(_isVictory) then {
        _title = "Victory";
        _subtitle = "You have been victorious";
    }
    else {
        _title = "Failure";
        _subtitle = "You have lost";
    };
};

cutRsc [QGVAR(endSplash),_fadeType,1,true];
waitUntil {!isNull (uiNamespace getVariable [QGVAR(endSplash), displayNull])};
with uiNamespace do {
    (GVAR(endSplash) displayCtrl TMF_ENDMISSION_HEADER) ctrlSetText _title;
    (GVAR(endSplash) displayCtrl TMF_ENDMISSION_SUBTILE) ctrlSetText _subtitle;
};
waitUntil {!isNull ((uiNamespace getVariable [QGVAR(endSplash), displayNull]) displayCtrl TMF_ENDMISSION_BACK)};
[{
    _fade = (missionNamespace getVariable ["tmf_common_endSplash_fade", 0.1])+0.01;
    (uiNamespace getVariable ["tmf_common_endSplash",displayNull] displayCtrl 1516) ctrlSetBackgroundColor [0,0,0,_fade];
    missionNamespace setVariable ["tmf_common_endSplash_fade", _fade];
}, 0.1] call CBA_fnc_addPerFrameHandler;
