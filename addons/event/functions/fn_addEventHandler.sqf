/*
 * Name = TMF_event_fnc_addEventHandler
 * Author = Nick
 *
 * Arguments:
 * 0: String. Event name
 * 1: Code. Event code
 * 2: Array (optional). Extra arguments, appended to _this
 * 3: Number (optional). Handler ID
 *
 * Return:
 * 0: NUMBER. Handler ID
 *
 * Description:
 * Adds an event handler
 */
#include "\x\tmf\addons\event\script_component.hpp"
params [
    "_name",
    "_code",
    ["_args",[],[[]]],
    ["_id",-1,[0]]
];

private _functions = missionNamespace getVariable [EVENT,[]];
if !(_id < 0) then {
    _functions set [_id,[_code,_args]];
} else {
    _id = _functions pushBack [_code,_args];
};
missionNamespace setVariable [EVENT,_functions];

_id