#include "\x\tmf\addons\common\script_component.hpp"
GVAR(posIdxs) = [];

#define MANOBJECTS ((get3DENSelected "object") select {_x isKindOf "CAManBase"})

// Exit conditions
if !(0 in GVAR(mouseKeysPressed)) exitWith {};
if !(current3DENOperation != "MoveItems") exitWith {};
if ((count get3DENSelected "Object") == 0) exitWith {};

// Get mouseOver building
private _building = GVAR(edenMouseObjects);
_building = _building select {!(_x in (get3DENSelected "Object"))};
if (count _building == 0) exitWith {};


//TODO Sleep to act after the move action?
{
    private _pos = (_mouseOver buildingPos (GVAR(posIdxs) select _forEachIndex));
    _x set3DENAttribute ["position",_pos];
    do3DENAction "SnapToSurface";
} forEach MANOBJECTS;