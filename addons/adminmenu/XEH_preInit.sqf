#include "\x\tmf\addons\adminmenu\script_component.hpp"

#include "initSettings.sqf"

GVAR(listEntries) = [];

[ // Handle new log messages
    QGVAR(log),
    {
        // params ["_time","_text","_isWarning"]
        GVAR(listEntries) pushBack _this;
        GVAR(listEntries) sort true;
        TRACE_1("Received log message", _this);

        // See settings
        if (GVAR(printToChat) isEqualTo 2 || {GVAR(printToChat) == 1 && {_this # 2}}) then {
            private _warning = if (_this # 2) then [{"[WARNING] "},{""}];
            systemChat (_warning + (_this # 1));
        };
    }
] call CBA_fnc_addEventHandler;

if (isServer) then {
    [ // Emit new log messages to admins
        QGVAR(serverLog),
        {
            private _targets = (allPlayers select {[_x] call FUNC(isAuthorized)});

            [QGVAR(log),_this,_targets] call CBA_fnc_targetEvent;

            TRACE_2("Broadcasted log message",_this,_targets);
        }
    ] call CBA_fnc_addEventHandler;
};
