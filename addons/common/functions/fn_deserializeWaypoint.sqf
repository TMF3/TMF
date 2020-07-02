/*
 * Name: TMF_common_fnc_deserializeWaypoint
 * Author: Head
 *
 * Arguments:
 * _group: Group
 * _wpIndex: number
 * _wpData: array
 *
 * Return:
 * created waypoint
 *
 */
params ['_group','_wpIndex', '_wpData'];

_wpData params [
    '_name',
    '_pos',
    '_type',
    '_behaviour',
    '_combatMode',
    '_description',
    '_formation',
    '_housePosition',
    '_script',
    '_speed',
    '_timeout',
    '_visible',
    '_radius',
    '_statements',
    '_attachedObject',
    '_attachedVehicle'
];
_wp = _group addWaypoint [_pos, -1, _wpIndex, _name];
_wp setWaypointType _type;
_wp setWaypointBehaviour _behaviour;
_wp setWaypointCombatMode _combatMode;
_wp setWaypointDescription _description;
_wp setWaypointFormation _formation;
_wp setWaypointHousePosition _housePosition;
_wp setWaypointScript _script;
_wp setWaypointSpeed _speed;
_wp setWaypointTimeout _timeout;
_wp setWaypointVisible _visible;
_wp setWaypointCompletionRadius _radius;
_wp setWaypointStatements _statements;
_wp waypointAttachObject _attachedObject;
_wp waypointAttachVehicle _attachedVehicle;

_wp
