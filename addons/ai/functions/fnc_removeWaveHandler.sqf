// Remove eventhandler from wave spawner
// local only.
params ["_logic","_index"];
_hanlders = _logic getVariable ["Handlers", []];
if(count _handlers < _index) exitWith {false};
_hanlders set [_index,{}];
true
