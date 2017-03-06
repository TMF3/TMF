#include "\x\tmf\addons\AI\script_component.hpp"
params ["_logic","_units","_activated"];

//VERSION 1.0
//TODO return previous waypoints when no target
//TODO improve waypoint pathfinding, (when 50 cycles without match, use next waypoint)
//TODO add more configurable atributes to module

if(is3DEN) exitWith{};
if(!_activated) exitWith{};

//systemChat "ACTIVATED";
//systemChat str(_activated);

_radius = _logic getVariable ["Radius", 20];
_time = _logic getVariable ["Time", 10];

_count = 0;
_syncObjects = [];
_syncObjects = synchronizedObjects _logic;
_isFirstContact = true;

while {true} do {
    //systemChat format["[START] %1 --------------------------------------------------", _count];
    {
        private _vehicle = vehicle _x;

        if (!isNull _vehicle) then {
            private _closestTarget = _vehicle findNearestEnemy _vehicle;
            //systemChat format["[VEH][START] %1 --------------------------------------------------", _count];
            if (!isNull _closestTarget && alive _closestTarget) then {
                //systemChat format["Vehicle: %1 | Target: %2 | Radius: %3" , _vehicle, _closestTarget, _radius];
                private _driver = driver _vehicle;

                if (!isNull _driver && alive _driver) then {
                    _vehicleGroup = group _driver;

                    //remove previus waypoints if first contact
                    if (_isFirstContact) then {
                        //systemChat "First Contact, deleting waypoints.";
                        
                        while {(count (waypoints _vehicleGroup)) > 0} do {
                            deleteWaypoint ((waypoints _vehicleGroup) select 0);
                        };
                        
                        _isFirstContact = false;
                    };

                    if ((count (waypoints _vehicleGroup)) > 0) then {
                        //systemChat format["Waypoints count: %1 | Waypoint timer: %2 | Current: %3", 
                        count waypoints _vehicleGroup, waypointTimeoutCurrent _vehicleGroup, currentWaypoint _vehicleGroup];
                    } else {
                        //systemChat format["Waypoints count: %1", count waypoints _vehicleGroup];
                    };

                    switch ((count (waypoints _vehicleGroup))) do { 
                        case 0 : {
                            _waypoint = _vehicleGroup addWaypoint [getPosATL _closestTarget, _radius, 0, format["WP:%1", _closestTarget]];
                            
                            _waypoint setWaypointType ("MOVE");
                            _waypoint setWaypointBehaviour ("COMBAT");
                            _waypoint setWaypointCombatMode ("YELLOW");
                            _waypoint setWaypointCompletionRadius 5;
                            _waypoint setWaypointSpeed ("NORMAL");
                            _waypoint setWaypointTimeout [5, 10, 15];
                            _waypoint setWaypointForceBehaviour true;

                            _vehicleGroup setCurrentWaypoint [_vehicleGroup, ((count (waypoints _vehicleGroup)) - 1)];
                            //systemChat format["Targer: %1 | Added First Waypoint: %2 | Radius: %3", _closestTarget, _waypoint, _radius];
                        };
                        default {
                            //systemChat format["Targer: %1 | WaypointCurr: %2 | WaypointsCount: %3 | Radius: %4", 
                                _closestTarget, currentWaypoint _vehicleGroup, (count (waypoints _vehicleGroup)), _radius];
                            if (((count (waypoints _vehicleGroup)) - 1) == currentWaypoint _vehicleGroup) then {
                                //_prevWaypoint = currentWaypoint _vehicleGroup;
                                _waypoint = _vehicleGroup addWaypoint [getPosATL _closestTarget, _radius, (count (waypoints _vehicleGroup)), format["WP:%1", _closestTarget]];
                                
                                //_waypoint synchronizeWaypoint [_prevWaypoint];
                                _waypoint setWaypointType ("MOVE");
                                _waypoint setWaypointBehaviour ("COMBAT");
                                _waypoint setWaypointCombatMode ("YELLOW");
                                _waypoint setWaypointCompletionRadius 5;
                                _waypoint setWaypointSpeed ("NORMAL");
                                _waypoint setWaypointTimeout [5, 10, 15];
                                _waypoint setWaypointForceBehaviour true;

                                //_vehicleGroup setCurrentWaypoint [_vehicleGroup, ((count (waypoints _vehicleGroup)) - 1)];
                                //systemChat format["Targer: %1 | Added Next Waypoint: %2 | WaypointCurr: %3 | WaypointsCount: %4 | Radius: %5", 
                                _closestTarget, _waypoint, currentWaypoint _vehicleGroup, (count (waypoints _vehicleGroup)), _radius];
                            };
                        }; 
                    };
                };
            } else {
                //systemChat format["Vehicle: %1 No Target", _vehicle];
            };
            //systemChat format["[VEH][END] %1 --------------------------------------------------", _count];
        };
    } forEach _syncObjects;

    //systemChat format["[END] %1 --------------------------------------------------", _count];
    _count = _count + 1;
    sleep(_time);
};