#include "\x\tmf\addons\common\script_component.hpp"
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

if (missionNamespace getVariable [QGVAR(ending),false]) exitWith {}; // Already trying to end.

// Message admins
private _message = format["[TMF] Ending mission..."];
[_message,'tac1_admin_fnc_messageAdmin',true] call BIS_fnc_MP;

GVAR(endMissionWait) = -1;
GVAR(ending) = true;

if (!isNil "ocap_fnc_exportData") then {
    _message = format["[TMF] OCAP detected exporting (10 second timeout)..."];
    [_message,'tac1_admin_fnc_messageAdmin',true] call BIS_fnc_MP;

    GVAR(endMissionWait) = time + 10; //Give OCAP 10 seconds.

    // Start in own 'thread'
    [] spawn {
         {
            [] call ocap_fnc_exportData;
            private _message = format["[TMF] OCAP Export complete. Ending..."];
            [_message,'tac1_admin_fnc_messageAdmin',true] call BIS_fnc_MP;
            GVAR(endMissionWait) = -1;
         } call CBA_fnc_directCall;
    };


};

// End Mission.

//TODO - Replace with our own splashscreen
//[endName,isVictory,fadeType,playMusic,completeTasks] spawn BIS_fnc_endMission;
[{time > GVAR(endMissionWait)},{
    [(_this select 0),'BIS_fnc_endMission',true] call BIS_fnc_MP; // End the mission for everyone.
}, [_this]] call CBA_fnc_waitUntilAndExecute;
