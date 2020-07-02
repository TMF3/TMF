#include "\x\tmf\addons\adminmenu\script_component.hpp"

#include "initSettings.sqf"

GVAR(logEntries) = [];

[ // Handle new log messages
    QGVAR(log),
    {
        params [
            ["_time", CBA_missionTime, [-1]],
            ["_text","",[""]],
            ["_isWarning",false,[false]]
        ];
        GVAR(logEntries) pushBack _this;
        GVAR(logEntries) sort true;
        TRACE_3("Received log message",_time,_text,_isWarning);

        // See settings
        if (GVAR(printToChat) isEqualTo 2 || {GVAR(printToChat) == 1 && {_isWarning}}) then {
            private _warning = if (_isWarning) then [{"[WARNING] "},{""}];
            systemChat (_warning + _text);
        };
    }
] call CBA_fnc_addEventHandler;
