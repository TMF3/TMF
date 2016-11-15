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
GVAR(Garrison) = missionNamespace getVariable [QGVAR(Garrison),false]; // Will be set on UI onLoad
// Add mouseOver EH
private _idx = missionNamespace getVariable [QGVAR(edenDrawIdx),-1];
if !(_idx == -1) then {
    removeMissionEventHandler ["Draw3D",_idx];
};

_idx = addMissionEventHandler ["Draw3D",FUNC(edenDraw)];
GVAR(edenDrawIdx) = _idx;
GVAR(edenMouseObjects) = [];
GVAR(mouseKeysPressed) = [];
GVAR(posIdxs) = [];


// Do stuff with mouseOver EH
// KeyDown
GVAR(edenMouseKeyDownIdx) = ((findDisplay 313) displayAddEventHandler ["mouseButtonDown",{
    GVAR(mouseKeysPressed) pushBackUnique (_this select 1);
}]); // EDEN IDC 313
// KeyUp
GVAR(edenMouseKeyUpIdx) = ((findDisplay 313) displayAddEventHandler ["mouseButtonUp",{
    [_this select 1] call FUNC(edenMouseKeyUp);
    GVAR(mouseKeysPressed) = GVAR(mouseKeysPressed) - [(_this select 1)];
}]);
// MouseZchanged
GVAR(edenMouseZchangedIdx) = ((findDisplay 313) displayAddEventHandler ["mouseZchanged",{
    if (GVAR(Garrison)) then {
        private _A =+ GVAR(posIdxs);
        private _B = [];
        while {count _A > 0} do {_B pushBack (_A deleteAt floor random count _A)};
        GVAR(posIdxs) = +_B;
    };
}]);