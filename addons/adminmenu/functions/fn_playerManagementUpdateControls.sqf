#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_display"];

private _list = _display displayCtrl IDC_TMF_ADMINMENU_PMAN_LIST;
private _ctrlGrp = ctrlParentControlsGroup _list;

/*private _ctrlGrp = _display displayCtrl IDC_TMF_ADMINMENU_PMAN_LISTGROUP;
if (isNull _ctrlGrp) then {
	_ctrlGrp = (_display displayCtrl IDC_TMF_ADMINMENU_G_PMAN) controlsGroupCtrl IDC_TMF_ADMINMENU_PMAN_LISTGROUP;

	if (isNull _ctrlGrp) then {
		diag_log "_ctrlGrp still bad";
	};
};*/

private _numControls = count GVAR(playerManagement_listControls);
private _adjustControls = (lbSize _list) - _numControls;
//private _selected = (lbSelection _list) apply {_list lbData _x};

//systemChat format ["CONTROL PRE  Players: %1 | List rows: %2 | _adjustControls: %3 | Controls: %4", count GVAR(playerManagement_players), lbSize _list, _adjustControls, count GVAR(playerManagement_listControls)];
diag_log format ["CONTROL PRE  Players: %1 | List rows: %2 | _adjustControls: %3 | Controls: %4", count GVAR(playerManagement_players), lbSize _list, _adjustControls, count GVAR(playerManagement_listControls)];

// match control rows with listbox
if (_adjustControls > 0) then { // create more
	private _xPos = [
		TMF_ADMINMENU_PMAN_X_DEAD,
		TMF_ADMINMENU_PMAN_X_SIDE,
		TMF_ADMINMENU_PMAN_X_QRESP,
		TMF_ADMINMENU_PMAN_X_STEAM
	];
	private _stdWidth = TMF_ADMINMENU_STD_WIDTH;
	private _stdHeight = TMF_ADMINMENU_STD_HEIGHT;

	(ctrlPosition _ctrlGrp) params ["_grpX", "_grpY"];
	
	for "_i" from _numControls to (_numControls + _adjustControls - 1) do {
		private _ctrlDead = _display ctrlCreate ["RscPictureKeepAspect", -1, _ctrlGrp];
		_ctrlDead ctrlSetText "\a3\Ui_F_Curator\Data\CfgMarkers\kia_ca.paa";

		private _ctrlSide = _display ctrlCreate ["RscPictureKeepAspect", -1, _ctrlGrp];
		_ctrl ctrlSetFontHeight (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8);

		private _ctrlQResp = _display ctrlCreate ["RscPictureKeepAspect", -1, _ctrlGrp];
		_ctrlQResp ctrlSetText "\a3\ui_f\data\IGUI\RscTitles\MPProgress\respawn_ca.paa";
		_ctrlQResp ctrlSetTooltip "Quick Respawn the player to their pre-death state";

		private _ctrlSteam = _display ctrlCreate ["RscStructuredText", -1, _ctrlGrp];
		_ctrlSteam ctrlSetTooltip "Open Steam profile";

		{
			_x ctrlSetPosition [
				_grpX + (_xPos param [_forEachIndex]),
				_grpY + (_stdHeight * (_i - 1)),
				_stdWidth,
				_stdHeight
			];
			_x ctrlCommit 0;
		} forEach [_ctrlDead, _ctrlSide, _ctrlQResp, _ctrlSteam];

		GVAR(playerManagement_listControls) pushBack [_ctrlDead, _ctrlSide, _ctrlQResp, _ctrlSteam];
	};
} else {
	if (_adjustControls < 0) then { // delete overflow
		private _toDelete = [];
		for "_i" from (lbSize _list) to ((count GVAR(playerManagement_listControls)) - 1) do {
			_toDelete append (GVAR(playerManagement_listControls) param [_i]);
		};

		GVAR(playerManagement_listControls)	resize lbSize _list;

		{
			ctrlDelete _x;
		} forEach _toDelete;
	};
};

// update list and controlgroup heights
private _listPos = ctrlPosition _list;
_listPos set [3, (((lbSize _list) + 1) * TMF_ADMINMENU_STD_HEIGHT) max TMF_ADMINMENU_PMAN_H_LISTGROUP];
_list ctrlSetPosition _listPos;
_list ctrlCommit 0;

// update control rows data
{
	private _player = _x call BIS_fnc_objectFromNetId;
	(GVAR(playerManagement_listControls) param [_forEachIndex]) params ["_ctrlDead", "_ctrlSide", "_ctrlQResp", "_ctrlSteam"];

	private _isSpectator = _player isKindOf QEGVAR(spectator,unit);
	private _side = side _player;
	if (_isSpectator) then {
		_side = _player getVariable [QEGVAR(spectator,side), sideUnknown];
		_ctrlDead ctrlShow true; // player must be dead; show dead icon

		if (count (_player getVariable [QEGVAR(spectator,deathData), []]) >= 5) then { // enough data available for quick respawn
			_ctrlQResp ctrlRemoveAllEventHandlers "MouseButtonClick";
			_ctrlQResp ctrlAddEventHandler ["MouseButtonClick", format ["(param [0]) ctrlEnable false; %1 call %2", _x, QFUNC(quickRespawn)]];
			_ctrlQResp ctrlShow true;
			_ctrlQResp ctrlEnable true;
		} else {
			_ctrlQResp ctrlShow false;
			_ctrlQResp ctrlEnable false;
		};
	} else {
		_ctrlDead ctrlShow false;
		_ctrlQResp ctrlShow false;
		_ctrlQResp ctrlEnable false;
	};

	private _color = [0.9,0.8,0,0.8];
	switch (_side) do {
		case blufor: { 
			_color = GVAR(sideColors) param [0];
		};
		case opfor: { 
			_color = GVAR(sideColors) param [1];
		};
		case independent: { 
			_color = GVAR(sideColors) param [2];
		};
		case civilian: { 
			_color = GVAR(sideColors) param [3];
		};
		case sideLogic: { 
			_color = [1,1,1,0.8];
		};
	};

	if (isNil QGVAR(sideColors)) then {
		systemChat format ["%1 nil", QGVAR(sideColors)];
		diag_log format ["%1 nil", QGVAR(sideColors)];
	} else {
		private _test = GVAR(sideColors) param [0];

		if (isNil "_test") then {
			systemChat format ["%1 nil", "_test"];
			diag_log format ["%1 nil", "_test"];
		} else {
			systemChat format ["%1 _test", _test];
			diag_log format ["%1 _test", _test];
		};
	};

	diag_log "a color:";
	diag_log format ["#(argb,8,8,3)color(%1,%2,%3,%4)", _color param [0], _color param [1], _color param [2], _color param [3]];
	_ctrlSide ctrlSetText format ["#(argb,8,8,3)color(%1,%2,%3,%4)", _color param [0], _color param [1], _color param [2], _color param [3]];

	_ctrlSteam ctrlSetStructuredText parseText format [
		"<a href='http://steamcommunity.com/profiles/%1' size='0.4'><img image='%2'/></a>", 
		getPlayerUID _player, 
		"\a3\ui_f\data\GUI\RscCommon\RscButtonMenuSteam\steam_ca.paa"
	];

	if (random 2 > 1) then {
		_ctrlSteam ctrlSetStructuredText parseText format [
			"<a href='http://steamcommunity.com/profiles/%1'><img image='%2' size='0.4'/></a>", 
			getPlayerUID _player, 
			"\a3\ui_f\data\GUI\RscCommon\RscButtonMenuSteam\steam_ca.paa"
		];

		if (random 2 > 1) then {
			_ctrlSteam ctrlSetStructuredText parseText format [
				"<a href='http://steamcommunity.com/profiles/%1' size='0.4'><img image='%2' size='0.4'/></a>", 
				getPlayerUID _player, 
				"\a3\ui_f\data\GUI\RscCommon\RscButtonMenuSteam\steam_ca.paa"
			];
		};
	};
} forEach GVAR(playerManagement_players);

//systemChat format ["CONTROL POST Players: %1 | List rows: %2 | _adjustControls: %3 | Controls: %4", count GVAR(playerManagement_players), lbSize _list, _adjustControls, count GVAR(playerManagement_listControls)];
diag_log format ["CONTROL POST Players: %1 | List rows: %2 | _adjustControls: %3 | Controls: %4", count GVAR(playerManagement_players), lbSize _list, _adjustControls, count GVAR(playerManagement_listControls)];