#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_display", ["_reset", false, [false]]];

while {count GVAR(tabPFHHandles) > 0} do {
	[GVAR(tabPFHHandles) deleteAt 0] call CBA_fnc_removePerFrameHandler;
};

if (_reset) then {
	(_display displayCtrl IDC_TMF_ADMINMENU_PMAN_FILTER_SIDE) lbSetCurSel 0;
	(_display displayCtrl IDC_TMF_ADMINMENU_PMAN_FILTER_STATE) lbSetCurSel 0;
};

_display call FUNC(playerManagementUpdateList);

private _pfhUpdate = [{
	(param [1]) call FUNC(playerManagementUpdateList);
}, 3, _display] call CBA_fnc_addPerFrameHandler;

GVAR(tabPFHHandles) pushBack _pfhUpdate;