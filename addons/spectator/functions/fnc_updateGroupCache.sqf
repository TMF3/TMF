params ["_grp"];
#include "\x\tmf\addons\spectator\script_component.hpp"
private _avgpos = [0,0,0];
private _vehicles = ((units _grp) select {!isNull (objectParent _x)}) apply {objectParent _x};
_vehicles = _vehicles arrayIntersect _vehicles;
private _color = (side _grp) call CFUNC(sideToColor);
private _hasPlayers = (units _grp findIf { isPlayer _x || _x in playableUnits }) >= 0;
if(_hasPlayers || {GVAR(showGroupMarkers) == 1}) then {
    if(count (units _grp) > 1 && ((count _vehicles) != 1) ) then {
        private _cluster = ([units _grp] call FUNC(getGroupClusters));
        if (count _cluster > 0) then {
            {
                _pos = [_x] call CFUNC(getPosVisual);
                _avgpos = _avgpos vectorAdd _pos;
            } forEach _cluster;
            private _c = count _cluster;
            _avgpos = _avgpos vectorMultiply (1/_c);
            _avgpos set [2,(_avgpos select 2)+10];
        };
    } else {
        _avgpos = [leader _grp] call CFUNC(getPosVisual);
        _avgpos set [2,(_avgpos select 2)+10];
    };
};
private _grpCache = _x getVariable [QGVAR(grpCache),[[0,0,0],[1,1,1,1],true]];
if((_grpCache # 0) distance (_avgpos) < 1.5) then {
    _avgpos = _grpCache # 0; // diff is to small, render the same.
};
private _cache = [_avgpos,_color, !_hasPlayers];

_grp setVariable [QGVAR(grpCache),_cache];

_cache;
