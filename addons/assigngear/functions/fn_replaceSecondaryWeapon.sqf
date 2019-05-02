/*
 * Name = TMF_assignGear_fnc_replaceSecondaryWeapon
 * Author = Nick
 *
 * Arguments:
 * 0: Object. Unit
 * 1: STRING. Classname of weapon
 * 2: ARRAY. Array of classnames. All will be tried to add to the weapon
 *
 * Return:
 * None
 *
 * Description:
 * Replaces a units' secondary weapon
 */
 #include "\x\tmf\addons\assignGear\script_component.hpp"
 params ["_unit","_weaponArray","_items","_magazine"];

// Remove weapon and exit if weaponArray is empty
if (count _weaponArray < 1) exitWith {_unit removeWeapon (secondaryWeapon _unit)};

private _weapon = toLower selectRandom _weaponArray;

// Exit if weapon was set to "default"
if (_weapon isEqualTo "default") exitWith {};

if (!isNil "_magazine" && _magazine != "") then {
    _items pushBack _magazine;
};

_unit removeWeapon (secondaryWeapon _unit);
if !(isNil "_weapon") then {
    _unit addWeapon _weapon;
};
{
    if !(isNil "_x") then {
        _unit addSecondaryWeaponItem _x;
    };
} forEach _items;