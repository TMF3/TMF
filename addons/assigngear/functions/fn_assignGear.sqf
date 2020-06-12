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

_unit setUnitLoadout (configFile >> 'EmptyLoadout');

// Each index is tied to a specific type of item
{
    if (!isNil "_x" && {!(_x isEqualTo [])} && {!(_x isEqualTo "")}) then {
        switch _forEachIndex do {
            case 0: {}; // displayName
            case 1: { // uniform
                private _uniform = selectRandom _x;
                if !(_uniform isEqualTo '') then {
                    _unit forceAddUniform _uniform;
                };
            };
            case 2: { // vest
                private _vest = selectRandom _x;
                if !(_vest isEqualTo '') then {
                    _unit addVest _vest;
                };
            };
            case 3: { // backpack
                private _backpack = selectRandom _x;
                if !(_backpack isEqualTo '') then {
                    _unit addBackpack _backpack;
                };
            };
            case 4: { // headgear
                private _headgear = selectRandom _x;
                if !(_headgear isEqualTo '') then {
                    _unit addHeadgear _headgear;
                };
            };
            case 5: { // goggles -- overwritten by player identity so apply after a delay
                [{
                    params ["_unit", "_goggles"];

                    private _curGoggles = goggles _unit;
                    if (_curGoggles isEqualTo "") then { // Don't respect no-goggles profile in skip check
                        _curGoggles = "givemegoggles";
                    };

                    // Skip if loadout allows profile glasses OR profile glasses part of loadout
                    if ("default" in _goggles || _curGoggles in _goggles) exitWith {};

                    private _newGoggles = ""; 
                    if !(_goggles isEqualTo []) then {
                        _newGoggles = selectRandom _goggles;
                    };

                    if (_newGoggles isEqualTo "") then {
                        removeGoggles _unit;
                    } else {
                        _unit addGoggles _newGoggles;
                    };
                }, [_unit, _x], 1] call CBA_fnc_waitAndExecute;
            };
            case 6: { // hmd
                private _hmd = selectRandom _x;
                if !(_hmd isEqualTo '') then {_unit linkItem _hmd};
            };
            case 7: { // faces -- overwritten by player identity so apply after a delay
                if !(_x isEqualTo []) then {
                    [{
                        params ["_unit", "_faces"];

                        [_unit, _faces] call FUNC(setFace);
                    }, [_unit, _x], 1] call CBA_fnc_waitAndExecute;
                };
            };
            case 8: { // insignias
                [_unit, selectRandom _x] call FUNC(setInsignia);
            };
            case 9: { // backpackItems
                {_unit addItemToBackpack _x} forEach _x;
            };
            case 10: { // items
                { // Items try to fill uniform first
                    switch true do {
                        case (_unit canAddItemToUniform _x): {_unit addItemToUniform _x;};
                        case (_unit canAddItemToVest _x): {_unit addItemToVest _x;};
                        default {_unit addItemToBackpack _x;};
                    };
                } forEach _x;
            };
            case 11: { // magazines
                { // Magazines try to fill vest first
                    switch true do {
                        case (_unit canAddItemToVest _x): {_unit addItemToVest _x;};
                        case (_unit canAddItemToUniform _x): {_unit addItemToUniform _x;};
                        default {_unit addItemToBackpack _x;};
                    };
                } forEach _x;
            };
            case 12: { // linkedItems
                {_unit addWeapon _x} forEach _x;
            };
            case 13: { // primaryWeapon
                private _weapon = selectRandom _x;
                if !(_weapon isEqualTo '') then {_unit addWeapon _weapon};
            };
            case 14: { // scope
                private _scope = selectRandom _x;
                if !(_scope isEqualTo '') then {_unit addPrimaryWeaponItem _scope};
            };
            case 15: { // bipod
                private _bipod = selectRandom _x;
                if !(_bipod isEqualTo '') then {_unit addPrimaryWeaponItem _bipod};
            };
            case 16: { // attachment
                private _attachment = selectRandom _x;
                if !(_attachment isEqualTo '') then {_unit addPrimaryWeaponItem _attachment};
            };
            case 17: { // silencer
                private _silencer = selectRandom _x;
                if !(_silencer isEqualTo '') then {_unit addPrimaryWeaponItem _silencer};
            };
            case 18: { // secondaryWeapon
                private _weapon = selectRandom _x;
                if !(_weapon isEqualTo '') then {_unit addWeapon _weapon};
            };
            case 19: { // secondaryAttachments
                {_unit addSecondaryWeaponItem _x} forEach _x;
            };
            case 20: { // sidearmweapon
                private _weapon = selectRandom _x;
                if !(_weapon isEqualTo '') then {_unit addWeapon _weapon};
            };
            case 21: { // sidearmattachments
                {_unit addHandgunItem _x} forEach _x;
            };
            case 22: { // Unit traits
                {
                    [_unit, _x] call FUNC(setUnitTrait);
                } forEach _x;
            };
            case 23: { // code
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
