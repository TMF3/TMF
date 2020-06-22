#include "\x\tmf\addons\adminmenu\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: TMF_adminmenu_fnc_log

Description:
    Logs a message to registered admins, visible in the admin menu.

Parameters:
    _message - Message to be displayed [String or format array]
    _isWarning - Whether to display as warning [Bool]
    _tag - Tag that message will be prefixed with [String, defaults to "[TMF Log]"]

Returns:
    Nil

Examples:
    (begin example)
        ["Everything is on fire!",true,"[TMF Firealarm]"] call TMF_adminmenu_fnc_log;
    (end)
    (begin example)
        [format ["%1 did something",profileName]] call TMF_adminmenu_fnc_log;
    (end)

Author:
    Freddo
---------------------------------------------------------------------------- */
// TODO: Move to PREPMAIN(log)

params [
    ["_message","",["",[]]],
    ["_isWarning",false,[false]],
    ["_tag","[TMF Log] ",[""]]
];

if IS_ARRAY(_message) then {_message = format _message};

[QGVAR(serverLog),[CBA_missionTime,_tag + _message,_isWarning]] call CBA_fnc_serverEvent;
LOG_2("Sent log message to admins: ""%1"" isWarning: %2",_message,_isWarning)
