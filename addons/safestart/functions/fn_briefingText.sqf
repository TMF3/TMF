#include "\x\tmf\addons\safeStart\script_component.hpp"

disableSerialization;

TRACE_1("Briefing Text onLoad", _this);

params [["_ctrl", controlNull]];

[
    {
        [] call FUNC(isActive) && time <= 0
    },
    {
        private _time = [] call FUNC(timeRemaining);
        if (_time > 0) then {
            _this ctrlSetText "SAFESTART " + ([_time, "MM:SS"] call BIS_fnc_secondsToString);
            TRACE_1("Timer set", _time);
        } else {
            _this ctrlSetText "SAFESTART ACTIVE";
            TRACE_1("Indefinite Timer Set", _time);
        };
    },
    _ctrl
] call CBA_fnc_waitUntilAndExecute;
