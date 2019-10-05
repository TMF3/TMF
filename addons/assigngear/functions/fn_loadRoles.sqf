/*
 * Name = TMF_assignGear_fnc_loadRoles
 * Author = Head, Nick
 *
 * Arguments:
 * UI function do not use
 *
 * Return:
 * UI function do not use
 *
 * Description:
 * UI function do not use
 */
#include "\x\tmf\addons\assignGear\script_component.hpp"

private _selected = (get3DENSelected 'object' + get3DENSelected 'logic');
_selected params [["_unit",objNull]];


params ["_control","_value",["_faction",((_unit get3DENAttribute "TMF_assignGear_faction") select 0)]];

lbClear _control;
// Clear control



if (count _selected < 1) exitWith {DEBUG_ERR("No unit selected!")};

private _role = (_unit get3DENAttribute "TMF_assignGear_role") select 0;


private _classes = [];

//MissionConfigFile overrides.
call {
    if(isClass (missionConfigFile >> "CfgLoadouts" >> _faction)) exitWith {_classes = configProperties [missionConfigFile >> "CfgLoadouts" >> _faction,"isClass _x"];};
    if(isClass (configFile >> "CfgLoadouts" >> _faction)) exitWith {_classes = configProperties [configFile >> "CfgLoadouts" >> _faction,"isClass _x"];};
};

{
    if (configName _x != "AI") then // Skip AI macro
    {
        private _index = _control lbAdd getText(_x >> "displayName");
        _control lbSetData [_index,configName _x];
        _control lbSetTooltip [_index,getText(_x >> "tooltip")];
        if(configName _x == _role) then {_control lbSetCurSel _index};
    }
} forEach _classes;
