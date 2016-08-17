// Add eventhandler to wave spawner
// local only.
params ["_logic","_code"];
_hanlders = _logic getVariable ["Handlers", []];
_index = _code pushBack _hanlders;
_logic setVariable ["Handlers", _hanlders, false];
_index
