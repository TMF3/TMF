#include "\x\tmf\addons\AI\script_component.hpp"
/*
 * Name: TMF_ai_fnc_addWaveHandler
 * Author: Head
 *
 * Arguments:
 * 0: The wave spawner logic <OBJECT>
 * 1: Code to execute <CODE>
 * 2: Global effect <BOOL>
 *
 * Return:
 * Event handler ID or nil if executed globally
 *
 * Description:
 * Adds an eventhandler to a wave spawner that execute everytime a wave is spawned.
 */

params ["_logic","_code", ["_isGlobal",false]];
TRACE_3("Adding wavehandler",_logic,_code,_isGlobal);

if (_isGlobal && !isRemoteExecuted && isMultiplayer) then {
    // Remote exec to everyone but the client
    _this remoteExecCall [QFUNC(addWaveHandler),-clientOwner,true];
};

private _handlers = _logic getVariable ["Handlers", []];
private _index = _handlers pushBack _code;
_logic setVariable ["Handlers", _handlers, false];

// Return nil when executed globally,
// as order cannot be ensured to be the same
if !(_isGlobal) then {
    _index
} else {
    nil
}
