/*
 * Name = TMF_assignGear_fnc_setFace
 * Author = Nick
 *
 * Arguments:
 * 0: Object. Unit
 * 1: ARRAY. Array of faces to choose from
 *
 * Return:
 * 0: String. Selected face
 *
 * Description:
 * Will set a units face to a randomly chosen one from the supplied list.
 */
 #include "\x\tmf\addons\assignGear\script_component.hpp"
params ["_unit","_faces"];
private _face = "";

if (isNil "_unit" || isNil "_faces") exitWith {};

if (count _faces > 0) then {
    private _face = selectRandom _faces;
    if ((_face find "faceset:") isEqualTo 0) then {
        private _facesetName = _face select [8];
        private _array = uiNamespace getVariable ["tmf_assignGear_faceset_" + _facesetName,[]];
        if (count _array > 0) then {
            _face = selectRandomWeighted _array;
        };
    };
    [_unit,_face] remoteExec ["setFace",0,_unit];
    _unit setFace _face;
};
_face