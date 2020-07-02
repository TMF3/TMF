
params ["_point",["_radius",100]];
private _roads = _point nearRoads _radius;
private _road = objNull;
if(count _roads > 0) then {
    {
        _roads set [_forEachIndex, [_x distance _point, _x]];
    } forEach _roads;
    _roads sort true;
    _road = (_roads select 0) select 1;
};
_road
