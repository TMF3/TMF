if(is3DEN) exitWith {};
#include "\x\tmf\addons\AI\script_component.hpp"
params ["_logic","_units","_activated"];

_headless = (synchronizedObjects _logic) select {_x isKindOf "HeadlessClient_F" && !local _x};
if(count _headless > 0 && isServer) exitWith {
    _this remoteExec [QFUNC(vehicleAttackInit), _headless select 0];
};

hint "init vehicle ai attack";
sleep 5;
//private _unit = synchronizedObjects _logic;
//private _vehicleWaypointRadius = _logic getVaribale ["Radius", 20]

// check if we have done the setup.
/*if(!(_logic getVariable [QGVAR(init),false])) then
{
	hint str(_unit)    

    _logic setVariable [QGVAR(init),true];
};*/


/*
while {true} do {
	
}
*/
//TODO get vehicles
//TODO get drivers
//TODO check if under attack
//TODO set waypoints every 5 sec