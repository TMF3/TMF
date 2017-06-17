disableSerialization;
params ["_display"];

// Show dashboard when opening the admin menu, hide other tabs
(_display displayCtrl 56200) ctrlEnable true;
(_display displayCtrl 56200) ctrlShow true;
{
	(_display displayCtrl _x) ctrlShow false;
	(_display displayCtrl _x) ctrlEnable false;
} forEach [56300, 56400];

[true] remoteExec ["tmf_adminMenu_fnc_fpsHandlerServer", 2];