/*
 * Name = TMF_assignGear_fnc_addBackpackItems
 * Author = Nick
 *
 * Arguments:
 * 0: Object. Unit
 * 1: ARRAY. Array of items to add
 *
 * Return:
 * 0: ARRAY. Array of items that could not be added
 *
 * Description:
 * Tries to add items to a units' backpack. Logs those that were skipped
 */
 #include "\x\tmf\addons\assignGear\script_component.hpp"
params ["_unit","_items"];

if (isNil "_unit" || isNil "_items") exitWith {};
{
	if (!(isNil "_x") && {_unit canAddItemToBackpack _x}) then {
		_unit addItemToBackpack _x;
	} else {
        if (is3DEN && {!isNil QEGVAR(autotest,GEAR_OUTPUT)}) then {
            private _return = [1,format["Equipment %1 won't fit in inventory ( %2 - %3 )",_x,_unit getVariable [QGVAR(faction),""],_unit getVariable [QGVAR(role),""]]];
            EGVAR(autotest,GEAR_OUTPUT) pushBack _return;
        };
		DEBUG_LOG_3("Adding item to backpack failed. Unit: %1, Item: %2.",_unit,_x);
	};
} forEach _items;