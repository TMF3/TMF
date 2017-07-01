#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_display"];

private _list = _display displayCtrl IDC_TMF_ADMINMENU_PMAN_LIST;
private _ctrlGrp = _display displayCtrl IDC_TMF_ADMINMENU_PMAN_LISTGROUP;
private _adjustControls = (lbSize _list) - count GVAR(playerManagement_listControls);
private _selected = (lbSelection _list) apply {_list lbData _x};

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

	for "_i" from 1 to _adjustControls do {
		private _ctrlDead = _display ctrlCreate ["RscPictureKeepAspect", -1, _ctrlGrp];
		_ctrlQResp ctrlSetText "\a3\Ui_F_Curator\Data\CfgMarkers\kia_ca.paa";

		private _ctrlSide = _display ctrlCreate ["RscPictureKeepAspect", -1, _ctrlGrp];
		_ctrlQResp ctrlSetText QPATHTOF(square_ca.paa);

		private _ctrlQResp = _display ctrlCreate ["RscPictureKeepAspect", -1, _ctrlGrp];
		_ctrlQResp ctrlSetText "\a3\ui_f\data\IGUI\RscTitles\MPProgress\respawn_ca.paa";

		private _ctrlSteam = _display ctrlCreate ["RscStructuredText", -1, _ctrlGrp];

		{
			_x ctrlSetPosition [
				_xPos param [_forEachIndex],
				_stdHeight * (_i - 1),
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
_listPos set [3, ((lbSize _list) * TMF_ADMINMENU_STD_HEIGHT) max TMF_ADMINMENU_PMAN_H_LISTGROUP];
_list ctrlSetPosition _listPos;
_list ctrlCommit 0;

// update control rows data
{
	private _player = _x call BIS_fnc_objectFromNetId;
	(GVAR(playerManagement_listControls) param [_forEachIndex]) params ["_ctrlDead", "_ctrlSide", "_ctrlQResp", "_ctrlSteam"];

	private _isSpectator = _player isKindOf QEGVAR(spectator,unit);
	private _side;
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
		_side = side _player;
		_ctrlDead ctrlShow false;
		_ctrlQResp ctrlShow false;
		_ctrlQResp ctrlEnable false;
	};

	private _color = switch (_side) do {
		case blufor: { GVAR(sideColors) param [0] };
		case opfor: { GVAR(sideColors) param [1] };
		case independent: { GVAR(sideColors) param [2] };
		case civilian: { GVAR(sideColors) param [3] };
		case sideLogic: { [1,1,1,1] };
		default { [0.9,0.8,0,1] }; // yellow?
	};
	_ctrlSide ctrlSetTextColor _color;

	private _steamLink = parseText format [
		"<a href='http://steamcommunity.com/profiles/%1'><img image='%2'/></a>", 
		getPlayerUID _player, 
		"\a3\ui_f\data\GUI\RscCommon\RscButtonMenuSteam\steam_ca.paa"
	];
	
	if (!(_steamLink isEqualTo (ctrlStructuredText _ctrlSteam))) then { // avoid flickering
		_ctrlSteam ctrlSetStructuredText _steamLink;
	};
} forEach GVAR(playerManagement_players);

private _ctrlUpdateFlash = _display displayCtrl IDC_TMF_ADMINMENU_PMAN_UPDATEFLASH;
_ctrlUpdateFlash ctrlSetFade 0;
_ctrlUpdateFlash ctrlCommit 0;
_ctrlUpdateFlash ctrlSetFade 1;
_ctrlUpdateFlash ctrlCommit 2;