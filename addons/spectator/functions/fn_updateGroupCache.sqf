params ["_grp"];
#include "\x\tmf\addons\spectator\script_component.hpp"


_cluster = ([units _grp] call FUNC(getGroupClusters));

_avgpos = [0,0,0];


if (count _cluster > 0) then {
  {
      _pos = (getPosATLVisual _x);
      if(surfaceIsWater _pos) then {_pos = getPosASLVisual _x;};
      _avgpos = _avgpos vectorAdd _pos;
  } forEach _cluster;
  _c = count _cluster;
  _avgpos = _avgpos vectorMultiply (1/_c);
  _avgpos set [2,((_avgpos select 2) max 30)];
};

_color = (side _grp) call CFUNC(sideToColor);
_color set [3,0.7];
_isAI = {isPlayer _x || _x in playableUnits } count units _grp <= 0;

_grp setVariable [QGVAR(grpCache),[time + 0.1 + random 0.45,_avgpos,_color,_isAI]]; // Ensure random for different time updates for each group.

_cache
