/*
 * Name = TMF_assignGear_fnc_linkItems
 * Author = Nick
 *
 * Arguments:
 * 0: Object. Unit
 * 1: ARRAY. Array of items to link
 *
 * Return:
 * None.
 *
 * Description:
 * Tries to link all items to unit
 */
 #include "\x\tmf\addons\assignGear\script_component.hpp"
params ["_unit","_items"];

if (isNil "_unit") exitWith {};

{
    if !(isNil "_x") then {
        _unit addWeapon _x;
    };
} forEach _items;