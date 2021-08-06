#include "\x\tmf\addons\assignGear\script_component.hpp"
/*
 * Name = TMF_assignGear_fnc_vehicleGear_init
 * Author = Head
 *
 * Arguments:
 * 0: OBJECT
 * 1: HASH
 *
 * Return:
 * None.
 *
 * Description:
 * Insert items into the vehicle storage.
 */
params [
    '_object',
    ['_data', [], [[]]]
];

if (is3DEN || !isServer) exitWith {};

TRACE_2("Adding vehicle gear to vehicle",_object,_data);

_data params [
    ["_category", "", [""]],
    ["_faction", "", [""]],
    ["_data", createHashMap, [createHashMap, []]]
];

// Backwards compatibility
if (_data isEqualType []) then {
    TRACE_1("Converting legacy ammobox array to hashmap",_data);
    private _hashArray = [];
    {
        _hashArray append _x;
    } forEach _data;
    _hashArray = _hashArray apply {[
        toLower (_x # 0),
        _x # 1
    ]};
    _data = createHashMapFromArray _hashArray;
    TRACE_1("Converted legacy ammobox array to hashmap",_data);
};

[{
    params ["_object", "_data"];
    TRACE_2("Adding vehicle gear",_object,_data);
    {
        if (_x isKindOf "Bag_Base") then {
            [_object, _x, _y] call CBA_fnc_addBackpackCargo;
        } else {
            [_object, _x, _y] call CBA_fnc_addItemCargo;
        };
    } forEach _data;
}, [_object, _data]] call CBA_fnc_execNextFrame;

