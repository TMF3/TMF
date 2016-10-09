#include "\x\tmf\addons\spectator\script_component.hpp"
params ["_control","_button","_x","_y"];
if(_button != 0) exitWith {};
_pos = _control ctrlMapScreenToWorld [_x, _y];
switch (GVAR(mode)) do {
    case 0: {
        _ents = _pos nearEntities ["Man", 15];
        if(count _ents > 0) then {[_ents select 0] call FUNC(setTarget)};
    };
    case 1: {
        GVAR(camera) setPosASL [_pos select 0,_pos select 1,(getTerrainHeightASL[_pos select 0,_pos select 1])+2];
    };
    case 2: {
        _ents = _pos nearEntities ["Man", 15];
        if(count _ents > 0) then {[_ents select 0] call FUNC(setTarget)};
    };
};
