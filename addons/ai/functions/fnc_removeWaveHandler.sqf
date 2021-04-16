#include "\x\tmf\addons\ai\script_component.hpp"
/*
 * Name: TMF_ai_fnc_removeWaveHandler
 * Author: Head
 *
 * Arguments:
 * 0: The wave spawner logic <OBJECT>
 * 1: Event handler ID
 *
 * Return:
 * Boolean, true if successfully removed.
 *
 * Description:
 * Removes a wave spawner handle from an wave spawner
 * Local only.
 */

params ["_logic","_index"];

TRACE_2("Removing wavehandler",_logic,_index);
private _handlers = _logic getVariable ["Handlers", []];

if (isNil {_handlers # _index}) exitWith {
    WARNING_2("Failed removing wavehandler from %1 with ID %2",_logic,_index);
    false
};

_handlers set [_index,nil];

true
