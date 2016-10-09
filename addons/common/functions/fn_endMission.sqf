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


if (isServer) then {
    if (!isNil "ocap_fnc_exportData") then {
        [] call ocap_fnc_exportData;
    };
};

//TODO - Replace with our own splashscreen
//[endName,isVictory,fadeType,playMusic,completeTasks] spawn BIS_fnc_endMission;
_this spawn BIS_fnc_endMission;

