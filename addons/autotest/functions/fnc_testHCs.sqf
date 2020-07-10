#include "\x\tmf\addons\autotest\script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: TMF_autotest_fnc_testHCs

Description:
    Checks number of HCs and if they're set up correctly

Returns:
    Warning array [Array of Warnings]

Author:
    Freddo
---------------------------------------------------------------------------- */

private _warnings = [];
private _targetHCs = getNumber (_test >> "expectedHCs");

private _HCs = (all3DENEntities # 3) select {_x isKindOf "HeadlessClient_F"};

// Check presence
if (count _HCs < _targetHCs) then {
    _warnings pushBack [1,format ["Less than %1 Headless Clients present",_targetHCs]];
};

// Check if setup correctly
{
    if !(_x get3DENAttribute "ControlMP" isEqualTo [true]) then {
        _warnings pushBack [0,format ["Headless Client %1 is not marked as playable.",_x]];
    };
} forEach _HCs;

_warnings
