/*
 * Name = TMF_assignGear_fnc_assignAIGear
 * Author = Freddo
 *
 * Arguments:
 * 0: Object. Unit to assign gear to
 * 1: Array. Array of parameters in following order
 *   0: Config. Config path to AI loadout
 *   1: Boolean. (optional) Prioritize giving AI units tracers
 *   2: Boolean. (optional) Whether to add medical supplies
 *   3: Boolean. (optional) Whether to add HMDs
 *   4: Boolean. (optional) Whether to add flashlights
 *   5: Boolean. (optional) Whether to force flashlights on
 *   6: Code.    (optional) Code executed on unit. unit = _this
 *   7: Number.  (optional) AI skill, number between 1 and 0
 *
 * Return:
 * Nothing
 *
 * Description:
 * Creates a randomized loadout from the AI class defined in CfgLoadouts >> faction
 */
#include "\x\tmf\addons\assignGear\script_component.hpp"

params ["_unit", "_params"];
_params params ["_cfg", ["_useTracer", false], ["_addMedical", true], ["_addHMD", true], ["_addFlashlight", false], ["_forceFlashlight", false], ["_code", {}], ["_skill", 0.5]];

LOG_2("Applied AI Loadout", str _unit, str _params);

// Remove weapons and items
removeAllWeapons _unit;
removeAllAssignedItems _unit;
removeAllItemsWithMagazines _unit;
_unit linkItem "itemRadio"; // Some mods may depend on this item
_unit setVariable ["BIS_enableRandomization", false];

//Equipment
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
    {_unit addItem "FirstAidKit";};
};

//Identity
[_unit,GETGEAR("faces")] call FUNC(setFace);
[_unit,GETGEAR("voices")] call FUNC(setVoice);

//Weapons
[_unit, GETGEAR("primaryWeapon"), [GETGEAR("scope"), _useTracer]] call FUNC(replaceAIWeapon);
[_unit, GETGEAR("secondaryWeapon"), [GETGEAR("backpack")]] call FUNC(replaceAIWeapon);
[_unit, GETGEAR("sidearmWeapon")] call FUNC(replaceAIWeapon);


if (_addFlashlight) then
{
    private _weapon = currentWeapon _unit;
    if (_weapon isEqualTo "") then
    {
        _weapon = primaryWeapon _unit;

    };
    if !(_weapon isEqualTo "") then
    {
        private _compatibleItems = _weapon call BIS_fnc_compatibleItems;

        // Check if vanilla flashlight is compatible, to avoid searching through configs
        // Known issue, won't display in 3DEN
        if ("acc_flashlight" in _compatibleItems) then
        {
            _unit addWeaponItem [_weapon, "acc_flashlight"];
        }
        else
        {
            // Search through compatible items for flashlights
            _unit addWeaponItem
            [
                _weapon,
                selectRandom (_compatibleItems select {1 <= getNumber (configfile >> "CfgWeapons" >> _x >> "ItemInfo" >> "FlashLight" >> "useFlare")})
            ];
        };
    };
};

if (_forceFlashlight) then
{
    _unit enableGunLights "ForceOn";
};

// Add infinite magazines for unit, as the AI can't pick up magazines by themselves
_unit addEventHandler ["Reloaded", {
    params ["_unit", "_weapon", "_muzzle", "_newMagazine", "_oldMagazine"];

    // Skip launchers
    if (getNumber (configFile >> "CfgWeapons" >> _weapon >> "type") == 4) exitWith {};

    _unit addMagazine (_oldMagazine # 0);
}];

// Grenades
{_unit addMagazine _x} forEach (GETGEAR("grenades"));

// Skill
if !(_skill isEqualTo 0.5) then {_unit setSkill (_skill + (random 0.05) - (random 0.05))};

// Code defined in unit loadout
if !(GETGEAR("code") isEqualTo "") then
{
    _unit call compile (GETGEAR("code"));
};

// Code defined in module
if (_code isEqualType {}) then
{
    _unit call _code;
} else
{
    if (_code isEqualType "" && {!(_code isEqualTo "")}) then
    {
        _unit call compile _code;
    };
};

_unit setVariable [QGVAR(DOUBLES(aigear,done)), true, true];
