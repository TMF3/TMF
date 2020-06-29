/*
 * Name: TMF_ai_fnc_spawnWave
 * Author: Head, Snippers
 *
 * Arguments:
 * 0: TMF WaveSpawner logic
 *
 * Return:
 * N/A
 *
 * Description:
 * Handles spawning units
 */
#include "\x\tmf\addons\AI\script_component.hpp"
params ["_logic"];
private _spawnedVehicles = [];
private _spawnedGroups = [];
private _data = _logic getVariable [QGVAR(waveData), []];
_data params ['_groups', '_vehicles'];
{
    _x params ['_type','_pos','_dir','_custom'];
    private _formationType = "NONE";
    if((_pos select 2) > 3) then {_formationType = "FLY"};
    private _vehicle = createVehicle [_type, [0,0,0], [], 0, _formationType];
    _vehicle setPosATL _pos;
    _vehicle setDir _dir;
    [_vehicle,_custom select 0,_custom select 1] spawn BIS_fnc_initVehicle;
    _spawnedVehicles pushBack _vehicle;

} forEach _vehicles;

{
    _x params ['_side', '_units', '_waypoints'];

    private _grp = createGroup [_side, true]; // Delete group when empty
    {
        _x params ["_type","_pos","_dir","_gear", "_vehicleIndex", "_vehicleRole","_disabledAI"];
        private _unit = _grp createUnit [_type, [0,0,0],[] , 0, "NONE"];
        _unit setPosATL _pos;
        _unit setUnitLoadout [_gear, false];
        _unit setDir _dir;
        if (_vehicleIndex >= 0) then {
            private _vehicle = _spawnedVehicles # _vehicleIndex;
            _vehicleRole params ["_role", "_path"];
            _role = toLower _role;
            switch(_role) do {
                case 'driver': {
                    _unit assignAsDriver _vehicle;
                    _unit moveInDriver _vehicle;
                };
                case 'cargo': {
                    if(isNil '_path') then {
                        _unit assignAsCargo _vehicle;
                        _unit moveInCargo _vehicle;
                    } else {
                        if(_path isEqualType []) then {
                            _unit assignAsTurret [_vehicle, _path];
                            _unit moveInTurret [_vehicle, _path];
                        } else {
                            _unit assignAsCargoIndex [_vehicle, _path];
                            _unit moveInCargo [_vehicle, _path];
                        }
                    }
                };
                case 'turret': {
                    _unit assignAsTurret [_vehicle, _path];
                    _unit moveInTurret [_vehicle, _path];
                };
            };
        };

        {
            _unit disableAI (_x # 0);
        } forEach (_disabledAI select {!(_x # 1)});
    } forEach _units;
    (units _grp) join _grp;
     _lastIndex = (count waypoints _grp)-1;
    [_grp] call CBA_fnc_clearWaypoints;
    for "_i" from 0 to ((count _waypoints) - 1) step 1 do {
        _way = _waypoints select _i;

        // TODO fix this shit

        _w = _grp addWaypoint [_way select 1, 0,(_i+1),_way select 0];
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
} forEach _groups;

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
