#include "\x\tmf\addons\adminmenu\script_component.hpp"

#include "initSettings.sqf"

GVAR(logEntries) = [];

[ // Handle new log messages
    QGVAR(log),
    {
        // params ["_time","_text","_isWarning"]
        GVAR(logEntries) pushBack _this;
        GVAR(logEntries) sort true;
        TRACE_1("Received log message", _this);

        // See settings
        if (GVAR(printToChat) isEqualTo 2 || {GVAR(printToChat) == 1 && {_this # 2}}) then {
            private _warning = if (_this # 2) then [{"[WARNING] "},{""}];
            systemChat (_warning + (_this # 1));
        };
    }
] call CBA_fnc_addEventHandler;