/*
 * Name: TMF_common_fnc_debugMsg
 * Author: Nick
 *
 * Arguments:
 * Should only be used via the DEBUG_MSG() macro!
 *
 * Return:
 * Should only be used via the DEBUG_MSG() macro!
 *
 * Description:
 * Should only be used via the DEBUG_MSG() macro!
 */
#include "\x\tmf\addons\common\script_component.hpp"
params [
    ["_component","",["a"]],
    ["_text","",["a"]]
];

if ((!is3DEN) && {!(getMissionConfigValue ["tmf_debug_enabled",true])}) exitWith {};

// Prepare output
private _output = format ["[%1|MSG]%2: %3",QUOTE(PREFIX),_component,_text];

// Log to appropriate channels
if ((!is3DEN) && (getMissionConfigValue "tmf_debug_diag_log")) then {diag_log _output;};
if ((!is3DEN) && (getMissionConfigValue "tmf_debug_systemChat")) then {systemChat _output;};
if (is3DEN) then {diag_log _output;};