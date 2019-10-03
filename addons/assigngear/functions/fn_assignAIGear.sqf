/*
 * Name = TMF_assignGear_fnc_assignGear
 * Author = Nick
 *
 * Arguments:
 * 0: Object. Unit to assign gear to
 * 1: Number (optional). Numeric value of side of unit. Defaults to 3DEN attributes
 * 2: String (optional). Which faction to use. Defaults to 3DEN attributes
 * 3: String (optional). Which role to use. Defaults to 3DEN attributes
 *
 * Return:
 * None
 *
 * Description:
 * Dresses up a unit with the assignGear system
 */
#include "\x\tmf\addons\assignGear\script_component.hpp"

params ["_unit", "_params"];
_params params ["_cfg", "_useTracer", "_addMedical", "_addHMD", "_addFlashlight", "_forceFlashlight", "_code"];

removeAllWeapons _unit;
removeAllAssignedItems _unit;
removeAllItemsWithMagazines _unit;
_unit assignItem "itemRadio";
_unit setVariable ["BIS_enableRandomization", false];

[_unit, "uniform",  GETGEAR("uniform")] call FUNC(replaceEquipment);
[_unit, "vest",     GETGEAR("vest")] call FUNC(replaceEquipment);
[_unit, "backpack", GETGEAR("backpack")] call FUNC(replaceEquipment);
[_unit, "headgear", GETGEAR("headgear")] call FUNC(replaceEquipment);
[_unit, "goggles",  GETGEAR("goggles")] call FUNC(replaceEquipment);
if (_addHMD) then {[_unit, "hmd", GETGEAR("hmd")] call FUNC(replaceEquipment)};

if (_addMedical) then
{
    if (_unit getUnitTrait "Medic") then
    {
        for "_i" from 1 to 3 do {_unit addItem "FirstAidKit";};
        _unit addItem "Medikit";
    }
    else
    {
        _unit addItem "FirstAidKit";
    };
};

[_unit, GETGEAR("primaryWeapon"), GETGEAR("scope"), _useTracer] call FUNC(replaceAIWeapon);
[_unit, GETGEAR("secondaryWeapon")] call FUNC(replaceAIWeapon);
[_unit, GETGEAR("sidearmWeapon")] call FUNC(replaceAIWeapon);

// Add infinite magazines for unit, as the AI can't pick up magazines by themselves
_unit addEventHandler ["Reloaded", {
    params ["_unit", "_weapon", "_muzzle", "_newMagazine", "_oldMagazine"];

    // Skip launchers
    if (getNumber (configFile >> "CfgWeapons" >> _weapon >> "type") == 4) exitWith {};

    _unit addMagazine (_oldMagazine # 0);
}];

{_unit addMagazine _x} forEach (GETGEAR("grenades"));

if ((count GETGEAR("code")) > 0) then
{
    _unit call compile GETGEAR("code");
};
