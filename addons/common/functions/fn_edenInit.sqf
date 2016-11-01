/*
 * Name: TMF_common_fnc_edenInit
 * Author: Nick
 *
 * Arguments:
 * None
 *
 * Return:
 * nil
 *
 * Description:
 * Set up the needed EH
 *
 */
#include "\x\tmf\addons\common\script_component.hpp"

// Add mouseOver EH
private _idx = missionNamespace getVariable [QGVAR(mouseOverIdx),-1];
if !(_idx == -1) then {
    removeMissionEventHandler ["Draw3D",_idx];
};

_idx = addMissionEventHandler ["Draw3D",FUNC(mouseOver)];
GVAR(mouseOverIdx) = _idx;
GVAR(edenMouseObjects) = [];
GVAR(mouseKeysPressed) = [];
GVAR(posIdxs) = [];

// Do stuff with mouseOver EH
// KeyDown
GVAR(mouseKeyDown) = ((findDisplay 313) displayAddEventHandler ["mouseButtonDown",{
    GVAR(mouseKeysPressed) pushBackUnique (_this select 1);
    GVAR(mouseKeyDownIdx) = addMissionEventHandler ["Draw3D",FUNC(mouseKeyDown)];
}]); // EDEN IDC 313
// KeyUp
GVAR(mouseKeyUp) = ((findDisplay 313) displayAddEventHandler ["mouseButtonUp",{
    if !(0 in GVAR(mouseKeysPressed)) exitWith {};
    private _idx = missionNamespace getVariable [QGVAR(mouseKeyDownIdx),-1];
    if !(_idx == -1) then {
        removeMissionEventHandler ["Draw3D",_idx];
    };
    [_this select 1] call FUNC(mouseKeyUp);
    GVAR(mouseKeysPressed) = GVAR(mouseKeysPressed) - [(_this select 1)];
}]);
// MouseZchanged
GVAR(mouseZchanged) = ((findDisplay 313) displayAddEventHandler ["mouseZchanged",{
    private _A =+ GVAR(posIdxs);
    private _B = [];
    while {count _A > 0} do {_B pushBack (_A deleteAt random floor count _A)};
    GVAR(posIdxs) = +_B;
}]);