#include "\x\tmf\addons\spectator\script_component.hpp"
params ["_unit","_weapon","_muzzle","_mode","_ammo","_magazine","_projectile"];
//if(!(_unit getVariable [QGVAR(fired_enabled),false])) exitWith {};
_unit setVariable [QGVAR(fired), true];

  // thanks ACE
if (isNull _projectile) then {
    _projectile = nearestObject [_unit, _ammo];
};
GVAR(rounds) pushBack [_projectile,[getPosVisual _projectile],time];
