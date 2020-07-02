#include "\x\tmf\addons\spectator\script_component.hpp"
params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile"];

//if(!(_unit getVariable [QGVAR(fired_enabled),false])) exitWith {};
_unit setVariable [QGVAR(fired), 5];

  // thanks ACE
if (isNull _projectile) then {
    _projectile = nearestObject [_unit, _ammo];
};
private _type = 0; // bullet
if(_ammo isKindOf "Grenade") then {_type = 1};
if(_ammo isKindOf "SmokeShell") then {_type = 2};
if(_ammo isKindOf "MissileCore" || _ammo isKindOf "RocketCore") then {_type = 3};
GVAR(rounds) pushBack [_projectile,[getPosVisual _projectile],diag_frameNo,time,_type];
