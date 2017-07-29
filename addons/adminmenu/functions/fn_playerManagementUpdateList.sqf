#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_display"];

private _list = _display displayCtrl IDC_TMF_ADMINMENU_PMAN_LIST;
private _filterSide = [sideUnknown, blufor, opfor, resistance, civilian] param [(lbCurSel (_display displayCtrl IDC_TMF_ADMINMENU_PMAN_FILTER_SIDE)) max 0];
private _filterState = (lbCurSel (_display displayCtrl IDC_TMF_ADMINMENU_PMAN_FILTER_STATE)) max 0;

private _allPlayers = allPlayers - entities "HeadlessClient_F";
if (!isMultiplayer) then {
	_allPlayers = switchableUnits;
};

private _newPlayers = [];

{
	private _addPlayer = [true, alive _x, !alive _x] param [_filterState];

	private _isSpectator = _x isKindOf QEGVAR(spectator,unit);
	private _playerSide = side _x;

	if (_addPlayer && !(_filterSide isEqualTo sideUnknown)) then {
		if (_isSpectator) then {
			_playerSide = (_x getVariable [QEGVAR(spectator,side), sideUnknown]);
		};

		_addPlayer = _playerSide isEqualTo _filterSide;
	};

	if (_addPlayer) then {
		private _text = "";
		private _role = "";

		if (_isSpectator) then {
			_text = groupId (_x getVariable [QEGVAR(spectator,group), grpNull]);
			_role = toUpper (_x getVariable [QEGVAR(spectator,role), ""]);
		} else {
			_text = groupId group _x;
			_role = toUpper (_x getVariable [QEGVAR(assigngear,role), ""]);
		};

		if (count _role > 0) then {
			if (count _text > 0) then {
				_text = format ["%1: %2", _text, _role];
			} else {
				_text = _role;
			};
		};

		private _idx = count _newPlayers;
		if (_idx >= lbSize _list) then {
			_idx = _list lbAdd name _x;
			_list lbSetPictureRight [_idx, "\a3\ui_f\data\IGUI\RscTitles\MPProgress\respawn_ca.paa"];
		} else {
			_list lbSetText [_idx, name _x];
		};
		_list lbSetTextRight [_idx, _text];
		
		private _netId = _x call BIS_fnc_netId;
		_list lbSetSelected [_idx, _netId in GVAR(playerManagement_selected)];
		_list lbSetData [_idx, _netId];
		_newPlayers pushBack _netId;

		private _sideColor = [1,1,1,0.8];
		private _sideTexture = "\a3\Ui_F_Curator\Data\CfgMarkers\kia_ca.paa";

		//if (_isSpectator) then {
		if ((random 1) < 0.5) then {
			_list lbSetColor [_idx, [0.6,0.6,0.6,1]];
			_list lbSetColorRight [_idx, [0.6,0.6,0.6,1]];

			switch (_playerSide) do {
				case blufor: { 
					_sideColor = GVAR(sideColors) param [0];
				};
				case opfor: { 
					_sideColor = GVAR(sideColors) param [1];
				};
				case independent: { 
					_sideColor = GVAR(sideColors) param [2];
				};
				case civilian: { 
					_sideColor = GVAR(sideColors) param [3];
				};
				case sideLogic: {
					_sideColor = [0.9,0.8,0,0.8];
				};
			};
			
			_list lbSetPicture [_idx, _sideTexture];
			_list lbSetPictureColor [_idx, _sideColor];
			_list lbSetPictureColorSelected [_idx, _sideColor];

			if ((random 1) < 0.5) then {
				_list lbSetPictureRightColor [_idx, [1,1,1,0.8]];
			} else {
				_list lbSetPictureRightColor [_idx, [1,1,1,0]];
			};
		} else {
			_list lbSetColor [_idx, [1,1,1,1]];
			_list lbSetColorRight [_idx, [1,1,1,1]];

			switch (_playerSide) do {
				case blufor: { 
					_sideTexture = "\a3\ui_f\data\Map\Diary\Icons\playerWest_ca.paa"; 
				};
				case opfor: { 
					_sideTexture = "\a3\ui_f\data\Map\Diary\Icons\playerEast_ca.paa";
				};
				case independent: { 
					_sideTexture = "\a3\ui_f\data\Map\Diary\Icons\playerGuer_ca.paa";
				};
				case civilian: { 
					_sideTexture = "\a3\ui_f\data\Map\Diary\Icons\playerCiv_ca.paa";
				};
				case sideLogic: {
					_sideTexture = "\a3\ui_f\data\Map\Diary\Icons\playerVirtual_ca.paa";
				};
				default {
					_sideTexture = "\a3\ui_f\data\Map\Diary\Icons\playerBriefUnknown_ca.paa";
				};
			};

			_list lbSetPicture [_idx, _sideTexture];
			_list lbSetPictureColor [_idx, _sideColor];
			_list lbSetPictureColorSelected [_idx, _sideColor];
			_list lbSetPictureRightColor [_idx, [1,1,1,0]];
		};
	};
	
	//diag_log format ["PMAN LIST ICON for idx %1: %2 | %3 | %4 | %5 | %6", _idx, _x, str _playerSide, str _sideColor, str _sideTexture, str _isSpectator];
} forEach _allPlayers;

GVAR(playerManagement_players) = +_newPlayers;
GVAR(playerManagement_selected) = GVAR(playerManagement_selected) arrayIntersect GVAR(playerManagement_players);

while {(lbSize _list) > count _newPlayers} do {
	_list lbDelete ((lbSize _list) - 1);
};

lbSort _list;