#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_display"];

private _list = _display displayCtrl IDC_TMF_ADMINMENU_PMAN_LIST;
_list lnbAddColumn 0; // dead skull
_list lnbAddColumn 0.0625; // side icon
_list lnbAddColumn 0.125; // player name
_list lnbAddColumn 0.625; // group name
_list lnbAddColumn 0.875; // role name

private _filterSide = [sideUnknown, blufor, opfor, resistance, civilian] param [lbCurSel (_display displayCtrl IDC_TMF_ADMINMENU_PMAN_FILTER_SIDE)];
private _filterState = lbCurSel (_display displayCtrl IDC_TMF_ADMINMENU_PMAN_FILTER_STATE);

private _allPlayers = allPlayers apply {[name _x, _x]};
_allPlayers sort true;
_allPlayers = _allPlayers apply {_x param [1]};

{
	private _addPlayer = [true, alive _x, !alive _x] param [_filterState];
	
	if (_addPlayer && !(_filterSide isEqualTo sideUnknown)) then {
		_addPlayer = (side _x) isEqualTo _filterSide;
	};

	if (_addPlayer) then {
		private _idx = _list lnbAddRow ["", "", name _x, groupId group _x, toUpper (_x getVariable [QEGVAR(assigngear,role),"-"])];
		_list lnbSetData [[_idx, 0], _x call BIS_fnc_netId];

		_list lnbSetPicture [[_idx, 0], "\a3\Ui_F_Curator\Data\CfgMarkers\kia_ca.paa"];
		_list lnbSetPicture [[_idx, 1], QPATHTOF(square_ca.paa)];

		private _side;
		if (_x isKindOf QEGVAR(spectator,unit)) then {
			_side = _x getVariable [QEGVAR(spectator,side), sideUnknown];
			_list lnbSetPictureColor [[_idx, 0], [1,1,1,1]];
		} else {
			_side = side _x;
			_list lnbSetPictureColor [[_idx, 0], [1,1,1,0]];
		};
		
		private _color = switch (_side) do {
			case blufor: { GVAR(sideColors) param [0] };
			case opfor: { GVAR(sideColors) param [1] };
			case independent: { GVAR(sideColors) param [2] };
			case civilian: { GVAR(sideColors) param [3] };
			case sideLogic: { [1,1,1,1] };
			default { [1,1,1,0] };
		};

		_list lnbSetPictureColor [[_idx, 1], _color];
	};
} forEach _allPlayers;

private _pfhRefresh = [{
	disableSerialization;
	private _display = uiNamespace getVariable [QGVAR(display), displayNull];
	private _list = _display displayCtrl IDC_TMF_ADMINMENU_PMAN_LIST;


}, 1] call CBA_fnc_addPerFrameHandler;



private _pfhRefresh = [{
	disableSerialization;

	private _allPlayers = allPlayers apply {[name _x, _x]};
	_allPlayers sort true;
	_allPlayers = _allPlayers apply {_x param [1]};

	private _display = uiNamespace getVariable [QGVAR(display), displayNull];
	private _list = _display displayCtrl IDC_TMF_ADMINMENU_PMAN_LIST;

	private _listSize = (lnbSize _list) param [0];
	for "_i" from 0 to (_listSize - 1) do {
		private _player;
		 = (_list lnbData [_i, 0]) call BIS_fnc_objectFromNetId;
		do {
			
		} while (isNull _player);
	};


	private _filterSide = [sideUnknown, blufor, opfor, resistance, civilian] param [lbCurSel (_display displayCtrl IDC_TMF_ADMINMENU_PMAN_FILTER_SIDE)];
	private _filterState = lbCurSel (_display displayCtrl IDC_TMF_ADMINMENU_PMAN_FILTER_STATE);

	{
		private _addPlayer = [true, alive _x, !alive _x] param [_filterState];
		
		if (_addPlayer && !(_filterSide isEqualTo sideUnknown)) then {
			_addPlayer = (side _x) isEqualTo _filterSide;
		};

		if (_addPlayer) then {
			private _idx = _list lnbAddRow ["", "", name _x, groupId group _x, toUpper (_x getVariable [QEGVAR(assigngear,role),"-"])];
			_list lnbSetData [[_idx, 0], _x call BIS_fnc_netId];

			_list lnbSetPicture [[_idx, 0], "\a3\Ui_F_Curator\Data\CfgMarkers\kia_ca.paa"];
			_list lnbSetPicture [[_idx, 1], QPATHTOF(square_ca.paa)];

			private _side;
			if (_x isKindOf QEGVAR(spectator,unit)) then {
				_side = _x getVariable [QEGVAR(spectator,side), sideUnknown];
				_list lnbSetPictureColor [[_idx, 0], [1,1,1,1]];
			} else {
				_side = side _x;
				_list lnbSetPictureColor [[_idx, 0], [1,1,1,0]];
			};
			
			private _color = switch (_side) do {
				case blufor: { GVAR(sideColors) param [0] };
				case opfor: { GVAR(sideColors) param [1] };
				case independent: { GVAR(sideColors) param [2] };
				case civilian: { GVAR(sideColors) param [3] };
				case sideLogic: { [1,1,1,1] };
				default { [1,1,1,0] };
			};

			_list lnbSetPictureColor [[_idx, 1], _color];
		};
	} forEach _allPlayers;
}, 1] call CBA_fnc_addPerFrameHandler;







/*private _pfhRefresh = [{
	disableSerialization;

	private _allPlayers = allPlayers apply {[name _x, _x]};
	_allPlayers sort true;
	_allPlayers = _allPlayers apply {_x param [1]};

	private _display = uiNamespace getVariable [QGVAR(display), displayNull];
	private _list = _display displayCtrl IDC_TMF_ADMINMENU_PMAN_LIST;
	private _filterSide = [sideUnknown, blufor, opfor, resistance, civilian] param [lbCurSel (_display displayCtrl IDC_TMF_ADMINMENU_PMAN_FILTER_SIDE)];
	private _filterState = lbCurSel (_display displayCtrl IDC_TMF_ADMINMENU_PMAN_FILTER_STATE);

	{
		private _addPlayer = [true, alive _x, !alive _x] param [_filterState];
		
		if (_addPlayer && !(_filterSide isEqualTo sideUnknown)) then {
			_addPlayer = (side _x) isEqualTo _filterSide;
		};

		if (_addPlayer) then {
			private _idx = _list lnbAddRow ["", "", name _x, groupId group _x, toUpper (_x getVariable [QEGVAR(assigngear,role),"-"])];
			_list lnbSetData [[_idx, 0], _x call BIS_fnc_netId];

			_list lnbSetPicture [[_idx, 0], "\a3\Ui_F_Curator\Data\CfgMarkers\kia_ca.paa"];
			_list lnbSetPicture [[_idx, 1], QPATHTOF(square_ca.paa)];

			private _side;
			if (_x isKindOf QEGVAR(spectator,unit)) then {
				_side = _x getVariable [QEGVAR(spectator,side), sideUnknown];
				_list lnbSetPictureColor [[_idx, 0], [1,1,1,1]];
			} else {
				_side = side _x;
				_list lnbSetPictureColor [[_idx, 0], [1,1,1,0]];
			};
			
			private _color = switch (_side) do {
				case blufor: { GVAR(sideColors) param [0] };
				case opfor: { GVAR(sideColors) param [1] };
				case independent: { GVAR(sideColors) param [2] };
				case civilian: { GVAR(sideColors) param [3] };
				case sideLogic: { [1,1,1,1] };
				default { [1,1,1,0] };
			};

			_list lnbSetPictureColor [[_idx, 1], _color];
		};
	} forEach _allPlayers;
}, 1] call CBA_fnc_addPerFrameHandler;*/

GVAR(tabPFHHandles) pushBack _pfhRefresh;