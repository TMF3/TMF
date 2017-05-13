/*
 * Name: TMF_common_fnc_edenDraw
 * Author: Snippers
 *
 * Arguments:
 * None
 *
 * Return:
 * nil
 *
 * Description:
 * Called on the draw event in EDEN.
 *
 */
#include "\x\tmf\addons\common\script_component.hpp"

if (GVAR(Garrison)) then {
    [] call FUNC(edenMouseOver);
    [] call FUNC(edenMouseKeyDown);
};

[] call FUNC(edenHideMapObjects);