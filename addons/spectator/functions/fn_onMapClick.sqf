#include "\x\tmf\addons\spectator\script_component.hpp"
params ["_control","_button","_x","_y"];
if (_button != 0) exitWith {};
private _pos = _control ctrlMapScreenToWorld [_x, _y];
switch (GVAR(mode)) do {
    case FOLLOWCAM: {
        private _ents = _pos nearEntities ["Man", 15];
        if (count _ents > 0) then {[_ents select 0] call FUNC(setTarget)};
    };
    case FREECAM: {
        GVAR(camera) setPosASL [_pos select 0,_pos select 1,(getTerrainHeightASL[_pos select 0,_pos select 1])+2];
    };
    case FIRSTPERSON: {
        private _ents = _pos nearEntities ["Man", 15];
        if(count _ents > 0) then {[_ents select 0] call FUNC(setTarget)};
    };
};
