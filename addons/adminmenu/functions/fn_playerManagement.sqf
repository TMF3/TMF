#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_display"];

private _list = _display displayCtrl IDC_TMF_ADMINMENU_PMAN_LIST;

/*if (count (lbSelection _list) == 0) then {
	for "_i" from 0 to ((lbSize _list) - 1) do {
		_list lbSetSelected [_i, (_list lbData _i) in GVAR(playerManagement_selected)];
	};
};*/

_display call FUNC(playerManagementUpdateList);

private _pfhRefresh = [{
	(param [1]) call FUNC(playerManagementUpdateList);
}, 3, _display] call CBA_fnc_addPerFrameHandler;

GVAR(tabPFHHandles) pushBack _pfhRefresh;