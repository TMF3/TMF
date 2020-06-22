#include "\x\tmf\addons\adminmenu\script_component.hpp"
/*
 * Name: TMF_adminmenu_fnc_log
 * Author: Freddo
 *
 * Arguments:
 * 0: Logged message <String>
 * 2: Is warning <BOOL>
 *
 * Return:
 * None
 *
 * Description:
 * Logs a message to registered admins, visible in the admin menu.
 */

// TODO: Move to PREPMAIN(log)

params [
    ["_message","",[""]],
    ["_isWarning",false,[false]]
];

[QGVAR(serverLog),[CBA_missionTime,_message,_isWarning]] call CBA_fnc_serverEvent;
LOG_2("Sent log message to admins: ""%1"" isWarning: %2",_message,_isWarning)
