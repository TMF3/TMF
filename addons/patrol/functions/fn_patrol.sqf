params ["_group","_pos","_type",["_radius",0],["_numOfPoints",8],["_onRoad",false]];
#include "\x\tmf\addons\patrol\script_component.hpp"
// type = 0 = circular, 1 = rectangle
#define CIRCULAR 0
#define RECTANGLE 1
switch (_type) do {
    case (CIRCULAR): {
        private _index = 1;
        for "_angle" from 0 to 360 step (360/_numOfPoints) do {
            private _point = _pos vectorAdd [_radius * (cos _angle) ,_radius * (sin _angle),0];
            private _empty = _point findEmptyPosition [0,50];
            if(count _empty > 0) then {_point = _empty};
            if(_onRoad) then {
                private _road = [_point] call CFUNC(getNearestRoad);
                if(!isNull _road) then {_point = getpos _road};
            };
            private _type = "Move";
            if(_index == _numOfPoints+1) then {_type = "Cycle"};
            private _wp = _group create3DENEntity ["Waypoint", _type, _point];
            if(_index == 1) then {
                _wp set3DENAttribute ["behaviour","Safe"];
                _wp set3DENAttribute ["formation", 4];
            };
            _index = _index +1;
        };
    };
    case (RECTANGLE): {
        private _quickFunc = {
            if(_onRoad) then {
                private _road = [_this] call CFUNC(getNearestRoad);
                if(!isNull _road) then {_this = getpos _road};
            };
            _this
        };
        private _topleft = (_pos vectorAdd [-(_radius/2),-(_radius/2),0])  call _quickFunc;

        private _topright = (_pos vectorAdd [-(_radius/2),(_radius/2),0])  call _quickFunc;

        private _bottomleft = (_pos vectorAdd [(_radius/2),-(_radius/2),0]) call _quickFunc;
        private _bottomright = (_pos vectorAdd [(_radius/2),(_radius/2),0]) call _quickFunc;

        private _type = "Move";
        private _wp = _group create3DENEntity ["Waypoint", _type, _topleft];
        _wp set3DENAttribute ["behaviour","Safe"];
        _wp set3DENAttribute ["formation", 4];


        _group create3DENEntity ["Waypoint", _type, _topright];
        _group create3DENEntity ["Waypoint", _type, _bottomright];
        _group create3DENEntity ["Waypoint", _type, _bottomleft];
        _group create3DENEntity ["Waypoint", "Cycle", _topleft];
    };
};
