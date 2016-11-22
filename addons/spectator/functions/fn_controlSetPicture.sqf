#include "\x\tmf\addons\spectator\script_component.hpp"
params ["_control","_picturePath","_color"];
disableSerialization;
private _image = (_control controlsGroupCtrl 1);
if(_picturePath != "") then {
    _image ctrlSetText _picturePath;
};
_image ctrlSetTextColor _color;
