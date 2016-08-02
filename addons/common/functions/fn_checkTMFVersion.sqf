/*
 * Name: TMF_common_fnc_checkTMFVersion
 * Author: Snippers
 *
 * Arguments:
 *  Array - Version to check
 *
 * Return:
 * Boolean
 *
 * Description:
 * Checks if TMF Mission version is larger than the input version;
 */
#include "\x\tmf\addons\common\script_component.hpp"

params [
	["_input",[0,0,0]]
];

private _tmfVersion = getMissionConfigValue ["tmf_version",[0,0,0]];

([_tmfVersion,_input] call EFUNC(common,checkVersionArray));

