#include "../script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: TMF_ambient_fnc_ambientVehicleInit

Description:
    Initializes the Ambient Vehicles module,
    wrapper for the createAmbienVehicles function.

Parameters:
    Standard module parameters

Returns:
    Nothing

Author:
    Freddo
---------------------------------------------------------------------------- */

if !isServer exitWith {};

params ["_mode", "_input"];
TRACE_2("Initializing Ambient Vehicles module",_mode,_input);
_input params ["_logic"];

private _code =             _logic getVariable [QGVAR(code), ""];
private _lockedRate =       _logic getVariable [QGVAR(lockedRate), 0];
private _spacing =          _logic getVariable [QGVAR(spacing), 2];
private _vehicleNumber =    _logic getVariable [QGVAR(vehicleNumber), 5];

private _syncedObjects = [];
if is3DEN then {
    private _connections = (get3DENConnections _logic) select {(_x # 0) isEqualTo "Sync"};
    _syncedObjects = _connections apply {_x # 1};
} else {
    _syncedObjects = synchronizedObjects _logic;
};

private _area = (_syncedObjects select {_x isKindOf QEGVAR(ai,area)}) param [0, objNull];
private _syncedVehicles = _syncedObjects select {_x isKindOf "LandVehicle" && !(_x isKindOf "CAManBase")};
private _vehicleTypes = _syncedVehicles apply {typeOf _x};

if (isNull _area) exitWith {
    if (_mode == "init") then {
        ERROR_MSG("No area module synchronized to Ambient Vehicles module: %1",_logic);
    };
};

if (_vehicleTypes isEqualTo []) exitWith {
    if (_mode == "init") then {
        ERROR_MSG("No vehicles synchronized to Ambient Vehicles module: %1",_logic);
    };
};

// Parse area into an accepted format
if (is3DEN) then {
    _area = [
        getPos _area,

            ((_area get3DENAttribute "size2") # 0) +
            [direction _area,
            (_area get3DENAttribute "IsRectangle") # 0]

    ] call BIS_fnc_getArea;
} else {
    _area = [getPos _area,_area getVariable "objectarea"] call BIS_fnc_getArea;
};

switch _mode do {
	// Default object init
	case "init": {
        _input params ["", "_isActivated", "_isCuratorPlaced"];

        {deleteVehicle _x} forEach _syncedVehicles;

        if !(_isActivated) exitWith {};

        private _vehicles = [_area, _vehicleTypes, _vehicleNumber, _spacing] call FUNC(createAmbientVehicles);

        {
            _x call _code;

            if (random 1 < _lockedRate) then {
                _x setVehicleLock "LOCKED";
                ["init",_x] call bis_fnc_carAlarm;
            };
        } forEach _vehicles;

        _logic setVariable ["spawnedVehicles", _vehicles, true];
	};

	// When some attributes were changed (including position and rotation)
	case "attributesChanged3DEN";
	// When connection to object changes (i.e., new one is added or existing one removed)
	case "connectionChanged3DEN": {
        {
            deleteVehicle _x;
        } forEach (_logic getVariable ["spawnedVehicles", []]);

        private _vehicles = [_area, _vehicleTypes, _vehicleNumber, _spacing] call FUNC(createAmbientVehicles);
        _logic setVariable ["spawnedVehicles", _vehicles, true];
	};

	// When removed from the world (i.e., by deletion or undoing creation)
	case "unregisteredFromWorld3DEN": {
        {
            deleteVehicle _x;
        } forEach (_logic getVariable ["spawnedVehicles", []]);
	};
};

nil
