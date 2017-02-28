#include "\x\tmf\addons\AI\script_component.hpp"
params ["_logic","_units","_activated"];

if (!_activated) exitWith {};

private _vehicles = [];
private _vehicleWaypointRadius = _logic getVaribale ["Radius", 20]

