/*
 * Name = TMF_event_fnc_removeEventHandler
 * Author = Nick
 *
 * Arguments:
 * 0: String. Event name
 * 1: Number. EH ID.
 *
 * Return:
 * None
 *
 * Description:
 * Removes an event handler
 */
 /* Possibly leave nil values in place? */
#include "\x\tmf\addons\event\script_component.hpp"
params ["_name","_id"];

private _functions = missionNamespace getVariable [EVENT,[]];
if (count _functions >= _id) then {
    _functions set [_id,nil];
};
missionNamespace setVariable [EVENT,_functions];