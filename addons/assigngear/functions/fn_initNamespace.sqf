/*
 * Name = TMF_assignGear_fnc_initNamespace
 * Author = Fredoo
 *
 * Arguments:
 * None
 *
 * Return:
 * Location. Namespace
 *
 * Description:
 * Initializes the TMF assigngear namespace
 */
#include "\x\tmf\addons\assignGear\script_component.hpp"

if (!isNil QGVAR(namespace) && {!isNull GVAR(namespace)}) exitWith {GVAR(namespace)};

// Check if there is a saved namespace in uiNamespace
GVAR(namespace) = false call CBA_fnc_createNamespace;

LOG_1("Initialized namespace", GVAR(namespace));

GVAR(namespace)
