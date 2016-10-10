/*
 * Name: TMF_common_fnc_endMission
 * Author: Snippers
 *
 * Arguments:
 * See - https://community.bistudio.com/wiki/BIS_fnc_endMission
 *
 * Return:
 * nil
 *
 * Description:
 * Function to gracefull end mission and display splash screen.
 *
 */
params ["_endName",["_isVictory",true],["_fadeType", "PLAIN", [""]],["_playMusic", true, [false]],"_completeTask"];
#include "\x\tmf\addons\common\script_component.hpp"
if(!isServer) exitwith {};
if (!isNil "ocap_fnc_exportData") then {
    [] call ocap_fnc_exportData;
};
[_endName,_isVictory,_fadeType] remoteExec [QFUNC(showEndingSplash), 0];
[{
    [[],[_this select 0]] remoteExec ["endMission",0];
},[_endName],10] call CBA_fnc_waitAndExecute;
