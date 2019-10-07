#include "\x\tmf\addons\autotest\script_component.hpp"

params ["_subarray","_config", "_faction", "_role", ["_slot", -1]];

private _output = [];

{
    if ((_x != "") && (_x != "default")) then
    {
        if (!isClass (_config >> _x)) then
        {
            _output pushBack [0,format["Missing classname: %1 (for: %2 - %3)", _x,_faction,_role]];
        }
        else
        {
            if (_slot != -1 && {_slot in getArray (_config >> _x >> "type")}) then
            {
                _output pushBack [0,format["Incorrect weaponslot: %1 (for: %2 - %3)", _x,_faction,_role]];
            }
        }
    };
} forEach _subarray;

_output
