#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_display", "_ctrlGroup", "_data"];
GVAR(utility_teleport_players) = _data;

private _ctrlMap = _display ctrlCreate ["RscMapControl", -1, _ctrlGroup];
GVAR(utilityTabControls) = [_ctrlMap];
private _ctrlMapPos = ctrlPosition _ctrlGroup; // map controls dont support pos relative to group
private _ctrlGrpHeight = _ctrlMapPos select 3;
_ctrlMapPos set [2, _ctrlGrpHeight * (3/4)];
_ctrlMapPos set [3, _ctrlGrpHeight * 0.5];
_ctrlMap ctrlSetPosition _ctrlMapPos;
_ctrlMap ctrlCommit 0;
_ctrlMap ctrlAddEventHandler ["mouseButtonClick", {
	params ["_ctrlMap", "", "_pos_x", "_pos_y"];
	//systemChat format ["_ctrlMap mouseButtonClick | x/y: %1 | %2: %3", [_pos_x, _pos_y], QGVAR(utility_teleport_toggle), missionNamespace getVariable [QGVAR(utility_teleport_toggle), false]];

	if (missionNamespace getVariable [QGVAR(utility_teleport_toggle), false]) then {
		private _pos = (_ctrlMap ctrlMapScreenToWorld [_pos_x, _pos_y]) findEmptyPosition [0, 25];
		{
			_x setPos _pos;
			"[TMF Admin Menu] You were teleported" remoteExec ["systemChat", _x];
		} forEach GVAR(utility_teleport_players);

		systemChat format ["[TMF Admin Menu] Teleported %1 players", count GVAR(utility_teleport_players)];

		/*_ctrlMap ctrlEnable false;
		if (!isNil QGVAR(selectedTab)) then {
			[ctrlParent _ctrlMap, GVAR(selectedTab)] call FUNC(selectTab);
		};*/
	};
}];

private _newX = (_ctrlGrpHeight * (3/4)) + (0.1 * (((safezoneW / safezoneH) min 1.2) / 40));
private _newW = ((ctrlPosition _ctrlGroup) select 2) - _newX;

private _ctrlHint = _display ctrlCreate [QGVAR(RscTextMultiline), -1, _ctrlGroup];
GVAR(utilityTabControls) pushBack _ctrlHint;
_ctrlHint ctrlSetPosition [_newX, 0, _newW, 2 * TMF_ADMINMENU_STD_HEIGHT];
_ctrlHint ctrlCommit 0;
_ctrlHint ctrlSetText "After locating the destination area, press the Enable Teleport button and then click the desired location on the map.";

private _ctrlButton = _display ctrlCreate [QGVAR(RscButtonMenu), -1, _ctrlGroup];
GVAR(utilityTabControls) pushBack _ctrlButton;
_ctrlButton ctrlSetPosition [_newX, _ctrlGrpHeight - TMF_ADMINMENU_STD_HEIGHT, _newW, TMF_ADMINMENU_STD_HEIGHT];
_ctrlButton ctrlCommit 0;
_ctrlButton ctrlSetText "Enable Teleport";
_ctrlButton ctrlAddEventHandler ["buttonClick", {
	GVAR(utility_teleport_toggle) = !(missionNamespace getVariable [QGVAR(utility_teleport_toggle), false]);
	(_this select 0) ctrlSetText (["Enable Teleport", "Disable Teleport"] select GVAR(utility_teleport_toggle));
	//systemChat format ["_ctrlButton buttonClick | %1: %2", QGVAR(utility_teleport_toggle), GVAR(utility_teleport_toggle)];
}];