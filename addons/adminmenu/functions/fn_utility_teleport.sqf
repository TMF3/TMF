#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_display", "_ctrlGroup"];

GVAR(utility_teleport_toggle) = false;

(ctrlPosition _ctrlGroup) params ["", "", "_ctrlGrpWidth", "_ctrlGrpHeight"];

private _ctrlMap = _display ctrlCreate ["RscMapControl", -1, _ctrlGroup];
GVAR(utilityTabControls) = [_ctrlMap];
private _ctrlMapPos = ctrlPosition _ctrlGroup; // map controls dont support pos relative to group
_ctrlMapPos set [0, (_ctrlMapPos select 0) + (0.5 * TMF_ADMINMENU_STD_WIDTH)];
_ctrlMapPos set [1, (_ctrlMapPos select 1) + (0.5 * TMF_ADMINMENU_STD_HEIGHT)];
_ctrlMapPos set [2, (_ctrlMapPos select 2) - (1 * TMF_ADMINMENU_STD_WIDTH)];
//_ctrlMapPos set [3, (_ctrlMapPos select 3) - (2.1 * TMF_ADMINMENU_STD_HEIGHT)];
_ctrlMapPos set [3, (_ctrlMapPos select 3) - (5.1 * TMF_ADMINMENU_STD_HEIGHT)];
_ctrlMap ctrlSetPosition _ctrlMapPos;
_ctrlMap ctrlCommit 0;
_ctrlMap ctrlAddEventHandler ["mouseButtonClick", {
	params ["_ctrlMap", "", "_pos_x", "_pos_y"];

	private _toggle = missionNamespace getVariable [QGVAR(utility_teleport_toggle), false];
	if (_toggle) then {
		GVAR(utility_teleport_toggle) = !_toggle;
		(GVAR(utilityTabControls) select 2) ctrlSetText (["Enable Teleport", "Disable Teleport"] select GVAR(utility_teleport_toggle));

		private _pos = (_ctrlMap ctrlMapScreenToWorld [_pos_x, _pos_y]) findEmptyPosition [0, 25];
		{
			_x setPos _pos;
			"[TMF Admin Menu] You were teleported" remoteExec ["systemChat", _x];
		} forEach GVAR(utilityData);

		systemChat format ["[TMF Admin Menu] Teleported %1 players", count GVAR(utilityData)];
	};
}];

private _newX = (_ctrlGrpHeight * (3/4)) + (0.1 * TMF_ADMINMENU_STD_WIDTH);
private _newW = ((ctrlPosition _ctrlGroup) select 2) - _newX;

private _ctrlHint = _display ctrlCreate [QGVAR(RscText), -1, _ctrlGroup];
GVAR(utilityTabControls) pushBack _ctrlHint;
_ctrlHint ctrlSetPosition [0, _ctrlGrpHeight - TMF_ADMINMENU_STD_HEIGHT, 0.8 * _ctrlGrpWidth, TMF_ADMINMENU_STD_HEIGHT];
_ctrlHint ctrlCommit 0;
_ctrlHint ctrlSetText "After locating the destination area, press the Enable Teleport button and then click the desired location on the map.";

private _ctrlButton = _display ctrlCreate [QGVAR(RscButtonMenu), -1, _ctrlGroup];
GVAR(utilityTabControls) pushBack _ctrlButton;
_ctrlButton ctrlSetPosition [0.8 * _ctrlGrpWidth, _ctrlGrpHeight - TMF_ADMINMENU_STD_HEIGHT, 0.2 * _ctrlGrpWidth, TMF_ADMINMENU_STD_HEIGHT];
_ctrlButton ctrlCommit 0;
_ctrlButton ctrlSetText "Enable Teleport";
_ctrlButton ctrlAddEventHandler ["buttonClick", {
	GVAR(utility_teleport_toggle) = !(missionNamespace getVariable [QGVAR(utility_teleport_toggle), false]);
	(_this select 0) ctrlSetText (["Enable Teleport", "Disable Teleport"] select GVAR(utility_teleport_toggle));
}];
