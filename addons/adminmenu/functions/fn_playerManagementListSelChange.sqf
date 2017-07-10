#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_list"];

private _selected = [];
for "_i" from 0 to ((lbSize _list) - 1) do {
	if (_list lbIsSelected _i) then {
		_selected pushBack (_list lbData _i);
	};
};

GVAR(playerManagement_selected) = _selected;

//GVAR(playerManagement_selected) = (lbSelection _list) apply {_list lbData _x}; // doesnt catch last selected item?