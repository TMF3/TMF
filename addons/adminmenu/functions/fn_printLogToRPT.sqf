#include "\x\tmf\addons\adminmenu\script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: TMF_adminmenu_fnc_printLogToRPT

Description:
    Prints current admin log to RPT

Examples:
    (begin example)
        [] call TMF_adminmenu_fnc_printLogToRPT;
    (end)

Author:
    Freddo
---------------------------------------------------------------------------- */

diag_log "[TMF Adminmenu] Printing complete log to RPT";

{
    _x params [
        ["_time",CBA_missionTime,[-1]],
        ["_text","",[""]],
        ["_isWarning",false,[false]]
    ];

    private _text = format ["[%1]: %2", [_time,"MM:SS"] call BIS_fnc_secondsToString, _text];
    private _warning = if (_isWarning) then [{"[WARNING] "},{""}];
    diag_log (_warning + _text);
} forEach GVAR(listEntries);

diag_log "[TMF Adminmenu] Log end";
