#include "\x\tmf\addons\teleport\script_component.hpp"
params ["_target","_caller","_id","_args"];
_args params ["_duration","_alt","_parachute","_leadersOnly"];

GVAR(mapPos) = nil;
["GVAR(mapEvent)", "onMapSingleClick", {GVAR(mapPos) = _pos;}] call BIS_fnc_addStackedEventHandler;

openMap [true, true];
waitUntil {!isNil QGVAR(mapPos)};
openMap [false, false];
["GVAR(mapEvent)", "onMapSingleClick"] call BIS_fnc_removeStackedEventHandler;
_units = units player;

if(!_leadersOnly) then {_units = [player]};
_mapPos = GVAR(mapPos);


{
  _unit = _x;
  _uPos = _mapPos;
  if(_alt > 0) then {
    _uPos = _mapPos vectorAdd [random 100 - random 100,random 100 - random 100,_alt + random 15 - random 15];
  } else {
    _uPos = _mapPos vectorAdd [random 20 - random 20,random 20 - random 20,0];
  };

  _unit setpos _uPos;
  if(_parachute) then {
    [_unit] remoteExecCall [QFUNC(paraDrop), _unit];
  };
} forEach _units;


player removeAction _id;
