/*
 * Name = TMF_assignGear_fnc_assignGear
 * Author = Nick, Freddo
 *
 * Arguments:
 * 0: Object. Unit to assign loadout to
 * 1: String (optional). Which faction to use. Defaults to current unit faction
 * 2: String (optional). Which role to use. Defaults to current unit loadout
 *
 * Return:
 * None
 *
 * Description:
 * Assigns a loadout defined in CfgLoadouts to a unit.
 */
#include "\x\tmf\addons\assignGear\script_component.hpp"

params [["_unit", player]];

if !(local _unit) exitWith {};

_this params [
    "",
    ["_faction", _unit getVariable [QGVAR(faction), toLower faction _unit]],
    ["_role", _unit getVariable [QGVAR(role), "r"]]
];

// Sometimes in editor this function is run before preInit, this should make sure that the namespace exists
private _namespace = missionNamespace getVariable QGVAR(namespace);
ISNILS(_namespace, [FUNC(initNamespace)] call CBA_fnc_directCall);
private _loadout = format ["loadout_%1_%2", _faction, _role];

// Check if loadout if cached, if not then cache it
private _loadoutArray = _namespace getVariable _loadout;
ISNILS(_loadoutArray, [ARR_2(_faction, _role)] call FUNC(cacheAssignGear));

private _defGoggles = goggles _unit;
_unit setUnitLoadout (configFile >> 'EmptyLoadout');

// locally used to add item to next free container. Prioritize uniform.
private _fnc_addItems = {
    params [["_items", []]];
    {
        switch true do {
            case (_unit canAddItemToUniform _x): {_unit addItemToUniform _x;};
            case (_unit canAddItemToVest _x): {_unit addItemToVest _x;};
            default {_unit addItemToBackpack _x;};
        };
    } forEach _items;
};
// locally used to add magazine to next free container. Prioritize vest.
private _fnc_addMagazines = {
    params [["_magazines", []]];
    {
        switch true do {
            case (_unit canAddItemToVest _x): {_unit addItemToVest _x;};
            case (_unit canAddItemToUniform _x): {_unit addItemToUniform _x;};
            default {_unit addItemToBackpack _x;};
        };
    } forEach _magazines;
};

// Each index is tied to a specific type of item
{
    if (!isNil "_x" && {!(_x isEqualTo [])} && {!(_x isEqualTo "")}) then {
        switch _forEachIndex do {
            case IDX_DISPLAY_NAME: {};
            case IDX_UNIFORM: {
                private _uniform = selectRandom _x;
                if !(_uniform isEqualTo '') then {
                    _unit forceAddUniform _uniform;
                };
            };
            case IDX_VEST: {
                private _vest = selectRandom _x;
                if !(_vest isEqualTo '') then {
                    _unit addVest _vest;
                };
            };
            case IDX_BACKPACK: {
                private _backpack = selectRandom _x;
                if !(_backpack isEqualTo '') then {
                    _unit addBackpack _backpack;
                };
            };
            case IDX_HEADGEAR: {
                private _headgear = selectRandom _x;
                if !(_headgear isEqualTo '') then {
                    _unit addHeadgear _headgear;
                };
            };
            case IDX_GOGGLES: {
                // Goggles are overwritten by player identity
                private _goggles = selectRandom _x;
                if (_goggles != 'default') then {
                    _unit addGoggles _goggles;
                } else
                {
                    if !(_defGoggles isEqualTo '') then {_unit addGoggles _defGoggles};
                };
            };
            case IDX_HMD: {
                private _hmd = selectRandom _x;
                if !(_hmd isEqualTo '') then {_unit linkItem _hmd};
            };
            case IDX_FACES: {
                // Faces are overwritten by player identity
                [_unit, _x] call FUNC(setFace);
            };
            case IDX_INSIGNIAS: {
                [_unit, selectRandom _x] call FUNC(setInsignia);
            };
            case IDX_BACKPACK_ITEMS: {
                {_unit addItemToBackpack _x} forEach _x;
            };
            case IDX_ITEMS: {
                [_x] call _fnc_addItems;
            };
            case IDX_MAGAZINES: {
                [_x] call _fnc_addMagazines;
            };
            case IDX_LINKED_ITEMS: {
                {_unit addWeapon _x} forEach _x;
            };
            case IDX_PRIMARY_WEAPON: {
                private _weapon = selectRandom _x;
                if !(_weapon isEqualTo '') then {_unit addWeapon _weapon};
            };
            case IDX_SCOPE: {
                private _scope = selectRandom _x;
                if !(_scope isEqualTo '') then {_unit addPrimaryWeaponItem _scope};
            };
            case IDX_BIPOD: {
                private _bipod = selectRandom _x;
                if !(_bipod isEqualTo '') then {_unit addPrimaryWeaponItem _bipod};
            };
            case IDX_ATTACHMENT: {
                private _attachment = selectRandom _x;
                if !(_attachment isEqualTo '') then {_unit addPrimaryWeaponItem _attachment};
            };
            case IDX_SILENCER: {
                private _silencer = selectRandom _x;
                if !(_silencer isEqualTo '') then {_unit addPrimaryWeaponItem _silencer};
            };
            case IDX_SECONDARY_WEAPON: {
                private _weapon = selectRandom _x;
                if !(_weapon isEqualTo '') then {_unit addWeapon _weapon};
            };
            case IDX_SECONDARY_ATTACHMENTS: {
                {_unit addSecondaryWeaponItem _x} forEach _x;
            };
            case IDX_SIDEARM_WEAPON: {
                private _weapon = selectRandom _x;
                if !(_weapon isEqualTo '') then {_unit addWeapon _weapon};
            };
            case IDX_SIDEARM_ATTACHMENTS: {
                {_unit addHandgunItem _x} forEach _x;
            };
            case IDX_TRAITS: {
                {
                    [_unit, _x] call FUNC(setUnitTrait);
                } forEach _x;
            };
            case IDX_PRIMARY_MAGAZINE: {
                private _magazine = selectRandom _x;
                if (_magazine != 'default') then {
                    // Sadly I don't think this can't be done faster, primaryMagazine should then only be used when really needed.
                    private _weapon = primaryWeapon _unit;
                    private _weaponMags = [_weapon, false] call CBA_fnc_compatibleMagazines;
                    private _backup = (primaryWeaponMagazine _unit) select {_x in _weaponMags};  // Save what game already placed inside the weapon, so it can be put back in inventory
                    _unit addPrimaryWeaponItem _magazine;
                    [_backup] call _fnc_addMagazines;
                };
            };
            case IDX_PRIMARY_GRENADE: {
                private _magazine = selectRandom _x;
                if (_magazine != 'default') then {
                    // Sadly I don't think this can't be done faster, primaryGrenade should then only be used when really needed.
                    private _weapon = primaryWeapon _unit;
                    private _weaponMags = [_weapon, false] call CBA_fnc_compatibleMagazines;
                    private _weaponGrenades = ([_weapon, true] call CBA_fnc_compatibleMagazines) - _weaponMags;
                    private _backup = (primaryWeaponMagazine _unit) select {_x in _weaponGrenades};
                    _unit addPrimaryWeaponItem _magazine;
                    [_backup] call _fnc_addMagazines;
                };
            };
            case IDX_SECONDARY_MAGAZINE: {
                private _magazine = selectRandom _x;
                if (_magazine != 'default') then {
                    private _backup = secondaryWeaponMagazine _unit;
                    _unit addSecondaryWeaponItem _magazine;
                    [_backup] call _fnc_addMagazines;
                };
            };
            case IDX_SIDEARM_MAGAZINE: {
                private _magazine = selectRandom _x;
                if (_magazine != 'default') then {
                    private _backup = handgunMagazine _unit;
                    _unit addHandgunItem _magazine;
                    [_backup] call _fnc_addMagazines;
                };
            };
            case IDX_CODE: {
                _unit call compile _x;
            };
        };
    };
} forEach _loadoutArray;

_unit setVariable [QGVAR(faction), _faction,true];
_unit setVariable [QGVAR(role), _role,true];

LOG_3("Assigned loadout to unit",_unit,_faction,_loadout);

[QGVAR(done),[_unit,_faction,_role]] call EFUNC(event,emit);
_unit setVariable [QGVAR(done),true,true];

//TODO: Move to CBA
//[QGVAR(assignedLoadout), [_unit, _faction, _role]] call CBA_fnc_localEvent;
