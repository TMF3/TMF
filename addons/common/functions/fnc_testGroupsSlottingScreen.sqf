#include "\x\tmf\addons\autotest\script_component.hpp"
/*
 * Name: TMF_common_fnc_testGroupsSlottingScreen
 * Author: Snippers
 *
 * Arguments:Index of side
 *
 * Return:
 * Side
 *
 * Description:
 * checks if groups will have a custom name in the slotting screen.
 */

private _output = [];

{
    private _desc = (_x get3DENAttribute "description") # 0;

    if (_desc isEqualTo "") then {
        _output pushBack [1,format ["%1 has no role description, so the lobby shows only its class name.",_x]];
    } else {
        if !("@" in _desc) then {
            _output pushBack [1,format ["Role %1 has no lobby group name. Write it as %1@Group Name.", _desc]];
        };
    };
} forEach (playableUnits + [player] - [objNull]);

_output
