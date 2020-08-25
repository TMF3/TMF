#include "\x\tmf\addons\assignGear\script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: TMF_assigngear_fnc_loadFaces

Description:
    Parses an array with facesets

Parameters:
    _faces - An array containing face classes and facesets [Array]

Returns:
    Weighted array of faces

Author:
    Freddo, Nick
---------------------------------------------------------------------------- */

private _weightedArr = [];

{
    if (_x isEqualType "") then {
        _x = toLower _x;

        if ((_x find "faceset:") == 0) then {
            // faceset
            TRACE_1("Loading faceset",_x);

            private _arr = uiNamespace getVariable [
                format [QGVAR(faceset_%1),_x select [8]],
                ["",0]
            ];

            if (_arr isEqualTo ["",0]) then {
                ERROR_1("Faceset error in: %1",_x);
            };

            _weightedArr append _arr
        } else {
            // Simple entry
            TRACE_1("Appending face to face array",_x);
            _weightedArr append [_x, 1];
        };
    } else {
        // Simple weighted already
        if (_x isEqualTypeArray ["",-1]) then {
            TRACE_1("Appending weighted face array to face array",_x);
            _weightedArr append _x;
        } else {
            ERROR_1("Error in weighted face array: %1",_x);
        };
    };
} forEach _this;

_weightedArr
