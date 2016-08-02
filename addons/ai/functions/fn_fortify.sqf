#include "\x\tmf\addons\AI\script_component.hpp"
params ["_group","_pos","_attached"];

private _waypoint = currentWaypoint _group;
private _radius = (waypointCompletionRadius [_group,_waypoint]) max 100 min 1;
private _leader = leader _group;

// Check if group needs to move first
if (_leader distance2D _pos > _radius) then {
	_leader doMove _pos;
	((units _group) select {!(_x == _leader)}) doFollow _leader;
	waitUntil {_leader distance2D _pos < _radius};
};

// CBA_fnc_taskDefend for now
[_group,_pos,_radius] call CBA_fnc_taskDefend;

true