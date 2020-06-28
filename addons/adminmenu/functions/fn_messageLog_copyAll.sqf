#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_ctrl"];

private _stringArr = [];

{
    _x params [
        ["_time",-1,[-1]],
        ["_text","",[""]],
        ["_isWarning",false,[false]]
    ];

    _stringArr pushBack format ["%1[%2]: %3",
        if (_isWarning) then [{"[WARNING] "},{""}],
        [_time,"MM:SS"] call BIS_fnc_secondsToString,
        _text
    ];
} forEach GVAR(logEntries);

LOG("Copied all logged messages to clipboard");
private _return = _stringArr joinString toString [13,10]; // Join with a linebreak
copyToClipboard _return;
_return
