#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_display"];

// Populate ending list
// Populate side-specific combos with victory, defeat - or change to toolboxes

[_display, 0] call FUNC(endMissionOccluder);