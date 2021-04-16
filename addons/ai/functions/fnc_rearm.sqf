#include "\x\tmf\addons\ai\script_component.hpp"
params ["_self","_caller"];
_repairPerTick = 0.1;
_fuelPerTick = 0.1;
_ammoPerTick = 0.1;
if(_caller getvariable [QGVAR(rearming),false]) exitwith {
    hint "You are already rearming!";
};
_caller setVariable [QGVAR(rearming), true];
_vehicle = vehicle _caller;
if(_vehicle == _caller) exitwith {
    hint "You have to be in the vehicle";
};
_vehicle setFuel 0;
_initalDamage = damage _vehicle;
while {damage _vehicle > 0} do {
    _vehicle setDamage (damage _vehicle - _repairPerTick);
    hint "Repairing";
    sleep 1;
};
_ammo = 0;
while {_ammo < 1} do {
    _vehicle setVehicleAmmoDef (_ammo + _ammoPerTick);
    _ammo = _ammo + 0.1;
    hint "Rearming";
    sleep 1;
};

while {fuel _vehicle < 1} do {
    _vehicle setFuel (fuel _vehicle + _fuelPerTick);
    hint "Refueling";
    sleep 1;
};
hint "Done!";
_caller setVariable [QGVAR(rearming), false];
