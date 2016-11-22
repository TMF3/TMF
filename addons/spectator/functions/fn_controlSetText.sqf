#include "\x\tmf\addons\spectator\script_component.hpp"
params ["_control","_text",["_color",[]],["_subtext",false]];
disableSerialization;

private _textControl = controlNull;

if(!_subtext) then {_textControl = _control controlsGroupCtrl 2;}
else {_textControl = _control controlsGroupCtrl 3;};

_textControl ctrlSetText _text;
if(!isnil "_color" && {count _color == 4}) then {
    _textControl ctrlSetTextColor _color;
};
