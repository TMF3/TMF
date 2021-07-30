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


private _units = playableUnits + [player] - [objNull];
{
    private _desc = (_x get3DENAttribute "description") # 0;

    if (_desc isEqualTo "") then {
        _output pushBack [1,format ["Unit lacks role description: %1",_x]];
    } else {
        if !("@" in _desc) then {
            _output pushBack [1,format ["Unit lacks slotting group name: %1 (should be: %1@Group Name)", _desc]];
        };
    };
} forEach (playableUnits + [player]);

_output
