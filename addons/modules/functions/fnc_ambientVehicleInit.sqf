#include "../script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: TMF_modules_fnc_ambientVehicleInit

Description:
    Initializes the Ambient Vehicles module,
    wrapper for the createAmbientVehicles function.

Parameters:
    Standard module parameters

Returns:
    Nothing

Author:
    Freddo
---------------------------------------------------------------------------- */

params ["_mode", "_input"];
TRACE_2("Initializing Ambient Vehicles module",_mode,_input);
_input params ["_logic"];

private _code = _logic getVariable [QGVAR(code), ""];
private _lockedRate = _logic getVariable [QGVAR(lockedRate), 0];
private _spacing = _logic getVariable [QGVAR(spacing), 2];
private _vehicleNumber = _logic getVariable [QGVAR(vehicleNumber), 5];
private _emptyCargo = _logic getVariable [QGVAR(emptyCargo), false];

switch _mode do {
    // Default object init
    case "init": {
        _input params ["", "_isActivated", "_isCuratorPlaced"];

        if !(_isActivated) exitWith {
            // Clean up vehicles far from players when deactivated on repeatable triggers
            private _count = 0;
            {
                private _obj = _x;
                // Assumes that triggers are set at least 500m away
                if (alive _obj && (allPlayers findIf {_x distance2D _obj < 500}) == -1) then {
                    deleteVehicle _obj;
                    TRACE_2("Ambient vehicles despawning vehicle",_logic,_obj);
                    INC(_count);
                };
            } forEach (_logic getVariable [QGVAR(spawnedVehicles), []]);
            TRACE_2("Ambient vehicles finished despawning vehicles",_logic,_count);
            _logic setVariable [QGVAR(vehicleNumber), _count, true];
            true
        };

        if (isNil {_logic getVariable QGVAR(data)}) then {
            TRACE_1("Ambient Vehicles post init run before pre init, running preinit now",_logic);
            ["preInit", _logic] call FUNC(ambientVehicleInit);
        };

        private _moduleData = _logic getVariable QGVAR(data);
        ASSERT_DEFINED("_moduleData","Ambient Vehicles module failed init, postInit ran before preInit!");

        _moduleData params [
            ["_vehicleTypes", []],
            ["_area", []]
        ];

        if (_area isEqualTo [] || {_area isEqualTo ([] call BIS_fnc_getArea)}) exitWith {
            ERROR_MSG("No area module synchronized to Ambient Vehicles module: %1",_logic);
        };

        if (_vehicleTypes isEqualTo []) exitWith {
            ERROR_MSG("No vehicles synchronized to Ambient Vehicles module: %1",_logic);
        };

        private _vehicles = [_area, _vehicleTypes, _vehicleNumber, _spacing] call FUNC(createAmbientVehicles);

        {
            if (_emptyCargo) then {
                clearWeaponCargoGlobal _x;
                clearMagazineCargoGlobal _x;
                clearItemCargoGlobal _x;
                clearBackpackCargoGlobal _x;
            };

            if (random 1 < _lockedRate) then {
                _x setVehicleLock "LOCKED";
                ["init",_x] call bis_fnc_carAlarm;
            };

            _x call _code;

        } forEach _vehicles;

        TRACE_2("Ambient Vehicles module spawned vehicles",_logic,_vehicles);

        _logic setVariable [QGVAR(spawnedVehicles), _vehicles, true];
    };

    case "preInit": {
        private ["_syncedObjects", "_area"];

        private _moduleData = _logic getVariable QGVAR(data);
        if (!is3DEN && !isNil "_moduleData") exitWith {
            TRACE_2("Tried to run preInit on Ambient Vehicles module, but preInit has already been run",_logic,_moduleData);
        };

        if is3DEN then {
            private _connections = (get3DENConnections _logic);;
            FILTER(_connections,(_x select 0) isEqualTo "Sync");
            _syncedObjects = _connections apply {_x # 1};
            _area = (_syncedObjects select {_x isKindOf QEGVAR(ai,area)}) param [0, objNull];

            ((_area get3DENAttribute "size2") # 0) params [
                "_a",
                "_b"
            ];

            _area = [
                getPos _area,
                [
                    _a,
                    _b,
                    direction _area,
                    (_area get3DENAttribute "IsRectangle") # 0
                ]
            ] call BIS_fnc_getArea;
        } else {
            _syncedObjects = synchronizedObjects _logic;
            _area = (_syncedObjects select {_x isKindOf QEGVAR(ai,area)}) param [0, objNull];
            _area = [getPos _area,_area getVariable "objectarea"] call BIS_fnc_getArea;
        };

        _syncedObjects = _syncedObjects select {
            (_x call BIS_fnc_objectType) params ["_category", "_type"];
            _category in ["Vehicle", "VehicleAutonomous", "Object"] &&
            !(_type in [
                "Ship", "Submarine",
                "Animal", "Camera", "Effect", "Fire", "Marker", "Parachute",
                "Seagull", "Sound", "Target", "Trigger", "UnknownObject", "VASI"
            ])
        };
        private _vehicleTypes = _syncedObjects apply {typeOf _x};

        // Clean up objects later
        [{
            {
                deleteVehicle _x;
            } forEach _this;
        }, _syncedObjects] call CBA_fnc_execNextFrame;

        TRACE_2("Ambient Vehicle PreInit run with result",_vehicleTypes,_area);
        _logic setVariable [QGVAR(data), [_vehicleTypes, _area]];
    };

    // When some attributes were changed (including position and rotation)
    case "attributesChanged3DEN";
    // When connection to object changes (i.e., new one is added or existing one removed)
    case "connectionChanged3DEN": {
        ["preInit", [_logic]] call FUNC(ambientVehicleInit);

        (_logic getVariable QGVAR(data)) params [
            ["_vehicleTypes", []],
            ["_area", objNull]
        ];

        {
            deleteVehicle _x;
        } forEach (_logic getVariable [QGVAR(spawnedVehicles), []]);

        private _vehicles = [_area, _vehicleTypes, _vehicleNumber, _spacing] call FUNC(createAmbientVehicles);
        {_x call _code;} forEach _vehicles;

        _logic setVariable [QGVAR(spawnedVehicles), _vehicles, true];
    };

    // When removed from the world (i.e., by deletion or undoing creation)
    case "unregisteredFromWorld3DEN": {
        {
            deleteVehicle _x;
        } forEach (_logic getVariable [QGVAR(spawnedVehicles), []]);
    };
};
true
