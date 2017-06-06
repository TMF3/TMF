if(is3DEN) exitWith {};
#include "\x\tmf\addons\AI\script_component.hpp"
params ["_logic","_units","_activated"];

_headless = (synchronizedObjects _logic) select {_x isKindOf "HeadlessClient_F" && !local _x};
if(count _headless > 0 && isServer) exitWith {
    _this remoteExec [QFUNC(waveInit), _headless select 0];
};

// check if we have done the setup.
if(!(_logic getVariable [QGVAR(init),false])) then {
    private _allgroups = [];
    
    {if(side group _x in [blufor,opfor,independent,civilian]) then {_allgroups pushBackUnique group _x};} foreach (synchronizedObjects _logic);

    _data = _allgroups apply {
        _vehicles = [];
        { if(vehicle _x != _x) then {_vehicles pushBackUnique (vehicle _x)}; } foreach units _x;
        private _units = (units _x select {vehicle _x == _x}) apply {[typeof _x,getposATL _x,getDir _x,getUnitLoadout _x]};
        private _vehicles  = _vehicles apply {[typeof _x,getposATL _x,getDir _x,crew _x apply {[typeof _x,getpos _x,getUnitLoadout _x]}]};
        [side _x,_units ,_vehicles,[_x] call CFUNC(serializeWaypoints)];
    };

    _logic setVariable [QGVAR(waveData), _data];

    // Delete the old units/grps
    {
        _units = units _x;
        {
            if(vehicle _x != _x) then {_units pushBackUnique vehicle _x};
            deleteVehicle _x;
        } foreach _units;
    } foreach _allgroups;

    _logic setVariable [QGVAR(init),true];
};


if(_activated) then {
    private _delay = _logic getVariable ["Delay",0];
    [FUNC(spawnWave),[_logic],_delay] call CBA_fnc_waitAndExecute;
};
