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
    _warnings pushBack [1,format ["Fewer than %1 headless clients are placed. Add headless client entities in the editor.",_targetHCs]];
};

// Check if setup correctly
{
    if (_x get3DENAttribute "ControlMP" isNotEqualTo [true]) then {
        _warnings pushBack [0,format ["Headless client %1 is not playable, so it cannot connect. Tick Playable in its attributes.",_x]];
    };
} forEach _HCs;

_warnings
