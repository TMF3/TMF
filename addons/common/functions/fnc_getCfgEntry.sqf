#include "\x\tmf\addons\common\script_component.hpp"
/*
 * Name: TMF_common_fnc_getCfgEntry
 * Author: Nick
 *
 * Arguments:
 * ARRAY. Contains order of strings to look up.
 *
 * Return:
 * STRING or ARRAY or NUMBER or nil
 *
 * Description:
 * Reads config entries for the framework. First tries missionConfigFile, then configFile
 */
params [["_arr",[],[[]]]];

// Look up in missionConfigFile first
private _path = missionConfigFile;
{_path = _path >> _x} forEach _this;

// If there was no corresponding entry in the missionConfig, try configFile
if (configName _path isEqualTo "") then {
    _path = configFile;
    {_path = _path >> _x} forEach _this;
};

// Get value from path
private _return = switch (true) do {
    case (isNumber _path):     {getNumber _path};
    case (isText _path):     {getText   _path};
    case (isArray _path):     {getArray  _path};
    default {nil};
};

// Return value
if (isNil "_return") exitWith {nil};
_return
