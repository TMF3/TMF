#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_display"];
uiNamespace setVariable [QGVAR(display), _display];


if (!isMultiplayer) then {
	(_display displayCtrl IDC_TMF_ADMINMENU_DASH_CURRADMIN) ctrlSetText "none (singleplayer)";
};

private _ctrl = _display displayCtrl IDC_TMF_ADMINMENU_PMAN_FILTER_STATE;
{
	_ctrl lbAdd _x;
} forEach ["Alive and Dead", "Alive", "Dead"];
_ctrl lbSetCurSel 0;
_ctrl ctrlAddEventHandler ["LBSelChanged", format ["[ctrlParent (param [0])] call %1;", QFUNC(playerManagementFilter)]];

_ctrl = _display displayCtrl IDC_TMF_ADMINMENU_PMAN_FILTER_SIDE;
{
	_x params ["_color", "_text"];
	_ctrl lbAdd _text;
	_ctrl lbSetPicture [_forEachIndex, QPATHTOF(square_ca.paa)];
	_ctrl lbSetPictureColor [_forEachIndex, _color];
	_ctrl lbSetPictureColorSelected [_forEachIndex, _color];
} forEach [
	[[1,1,1,0.8], "All Sides"], 
	[[profilenamespace getvariable ['Map_BLUFOR_R',0], profilenamespace getvariable ['Map_BLUFOR_G',0], profilenamespace getvariable ['Map_BLUFOR_B',1], 0.8], "BLUFOR"], // fetch from profile vars
	[[profilenamespace getvariable ['Map_OPFOR_R',1], profilenamespace getvariable ['Map_OPFOR_G',0], profilenamespace getvariable ['Map_OPFOR_B',0], 0.8], "OPFOR"],
	[[profilenamespace getvariable ['Map_Independent_R',0], profilenamespace getvariable ['Map_Independent_G',1], profilenamespace getvariable ['Map_Independent_B',0], 0.8], "Independent"],
	[[profilenamespace getvariable ['Map_Civilian_R',0.5], profilenamespace getvariable ['Map_Civilian_G',0], profilenamespace getvariable ['Map_Civilian_B',0.5], 0.8], "Civilian"]
];
_ctrl lbSetCurSel 0;
_ctrl ctrlAddEventHandler ["LBSelChanged", format ["[ctrlParent (param [0])] call %1;", QFUNC(playerManagementFilter)]];

// Register client as server FPS receiver
[true] remoteExec [QFUNC(fpsHandlerServer), 2];

// Show dashboard when opening the admin menu, hide other tabs
[_display] call FUNC(selectTab);