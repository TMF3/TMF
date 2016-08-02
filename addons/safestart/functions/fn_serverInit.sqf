#include "\x\tmf\addons\safestart\script_component.hpp"


params ["_logic","_units","_activated"];

switch (_logic getVariable ["TMFUnits",-1]) do {
    case (-1): {
        _units append allUnits;
    };
    case (0): {
        _units = synchronizedObjects _logic;
    };
    case (1): {
        {
          _grpUnits = units _x;
          {
            if(!(_x in _units)) then {_units pushBack _x};
          } forEach _grpUnits;
        } forEach synchronizedObjects _logic;
        
    };
    case (2): {
      {
        _side = side _x;
        {
          if(_side == side _x ) then {
            if(!(_x in _units)) then {_units pushBack _x};
          };
        } forEach allUnits;
      } forEach synchronizedObjects _logic;
    };
};

if(_activated) then {
    _duration = _logic getVariable ["Duration",120];
    _broadcastUnits = _units select {isPlayer _x};
    _units = _broadcastUnits - _units;
    if(count _broadcastUnits > 0) then {
        [_duration] remoteExec [QFUNC(playerInit), _broadcastUnits];
    };
    {
        _x setVariable [QGVAR(eventhandler), (_x addEventHandler ["fired",{deleteVehicle (_this select 6)}])];
        _x disableAI "TARGET";
        _x disableAI "AUTOTARGET";
        _x allowDamage false;
    } forEach _units;
    uiSleep _duration;
    {
        private _EH = _x getVariable [QGVAR(eventhandler),-1];
        // Ensure unit wasn't created after safe start started.
        if (_EH != -1) then {
            _x removeEventHandler ["fired",_EH];
            _x enableAI "TARGET";
            _x enableAI "AUTOTARGET";
            _x allowDamage true;
        };
    } forEach _units;
};
