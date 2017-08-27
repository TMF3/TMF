disableSerialization;
params ["_button"];
_button ctrlEnable false;

[{
    disableSerialization;
    params ["_button"];
    _button ctrlEnable true;
}, _button, 0.5] call CBA_fnc_waitAndExecute;
