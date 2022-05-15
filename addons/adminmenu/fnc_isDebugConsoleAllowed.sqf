#include "\x\tmf\addons\adminmenu\script_component.hpp"

([] call BIS_fnc_isDebugConsoleAllowed_old || {[player, "debugConsole"] call FUNC(isAuthorized)})
