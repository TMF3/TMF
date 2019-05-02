/*
 * Name = TMF_assignGear_fnc_replaceSidearmWeapon
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
 * Replaces a units' sidearm weapon
 */
 #include "\x\tmf\addons\assignGear\script_component.hpp"
 params ["_unit","_weaponArray","_items","_magazine"];

// Exit and remove weapon if weaponArray is empty
if (count _weaponArray < 1) exitWith {_unit removeWeapon (handgunWeapon _unit)};

private _weapon = selectRandom _weaponArray;

// Exit if weapon was set to "default"
if (_weapon isEqualTo "default") exitWith {};

if (!isNil "_magazine" && _magazine != "") then {
    _items pushBack _magazine;
};

_currentWeapon = handgunWeapon _unit;
_unit removeWeapon _currentWeapon;

if !(isNil "_weapon") then {
    _unit addWeapon _weapon;
};
{
    if !(isNil "_x") then {
        _unit addHandgunItem _x;
    };
} forEach _items;