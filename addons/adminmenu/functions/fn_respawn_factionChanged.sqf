#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_display"];

private _control = (_display displayCtrl IDC_TMF_ADMINMENU_RESP_FACTION);  /* Faction Control */
private _faction = _control lbData (lbCurSel _control);
GVAR(lastFactionSelection) set [1,lbCurSel _control];
private _classes = [];

//MissionConfigFile overrides.
call {
    if(isClass (missionConfigFile >> "CfgLoadouts" >> _faction)) exitWith {_classes = configProperties [missionConfigFile >> "CfgLoadouts" >> _faction,"isClass _x"];};
    if(isClass (configFile >> "CfgLoadouts" >> _faction) && count _classes <= 0) exitWith {_classes = configProperties [configFile >> "CfgLoadouts" >> _faction,"isClass _x"];};
};

private _control = (_display displayCtrl IDC_TMF_ADMINMENU_RESP_ROLECOMBO); /* Role control */ 
lbClear _control;
respawnMenuRoles = [];
{
    private _displayName = getText(_x >> "displayName");
    private _index = _control lbAdd _displayName;
    private _configName = (configName _x);
    respawnMenuRoles pushBack [_configName,_displayName];
    _control lbSetData [_index,_configName];
} forEach _classes;
if (count _classes > 0) then {
    _control lbSetCurSel 0;
};

GVAR(selectedRespawnGroup) = [];
[_display] call FUNC(respawn_refreshSpectatorList);
[_display] call FUNC(respawn_refreshGroupBox);

