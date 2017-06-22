#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_display"];
uiNamespace setVariable [QGVAR(display), _display];

// Show dashboard when opening the admin menu, hide other tabs
(_display displayCtrl 56200) ctrlEnable true;
(_display displayCtrl 56200) ctrlShow true;
{
	(_display displayCtrl _x) ctrlShow false;
	(_display displayCtrl _x) ctrlEnable false;
} forEach [56300, 56400, 56500];

// Disable current admin textfield
(_display displayCtrl 56207) ctrlEnable false;

if (!isMultiplayer) then {
	(_display displayCtrl 56207) ctrlSetText "none (singleplayer)";
};

[true] remoteExec [QFUNC(fpsHandlerServer), 2];