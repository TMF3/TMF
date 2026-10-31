#include "\x\tmf\addons\teleport\script_component.hpp"
params ["_target","_caller","_id","_args"];
_args params ["_duration","_alt","_parachute","_leadersOnly"];

GVAR(mapPos) = nil;
private _mapClickEH = addMissionEventHandler ["MapSingleClick", {GVAR(mapPos) = _this select 1;}];

openMap [true, true];
waitUntil {!isNil QGVAR(mapPos)};
openMap [false, false];
removeMissionEventHandler ["MapSingleClick", _mapClickEH];
private _units = units player;

if(!_leadersOnly) then {_units = [player]};
private _mapPos = GVAR(mapPos);


{
  private _unit = _x;
  private _uPos = _mapPos;
  if(_alt > 0) then {
    _uPos = _mapPos vectorAdd [random 100 - random 100,random 100 - random 100,_alt + random 15 - random 15];
  } else {
    _uPos = _mapPos vectorAdd [random 20 - random 20,random 20 - random 20,0];
  };

  _unit setPos _uPos;
  if(_parachute) then {
    [_unit] remoteExecCall [QFUNC(paraDrop), _unit];
  };
} forEach _units;


player removeAction _id;
