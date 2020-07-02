#include "\x\tmf\addons\adminmenu\script_component.hpp"

params ["_winners"];

private _isWinner = playerSide in _winners;

if (_isWinner) then {
    [QGVAR(victory), true] call EFUNC(common,endMission);
} else {
    [QGVAR(defeat), false] call EFUNC(common,endMission);
};
