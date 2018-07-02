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
params [["_unit",objNull]];
if (_unit isEqualTo objNull) exitWith {};
// Exit if not local
if !(local _unit) exitWith {};


// TODO Remove backwards compatability (Date TBC)

// Input type is array.
if (_this isEqualType []) then {
    if (count _this == 3) then {
        params ["",
            ["_faction",_unit getVariable [
                QGVAR(faction),
                toLower(faction _unit)
            ]],
            ["_role",_unit getVariable [QGVAR(role),"r"]]
        ];
        _unit setVariable [QGVAR(faction),_faction];
        _unit setVariable [QGVAR(role),_role];

    } else {
        params ["",
            ["_side",_unit getVariable [QGVAR(side),(side _unit) call EFUNC(common,sideToNum)]],
            ["_faction",_unit getVariable [
                QGVAR(faction),
                toLower(faction _unit)
            ]],
            ["_role",_unit getVariable [QGVAR(role),"r"]]
        ];
        // Transform side ID into side
        _unit setVariable [QGVAR(faction),_faction];
        _unit setVariable [QGVAR(role),_role];
        _unit setVariable [QGVAR(side),_side];
    };
};

private _side = _unit getVariable [QGVAR(side),-1];
private _faction = _unit getVariable [QGVAR(faction), toLower(faction _unit)];
private _role = _unit getVariable [QGVAR(role),"r"];
private _cfg = configNull;

if (_side isEqualTo -1) then {
    _cfg = missionConfigFile >> "cfgLoadouts" >> _faction;
} else {
    // OLD ASSIGN GEAR SYSTEM
    _side = toLower([_side] call CFUNC(sideType));
    _cfg = missionConfigFile >> "cfgLoadouts" >> _side >> _faction;
};

// Set variables to unit
_unit setVariable [QGVAR(faction),_faction,true];
_unit setVariable [QGVAR(role),_role,true];

// Faction not found in mission try in modpack.
if (!isClass _cfg) then {
    _cfg = configFile >> "cfgLoadouts" >> _faction;
};

if (!isClass _cfg) exitWith {
    // ERROR FACTION NOT FOUND.
    private _message = format["ERROR: Faction %1 not found.",_faction];
    if (is3DEN) then {
        0 = [_message,1,5,true] spawn {
            disableSerialization;
            _this call BIS_fnc_3DENNotification;
        };
    };
};

// post fix role

_cfg = _cfg >> _role;

/* TODO ERROR CHECK ROLE
if (configName _path isEqualTo "") exitWith {
    // ERROR FACTION NOT FOUND.
    private _message = "ERROR ROLE NOT FOUND";
    if (is3DEN) then {

    } else {

    };
};*/



// Error handle Config...

// Get uniform items
private _uniform = GETGEAR("uniform");
private _vest = GETGEAR("vest");
private _backpack = GETGEAR("backpack");
private _headgear = GETGEAR("headgear");
private _goggles = GETGEAR("goggles");
private _hmd = GETGEAR("hmd");

// Get primary weapon and items
private _primaryWeapon = GETGEAR("primaryWeapon");
private _scope = GETGEAR("scope");
private _bipod = GETGEAR("bipod");
private _attachment = GETGEAR("attachment");
private _silencer = GETGEAR("silencer"); // rename muzzle?!?
private _primaryAttachments = GETGEAR("primaryAttachments");

// Get other weapon and items
private _secondaryWeapon = GETGEAR("secondaryWeapon");
private _secondaryAttachments = GETGEAR("secondaryAttachments");
private _sidearmWeapon = GETGEAR("sidearmWeapon");
private _sidearmAttachments = GETGEAR("sidearmAttachments");

// Get items in inventory
private _magazines = GETGEAR("magazines");
private _items = GETGEAR("items");
private _linkedItems = GETGEAR("linkedItems");
private _backpackItems = GETGEAR("backpackItems");

// Get code line
private _code = GETGEAR("code");
private _traits = GETGEAR("traits");

// Strip unit
removeAllWeapons _unit;
removeAllAssignedItems _unit;
removeAllItemsWithMagazines _unit;
_unit setVariable ["BIS_enableRandomization", false];

if(!isNil "_traits" && {count _traits > 0}) then {
    {
        if(_x isEqualType [] && count _x >= 2) then {
            _x params ["_traitName","_value"];
            _custom = {_traitName == _x} count ["audibleCoef","camouflageCoef ","loadCoef ","engineer","explosiveSpecialist","medic","UAVHacker"];
            _unit setUnitTrait [_traitName,_value,_custom > 0];
        };
        if(_x isEqualType "") then {
            _unit setUnitTrait [_x,true];
        };
    } forEach _traits;
};

// Replace equipment
[_unit,"uniform",_uniform] call FUNC(replaceEquipment);
[_unit,"vest",_vest] call FUNC(replaceEquipment);
[_unit,"backpack",_backpack] call FUNC(replaceEquipment);
[_unit,"headgear",_headgear] call FUNC(replaceEquipment);
[_unit,"goggles",_goggles] call FUNC(replaceEquipment);
[_unit,"hmd",_hmd] call FUNC(replaceEquipment);

// Add items to inventory. Overflow items get a second chance when backpack items get added. Overflow after backpack items gets logged
_backpackItems append ([_unit,_magazines] call FUNC(addItems));
_backpackItems append ([_unit,_items]     call FUNC(addItems));
[_unit,_linkedItems]   call FUNC(linkItems);
[_unit,_backpackItems] call FUNC(addBackPackItems);

// Replace primary weapon
if(isnil "_primaryAttachments") then {
    [_unit,_primaryWeapon,_scope,_bipod,_attachment,_silencer] call FUNC(replacePrimaryWeapon);
}
else {
    [_unit,_primaryWeapon,_primaryAttachments] call FUNC(replacePrimaryWeapon);
};
// Replace secondary weapon and sidearm
[_unit,_secondaryWeapon,_secondaryAttachments] call FUNC(replaceSecondaryWeapon);
[_unit,_sidearmWeapon,_sidearmAttachments]     call FUNC(replaceSidearmWeapon);

// Execute code statement
if ((count _code) > 0) then {_unit call compile _code};

// Select primary weapon
if !((primaryWeapon _unit) isEqualTo "") then {
    private _type = primaryWeapon _unit;
    private _muzzles = getArray (configFile >> "cfgWeapons" >> _type >> "muzzles");
    if (count _muzzles > 1) then {
        _unit selectWeapon (_muzzles select 0);
    } else {
        _unit selectWeapon _type;
    };
};

// Finish assignGear by emitting the event (locally) and setting a variable on the unit
[QGVAR(done),[_unit,_faction,_role]] call EFUNC(event,emit);
_unit setVariable [QGVAR(done),true,true];
