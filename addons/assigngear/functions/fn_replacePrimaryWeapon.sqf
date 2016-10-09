/*
 * Name = TMF_assignGear_fnc_replacePrimaryWeapon
 * Author = Nick
 *
 * Arguments:
 * 0: Object. Unit
 * 1: ARRAY. Array of classnames. One is chosen randomly
 * 2: ARRAY. Array of classnames. One is chosen randomly
 * 3: ARRAY. Array of classnames. One is chosen randomly
 * 4: ARRAY. Array of classnames. One is chosen randomly
 * 5: ARRAY. Array of classnames. One is chosen randomly
 *
 * Return:
 * None
 *
 * Description:
 * Replaces a units' primary weapon
 */
 #include "\x\tmf\addons\assignGear\script_component.hpp"
 params ["_unit","_weaponArray","_scopeArray","_bipodArray","_attachmentArray","_silencerArray"];

// Remove weapon and exit if weaponArray is empty
if (count _weaponArray < 1) exitWith {_unit removeWeapon (primaryWeapon _unit)};

private _weapon = toLower selectRandom _weaponArray;

// Exit if weapon was set to "default"
if (_weapon isEqualTo "default") exitWith {};
// Replace weapon, sanitize and add weapon items
_unit removeWeapon (primaryWeapon _unit);
if !(isNil "_weapon") then {
    _unit addWeapon _weapon;
};
removeAllPrimaryWeaponItems _unit;
if(count _this > 3) then {
    private _scope = toLower selectRandom _scopeArray;
    private _bipod = toLower selectRandom _bipodArray;
    private _attachment = toLower selectRandom _attachmentArray;
    private _silencer = toLower selectRandom _silencerArray;

    if(isNil "_scope") then {_scope = ""};
    if(isNil "_bipod") then {_bipod = ""};
    if(isNil "_attachment") then {_attachment = ""};
    if(isNil "_silencer") then {_silencer = ""};
    {
        if (!isNil "_x" && _x != "" ) then {
            _unit addPrimaryWeaponItem _x;
        };
    } forEach [_scope,_bipod,_attachment,_silencer];;
}
else
{
    {
        if (!isNil "_x" && _x != "" ) then {
            _unit addPrimaryWeaponItem _x;
        };
    } forEach _scopeArray;
};
