/*
 * Name: TMF_common_fnc_debugError
 * Author: Nick
 *
 * Arguments:
 * Should only be used via the DEBUG_ERR() macro!
 *
 * Return:
 * Should only be used via the DEBUG_ERR() macro!
 *
 * Description:
 * Should only be used via the DEBUG_ERR() macro!
 */
#include "\x\tmf\addons\common\script_component.hpp"
params [
	["_file","",["a"]],
	["_line",0,[0]],
	["_text","",["a"]]
];

if ((!is3DEN) && {!(getMissionConfigValue ["tmf_debug_enabled",true])}) exitWith {};

// Remove x\tmf\addons from __FILENAME__
_file = _file splitString "\";
_file = _file select [3,count _file - 3];
_file = _file joinString "\";

// Prepare output
private _output = format ["[%1|ERR]%2@L%3: %4",QUOTE(PREFIX),_file,_line,_text];

// Log to appropriate channels
if ((!is3DEN) && (getMissionConfigValue "tmf_debug_diag_log")) then {diag_log _output;};
if ((!is3DEN) && (getMissionConfigValue "tmf_debug_systemChat")) then {systemChat _output;};
if (is3DEN) then {diag_log _output;};