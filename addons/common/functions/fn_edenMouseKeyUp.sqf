/*
 * Name: TMF_common_fnc_mouseKeyUp
 * Author: Nick
 *
 * Arguments:
 * None
 *
 * Return:
 * nil
 *
 * Description:
 * Left mouse button up behaviour for drag to garrison
 *
 */
 #include "\x\tmf\addons\common\script_component.hpp"
#define MANOBJECTS ((get3DENSelected "object") select {_x isKindOf "CAManBase"})

// Exit conditions
if ((_this select 0) != 0) exitWith {};
if (!GVAR(Garrison)) exitWith {};
if (current3DENOperation != "MoveItems") exitWith {};


// Delay execution
0 = [] spawn {
    // See if we have a suitable object
    private _building = GVAR(edenMouseObjects);
    _building = _building select {!(_x in (get3DENSelected "Object"))};
    if (count _building == 0) exitWith {};
    if (count GVAR(posIdxs) == 0) exitWith {};
    _building = _building select 0;
    do3DENAction "Undo"; // Undo movement
    collect3DENHistory { // Easy CtrlZ undo
        {
            if (_forEachIndex > (count GVAR(posIdxs))) exitWith {};
            private _pos = (_building buildingPos (GVAR(posIdxs) select _forEachIndex));
            _x set3DENAttribute ["position",_pos];
            do3DENAction "SnapToSurface";
        } forEach MANOBJECTS;
    };
    GVAR(posIdxs) = [];
};