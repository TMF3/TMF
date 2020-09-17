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
 * Handles spawning units
 */
params ["_logic"];
private _spawnedVehicles = [];
private _spawnedGroups = [];
private _spawnedUnits = [];
private _spawnedObjects = [];
private _data = _logic getVariable [QGVAR(waveData), []];
_data params ['_groups', '_vehicles', '_objects'];
{
    _x params ["_type", "_pos", "_dir", "_vectorDirAndUp", "_isSimple", "_simulationEnabled","_simpleObjData"];

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
} forEach _objects;

{
    _x params ['_type','_pos','_vectorDirAndUp','_custom', '_pylons'];
    private _formationType = "NONE";
    if((_pos select 2) > 3) then {_formationType = "FLY"};
    private _vehicle = createVehicle [_type, [0,0,0], [], 0, _formationType];
    _vehicle setPosATL _pos;
    _vehicle setVectorDirAndUp _vectorDirAndUp;
    [_vehicle,_custom select 0,_custom select 1] spawn BIS_fnc_initVehicle;

    if(count _pylons > 0) then {
        private _pylonPaths = (configProperties [configFile >> "CfgVehicles" >> typeOf _vehicle >> "Components" >> "TransportPylonsComponent" >> "Pylons", "isClass _x"]) apply {getArray (_x >> "turret")};
        {
            _vehicle removeWeaponGlobal getText (configFile >> "CfgMagazines" >> _x >> "pylonWeapon")
        } forEach getPylonMagazines _vehicle;
        {
            _vehicle setPylonLoadout [_forEachIndex + 1, _x, true, _pylonPaths select _forEachIndex]
        } forEach _pylons;
    };
    _spawnedVehicles pushBack _vehicle;

} forEach _vehicles;

{
    _x params ['_side', '_units', '_waypoints'];

    private _grp = createGroup [_side, true]; // Delete group when empty
    {
        _x params ["_type","_pos","_vectorDirAndUp","_gear", "_vehicleIndex", "_vehicleRole","_disabledAIFeatures"];
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

        {
            _unit disableAI _x;
        } forEach _disabledAIFeatures;
    } forEach _units;
    (units _grp) join _grp;
     _lastIndex = (count waypoints _grp)-1;
    [_grp] call CBA_fnc_clearWaypoints;
    {
        [_grp, _forEachIndex + 1, _x] call CFUNC(deserializeWaypoint);
    } forEach _waypoints;
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
        [_wave,_spawnedGroups,_spawnedUnits,_spawnedVehicles,_spawnedObjects,_logic,_forEachIndex] call _x;
    };
} forEach _handlers;
// Check if there is another wave
if(_logic getVariable ["Waves",1] > 0) then {
    private _time = _logic getvariable ["Time",10];
    private _whenDead = _logic getVariable ["WhenDead",0];

    // Wait for conditions before spawning waves
    [
        {
            //params ["","","_minimumDead","_spawnedUnits", "_targetTime"];
            CBA_missionTime > (_this # 4) &&
            {{!alive _x || lifeState _x isEqualTo "INCAPACITATED"} count (_this # 3) >= (_this # 2)}
        },
        FUNC(spawnWave),
        [_logic,_spawnedGroups,_whenDead * count _spawnedUnits,_spawnedUnits, CBA_missionTime + _time]
    ] call CBA_fnc_waitUntilAndExecute;

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
