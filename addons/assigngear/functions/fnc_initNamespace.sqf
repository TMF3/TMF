#include "\x\tmf\addons\assignGear\script_component.hpp"
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
if (!isNil QGVAR(namespace) && {!isNull GVAR(namespace)}) exitWith {GVAR(namespace)};

GVAR(namespace) = false call CBA_fnc_createNamespace;

LOG_1("Initialized namespace", GVAR(namespace));

GVAR(namespace)
