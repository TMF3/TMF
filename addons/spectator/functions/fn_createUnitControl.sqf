#include "\x\tmf\addons\spectator\script_component.hpp"
params ["_unit"];
disableSerialization;
private _color = (side group _unit) call CFUNC(sideToColor);
private _control = (findDisplay 5454) ctrlCreate [QGVAR(EntityTag), -1];

_control ctrlShow false;

[_control,"\A3\ui_f\data\map\markers\military\triangle_CA.paa",_color] call FUNC(controlSetPicture);
[_control,name _unit] call FUNC(controlSetText);
[_control,"",[],true] call FUNC(controlSetText);
_unit setVariable [QGVAR(tagControl), [_control]];
_control setVariable [QGVAR(attached),_unit];
GVAR(controls) pushBack _control;
