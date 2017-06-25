#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_display"];

// Populate ending list
// Populate side-specific combos with victory, defeat - or change to toolboxes

/*if (!isNil QGVAR(selectedEndMissionCheckbox)) then {
	[_display] call FUNC(endMissionOccluder);
};*/

[_display] call FUNC(endMissionOccluder);