#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_display"];
uiNamespace setVariable [QGVAR(display), _display];

// Show dashboard when opening the admin menu, hide other tabs
(_display displayCtrl IDC_TMF_ADMINMENU_G_DASH) ctrlEnable true;
(_display displayCtrl IDC_TMF_ADMINMENU_G_DASH) ctrlShow true;
{
	(_display displayCtrl _x) ctrlShow false;
	(_display displayCtrl _x) ctrlEnable false;
} forEach IDCS_TMF_ADMINMENU_GRPS - [IDC_TMF_ADMINMENU_G_DASH];

// Disable 'current admin' field
(_display displayCtrl IDC_TMF_ADMINMENU_DASH_CURRADMIN) ctrlEnable false;

if (!isMultiplayer) then {
	(_display displayCtrl IDC_TMF_ADMINMENU_DASH_CURRADMIN) ctrlSetText "none (singleplayer)";
};

[true] remoteExec [QFUNC(fpsHandlerServer), 2];