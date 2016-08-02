#include "\x\tmf\addons\teleport\script_component.hpp"
params ["_unit","_pos"];
if(_unit == player) then {
  [QGVAR(parachute),false] call BIS_fnc_blackOut;
};
_chute = createVehicle ["Steerable_Parachute_F", _pos , [],random 360, 'NONE'];
_chute setPos _pos;
_unit assignAsDriver _chute;
_unit setpos [0,0,0];
_unit moveIndriver _chute;
if(_unit == player) then {
  [QGVAR(parachute),true,1] call BIS_fnc_blackIn;
};
