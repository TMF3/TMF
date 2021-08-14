#include "\x\tmf\addons\assignGear\script_component.hpp"
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

// Check if loadout is cached, if not then cache it
private _loadoutArray = _namespace getVariable _loadout;
ISNILS(_loadoutArray, [ARR_2(_faction, _role)] call FUNC(cacheAssignGear));

_unit setUnitLoadout (configFile >> 'EmptyLoadout');

private _primaryWeapon = "";
private _primaryMagazine = [];
private _secondaryWeapon = "";
private _secondaryMagazine = [];
private _sidearmWeapon = "";
private _sidearmMagazine = [];

// Each index is tied to a specific type of item
{
    if (!isNil "_x" && {!(_x isEqualTo [])} && {!(_x isEqualTo "")}) then {
        switch _forEachIndex do {
            case IDX_DISPLAY_NAME: {}; // displayName
            case IDX_UNIFORM: { // uniform
                private _uniform = selectRandom _x;
                if !(_uniform isEqualTo '') then {
                    _unit forceAddUniform _uniform;
                };
            };
            case IDX_VEST: { // vest
                private _vest = selectRandom _x;
                if !(_vest isEqualTo '') then {
                    _unit addVest _vest;
                };
            };
            case IDX_BACKPACK: { // backpack
                private _backpack = selectRandom _x;
                if !(_backpack isEqualTo '') then {
                    _unit addBackpack _backpack;
                };
            };
            case IDX_HEADGEAR: { // headgear
                private _headgear = selectRandom _x;
                if !(_headgear isEqualTo '') then {
                    _unit addHeadgear _headgear;
                };
            };
            case IDX_GOGGLES: { // goggles
                [_unit, _x] call FUNC(setGoggles);
            };
            case IDX_HMD: { // hmd
                private _hmd = selectRandom _x;
                if !(_hmd isEqualTo '') then {_unit linkItem _hmd};
            };
            case IDX_FACES: { // faces
                [_unit, _x] call FUNC(setFace);
            };
            case IDX_INSIGNIAS: { // insignias
                [_unit, selectRandom _x] call FUNC(setInsignia);
            };
            case IDX_BACKPACK_ITEMS: { // backpackItems
                {_unit addItemToBackpack _x} forEach _x;
            };
            case IDX_ITEMS: { // items
                { // Items try to fill uniform first
                    switch true do {
                        case (_unit canAddItemToUniform _x): {_unit addItemToUniform _x;};
                        case (_unit canAddItemToVest _x): {_unit addItemToVest _x;};
                        default {_unit addItemToBackpack _x;};
                    };
                } forEach _x;
            };
            case IDX_MAGAZINES: { // magazines
                if (count _primaryMagazine > 0) then {
                    if !(_primaryWeapon isEqualTo '') then {_unit addWeapon _primaryWeapon};
                    { _unit addPrimaryWeaponItem _x; } forEach _primaryMagazine;
                };
                if (count _secondaryMagazine > 0) then {
                    if !(_secondaryWeapon isEqualTo '') then {_unit addWeapon _secondaryWeapon};
                    { _unit addSecondaryWeaponItem _x; } forEach _secondaryMagazine;
                };
                if (count _sidearmMagazine > 0) then {
                    if !(_sidearmWeapon isEqualTo '') then {_unit addWeapon _sidearmWeapon};
                    { _unit addHandgunItem _x; } forEach _sidearmMagazine;
                };

                { // Magazines try to fill vest first
                    switch true do {
                        case (_unit canAddItemToVest _x): {_unit addItemToVest _x;};
                        case (_unit canAddItemToUniform _x): {_unit addItemToUniform _x;};
                        default {_unit addItemToBackpack _x;};
                    };
                } forEach _x;

                if (count _primaryMagazine == 0) then {
                    if !(_primaryWeapon isEqualTo '') then {_unit addWeapon _primaryWeapon};
                };
                if (count _secondaryMagazine == 0) then {
                    if !(_secondaryWeapon isEqualTo '') then {_unit addWeapon _secondaryWeapon};
                };
                if (count _sidearmMagazine == 0) then {
                    if !(_sidearmWeapon isEqualTo '') then {_unit addWeapon _sidearmWeapon};
                };
            };
            case IDX_LINKED_ITEMS: { // linkedItems
                {_unit addWeapon _x} forEach _x;
            };
            case IDX_PRIMARY_WEAPON: { // primaryWeapon
                _primaryWeapon = selectRandom _x;
            };
            case IDX_PRIMARY_MAGAZINE: { // primarymagazine
                _primaryMagazine = _x;
            };
            case IDX_PRIMARY_SCOPE: { // scope
                private _scope = selectRandom _x;
                if !(_scope isEqualTo '') then {_unit addPrimaryWeaponItem _scope};
            };
            case IDX_PRIMARY_BIPOD: { // bipod
                private _bipod = selectRandom _x;
                if !(_bipod isEqualTo '') then {_unit addPrimaryWeaponItem _bipod};
            };
            case IDX_PRIMARY_ATTACHMENT: { // attachment
                private _attachment = selectRandom _x;
                if !(_attachment isEqualTo '') then {_unit addPrimaryWeaponItem _attachment};
            };
            case IDX_PRIMARY_SILENCER: { // silencer
                private _silencer = selectRandom _x;
                if !(_silencer isEqualTo '') then {_unit addPrimaryWeaponItem _silencer};
            };
            case IDX_SECONDARY_WEAPON: { // secondaryWeapon
                _secondaryWeapon = selectRandom _x;
            };
            case IDX_SECONDARY_MAGAZINE: { // secondarymagazine
                _sidearmMagazine = _x;
            };
            case IDX_SECONDARY_ATTACHMENT: { // secondaryAttachments
                {_unit addSecondaryWeaponItem _x} forEach _x;
            };
            case IDX_SIDEARM_WEAPON: { // sidearmweapon
                _sidearmWeapon = selectRandom _x;
            };
            case IDX_SIDEARM_MAGAZINE: { // sidearmmagazine
                _sidearmMagazine = _x;
            };
            case IDX_SIDEARM_ATTACHMENT: { // sidearmattachments
                {_unit addHandgunItem _x} forEach _x;
            };
            case IDX_TRAITS: { // Unit traits
                {
                    [_unit, _x] call FUNC(setUnitTrait);
                } forEach _x;
            };
            case IDX_CODE: { // code
                _unit call compile _x;
            };
        };
    };
} forEach _loadoutArray;

_unit setVariable [QGVAR(faction), _faction,true];
_unit setVariable [QGVAR(role), _role,true];

LOG_3("Assigned loadout to unit", _unit, _faction,_loadout);

[QGVAR(done), [_unit, _faction, _role]] call CBA_fnc_localEvent;
_unit setVariable [QGVAR(done), true, true];
