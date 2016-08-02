/*
 * Name = TMF_event_fnc_removeAllEventHandlers
 * Author = Nick
 *
 * Arguments:
 * 0: String. Event name
 *
 * Return:
 * None
 *
 * Description:
 * Removes all eventHandlers for given event.
 */
 /* Possibly leave nil values in place? */
 #include "\x\tmf\addons\event\script_component.hpp"
params ["_name"];

missionNamespace setVariable [EVENT,nil];