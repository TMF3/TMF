/*
 * Name: TMF_ai_fnc_addWaveHandler
 * Author: Head
 *
 * Arguments:
 * 0: The wave spawner logic <OBJECT>
 * 1: Code to execute <CODE>
 *
 * Return:
 * None
 *
 * Description:
 * Adds an eventhandler to a wave spawner that execute everytime a wave is spawned.
 * Local execution only.
 */

params ["_logic","_code"];

private _handlers = _logic getVariable ["Handlers", []];
private _index = _handlers pushBack _code;
_logic setVariable ["Handlers", _handlers, false];

_index
