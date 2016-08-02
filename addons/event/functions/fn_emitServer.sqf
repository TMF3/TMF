/*
 * Name = TMF_event_fnc_emitServer
 * Author = Nick
 *
 * Arguments:
 * 0: String. Event name
 * 1: Array. Event arguments
 *
 * Return:
 * None
 *
 * Description:
 * Emit a server event
 */
#include "\x\tmf\addons\event\script_component.hpp"
params [
	"_name",
	"_arguments"
];

[
	[_name,_arguments],
	QUOTE(FUNC(emitEvent)),
	false,
	true,
	_persistent
] call BIS_fnc_MP;