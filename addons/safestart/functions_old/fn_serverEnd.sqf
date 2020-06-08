#include "\x\tmf\addons\safestart\script_component.hpp"
params ["_module"];

// disable module
_module setVariable [QGVAR(enabled),false,true];

// Take care of AI units
private _units = _module getVariable [QGVAR(units),[]];
{
    private _EH = _x getVariable [QGVAR(eventhandler),-1];
    if (_EH != -1) then {
        _x removeEventHandler ["fired",_EH];
        _x enableAI "TARGET";
        _x enableAI "AUTOTARGET";
        _x allowDamage true;
    };
} forEach _units;
