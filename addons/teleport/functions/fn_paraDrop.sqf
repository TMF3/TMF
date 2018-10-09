#include "\x\tmf\addons\teleport\script_component.hpp"
params["_unit","_pos"];
_unit setPos _pos;
[{ (getpos (_this select 0) select 2) < 200 },{
params ["_unit"];
_chute = createVehicle ["Steerable_Parachute_F", position _unit, [], direction _unit, 'FLY'];
_chute setPos (getPos _unit);
_unit assignAsDriver _chute;
_unit moveIndriver _chute;
}, _this] call CBA_fnc_waitUntilAndExecute;
