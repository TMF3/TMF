/*
 * Name: TMF_common_fnc_serializeWaypoints
 * Author: Head
 *
 * Arguments:
 * _group: Group
 *
 * Return:
 * array: of waypoint data
 *
 */
params ["_group"];
#include "\x\tmf\addons\common\script_component.hpp"
private _waypoints = (waypoints _group) apply { _x call FUNC(serializeWaypoint)};
_waypoints
