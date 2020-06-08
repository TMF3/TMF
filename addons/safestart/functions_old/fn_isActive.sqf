/*
 * Name = TMF_safestart_fnc_isActive
 * Author = Freddo
 *
 * Parameters:
 * None
 *
 * Description:
 * Checks if safestart is active
 *
 * Return:
 * Boolean. - Whether safestart is active
 */

#include "\x\tmf\addons\safestart\script_component.hpp"

(entities QGVAR(module)) params [["_safestartModule", objNull, [objNull]]];

(!isNull _safestartModule && {_safestartModule getVariable [QGVAR(enabled), false]})
