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

	if (_addPlayer && !(_filterSide isEqualTo sideUnknown)) then {
		private _playerSide = _x call {
			if (_this isKindOf QEGVAR(spectator,unit)) exitWith {
				_this getVariable [QEGVAR(spectator,side), sideUnknown];
			};
			side _this;
		};

		_addPlayer = _playerSide isEqualTo _filterSide;
	};

	if (_addPlayer) then {
		private _text = "";
		private _role = "";
		if (_x isKindOf QEGVAR(spectator,unit)) then {
			_text = groupId (_x getVariable [QEGVAR(spectator,group), grpNull]);
			_role = toUpper (_x getVariable [QEGVAR(spectator,role), ""]);
		} else {
			_text = groupId group _x;
			_role = toUpper (_x getVariable [QEGVAR(assigngear,role), ""]);
		};

		if (count _role > 0) then {
			if (count _text > 0) then {
				_text = format ["%1:    %2", _text, _role];
			} else {
				_text = _role;
			};
		};

		private _idx = count _newPlayers;
		if (_idx >= lbSize _list) then {
			_idx = _list lbAdd name _x;
		} else {
			_list lbSetText [_idx, name _x];
		};

		_list lbSetTextRight [_idx, _text];
		
		private _netId = _x call BIS_fnc_netId;
		_list lbSetSelected [_idx, _netId in GVAR(playerManagement_selected)];
		_list lbSetData [_idx, _netId];
		_newPlayers pushBack _netId;
	};
} forEach _allPlayers;

GVAR(playerManagement_players) = +_newPlayers;
GVAR(playerManagement_selected) = GVAR(playerManagement_selected) arrayIntersect GVAR(playerManagement_players);

while {(lbSize _list) > count _newPlayers} do {
	_list lbDelete ((lbSize _list) - 1);
};

// update list and controlgroup heights
private _listPos = ctrlPosition _list;
//_listPos set [3, ((lbSize _list) + (linearConversion [0, 200, lbSize _list, 0, 2])) * TMF_ADMINMENU_STD_HEIGHT];
_listPos set [3, ((lbSize _list) min 1) * TMF_ADMINMENU_STD_HEIGHT];
_list ctrlSetPosition _listPos;
_list ctrlCommit 0;

diag_log "_list height 1 2:";
diag_log ((lbSize _list) * TMF_ADMINMENU_STD_HEIGHT);
diag_log (((lbSize _list) + (linearConversion [0, 200, lbSize _list, 0, 2])) * TMF_ADMINMENU_STD_HEIGHT);

lbSort _list;

[{
	_this call FUNC(playerManagementUpdateControls);
}, _display, 0.1] call CBA_fnc_waitAndExecute;