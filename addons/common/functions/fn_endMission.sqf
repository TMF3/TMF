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
 * Function to gracefully end the mission and display the end mission splash screen.
 * 
 */

if (!isServer) exitWith {}; // Only run on server.

// Message admins
private _message = format["[TMF] Ending mission..."];
[_message,'tac1_admin_fnc_messageAdmin',true] call BIS_fnc_MP;

if (!isNil "ocap_fnc_exportData") then {
    _message = format["[TMF] OCAP detected exporting..."];
    [_message,'tac1_admin_fnc_messageAdmin',true] call BIS_fnc_MP;

    [] call ocap_fnc_exportData;

    _message = format["[TMF] OCAP Export complete."];
    [_message,'tac1_admin_fnc_messageAdmin',true] call BIS_fnc_MP;
};



// End Mission.

//TODO - Replace with our own splashscreen
//[endName,isVictory,fadeType,playMusic,completeTasks] spawn BIS_fnc_endMission;

[_this,'BIS_fnc_endMission',true] call BIS_fnc_MP; // End the mission for everyone.

