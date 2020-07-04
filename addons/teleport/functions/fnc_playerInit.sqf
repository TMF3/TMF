#include "\x\tmf\addons\teleport\script_component.hpp"
params ["_duration","_alt","_parachute","_leadersOnly"];
_str = [];
if(_leadersOnly) then {_str pushBack "group"};
if(_parachute) then {_str pushback "parachute"};
_text = "";
_str pushBack "teleport";
{
  if(_forEachIndex != 0) then {_x = " " +_x}
  else {
    _x = [_x] call CFUNC(capitalize);
  };
  _text = _text + _x;
}  forEach _str;
_action = player addAction [_text, {_this call FUNC(onAction)}, _this, 6, true, true, "", "_target == _this"];
uiSleep _duration;
player removeAction _action;
