/*
 * Name = TMF_assignGear_fnc_replaceAIWeapon
 * Author = Nick
 *
 * Arguments:
 * 0: Object. Unit to weapon to
 * 1: String. Weapon classname
 * 2: Array. Additional parameters, depends on weapon type
 *
 * Return:
 * None
 *
 * Description:
 * Dresses up a unit with the assignGear system
 */

#include "\x\tmf\addons\assignGear\script_component.hpp"

params ["_unit", "_weapon", "_params"];

if (isNil "_unit" || {isNil "_weapon"}) exitWith {};

if (_weapon isEqualType []) then {_weapon = selectRandom _weapon};

if (isNil "_weapon" || {_weapon isEqualTo ""}) exitWith {};

switch (getNumber (configFile >> "CfgWeapons" >> _weapon >> "type") ) do
{
    case 1: //Primary
    {
        _params params [["_scope", []], ["_useTracer", false]];
        _unit removeWeapon (primaryWeapon _unit);
        if !(_useTracer) then
        {
            [_unit, _weapon, 3] call BIS_fnc_addWeapon;
        } else
        {
            private _tracerMags = getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines") select {getNumber (configFile >> "CfgMagazines" >> _x >> "tracersEvery") == 1};
            if !(_tracerMags isEqualTo []) then
            {
                for "_i" from 1 to 3 do
                {
                    _unit addMagazine (_tracerMags # 0);
                };
                _unit addWeapon _weapon;
            } else
            {
                [_unit, _weapon, 3] call BIS_fnc_addWeapon;
            }
        };

        if (!isNil "_scope") then
        {
            // Add appropiate optics
            switch (getText (configFile >> "CfgWeapons" >> _weapon >> "cursor")) do
            {
                case "arifle":
                {
                    // Select only optics with MRCO zoom or less
                    private _arifleScopes = _scope select
                    {
                        (count ("true" configClasses (configFile >> "CfgWeapons" >> _x >> "ItemInfo" >> "OpticsModes"))) ==
                        count ("getNumber (_x >> 'opticsZoomMin') >= 0.125" configClasses (configFile >> "CfgWeapons" >> _x >> "ItemInfo" >> "OpticsModes"));
                    };
                    _unit addPrimaryWeaponItem selectRandom _arifleScopes;
                };
                case "srifle":
                {
                    // Select only optics with MRCO zoom or more
                    private _srifleScopes = _scope select
                    {
                        1 <= count ("getNumber (_x >> 'opticsZoomMin') <= 0.125" configClasses (configFile >> "CfgWeapons" >> _x >> "ItemInfo" >> "OpticsModes"));
                    };
                    if (_srifleScopes isEqualTo []) then {_srifleScopes = _scope}; //No optic found, give them anything
                    _unit addPrimaryWeaponItem selectRandom _srifleScopes;
                };
                case "mg":
                {
                    // Select only optics with AMS zoom or less
                    private _mgScopes = _scope select
                    {
                        (count ("true" configClasses (configFile >> "CfgWeapons" >> _x >> "ItemInfo" >> "OpticsModes"))) ==
                        count ("getNumber (_x >> 'opticsZoomMin') >= 0.025" configClasses (configFile >> "CfgWeapons" >> _x >> "ItemInfo" >> "OpticsModes"));
                    };
                    _unit addPrimaryWeaponItem selectRandom _mgScopes;
                };
                default
                {
                    // Select only optics with holo zoom or less
                    private _defaultScopes = _scope select
                    {
                        (count ("true" configClasses (configFile >> "CfgWeapons" >> _x >> "ItemInfo" >> "OpticsModes"))) ==
                        count ("getNumber (_x >> 'opticsZoomMin') >= 0.25" configClasses (configFile >> "CfgWeapons" >> _x >> "ItemInfo" >> "OpticsModes"));
                    };
                    _unit addPrimaryWeaponItem selectRandom _defaultScopes;
                };
            };
        };
    };
    case 2: //Sidearm
    {
        _unit removeWeapon (handgunWeapon _unit);
        [_unit, _weapon, 3] call BIS_fnc_addWeapon;
    };
    case 4: //Secondary
    {
        _params params ["_backpack"];

        // Ensure unit has backpack
        // TODO: add exception for disposable launchers
        if (backpack _unit isEqualTo "" && count _backpack > 0) then
        {
            _backpackFiltered = _backpack select {["RPG", _x] call BIS_fnc_inString};
            if (_backpackFiltered isEqualTo []) then
            {
                _backpackFiltered = _backpack select {!(_x isEqualTo "")};
            };
            _unit addBackpack selectRandom _backpackFiltered;
        };

        _unit removeWeapon (secondaryWeapon _unit);
        [_unit, _weapon, 2] call BIS_fnc_addWeapon;
    };
};