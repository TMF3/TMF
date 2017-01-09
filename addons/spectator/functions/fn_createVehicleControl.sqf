#include "\x\tmf\addons\spectator\script_component.hpp"
params ["_veh"];
disableSerialization;
private _color = [1,1,1,1];
private _control = (findDisplay 5454) ctrlCreate [QGVAR(EntityTag), -1];

_control ctrlShow false;

[_control,"\a3\ui_f\data\map\Markers\military\box_CA.paa",_color] call FUNC(controlSetPicture);
[_control,getText (configFile >> "CfgVehicles" >> typeof _veh >> "displayName")] call FUNC(controlSetText);

_veh setVariable [QGVAR(tagControl), [_control]];
_control setVariable [QGVAR(attached),_veh];
GVAR(controls) pushBack _control;
