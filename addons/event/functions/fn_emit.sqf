/*
 * Name = TMF_event_fnc_emit
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
 * Emit a local event
 */
#include "\x\tmf\addons\event\script_component.hpp"
params ["_name","_arguments"];

private _functions = missionNamespace getVariable [EVENT,[]];
// Filter out nil entries
_functions = _functions arrayIntersect _functions;
// Call functions
{
    _x params ["_code","_args"];
    private _this =+ _arguments;
    _this append _args;
    _this call _code;
} forEach _functions;