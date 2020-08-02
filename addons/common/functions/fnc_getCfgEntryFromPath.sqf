#include "\x\tmf\addons\common\script_component.hpp"
/*
 * Name: TMF_common_fnc_getCfgEntryFromPath
 * Author: Snippers
 *
 * Arguments:
 * CONFIG. Contains path to config
 *
 * Return:
 * STRING or ARRAY or NUMBER or nil
 *
 * Description:
 * Attempts to read a config value.
 */

params [["_path",configNull,[configNull]]];

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
