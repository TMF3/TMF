params ["_group"];
#include "\x\tmf\addons\common\script_component.hpp"
private _waypoints = [];
{ _waypoints pushback (_x call FUNC(serializeWaypoint)); } foreach waypoints _group;
_waypoints
