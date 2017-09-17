#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_display"];
uiNamespace setVariable [QGVAR(display), _display];

{
    (_display displayCtrl _x) ctrlEnable false;
    (_display displayCtrl _x) ctrlShow false;
} forEach IDCS_TMF_ADMINMENU_UTIL;

if (!isMultiplayer) then {
    (_display displayCtrl IDC_TMF_ADMINMENU_DASH_CURRADMIN) ctrlSetText "none (singleplayer)";
};

private _ctrl = _display displayCtrl IDC_TMF_ADMINMENU_DASH_SPECTATORTALK;
_ctrl cbSetChecked ([] call acre_api_fnc_isSpectator);
_ctrl ctrlAddEventHandler ["CheckedChanged", {[[false, true] select (param [1])] call acre_api_fnc_setSpectator;}];

_ctrl = _display displayCtrl IDC_TMF_ADMINMENU_PMAN_FILTER_STATE;
{
    _ctrl lbAdd _x;
} forEach ["Alive and Dead", "Alive", "Dead"];
_ctrl lbSetCurSel 0;
_ctrl ctrlAddEventHandler ["LBSelChanged", format ["[ctrlParent (param [0])] call %1;", QFUNC(playerManagement_filter)]];

_ctrl = _display displayCtrl IDC_TMF_ADMINMENU_PMAN_FILTER_SIDE;
{
    _x params ["_color", "_text"];
    _ctrl lbAdd _text;
    _ctrl lbSetPicture [_forEachIndex, QPATHTOF(square_ca.paa)];
    _ctrl lbSetPictureColor [_forEachIndex, _color];
    _ctrl lbSetPictureColorSelected [_forEachIndex, _color];
} forEach [
    [sideLogic call FUNC(sideToColor), "All Sides"],
    [blufor call FUNC(sideToColor), "BLUFOR"], // fetch from profile vars
    [opfor call FUNC(sideToColor), "OPFOR"],
    [resistance call FUNC(sideToColor), "Independent"],
    [civilian call FUNC(sideToColor), "Civilian"]
];
_ctrl lbSetCurSel 0;
_ctrl ctrlAddEventHandler ["LBSelChanged", format ["[ctrlParent (param [0])] call %1;", QFUNC(playerManagement_filter)]];

// Register client as server FPS receiver
[true] remoteExec [QFUNC(fpsHandlerServer), 2];

// Show dashboard when opening the admin menu, hide other tabs
[_display] call FUNC(selectTab);
