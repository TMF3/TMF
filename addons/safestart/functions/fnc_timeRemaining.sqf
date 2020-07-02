#include "\x\tmf\addons\safeStart\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: TMF_safestart_fnc_timeRemaining

Description:
    Returns how much time is remaining before safestart ends.

    * Consider calling <TMF_safestart_fnc_isActive> first

Returns:
    Time remaining in seconds [Number, default -1]

Examples:
    (begin example)
        _timeRemaining = [] call TMF_safestart_fnc_timeRemaining

        if (_timeRemaining < 5) then {systemChat "Less than 5 seconds left!"};
    (end)

Author:
    Freddo
---------------------------------------------------------------------------- */

if (isNil QGVAR(instance)) then [{-1}, {(GVAR(instance) getVariable ["timer", -1]) - CBA_missionTime}];
