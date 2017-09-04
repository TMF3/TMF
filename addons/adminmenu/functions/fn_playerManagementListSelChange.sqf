#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
//params ["_list", "_current"];

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

    systemChat format ["Last Selected: %1 | lbCurSel: %2", _lastSelected, lbCurSel _list];
    systemChat format ["lbIsSelected: %1", _selected];
    systemChat format ["lbSelection: %1", _selection];
}, _this] call CBA_fnc_execNextFrame;

//systemChat format ["LBSelChange | _current:%1 | lbCurSel:%2", _current, lbCurSel _list];

/*
private _selected = [];
for "_i" from 0 to ((lbSize _list) - 1) do {
    if (_list lbIsSelected _i) then {
        _selected pushBack (_list lbData _i);
    };
};

if (_current isEqualTo lbCurSel _list) then {
    _selected pushBackUnique (_list lbData _current);
} else {
    _selected deleteAt (_selected find (_list lbData _current));
};

GVAR(playerManagement_selected) = _selected;*/

/*private _selection = lbSelection _list;

if (isNil "_current") then {
    systemChat "lbSelChanged is nil";
} else {
    if (_current in _selection) then {
        systemChat format ["EXISTS: %1 | %2       %3", _list lbtext _current, _current, _selection];
    } else {
        systemChat format ["NEW: %1 | %2       %3", _list lbtext _current, _current, _selection];
        if (_current < 0) then {
            systemChat format ["<= 0: %1 |       %2", _current, _selection];
        } else {
            _selection pushBack _current;
        };
    };
};*/




//GVAR(playerManagement_selected) = _selection apply {_list lbData _x};
