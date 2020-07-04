/*
 * Author: Head
 * Set control text for a 3D tag
 *
 * Arguments:
 * 0: _control
 * 1: _text
 * 2: _color
 * 3: _subtext - Controls if its the subtext being set or the main text.
 *
 * Return Value:
 * nil
 *
 * Example:
 * [_control,"mytext",[1,1,1,1],false] call tmf_spectator_fnc_controlSetPicture
 *
 * Public: No
 */
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
