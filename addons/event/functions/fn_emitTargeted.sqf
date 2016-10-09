/*
 * Name = TMF_event_fnc_emitServer
 * Author = Nick
 *
 * Arguments:
 * 0: String. Event name
 * 1: Array. Event arguments
 * 2: Object, Array of objects, Number (client ID), Side, Group. Target(s)
 * 3: Bool (optional). Persistent for JIPs. Default false
 *
 * Return:
 * None
 *
 * Description:
 * Emit a targeted event
 */
#include "\x\tmf\addons\event\script_component.hpp"
params [
    "_name",
    "_arguments",
    "_target",
    ["_persistent",false,[false]]
];

[
    [_name,_arguments],
    QUOTE(FUNC(emitEvent)),
    _target,
    true,
    _persistent
] call BIS_fnc_MP;