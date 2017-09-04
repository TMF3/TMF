#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;

[{
    disableSerialization;
    params ["_list", "_lastSelected"];

    private _selection = lbSelection _list;
    GVAR(playerManagement_selected) = _selection apply {_list lbData _x};

    private _selected = [];
    for "_i" from 0 to ((lbSize _list) - 1) do {
        if (_list lbIsSelected _i) then {
            _selected pushBack _i;
        };
    };
}, _this] call CBA_fnc_execNextFrame;
