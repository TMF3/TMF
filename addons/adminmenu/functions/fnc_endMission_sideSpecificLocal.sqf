#include "\x\tmf\addons\adminmenu\script_component.hpp"

params ["_winners"];

private _playerSide = playerSide;

// Check side before entering spectator
private _unitData = player getVariable QEGVAR(spectator,unitData);
if (!isNil "_unitData") then {
    _playerSide = _unitData # 3;
};

private _isWinner = _playerSide in _winners;

if (_isWinner) then {
    [QGVAR(victory), true] call EFUNC(common,endMission);
} else {
    [QGVAR(defeat), false] call EFUNC(common,endMission);
};
