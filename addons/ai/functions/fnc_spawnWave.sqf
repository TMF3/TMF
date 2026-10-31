#include "\x\tmf\addons\AI\script_component.hpp"
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
 * Handles spawning units. Spawning is spread over several frames to avoid
 * freezing the machine when a large wave spawns.
 */

// Spawn cost budget per frame. Units and vehicles cost 4, objects cost 1.
#define SPAWN_BUDGET 8
#define COST_OBJECT 1
#define COST_HEAVY 4

params ["_logic"];
private _data = _logic getVariable [QGVAR(waveData), []];
_data params ['_groups', '_vehicles', '_objects'];

// Build a queue of spawn steps: [kind, data]
// 0: object, 1: vehicle, 2: start group, 3: unit, 4: finish group (waypoints)
private _queue = [];
{ _queue pushBack [0, _x] } forEach _objects;
{ _queue pushBack [1, _x] } forEach _vehicles;
{
    _x params ['_side', '_units', '_waypoints'];
    _queue pushBack [2, _side];
    { _queue pushBack [3, _x] } forEach _units;
    _queue pushBack [4, _waypoints];
} forEach _groups;
reverse _queue; // pop from the end

// [groups, units, vehicles, objects, current group side, current group]
private _state = [[], [], [], [], sideUnknown, grpNull];

[{
    params ["_args", "_pfh"];
    _args params ["_logic", "_queue", "_state"];
    _state params ["_spawnedGroups", "_spawnedUnits", "_spawnedVehicles", "_spawnedObjects"];

    private _budget = SPAWN_BUDGET;
    while {_budget > 0 && {_queue isNotEqualTo []}} do {
        (_queue deleteAt (count _queue - 1)) params ["_kind", "_item"];
        switch (_kind) do {
            case 0: {
                _item params ["_type", "_pos", "_dir", "_vectorDirAndUp", "_isSimple", "_simulationEnabled"];
                if (_isSimple) then {
                    private _simpleObj = [_type,_pos, _dir] call BIS_fnc_createSimpleObject;
                    _simpleObj setPosWorld _pos;
                    _simpleObj setVectorDirAndUp _vectorDirAndUp;
                    _spawnedObjects pushBack _simpleObj;
                } else {
                    private _object = createVehicle [_type, _pos, [], 0, "CAN_COLLIDE"];
                    _object setDir _dir;
                    _object setVectorDirAndUp _vectorDirAndUp;
                    _object enableSimulation _simulationEnabled;
                    _spawnedObjects pushBack _object;
                };
                _budget = _budget - COST_OBJECT;
            };
            case 1: {
                _item params ['_type','_pos','_vectorDirAndUp','_custom', '_pylons'];
                private _formationType = ["NONE", "FLY"] select ((_pos select 2) > 3);
                private _vehicle = createVehicle [_type, [0,0,0], [], 0, _formationType];
                _vehicle setPosATL _pos;
                _vehicle setVectorDirAndUp _vectorDirAndUp;
                [_vehicle,_custom select 0,_custom select 1] spawn BIS_fnc_initVehicle;

                if (_pylons isNotEqualTo []) then {
                    private _pylonPaths = (configProperties [configOf _vehicle >> "Components" >> "TransportPylonsComponent" >> "Pylons", "isClass _x"]) apply {getArray (_x >> "turret")};
                    {
                        _vehicle removeWeaponGlobal getText (configFile >> "CfgMagazines" >> _x >> "pylonWeapon")
                    } forEach getPylonMagazines _vehicle;
                    {
                        _vehicle setPylonLoadout [_forEachIndex + 1, _x, true, _pylonPaths select _forEachIndex]
                    } forEach _pylons;
                };
                _spawnedVehicles pushBack _vehicle;
                _budget = _budget - COST_HEAVY;
            };
            case 2: {
                // The group itself is created with its first unit, so an
                // empty group is never left waiting for deleteWhenEmpty.
                _state set [4, _item];
                _state set [5, grpNull];
            };
            case 3: {
                private _grp = _state select 5;
                if (isNull _grp) then {
                    _grp = createGroup [_state select 4, true]; // Delete group when empty
                    _state set [5, _grp];
                    _spawnedGroups pushBack _grp;
                };
                _item params ["_type","_pos","_vectorDirAndUp","_gear", "_vehicleIndex", "_vehicleRole"];
                private _unit = _grp createUnit [_type, [0,0,0],[] , 0, "NONE"];
                _spawnedUnits pushBack _unit;
                _unit setPosATL _pos;
                _unit setUnitLoadout [_gear, false];
                _unit setVectorDirAndUp _vectorDirAndUp;
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
                _budget = _budget - COST_HEAVY;
            };
            case 4: {
                private _grp = _state select 5;
                if (!isNull _grp) then {
                    [_grp] call CBA_fnc_clearWaypoints;
                    {
                        [_grp, _forEachIndex + 1, _x] call CFUNC(deserializeWaypoint);
                    } forEach _item;
                    if((count waypoints _grp) > 1) then {
                        _grp setCurrentWaypoint [_grp,1]; // skip the next one okeyyo..
                    };
                };
            };
        };
    };

    if (_queue isNotEqualTo []) exitWith {};

    // Wave fully spawned
    [_pfh] call CBA_fnc_removePerFrameHandler;

    private _wave = _logic getVariable ["Waves",1];
    _logic setVariable ["Waves", (_wave-1), true];
    private _handlers = _logic getVariable ["Handlers",[]];
    {
        if(_x isEqualType {}) then {
            [_wave,_spawnedGroups,_spawnedUnits,_spawnedVehicles,_spawnedObjects,_logic,_forEachIndex] call _x;
        };
    } forEach _handlers;

    // Check if there is another wave
    if(_logic getVariable ["Waves",1] > 0) then {
        private _time = _logic getVariable ["Time",10];
        private _whenDead = _logic getVariable ["WhenDead",0];

        // Wait for conditions before spawning the next wave, checked once a second
        [{
            params ["_args", "_pfh"];
            _args params ["_logic", "_minimumDead", "_spawnedUnits", "_targetTime"];
            if (CBA_missionTime < _targetTime) exitWith {};
            if ({!alive _x || lifeState _x isEqualTo "INCAPACITATED"} count _spawnedUnits < _minimumDead) exitWith {};

            [_pfh] call CBA_fnc_removePerFrameHandler;
            [_logic] call FUNC(spawnWave);
        }, 1, [_logic, _whenDead * count _spawnedUnits, _spawnedUnits, CBA_missionTime + _time]] call CBA_fnc_addPerFrameHandler;
    } else {
        deleteVehicle _logic;
    };

    [
        format [
            "Spawned wave, unit count: %1, vehicle count: %2, group count %3, object count %4",
            count _spawnedUnits,
            count _spawnedVehicles,
            count _spawnedGroups,
            count _spawnedObjects
        ],
        count _spawnedUnits > 40,
        "AI"
    ] call EFUNC(adminmenu,log);
}, 0, [_logic, _queue, _state]] call CBA_fnc_addPerFrameHandler;
