#include "\x\tmf\addons\safeStart\script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: TMF_safestart_fnc_init

Description:
    Initializes Safestart CBA perFrameHandler object.

Parameters:
    _duration - Target time before ending safestart. <= 0 for infinite [Number, default -1]

Returns:
    Created CBA perFrameHandler object [Namespace]

Examples:
    (begin example)
        TMF_safestart = [CBA_missionTime + 50] call TMF_safestart_fnc_init;
    (end)

Author:
    Freddo
---------------------------------------------------------------------------- */
params [["_duration", -1]];

private _serializedVariables = ["_firedEH","_playerAction","_textCtrl"];
private _args = _duration;
private _delay = 1;
private _startCode = COMPILE_FILE(functions\pfh_start);
private _runCondition = {true};
private _perframeCode = COMPILE_FILE(functions\pfh_perframe);
private _exitCondition = {TIMER > 0 && CBA_missionTime > TIMER};
private _exitCode = COMPILE_FILE(functions\pfh_exit);

// https://cbateam.github.io/CBA_A3/docs/files/common/fnc_createPerFrameHandlerObject-sqf.html
private _logic = [
    _perframeCode,
    _delay,
    _args,
    _startCode,
    _exitCode,
    _runCondition,
    _exitCondition,
    _serializedVariables
] call CBA_fnc_createPerFrameHandlerObject;

_logic
