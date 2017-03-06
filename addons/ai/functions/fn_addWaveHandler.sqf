// Add eventhandler to wave spawner
// local only.
params ["_logic","_code"];
_handlers = _logic getVariable ["Handlers", []];
_index = _code pushBack _handlers;
_logic setVariable ["Handlers", _handlers, false];
_index
