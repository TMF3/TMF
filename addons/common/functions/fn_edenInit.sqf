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

if !is3DEN exitWith {};

call FUNC(edenDisplayFactionIcons);

// Add mouseOver EH
private _idx = missionNamespace getVariable [QGVAR(edenDrawIdx),-1];
if !(_idx == -1) then {
    removeMissionEventHandler ["Draw3D",_idx];
};

_idx = addMissionEventHandler ["Draw3D",FUNC(edenDraw)];

GVAR(Garrison) = missionNamespace getVariable [QGVAR(Garrison),false]; // Will be set on UI onLoad
(uiNamespace getVariable [QGVAR(GarrisonControl),controlNull]) cbSetChecked GVAR(Garrison); // Reset garrison toggle.
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

// Some stuff for hiding map objects
{
    { _x hideObjectGlobal false } forEach (_x getVariable [QGVAR(intersections),[]]);

    private _ints = [];
    _ints append lineIntersectsObjs [AGLToASL(_x modelToWorld [-2,0,0]), AGLToASL(_x modelToWorld [2,0,0]), objNull, _x, true, 32];
    _ints append lineIntersectsObjs [AGLToASL(_x modelToWorld [0,-2,0]), AGLToASL(_x modelToWorld [0,2,0]), objNull, _x, true, 32];
    _ints append lineIntersectsObjs [AGLToASL(_x modelToWorld [0,0,-2]), AGLToASL(_x modelToWorld [0,0,2]), objNull, _x, true, 32];

    _ints = _ints select {!(_x in (all3DENEntities select 0))};
    _ints = _ints arrayIntersect _ints;

    _x setVariable [QGVAR(intersections),_ints];
    { _x hideObjectGlobal true } forEach _ints;
} forEach ((all3DENEntities select 3) select {_x isKindOf QGVAR(hideMapObjects)});

add3DENEventHandler ["OnMissionPreviewEnd",{
    // Cheat to get OnMissionPreviewEnd working
    0 = [] spawn {
        uisleep 0.5;
        {
            { _x hideObjectGlobal false } forEach (_x getVariable [QGVAR(intersections),[]]);

            private _ints = [];
            _ints append lineIntersectsObjs [AGLToASL(_x modelToWorld [-2,0,0]), AGLToASL(_x modelToWorld [2,0,0]), objNull, _x, true, 32];
            _ints append lineIntersectsObjs [AGLToASL(_x modelToWorld [0,-2,0]), AGLToASL(_x modelToWorld [0,2,0]), objNull, _x, true, 32];
            _ints append lineIntersectsObjs [AGLToASL(_x modelToWorld [0,0,-2]), AGLToASL(_x modelToWorld [0,0,2]), objNull, _x, true, 32];

            _ints = _ints select {!(_x in (all3DENEntities select 0))};
            _ints = _ints arrayIntersect _ints;

            _x setVariable [QGVAR(intersections),_ints];
            { _x hideObjectGlobal true } forEach _ints;
        } forEach ((all3DENEntities select 3) select {_x isKindOf QGVAR(hideMapObjects)});
    };
}];
