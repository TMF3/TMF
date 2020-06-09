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
    if (_duration isEqualTo 0) exitWith {
        [] call FUNC(end);
    };
    if (_duration > 0) then {
        ADD(_duration,CBA_missionTime);
    };

    LOG_1("Enabling safestart until %1",_duration);
    [_duration, true] call FUNC(set);

    deleteVehicle _logic;
};
