//fn_testGear
//
#include "\x\tmf\addons\autotest\script_component.hpp"

private _loadoutsToTest = [];
private _output = [];

// do arrays, error type and text
// errortypes: 0 = red, 1 = warning

GVAR(GEAR_OUTPUT) = []; // Hook for addbackpackItems when we do assignGear.
{
    (_x get3DENAttribute 'TMF_assignGear_enabled') params [["_enabled",false]];

    if (_enabled) then {
        (_x get3DENAttribute 'TMF_assignGear_role') params [["_role","r"]];
        (_x get3DENAttribute 'TMF_assignGear_faction') params [["_faction",toLower(faction _unit)]];
        
        private _index = _loadoutsToTest pushBackUnique [_faction, _role];
        if (_index != -1) then {
            _x call EFUNC(assigngear,assignGear);
            private _weight = (loadAbs _x) * 0.1;
            _weight = (round (_weight * (1/2.2046) * 100)) / 100; // ACE calculation
            if (_weight >= 35) then {
                _output pushBack [1,format["Heavy role %1kg (for: %2 - %3)",_weight,_faction,_role]];
            };
        };
    };
} forEach allUnits;

_output append GVAR(GEAR_OUTPUT);
GVAR(GEAR_OUTPUT) = nil;

#define GETGEAR(var) [_config >> var] call CFUNC(getCfgEntryFromPath)


private _fnc_checkExists = {
    params ["_subarray","_config"];
    
    {
        if ((_x != "") and (_x != "default")) then {
            if (!isClass (_config >> _x)) then {
                _output pushBack [0,format["Missing classname: %1 (for: %2 - %3)", _x,_faction,_role]];  
            };
        };
    } forEach _subarray;
};

{
    _x params ["_faction","_role"];

    private _config = missionConfigFile >> "cfgLoadouts" >> _faction >> _role;
    if (!isClass (_config)) then { 
        _config = configFile >> "cfgLoadouts" >> _faction >> _role;
    };

    if (isClass _config) then {
        private _uniform = GETGEAR("uniform"); //cfgweapons
        [_uniform, configFile >> "CfgWeapons"] call _fnc_checkExists;
        private _vest = GETGEAR("vest"); //CfgWeapons
        [_vest, configFile >> "CfgWeapons"] call _fnc_checkExists;
        private _backpack = GETGEAR("backpack"); /// cfghivecles
        [_backpack, configFile >> "CfgVehicles"] call _fnc_checkExists;
        private _headgear = GETGEAR("headgear"); //cfgweapons
        [_headgear, configFile >> "CfgWeapons"] call _fnc_checkExists;
        private _goggles = GETGEAR("goggles"); //CfgGlasses
        [_goggles, configFile >> "CfgGlasses"] call _fnc_checkExists;
        private _hmd = GETGEAR("hmd"); // "Cfgweapons" 
        [_hmd, configFile >> "Cfgweapons"] call _fnc_checkExists;
        // Get primary weapon and items
        private _primaryWeapon = GETGEAR("primaryWeapon"); //Cfgweapons"
        [_primaryWeapon, configFile >> "CfgWeapons"] call _fnc_checkExists;
        private _scope = GETGEAR("scope"); // "Cfgweapons"
        [_scope, configFile >> "CfgWeapons"] call _fnc_checkExists;
        private _bipod = GETGEAR("bipod"); //"Cfgweapons"
        [_bipod, configFile >> "CfgWeapons"] call _fnc_checkExists;
        private _attachment = GETGEAR("attachment"); // "Cfgweapons"
        [_attachment, configFile >> "CfgWeapons"] call _fnc_checkExists;
        private _silencer = GETGEAR("attachment"); //"Cfgweapons"
        [_silencer, configFile >> "CfgWeapons"] call _fnc_checkExists;

        // Get other weapon and items
        private _secondaryWeapon = GETGEAR("secondaryWeapon"); //Cfgweapons"
        [_secondaryWeapon, configFile >> "CfgWeapons"] call _fnc_checkExists;
        private _secondaryAttachments = GETGEAR("secondaryAttachments");//"Cfgweapons"
        [_secondaryAttachments, configFile >> "CfgWeapons"] call _fnc_checkExists;
        private _sidearmWeapon = GETGEAR("sidearmWeapon"); //Cfgweapons"
        [_sidearmWeapon, configFile >> "CfgWeapons"] call _fnc_checkExists;
        private _sidearmAttachments = GETGEAR("sidearmAttachments");//"Cfgweapons"
        [_sidearmAttachments, configFile >> "CfgWeapons"] call _fnc_checkExists;

        private _linkedItems = GETGEAR("linkedItems");// "Cfgmagazines"
        [_linkedItems, configFile >> "CfgWeapons"] call _fnc_checkExists;
        
        // Get items in inventory
        private _magsAndItems = (GETGEAR("magazines")) + (GETGEAR("items")) + (GETGEAR("backpackItems"));
        
        private _mags = [];
        {
            private _exists = false;
            if (isClass (configFile >> "CfgMagazines" >> _x)) then { _exists = true; _mags pushBack (toLower _x);};
            if (isClass (configFile >> "CfgWeapons" >> _x)) then { _exists = true; };
            if (!_exists) then {
                _output pushBack [0,format["Missing classname: %1 (for: %2 - %3 - %4)", _x,_side,_faction,_role]]; 
            }
        } forEach _magsAndItems;

        //Mag check 
        if (count _primaryWeapon > 0) then {
            private _weaponMags = getArray (configFile >> "CfgWeapons" >> (_primaryWeapon select 0) >> "magazines");
            _weaponMags = _weaponMags apply {toLower _x};
            private _weaponMagCount = 0;
            {
                if (_x in _weaponMags) then {
                    _weaponMagCount = _weaponMagCount + 1;
                };
            } forEach _mags;
            if (_weaponMagCount < 3) then {
                _output pushBack [1,format["Role: %2 - %3 has less than 3 compatible mags for primary weapon.", _x,_faction,_role]]; 
            };
        };
        
        if (count _sidearmWeapon > 0) then {
            private _weaponMags = getArray (configFile >> "CfgWeapons" >> (_sidearmWeapon select 0) >> "magazines");
            _weaponMags = _weaponMags apply {toLower _x};
            private _weaponMagCount = 0;
            {
                if (_x in _weaponMags) then {
                    _weaponMagCount = _weaponMagCount + 1;
                };
            } forEach _mags;
            if (_weaponMagCount == 0) then {
                _output pushBack [1,format["Role: %2 - %3 has no compatible mag for sidearm.", _x,_faction,_role]]; 
            };
        };

    } else {
        _output pushBack [0,format["Missing kit %1 - %2",_faction,_role]];
    };
    
} forEach _loadoutsToTest;

_output pushBack [-1,"AssignGear checks complete."];

_output;