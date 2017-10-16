#include "\x\tmf\addons\AI\script_component.hpp"
params ["_logic"];
_spawnedGroups = [];
_data = _logic getVariable [QGVAR(waveData), []];
{
    _x params ["_side","_units","_vehicles","_waypoints"];

    private _grp = createGroup [_side, true]; // Delete group when empty

    {
        _x params ["_type","_pos","_dir","_gear"];
        _unit = _grp createUnit [_type, _pos,[] , 0, "NONE"];
        _unit setPosATL _pos;
        _unit setUnitLoadout [_gear, false];
        _unit setDir _dir;
    } forEach _units;


    {
        _x params ["_type","_pos","_dir","_units"];
        private _formationType = "NONE";
        if((_pos select 2) > 3) then {_formationType = "FLY"};
        _vehicle = createVehicle [_type, _pos, [], 0, _formationType];
        _vehicle setPosATL _pos;
        _vehicle setDir _dir;
        {
            _x params ["_type","_pos","_gear"];
            _unit = _grp createUnit [_type, _pos,[] , 0, "NONE"];
            _unit moveInAny _vehicle;
            _unit setUnitLoadout [_gear, false];
        } forEach _units;
    } forEach _vehicles;


    _lastIndex = (count waypoints _grp)-1;
    for "_i" from 0 to ((count _waypoints) - 1) step 1 do {
        _way = _waypoints select _i;

        // TODO fix this shit

        _w = _grp addWaypoint [_way select 1, 0,_i,_way select 0];
        _w setWaypointType (_way select 2);
        _w setWaypointBehaviour (_way select 3);
        _w setWaypointCombatMode (_way select 4);
        _w setWaypointDescription (_way select 5);
        _w setWaypointFormation (_way select 6);
        _w setWaypointHousePosition (_way select 7);
        _w setWaypointScript (_way select 8);
        _w showWaypoint (_way select 9);
        _w setWaypointSpeed (_way select 10);
        _w setWaypointTimeout (_way select 11);
        _w setWaypointVisible (_way select 12);
    };
    if((count waypoints _grp) > 1) then {
        _grp setCurrentWaypoint [_grp,1]; // skip the next one okeyyo..
    };
    _spawnedGroups pushBack _grp;
} forEach _data;

_wave = _logic getVariable ["Waves",1];
_logic setVariable ["Waves", (_wave-1)];
_handlers = _logic getVariable ["Handlers",[]];
{
    if(_x isEqualType {}) then {
        [_wave,_spawnedGroups] call _x;
    };
} forEach _handlers;
// Check if there is another wave
if(_logic getVariable ["Waves",1] > 0) then {

    // Check if we need to wait for them to die
    if(_logic getVariable ["WhenDead",false]) then {
        [{ {{alive _x} count (units _x) > 0 } count (_this select 1) <= 0 },FUNC(spawnWave), [_logic,_spawnedGroups]] call CBA_fnc_waitUntilAndExecute;
    }
    else {  // Otherwise spawn the wave after sleeping for some time
        [FUNC(spawnWave), [_logic], _logic getvariable ["Time",10]] call CBA_fnc_waitAndExecute;
    };

};
