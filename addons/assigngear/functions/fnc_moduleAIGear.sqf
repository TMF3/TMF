#include "\x\tmf\addons\assignGear\script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: TMF_assigngear_fnc_moduleAIGear

Description:
    Initializes AIGear module

Parameters:
    _logic - Module [Object]
    _units - Unused [Array of units]
    _activated - Unused [Boolean]

Author:
    Freddo
---------------------------------------------------------------------------- */
params ["_logic","_units","_activated"];

if (_logic call BIS_fnc_isCuratorEditable) then {
    waitUntil {
        (!isNil {_logic getVariable QGVARMAIN(updated)} || isNull _logic) &&
        {!isNil {_logic getVariable QGVARMAIN(Faction)}} &&
        {!isNil {_logic getVariable QGVARMAIN(Loadout)}} &&
        {!isNil {_logic getVariable QGVARMAIN(Retroactive)}}
    };
};
if (isNull _logic) exitWith {};

private _faction = _logic getVariable QGVARMAIN(Faction);
private _loadout = _logic getVariable QGVARMAIN(Loadout);
private _retroactive = _logic getVariable QGVARMAIN(Retroactive);

TRACE_3("Executed AIGear module",_faction,_loadout,_retroactive);

[
    _faction,
    _loadout,
    _retroactive
] remoteExecCall [QFUNC(initAIGear),0,true];

deleteVehicle _logic;

nil
