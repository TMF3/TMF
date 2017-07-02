#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_display"];

systemChat format ["selected: %1", GVAR(playerManagement_selected)];
systemChat format ["selected: %1", count GVAR(playerManagement_selected)];