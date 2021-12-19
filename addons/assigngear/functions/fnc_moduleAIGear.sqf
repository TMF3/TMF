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
params [
    ["_logic", objNull],
    ["_units", []],
    ["_activated", false]
];

TRACE_3("Executing AIGear Module Function",_logic,_units,_activated);

[{
    isNull _this || {
        _this getVariable [QGVARMAIN(updated), false] &&
        {!isNil {_this getVariable QGVARMAIN(Faction)}} &&
        {!isNil {_this getVariable QGVARMAIN(Loadout)}} &&
        {!isNil {_this getVariable QGVARMAIN(Retroactive)}}
    }
}, {
    if (isNull _this) exitWith {
        LOG("AIGear Module Deleted before applied");
    };

    private _faction = _this getVariable QGVARMAIN(Faction);
    private _loadout = _this getVariable QGVARMAIN(Loadout);
    private _retroactive = _this getVariable QGVARMAIN(Retroactive);

    TRACE_3("Executed AIGear module",_faction,_loadout,_retroactive);

    [
        _faction,
        _loadout,
        _retroactive
    ] remoteExecCall [QFUNC(initAIGear),0,true];

    deleteVehicle _this;

}, _logic] call CBA_fnc_waitUntilAndExecute;
