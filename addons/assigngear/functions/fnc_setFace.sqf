#include "\x\tmf\addons\assignGear\script_component.hpp"
/*
 * Name = TMF_assignGear_fnc_setFace
 * Author = Nick
 *
 * Arguments:
 * 0: Object. Unit
 * 1: ARRAY. Array of faces to choose from
 *
 * Description:
 * Will set a units face to a randomly chosen one from the supplied list.
 */
params ["_unit","_faces"];

if (_faces isEqualTo []) exitWith {};

private _unitFace = toLower (face _unit);
private _hasValidFace = false;

{
    if ((_x find "faceset:") isEqualTo 0) then {
        private _facesetName = _x select [8];
        private _array = uiNamespace getVariable ["tmf_assignGear_faceset_" + _facesetName, []];
        if (_unitFace in _array) exitWith { _hasValidFace = true; };
    } else {
        if (_unitFace isEqualTo (toLower _x)) exitWith { _hasValidFace = true; };
    };
} forEach _faces;

if (_hasValidFace) exitWith {};

private _face = selectRandom _faces;

if ((_face find "faceset:") isEqualTo 0) then {
    private _facesetName = _face select [8];
    private _array = uiNamespace getVariable ["tmf_assignGear_faceset_" + _facesetName, []];
    if (_array isNotEqualTo []) then {
        _face = selectRandomWeighted _array;
    };
};

[_unit, _face] remoteExec ["setFace", 0, _unit];
