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

private _faceClasses = [];
{
    _faceClasses append (("true" configClasses _x) apply {configName _x});
} forEach ("true" configClasses(configfile >> "CfgFaces"));
_faces = _faces select {_x in _faceClasses}; // Need to maintain multiply identical entries to weigh chances

if (count _faces > 0) then {
    private _face = selectRandom _faces;
    [_unit,_face] remoteExec ["setFace",0,_unit];
    _unit setFace _face;
};
_face