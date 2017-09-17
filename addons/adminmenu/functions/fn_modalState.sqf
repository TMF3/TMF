#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;

if (isNil QGVAR(modalDisplay)) exitWith {false};
if (isNull GVAR(modalDisplay)) exitWith {false};
true
