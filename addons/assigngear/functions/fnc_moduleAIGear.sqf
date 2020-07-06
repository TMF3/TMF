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

private _faction = _logic getVariable "faction";
private _loadout = _logic getVariable "loadout";
private _retroactive = _logic getVariable "Retroactive";

TRACE_3("Executed AIGear module",_faction,_loadout,_retroactive);

[
    "CAManBase",
    "init",
    compile format ['[FUNC(AIGearEH),[_this # 0,%1,%2]] call CBA_fnc_execNextFrame', str _faction, str _loadout],
    true,
    [],
    _retroactive
] call CBA_fnc_addClassEventHandler;

nil
