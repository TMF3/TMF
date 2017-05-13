/*
 * Name: TMF_common_fnc_edenHideMapObjects
 * Author: Nick
 *
 * Arguments:
 * None
 *
 * Return:
 * nil
 *
 * Description:
 * Visuals for the map objects remover logic
 *
 */
#include "\x\tmf\addons\common\script_component.hpp"

#define RANGE 2
#define COLX [1,0,0,1]
#define COLY [0,1,0,1]
#define COLZ [0,0,1,1]

#define X1 [ARR_3(-RANGE,0,0)]
#define X2 [ARR_3(RANGE,0,0)]
#define Y1 [ARR_3(0,-RANGE,0)]
#define Y2 [ARR_3(0,RANGE,0)]
#define Z1 [ARR_3(0,0,-RANGE)]
#define Z2 [ARR_3(0,0,RANGE)]

#define ICON "\a3\ui_f\data\map\Markers\Military\dot_ca.paa"
{
    _x removeAllEventHandlers "UnregisteredFromWorld3DEN";
    _x addEventHandler ["UnregisteredFromWorld3DEN", {
        { _x hideObjectGlobal false } forEach ((_this select 0) getVariable [QGVAR(intersections),[]]);
    }];

    drawLine3D [_x modelToWorld X1, _x modelToWorld X2, COLX];
    drawLine3D [_x modelToWorld Y1, _x modelToWorld Y2, COLY];
    drawLine3D [_x modelToWorld Z1, _x modelToWorld Z2, COLZ];

    drawIcon3D [ICON,COLX,_x modelToWorld X1,1,1,0];
    drawIcon3D [ICON,COLX,_x modelToWorld X2,1,1,0];
    drawIcon3D [ICON,COLY,_x modelToWorld Y1,1,1,0];
    drawIcon3D [ICON,COLY,_x modelToWorld Y2,1,1,0];
    drawIcon3D [ICON,COLZ,_x modelToWorld Z1,1,1,0];
    drawIcon3D [ICON,COLZ,_x modelToWorld Z2,1,1,0];

} forEach ((all3DENEntities select 3) select {_x isKindOf QGVAR(hideMapObjects)});

if (current3DENOperation == "MoveItems" || current3DENOperation == "RotateItems") then {
    {
        { _x hideObjectGlobal false } forEach (_x getVariable [QGVAR(intersections),[]]);

        private _ints = [];
        _ints append lineIntersectsObjs [AGLToASL(_x modelToWorld X1), AGLToASL(_x modelToWorld X2), objNull, _x, true, 32];
        _ints append lineIntersectsObjs [AGLToASL(_x modelToWorld Y1), AGLToASL(_x modelToWorld Y2), objNull, _x, true, 32];
        _ints append lineIntersectsObjs [AGLToASL(_x modelToWorld Z1), AGLToASL(_x modelToWorld Z2), objNull, _x, true, 32];

        _ints = _ints select { !(_x in (all3DENEntities select 0))};
        _ints = _ints arrayIntersect _ints;

        _x setVariable [QGVAR(intersections),_ints];
        { _x hideObjectGlobal true } forEach _ints;
    } forEach ((get3DENSelected "Logic") select {_x isKindOf QGVAR(hideMapObjects)});
};