#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_display", ["_reset", false, [false]]];

if (_reset) then {
	(_display displayCtrl IDC_TMF_ADMINMENU_PMAN_FILTER_SIDE) lbSetCurSel 0;
	(_display displayCtrl IDC_TMF_ADMINMENU_PMAN_FILTER_STATE) lbSetCurSel 0;
};

_display call FUNC(playerManagementUpdateList);