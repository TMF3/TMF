#include "../script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: TMF_ambient_fnc_createAmbientVehicles

Description:
    Spawns empty vehicles close to roads in an area,
    script taken from Quarry mission.

Parameters:
    _area - Area to cover [Area array, trigger or marker]
    _vehicles - Vehicle types to spawn [Array of class names]
    _vehicleCount - Number of vehicles to spawn [Number, default 1]
    _spacing - Number of road segments between spawned vehicles [Number, Default 2]

Returns:
    List of spawned vehicles [Array of objects]

Author:
    Snippers(?), Freddo
---------------------------------------------------------------------------- */
params [
    "_area",
    "_vehicles",
    ["_vehicleCount", 1, [1]],
    ["_spacing", 2, [-1]]
];

_area = _area call BIS_fnc_getArea;

TRACE_4("Creating ambient vehicles",_area,_vehicles,_vehicleCount,_code);

private _createdVehicles = [];

#ifdef DEBUG_MODE_FULL
// Initialize or cleanup debug marks
if (isNil QGVAR(vehicleDebugMarkers)) then {
    GVAR(vehicleDebugMarkers) = 0;
} else {
    {
        deleteMarker _x;
    } forEach (allMapMarkers select {(_x find QGVAR(roadDebugMark_)) == 0});
};

private _fnc_createDebugMarker = {
    params [["_road",objNull]];

    if (isNull _road) exitWith {};

    private _childSegments = roadsConnectedTo _road;
    private _txt = format [QGVAR(roadDebugMark_%1),GVAR(vehicleDebugMarkers)];
    private _debugMkr = createMarker [_txt, getPos _road];
    _debugMkr setMarkerShape "ICON";
    _debugMkr setMarkerType "hd_dot";
    _debugMkr setMarkerText format ["%1",count _childSegments];
    switch (count _childSegments) do {
        case 0: { _debugMkr setMarkerColor "ColorBlue";};
        case 1: {_debugMkr setMarkerColor "ColorRed";};
        case 2: {_debugMkr setMarkerColor "ColorGreen";};
        case 3: {_debugMkr setMarkerColor "ColorYellow";};
        case 4: {_debugMkr setMarkerColor "ColorOrange";};
        case 5: {_debugMkr setMarkerColor "ColorPink";};
        case 6: {_debugMkr setMarkerColor "ColorWhite";};
        case 7: {_debugMkr setMarkerColor "ColorBrown";};
        default {};
    };

    INC(GVAR(vehicleDebugMarkers));
};
#endif

private _fnc_findRoadConnections = {
    params ["_road", ["_depth", 2, [-1]]];

    #ifdef DEBUG_MODE_FULL
    [_road] call _fnc_createDebugMarker;
    #endif

    private _return = [_road];
    if (_depth > 0) then {
        {
            // Filter out isPedestrian roads
            if !((getRoadInfo _x) # 2) then {
                _return = _return + ([_x, _depth - 1] call _fnc_findRoadConnections);
            };
        } forEach (roadsConnectedTo _road);
    };

    _return
};

private _fnc_isNearIntersection = {
    //Primary logic intersection either has 1 or 2+ connections.
    params ["_road"];

    private _roadConnectedTo = roadsConnectedTo _road;
    private _return = false;

    if ((count _roadConnectedTo != 2)) then {
        _return = true;
    } else {
        {
            if (count (roadsConnectedTo _x) != 2) exitWith { _return = true};
        } forEach (_roadConnectedTo);
    };

    _return
};

// Code start here
_area params ["_center", "_sizeX", "_sizeY", "_dir", "_isRect", "_height"];

private _size = _sizeX max _sizeY;
private _roadPosArray = _center nearRoads _size;
_roadPosArray = _roadPosArray select {count (roadsConnectedTo _x) == 2};

_roadPosArray = _roadPosArray call BIS_fnc_arrayShuffle;

for "_i" from 0 to _vehicleCount do {
    if (_i > (count _roadPosArray) - 2) exitWith {
        WARNING_2("Not enough positions to spawn desired number of vehicles. Spawned %1 out of %2",_i,_vehicleCount);
    };

    private _road = _roadPosArray # 0;
    private _roadConnectedTo = roadsConnectedTo _road;

    if ([_road] call _fnc_isNearIntersection) then {
        // Don't spawn vehicles near intersections, reset.
        _roadPosArray deleteAt 0;
        DEC(_i);
    } else {
        private _connectedRoad = _roadConnectedTo # 0;
        private _roadPos = getPos _road;
        private _newPos = _roadPos;
        private _direction = _road getDir _connectedRoad;
        private _vehicle = selectRandom _vehicles;

        //test either side of the road for more space.
        private _direction2 = _direction + 90;
        private _tempPos = _newPos getPos [0.5, _direction2];

        private _k2 = 0;
        for "_k" from 1 to 15 do {
            _tempPos = _tempPos getPos [0.5, _direction2];

            if ((_tempPos findEmptyPosition [0, 0, _vehicle]) isEqualTo []) exitWith {TRACE_1("Colliding at",_k,_tempPos)};
            _newPos = _tempPos;


            #ifdef DEBUG_MODE_FULL
                private _txt = format [QGVAR(roadDebugMark_%1), GVAR(vehicleDebugMarkers)];
                private _debugMkr = createMarker [_txt,_tempPos];
                _debugMkr setMarkerShape "ICON";
                _debugMkr setMarkerType "hd_dot";
                _debugMkr setMarkerColor "ColorBlue";
                INC(GVAR(vehicleDebugMarkers));
            #endif

            INC(_k2);
        };

        private _jPos = _newPos;
        private _newPos = _roadPos;
        _direction2 = _direction - 90;

        private _j2 = 0;
        for "_j" from 1 to 15 do {
            _tempPos = _tempPos getPos [0.5, _direction2];

            if ((_tempPos findEmptyPosition [0, 0, _vehicle]) isEqualTo []) exitWith {TRACE_1("Colliding at",_j,_tempPos)};
            _newPos = _tempPos;

            #ifdef DEBUG_MODE_FULL
                private _txt = format [QGVAR(roadDebugMark_%1), GVAR(vehicleDebugMarkers)];
                private _debugMkr = createMarker [_txt,_tempPos];
                _debugMkr setMarkerShape "ICON";
                _debugMkr setMarkerType "hd_dot";
                _debugMkr setMarkerColor "ColorGreen";
                INC(GVAR(vehicleDebugMarkers));
            #endif

            INC(_j2);
        };

        if (_j2 + _k2 <= 2) then {
            _direction2 = _direction + 90;
            _newPos = _newPos getPos [0.5, _direction2];
        } else {
            if (_k2 > _j2) then {
                _direction2 = _direction + 90;
                _newPos = _newPos getPos [0.5 * (_k2 - 4), _direction2];
            } else {
                _direction2 = _direction + 90;
                _newPos = _newPos getPos [0.5 * (_j2 - 4), _direction2];
            };
        };

        TRACE_3("Creating vehicle",_vehicle,_newPos,_direction);
        #ifdef DEBUG_MODE_FULL
            private _txt = format [QGVAR(roadDebugMark_%1), GVAR(vehicleDebugMarkers)];
            private _debugMkr = createMarker [_txt, _newPos];
            _debugMkr setMarkerShape "ICON";
            _debugMkr setMarkerType "hd_arrow";
            _debugMkr setMarkerColor "colorCivilian";
            _debugMkr setMarkerDir _direction;
            INC(GVAR(vehicleDebugMarkers));
        #endif

        private _veh = createVehicle [_vehicle, _newPos, [], 0, "NONE"];
        _veh setDir _direction;
        _createdVehicles pushBack _veh;
        [QGVAR(ambientVehicleCreated), [_veh]] call CBA_fnc_localEvent;

        // Handle vehicles getting launched
        _veh allowDamage false;
        [{
            if (speed _this > 1) exitWith {
                ERROR_1("%1 was launched, deleting",_this);
                deleteVehicle _this;
            };
            _this allowDamage true;
        }, _veh, 1] call CBA_fnc_waitAndExecute;

        _roadPosArray = _roadPosArray - ([_road, _spacing] call _fnc_findRoadConnections);
    };
};

_createdVehicles
