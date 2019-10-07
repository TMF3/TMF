#include "\x\tmf\addons\autotest\script_component.hpp"

params ["_faces", "_faction", "_role"];

private _output = [];

{
    private _face = toLower _x;
     if ((_face find "faceset:") isEqualTo 0) then
     {
        private _facesetName = _face select [8];
        private _array = uiNamespace getVariable [QEGVAR(assignGear,faceset_) + _facesetName,0];
        if (_array isEqualTo 0) then
        {
            _output pushBack [0,format["Invalid faceset: %1 (for: %2 - %3)", _face,_faction,_role]];
        };
    }
    else
    {
        if (!(_face in EGVAR(assignGear,validFaces))) then
        {
            _output pushBack [0,format["Invalid face classname: %1 (for: %2 - %3)", _face,_faction,_role]];
        };
    };
} forEach _faces;

_output
