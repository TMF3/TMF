#include "\x\tmf\addons\teleport\script_component.hpp"
params ["_duration","_alt","_parachute","_leadersOnly"];
private _str = [];
if(_leadersOnly) then {_str pushBack "group"};
if(_parachute) then {_str pushBack "parachute"};
_str pushBack "teleport";
_str set [0, [_str select 0] call CFUNC(capitalize)];
private _text = _str joinString " ";
private _action = player addAction [_text, {_this call FUNC(onAction)}, _this, 6, true, true, "", "_target == _this"];
uiSleep _duration;
player removeAction _action;
