#include "\x\tmf\addons\assignGear\script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: TMF_assigngear_fnc_AIGearEH

Description:
    CAManBase init eventhandler that assigns gear dependent on
    unit type. Used with AIGear module.

Parameters:
    _unit - New unit [Object]
    _faction - Affected faction class [String]
    _loadout - Used loadout file

Examples:
    (begin example)
        [_dude,"OPF_F","OPF_G_F"] call TMF_assigngear_fnc_AIGearEH
    (end)

Author:
    Freddo
---------------------------------------------------------------------------- */
params ["_unit","_faction","_loadout"];

if (!local _unit || {isPlayer _unit} || {_faction != faction _unit} || {_unit getVariable [QGVAR(done),false]}) exitWith {};

TRACE_3("Executed AIGear EH",_unit,_faction,_loadout);

private _hash = GVAR(namespace) getVariable "AIGear_hash";

private _typeCode = [_hash,"code"] call CBA_fnc_hashGet;
private _type = toLower (_unit call _typeCode);

// Get a weighted array of roles for the listed type
private _weightedArray = [_hash,_type] call CBA_fnc_hashGet;

private _role = selectRandomWeighted _weightedArray;
LOG_2("%1 is type: %2",_unit,_type);

if !(
    isClass (missionConfigFile >> "CfgLoadouts" >> _loadout >> _role) ||
    isClass (configFile >> "CfgLoadouts" >> _loadout >> _role)
) then {
    ERROR_2("AIGear: ""%1"" not present in ""%2"", reverting to default ""r""",_role,_loadout);
    _role = "r";
};

[_unit,_loadout,_role] call FUNC(assignGear);

[QGVAR(AIGearAssigned),[_unit,_loadout,_role]] call CBA_fnc_localEvent;

nil
