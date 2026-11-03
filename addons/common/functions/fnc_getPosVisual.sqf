params ["_object"];
private _pos = getPosATLVisual _object;
if(surfaceIsWater _pos) then {
    _pos = getPosASLVisual _object;
};
_pos
