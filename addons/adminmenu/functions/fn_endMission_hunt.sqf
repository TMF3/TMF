#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;

[format ["%1 triggered hunt manually",profileName],true,"[TMF Admin Menu] "] call FUNC(log);
[QGVAR(hunt), []] call CBA_fnc_serverEvent;

