/*
 * Name = TMF_assignGear_fnc_replaceEquipment
 * Author = Nick
 *
 * Arguments:
 * 0: Object. Unit
 * 1: String. Which type of piece to replace ("uniform","vest","backpack","headger","goggles","hmd")
 * 2: ARRAY. Array of classnames, one is chosen randomly.
 *
 * Return:
 * None.
 *
 * Description:
 * Replaces a specific part of equipment. Can be used to hotswap: will try to restore previous cargo
 */
#include "\x\tmf\addons\assignGear\script_component.hpp"
params ["_unit","_piece","_array"];

// If array is empty, fill it with an empty string
if (_array isEqualTo []) then {_array pushBack ""};

private _className = selectRandom _array;
// Exit if nil or set to "default"
if (isNil "_className" || {_className isEqualTo "default"} ) exitWith {};

// Apply
switch (_piece) do {
	case "uniform":{
		if ((uniform _unit) != _className) then {
			private _backup = uniformItems _unit;
			removeUniform _unit;
			if (_className isEqualTo "") exitWith {};
			_unit forceAddUniform _className;
			{_unit removeItemFromUniform _x} forEach uniformItems _unit;
			{_unit addItemToUniform _x}      forEach _backup;
		};
	};
	case "vest":{
		if ((vest _unit) != _className) then {
			private _backup = vestItems _unit;
			removeVest _unit;
			if (_className isEqualTo "") exitWith {};
			_unit addVest _className;
			{_unit removeItemFromVest _x} forEach vestItems _unit;
			{_unit addItemToVest _x}      forEach _backup;
		};
	};
	case "backpack":{
		if ((backpack _unit) != _className) then {
			private _backup = backpackItems _unit;
			removeBackpack _unit;
			if (_className isEqualTo "") exitWith {};
			_unit addBackpack _className;
			{_unit removeItemFromBackpack _x} forEach backpackItems _unit;
			{_unit addItemToBackpack _x}      forEach _backup;
		};
	};
	case "headgear": {
		removeHeadgear _unit;
		if (_className isEqualTo "") exitWith {};
		_unit addHeadgear _className;
	};
	case "goggles": {
		removeGoggles _unit;
		if (_className isEqualTo "") exitWith {};
		_unit addGoggles _className;
	};
	case "hmd": {
		_unit unlinkItem (hmd _unit);
		if (_className isEqualTo "") exitWith {};
		_unit linkItem _className;
	};
	default {DEBUG_ERR("Incorrect piece parameter!")};
};