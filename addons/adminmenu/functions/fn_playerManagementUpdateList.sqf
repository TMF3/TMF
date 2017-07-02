#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_display"];

systemChat format ["%1 %2", QFUNC(playerManagementUpdateList), time];

private _filterSide = [sideUnknown, blufor, opfor, resistance, civilian] param [lbCurSel (_display displayCtrl IDC_TMF_ADMINMENU_PMAN_FILTER_SIDE)];
private _filterState = lbCurSel (_display displayCtrl IDC_TMF_ADMINMENU_PMAN_FILTER_STATE);

private _allPlayers = allPlayers - entities "HeadlessClient_F";
/*private _allPlayers = (allPlayers - entities "HeadlessClient_F") apply {[name _x, _x]};
_allPlayers sort true;
_allPlayers = _allPlayers apply {_x param [1]};*/

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
		private _text;
		private _role;
		if (_x isKindOf QEGVAR(spectator,unit)) then {
			_text = groupId (_x getVariable [QEGVAR(spectator,group), grpNull]);
			_role = _x getVariable [QEGVAR(spectator,role), ""];
		} else {
			_text = groupId group _x;
			_role = _x getVariable [QEGVAR(assigngear,role), ""];
		};

		if (count _role > 0) then {
			if (count _text > 0) then {
				_text = format ["%1 - %2", _text, _role];
			} else {
				_text = _role;
			};
		};

		private _idx = count _newPlayers;
		if (_idx >= lbSize _list) then {
			_list lbAdd name _x;
		} else {
			_list lbSetText [_idx, name _x];
		};
		_list lbSetTextRight [_idx, _textRight];
		
		private _netId = _x call BIS_fnc_netId;
		_list lbSetSelected [_idx, _netId in GVAR(playerManagement_selected)];
		_list lbSetData [_idx, _netId];
		_newPlayers pushBack _netId;
	};
} forEach _allPlayers;

GVAR(playerManagement_players) = _newPlayers;
GVAR(playerManagement_selected) = GVAR(playerManagement_selected) arrayIntersect GVAR(playerManagement_players);

for "_i" from (count _newPlayers) to ((lbSize _list) - 1) do {
	_list lbDelete _i;
};

lbSort _list;

[{
	_this call FUNC(playerManagementUpdateControls);
}, _display, 0.1] call CBA_fnc_waitAndExecute;