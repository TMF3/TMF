params ["_object"];
_pos = getPosATLVisual _object;
if(surfaceIsWater _pos) then {
    _pos = getPosASLVisual _object;
};
_pos