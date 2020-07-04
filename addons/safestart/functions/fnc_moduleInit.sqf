#include "\x\tmf\addons\safeStart\script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: TMF_safestart_fnc_moduleInit

Description:
    Handles TMF_safestart_module initialization.

Parameters:
    _logic - Module object [Object]
    _units - Not used [Array, default []]
    _activated - Whether it was triggered [Boolean, default false]
Returns:
    nil

Examples:
    (begin example)
        function = "TMF_safestart_moduleInit";
    (end)

Author:
    Freddo
---------------------------------------------------------------------------- */
params ["_logic", ["_units", []], ["_activated", false]];

TRACE_1("Module init",_this);

if (_activated) then {
    private _duration = _logic getVariable ["Duration", -1];
    if (_duration > 0) then {
        _duration = _duration + CBA_missionTime;
    } else {
        _duration = -1;
    };

    LOG_1("Enabling safestart until %1",_duration);
    [_duration, true] call FUNC(set);

    deleteVehicle _logic;
};
