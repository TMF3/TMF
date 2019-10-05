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
        private _vehicles = [];
        { if(vehicle _x != _x) then {_vehicles pushBackUnique (vehicle _x)}; } foreach units _x;
        private _units = (units _x select {vehicle _x == _x}) apply
        {
            if ((_x getVariable [QEGVAR(assigngear,done), ""]) isEqualTo "") then
            {
                [typeof _x,getposATL _x,getDir _x,getUnitLoadout _x]
            }
            else
            {
                private _arr = [
                    _x getVariable QEGVAR(assigngear,faction),
                    _x getVariable QEGVAR(assigngear,role)
                ];
                if !(_arr isEqualTypeArray ["",""]) then
                {
                    _arr = getUnitLoadout _x;
                };
                [typeof _x,getposATL _x,getDir _x,_arr]
            };
        };
        _vehicles  = _vehicles apply
        {
            [
                typeof _x,
                getposATL _x,
                getDir _x,
                [_x] call BIS_fnc_getVehicleCustomization,
                crew _x apply
                {
                    if ((_x getVariable [QEGVAR(assigngear,done), ""]) isEqualTo "") then
                    {
                        [typeof _x,getposATL _x,getDir _x,getUnitLoadout _x]
                    }
                    else
                    {
                        private _arr = [
                            _x getVariable QEGVAR(assigngear,faction),
                            _x getVariable QEGVAR(assigngear,role)
                        ];
                        if !(_arr isEqualTypeArray ["",""]) then
                        {
                            _arr = getUnitLoadout _x;
                        };
                        [typeof _x,getposATL _x,getDir _x,_arr]
                    };
                }
            ]
        };
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

    _logic setVariable [QGVAR(init),true,true];
};


if(_activated) then {
    private _delay = _logic getVariable ["Delay",0];
    [FUNC(spawnWave),[_logic],_delay] call CBA_fnc_waitAndExecute;
};

