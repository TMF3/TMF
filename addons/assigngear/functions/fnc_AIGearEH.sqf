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

private _type = [_unit] call BIS_fnc_objectType;

private _role = switch (_type # 1) do {
    case "MG":      {["ar","mmgg"] selectRandomWeighted [3,1]};
    case "AT":      {["rat","matg"] selectRandomWeighted [3,1]};
    case "Officer": {"pl"};
    case "Pilot":   {["pc","jp"] selectRandomWeighted [3,1]};
    case "Medic":   {"m"};
    case "Sniper":  {["sn","dm"] selectRandomWeighted [3,1]};
    default         {["r","ftl","g","aar","eng","sl"] selectRandomWeighted [10,2,3,2,1]};
};
LOG_2("%1 is type: %2",_unit,_type # 1);

if !(
    isClass (missionConfigFile >> "CfgLoadouts" >> _loadout >> _role) ||
    isClass (configFile >> "CfgLoadouts" >> _loadout >> _role)
) then {
    LOG_2("""%1"" not present in ""%2"", reverting to default ""r""",_role,_loadout);
    _role = "r";
};

[_unit,_loadout,_role] call FUNC(assignGear);

nil
