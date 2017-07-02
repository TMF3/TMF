#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_display"];

systemChat format ["%1 %2", QFUNC(playerManagementUpdateList), time];

private _list = _display displayCtrl IDC_TMF_ADMINMENU_PMAN_LIST;
private _filterSide = [sideUnknown, blufor, opfor, resistance, civilian] param [(lbCurSel (_display displayCtrl IDC_TMF_ADMINMENU_PMAN_FILTER_SIDE)) max 0];
private _filterState = (lbCurSel (_display displayCtrl IDC_TMF_ADMINMENU_PMAN_FILTER_STATE)) max 0;


systemChat format ["update side filter %1, %2", _filterSide, lbCurSel (_display displayCtrl IDC_TMF_ADMINMENU_PMAN_FILTER_SIDE)];
diag_log format ["update side filter %1, %2", _filterSide, lbCurSel (_display displayCtrl IDC_TMF_ADMINMENU_PMAN_FILTER_SIDE)];

/*private _allPlayers = (allPlayers - entities "HeadlessClient_F") apply {[name _x, _x]};
_allPlayers sort true;
_allPlayers = _allPlayers apply {_x param [1]};*/

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
				diag_log format ["_this is spectator : %1", _this];

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
			systemChat format ["is spectator: %1, %2", _x, name _x];
			diag_log format ["is spectator: %1, %2", _x, name _x];

			_text = groupId (_x getVariable [QEGVAR(spectator,group), grpNull]);
			_role = toUpper (_x getVariable [QEGVAR(spectator,role), ""]);
		} else {
			_text = groupId group _x;
			_role = toUpper (_x getVariable [QEGVAR(assigngear,role), ""]);
		};

		if (count _role > 0) then {
			if (count _text > 0) then {
				_text = format ["%1  -  %2", _text, _role];
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

		if (!(_text isEqualType "string")) then {
			_text = "any...";
		};

		_list lbSetTextRight [_idx, _text];
		
		private _netId = _x call BIS_fnc_netId;
		_list lbSetSelected [_idx, _netId in GVAR(playerManagement_selected)];
		_list lbSetData [_idx, _netId];
		_newPlayers pushBack _netId;

		//systemChat format ["_allPlayers: %1 | _newPlayers: %2 | list: %3 | this: %4", count _allPlayers, count _newPlayers, lbSize _list, [name _x, _text, _netId]];
	};
} forEach _allPlayers;

GVAR(playerManagement_players) = +_newPlayers;
GVAR(playerManagement_selected) = GVAR(playerManagement_selected) arrayIntersect GVAR(playerManagement_players);

systemChat format ["Players: %1 | List rows: %2 | Deleting from %3 to %4", count GVAR(playerManagement_players), lbSize _list, count _newPlayers, (lbSize _list) - 1];
diag_log format ["Players: %1 | List rows: %2 | Deleting from %3 to %4", count GVAR(playerManagement_players), lbSize _list, count _newPlayers, (lbSize _list) - 1];

while {(lbSize _list) > count _newPlayers} do {
	_list lbDelete ((lbSize _list) - 1);
};

lbSort _list;

[{
	_this call FUNC(playerManagementUpdateControls);
}, _display, 0.1] call CBA_fnc_waitAndExecute;