params ["_logic","_units","_activated"];
#include "\x\tmf\addons\ai\script_component.hpp"


if(!_activated) exitwith {};

private _areas = (synchronizedObjects _logic) select {_x isKindOf QGVAR(area)};
private _vehicles = (synchronizedObjects _logic) select { !(_x isKindOf QGVAR(area)) };

[{_this call FUNC(doArty);},[_logic,_areas,_vehicles]] call CBA_fnc_execNextFrame;
