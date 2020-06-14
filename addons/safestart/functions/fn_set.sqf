#include "\x\tmf\addons\safeStart\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: TMF_safestart_fnc_set

Description:
    Sets safestart to target time, and initializes it
    if not previously initialized.
    Counts towards CBA_missionTime, for unified time.

Parameters:
    _duration - Target time. <= 0 for infinite [Number, defaults to -1]
    _isGlobal - Whether to broadcast globally [Boolean, defaults to false]

Returns:
    nil

Examples:
    (begin example)
        [CBA_missionTime + 50, true] call TMF_safestart_fnc_set;
    (end)

Author:
    Freddo
---------------------------------------------------------------------------- */
params [["_duration", -1],["_isGlobal",false]];

if (_isGlobal) exitWith {
    [_duration, false] remoteExecCall [QFUNC(set),0,'ADDON'];
};

if (isNil QGVAR(instance)) then {
    GVAR(instance) = [_duration] call FUNC(init);
} else {
    GVAR(instance) setVariable ["timer", _duration];
};

LOG_1("SafeStart set to %1", _duration);

nil
