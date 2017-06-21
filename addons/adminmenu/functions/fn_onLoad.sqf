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

[true] remoteExec [QFUNC(fpsHandlerServer), 2];


(_display displayCtrl 56207) ctrlEnable false; // disable safestart cancel button for demo

if (!isMultiplayer) then {
	//((_display displayCtrl 56200) controlsGroupCtrl 56208) ctrlSetText "none (singleplayer)";
	(_display displayCtrl 56208) ctrlSetText "none (singleplayer)";
};