#include "\x\tmf\addons\assignGear\script_component.hpp"
/*
 * Name = TMF_assignGear_fnc_setFace
 * Author = Nick, Freddo
 *
 * Arguments:
 * 0: Object. Unit
 * 1: ARRAY. Weighted array of faces to choose from
 *
 * Description:
 * Will set a units face to a randomly chosen one from the supplied list.
 */
params ["_unit","_faces"];

_unit setVariable [QGVAR(faces),_faces];

if (
    isPlayer _unit &&
    { !(_unit getVariable [QGVAR(overridePlayerIdentity),GVAR(overridePlayerIdentity) ]) }
) exitWith {
    TRACE_1("Kept default face for unit",_unit);
};

if (
    _faces isEqualTo [] ||
    (toLower face _unit) in _faces
) exitWith {
    TRACE_1("Kept default face for unit",_unit);
};

private _face = selectRandomWeighted _faces;

if (_face == "Default") exitWith {
    TRACE_1("Kept default face for unit",_unit);
};

[_unit, _face] remoteExec ["setFace", 0, _unit];
TRACE_2("Set face for unit",_unit,_face);
