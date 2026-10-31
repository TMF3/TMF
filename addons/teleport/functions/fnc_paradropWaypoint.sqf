#include "\x\tmf\addons\teleport\script_component.hpp"
params ["_group","_pos","_attached"];
_units = units _group;
_flyingVehicles = _units select {vehicle _x isKindOf "Air" && effectiveCommander (vehicle _x) == _x};
_flyingVehicles = _flyingVehicles apply {vehicle _x};
_flyingVehicles = _flyingVehicles arrayIntersect _flyingVehicles;

{
  _x spawn {
    _vehicle = _this;
    _cargo = fullCrew _vehicle select {(toLower (_x select 1) == "cargo") || (_x select 4)};
    _cargo = _cargo apply {_x select 0};
    _cargo = _cargo arrayIntersect _cargo;

    _groups = [];
    {
        _groups pushBackUnique group _x
    } forEach _cargo;

    {
      private _pos = getPos _vehicle;
      _pos = _pos vectorAdd (vectorDirVisual _vehicle vectorMultiply -30);
      [_x,_pos] remoteExecCall [QFUNC(paradropEffect), _x];
      sleep 1.5;
    } forEach _cargo;

    {
        _x leaveVehicle _vehicle;
    } forEach _groups
  };
} forEach _flyingVehicles;
true
