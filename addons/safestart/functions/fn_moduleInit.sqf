#include "\x\tmf\addons\safeStart\script_component.hpp"

params ["_logic", ["_units", []], ["_activated", false]];

TRACE_1("Module init",_this);

if (_activated) then {
    private _duration = _logic getVariable ["Duration", -1];
    if (_duration > 0) then {
        ADD(_duration,CBA_missionTime);
    };

    LOG_1("Enabling safestart until %1",_duration);
    [_duration, true] call FUNC(set);

    deleteVehicle _logic;
};
