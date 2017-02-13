params ["_grp"];
#include "\x\tmf\addons\spectator\script_component.hpp"


private _cluster = ([units _grp] call FUNC(getGroupClusters));

private _avgpos = [0,0,0];


if (count _cluster > 0) then {
    {
        _pos = [_x] call CFUNC(getPosVisual);
        _avgpos = _avgpos vectorAdd _pos;
    } forEach _cluster;
    private _c = count _cluster;
    _avgpos = _avgpos vectorMultiply (1/_c);
    _avgpos set [2,(_avgpos select 2)+10];
};

private _color = (side _grp) call CFUNC(sideToColor);
//_color set [3,0.7];
private _isAI = {isPlayer _x || _x in playableUnits } count units _grp <= 0;

private _cache = [time + 0.1 + random 0.45,_avgpos,_color,_isAI];

_grp setVariable [QGVAR(grpCache),_cache]; // Ensure random for different time updates for each group.

_cache;
