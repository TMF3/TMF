#include "\x\tmf\addons\spectator\script_component.hpp"
params ["_control","_text",["_color",[]],["_subtext",false]];
disableSerialization;

private _textControl = controlNull;

if (!_subtext) then {_textControl = _control controlsGroupCtrl 2;}
else {_textControl = _control controlsGroupCtrl 3;};
if (!(_textControl getVariable [QGVAR(lastText),""] isEqualTo _text)) then {
    _textControl ctrlSetText _text;
    _textControl setVariable [QGVAR(lastText),_text];
};
if (!isnil "_color" && {count _color == 4}) then {
    _textControl ctrlSetTextColor _color;
};
