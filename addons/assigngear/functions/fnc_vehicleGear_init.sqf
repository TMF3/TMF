#include "\x\tmf\addons\assignGear\script_component.hpp"
/*
 * Name = TMF_assignGear_fnc_vehicleGear_init
 * Author = Head
 *
 * Arguments:
 * 0: OBJECT
 * 1: ARRAY in the format of role, faction, contents.
 *    0: STRING. Category
 *    1: STRING: Faction
 *    2: Array: Contents
 *
 * Return:
 * None.
 *
 * Description:
 * Insert items into the vehicle storage.
 */
params ['_object', ['_data', []]];

TRACE_1("Vehicle Gear INIT", _this);
if(count _data <= 0) exitWith {};
_data params ['_category', '_faction', ['_contents',  [], [], [] , [[]], 3]];
TRACE_3("Vehicle Gear INIT", _category, _faction, _contents);

[
     {
        params ['_object', '_contents'];
        {
            {
                if((_x # 0) isKindOf "Bag_Base") then {
                    _object addBackpackCargoGlobal _x;
                } else {
                    _object addItemCargoGlobal _x;
                };
            } forEach _x;
        } forEach _contents;
     },
     [_object, _contents]
] call CBA_fnc_execNextFrame;