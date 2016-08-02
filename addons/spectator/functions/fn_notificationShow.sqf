#include "\x\tmf\addons\spectator\script_component.hpp"
params [["_message","error",[""]]];


if(_message == "") then {_message = "Error: Empty string"};
GVAR(notification) pushBack _message;