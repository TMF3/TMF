#include "\x\tmf\addons\assigngear\script_component.hpp"

/*
 * Name = TMF_assignGear_fnc_moduleAIMacro
 * Author = Freddo
 *
 * Arguments:
 * Module function, do not use
 *
 * Return:
 * Nothing
 *
 * Description:
 * Initialises AI gear assignment variables and assigns gear at mission start.
 */


params ["_mode", "_input"];

if (_mode in ["connectionChanged3DEN", "dragged3DEN"]) exitWith {};

_input params ["_logic", "_isActivated", "_isCuratorPlaced"];

private _TMF_aiGear_full = if ((_logic getVariable "TMF_aiGear_full") isEqualType "") then
[
    {call compile (_logic getVariable "TMF_aiGear_full")}, //is a string
    {_logic getVariable "TMF_aiGear_full"} //is an array
];
private _faction = _TMF_aiGear_full # 1;

private ["_config"];
if (isClass (missionConfigFile >> "CfgLoadouts" >> _faction >> "AI")) then
{
    _config = (missionConfigFile >> "CfgLoadouts" >> _faction >> "AI");
}
else
{
    _config = (configFile >> "CfgLoadouts" >> _faction >> "AI");
};
ASSERT_TRUE(isClass _config, "Loadout/macro class does not exist");

_logic setVariable ["TMF_aiGear_config", _config];
_logic setVariable ["TMF_aiGear_faction", _faction];

private _side = ((_logic getVariable "TMF_aiGear_side") call BIS_fnc_sideType);

missionNamespace setVariable [QGVAR(aiGear_) + str _side,
[
    _config,
    _logic getVariable ["TMF_aiGear_useTracer", false],
    _logic getVariable ["TMF_aiGear_addMedical", true],
    _logic getVariable ["TMF_aiGear_addHMD", true],
    _logic getVariable ["TMF_aiGear_addFlashlight", false],
    _logic getVariable ["TMF_aiGear_forceFlashlight", false],
    _logic getVariable ["TMF_aiGear_code", "''"],
    _logic getVariable ["TMF_aiGear_skill", 0.5]
]];

if (_mode isEqualTo "registeredToWorld3DEN") exitWith {LOG_1("Initialised AI Macro module ", str _module);};

// Apply gear in editor
if (_mode isEqualTo "attributesChanged3DEN") then
{
    // attributesChanged3DEN is triggered upon module placement
    // Skip that one time
    if !(_logic getVariable ["TMF_aiGear_initialised", false]) exitWith
    {
        GVAR(XEH_unitInit) = compileFinal preprocessFileLineNumbers QPATHTOF(XEH_unitInit.sqf);
        _logic setVariable ["TMF_aiGear_initialised", true];
    };

    {
        [_x] call GVAR(XEH_unitInit);
    } forEach allUnits;
    ["AI Macro - Attributes changed, reapplying AI gear"] call BIS_fnc_3DENNotification;
    LOG_1("Changed AI Macro attributes ", str _module);
};

true
