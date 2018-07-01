#include "\x\tmf\addons\teleport\script_component.hpp"
[{time > 0},{
    params ["_logic","_units","_activated"];
    if(_activated) then {
        _units = [_logic] call CFUNC(moduleUnits);
        _pos = getpos _logic;
        {
            _uPos = _pos vectorAdd [random 100 - random 100,random 100 - random 100,random 15 - random 15];
            [_x,_uPos] remoteExecCall [QFUNC(paraDrop),_x];
        } foreach _units;
    };
},_this] call CBA_fnc_waitUntilAndExecute;