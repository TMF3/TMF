#include "\x\tmf\addons\adminmenu\script_component.hpp"

[ // Emit new log messages to admins
    QGVAR(serverLog),
    {
        private _targets = (allPlayers select {[_x, "logs"] call FUNC(isAuthorized)});
        if (isServer && !hasInterface) then {
            GVAR(logEntries) pushBack _this;
            GVAR(logEntries) sort true;
            TRACE_1("Received log message", _this);
        };

        [QGVAR(log),_this,_targets] call CBA_fnc_targetEvent;

        TRACE_2("Broadcasted log message",_this,_targets);
    }
] call CBA_fnc_addEventHandler;

[ // Resync log
    QGVAR(resyncLog),
    {
        _this publicVariableClient QGVAR(logEntries);

        LOG_1("Resynchronized server log to client %1",_this);
    }
] call CBA_fnc_addEventHandler;
