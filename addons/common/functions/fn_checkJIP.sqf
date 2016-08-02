/*
 * Name: TMF_common_fnc_checkJIP
 * Author: Snippers
 *
 * Arguments: Object (unit)
 *
 * Return:
 * None
 *
 * Description:
 * Checks if a unit JIPs into a non AI slot and kills them. Only run on the server.
 */
#include "\x\tmf\addons\common\script_component.hpp"

if (!isServer) exitWith {};
if (!isTMF) exitWith {};
if (time == 0) exitWith {};

private _respawnTemplates = getMissionConfigValue "respawnTemplates";
private _exit = false;
if (!isNil "_respawnTemplates") then {
    if (!("TMF_Spectator" in _respawnTemplates)) then { _exit = true; };
};
if (_exit) exitWith {};

[{
    params["_unit"];
    if (_unit in playableUnits) then {
        [_unit, "tmf_common_fnc_handleLocalJip", _unit] call BIS_fnc_MP;
    };
}, _this, 1] call CBA_fnc_waitAndExecute;

