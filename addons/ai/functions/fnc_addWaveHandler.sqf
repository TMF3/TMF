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
 * Nothing
 *
 * Description:
 * Adds an eventhandler to a wave spawner that execute everytime a wave is spawned.
 */

params ["_logic","_code", ["_isGlobal",false]];

if (_isGlobal && !isRemoteExecuted) exitWith {
    [_logic,_code,false] remoteExecCall [QFUNC(addWaveHandler),0,true];
};

private _handlers = _logic getVariable ["Handlers", []];
_handlers pushBack _code;
_logic setVariable ["Handlers", _handlers, false];

nil
