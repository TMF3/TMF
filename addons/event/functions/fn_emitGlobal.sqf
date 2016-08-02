/*
 * Name = TMF_event_fnc_emitGlobal
 * Author = Nick
 *
 * Arguments:
 * 0: String. Event name
 * 1: Array. Event arguments
 * 2: Bool (optional). Persistent for JIPs. Default false
 *
 * Return:
 * None
 *
 * Description:
 * Emit a global event
 */
#include "\x\tmf\addons\event\script_component.hpp"
params [
	"_name",
	"_arguments",
	["_persistent",false,[false]]
];

[
	[_name,_arguments],
	QUOTE(FUNC(emitEvent)),
	true,
	true,
	_persistent
] call BIS_fnc_MP;