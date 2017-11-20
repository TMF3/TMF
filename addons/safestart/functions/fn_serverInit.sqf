#include "\x\tmf\addons\safestart\script_component.hpp"


params ["_logic","_units","_activated"];
_units = [_logic] call CFUNC(moduleUnits);
if(_activated) then {
    private _duration =_logic getVariable ["Duration",-1];
    _logic setVariable [QGVAR(enabled),true,true];
    private _broadcastUnits = _units select {isPlayer _x};
    _units = _units - _broadcastUnits;

    if(count _broadcastUnits > 0) then {
        [_logic,_duration] remoteExec [QFUNC(playerStart), _broadcastUnits];
    };

    _logic setVariable [QGVAR(units),_units];

    // take care of AI units.
    {
        _x setVariable [QGVAR(eventhandler), (_x addEventHandler ["fired",{deleteVehicle (_this select 6)}])];
        _x disableAI "TARGET";
        _x disableAI "AUTOTARGET";
        _x allowDamage false;
    } forEach _units;

    // if we dont have a duration set, we have to disable it manually
    if(_duration > 0) then {
        [{
            params ["_params"];
            _params params ["_logic"];
            _duration = _logic getVariable ["Duration",-1];
            if(_duration > 0) then {
                _duration = _duration - 1;
            } else {
              [_logic] call FUNC(serverEnd);
            };
            _logic setVariable ["Duration",_duration];
        },1,[_logic]] call CBA_fnc_addPerFrameHandler;
    };
};
