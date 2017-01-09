#include "\x\tmf\addons\spectator\script_component.hpp"
params ["_control","_picturePath","_color"];
disableSerialization;
private _image = (_control controlsGroupCtrl 1);
if(_picturePath != "" && {_control getVariable [QGVAR(lastImage),""] != _picturePath}) then {
    _image ctrlSetText _picturePath;
    _control setVariable [QGVAR(lastImage),_picturePath];
};
if(!(_control getVariable [QGVAR(lastColor),""] isEqualTo _color)) then {
    _image ctrlSetTextColor _color;
    _control setVariable [QGVAR(lastColor),_color];
};
