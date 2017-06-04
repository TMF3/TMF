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

private _cfgWeapons = configFile >> "CfgWeapons";
private _cfgVehicles = configFile >> "CfgVehicles";
private _cfgGlasses = configFile >> "CfgGlasses";
private _cfgMagazines = configFile >> "CfgMagazines";
{
    _x params ["_faction","_role"];

    private _config = missionConfigFile >> "cfgLoadouts" >> _faction >> _role;
    if (!isClass (_config)) then { 
        _config = configFile >> "cfgLoadouts" >> _faction >> _role;
    };

    if (isClass _config) then {
        private _uniform = GETGEAR("uniform"); //CfgWeapons
        [_uniform, _cfgWeapons] call _fnc_checkExists;
        private _vest = GETGEAR("vest"); //CfgWeapons
        [_vest, _cfgWeapons] call _fnc_checkExists;
        private _backpack = GETGEAR("backpack"); /// cfghivecles
        [_backpack, _cfgVehicles] call _fnc_checkExists;
        private _headgear = GETGEAR("headgear"); //CfgWeapons
        [_headgear, _cfgWeapons] call _fnc_checkExists;
        private _goggles = GETGEAR("goggles"); //CfgWeapons
        [_goggles, CfgWeapons] call _fnc_checkExists;
        private _hmd = GETGEAR("hmd"); // "CfgGlasses"
        [_hmd, _cfgGlasses] call _fnc_checkExists;
        // Get primary weapon and items
        private _primaryWeapon = GETGEAR("primaryWeapon"); //CfgWeapons"
        [_primaryWeapon, _cfgWeapons] call _fnc_checkExists;
        private _scope = GETGEAR("scope"); // "CfgWeapons"
        [_scope, _cfgWeapons] call _fnc_checkExists;
        private _bipod = GETGEAR("bipod"); //"CfgWeapons"
        [_bipod, _cfgWeapons] call _fnc_checkExists;
        private _attachment = GETGEAR("attachment"); // "CfgWeapons"
        [_attachment, _cfgWeapons] call _fnc_checkExists;
        private _silencer = GETGEAR("attachment"); //"CfgWeapons"
        [_silencer, _cfgWeapons] call _fnc_checkExists;

        // Get other weapon and items
        private _secondaryWeapon = GETGEAR("secondaryWeapon"); //CfgWeapons"
        [_secondaryWeapon, _cfgWeapons] call _fnc_checkExists;
        private _secondaryAttachments = GETGEAR("secondaryAttachments");//"CfgWeapons"
        [_secondaryAttachments, _cfgWeapons] call _fnc_checkExists;
        private _sidearmWeapon = GETGEAR("sidearmWeapon"); //CfgWeapons"
        [_sidearmWeapon, _cfgWeapons] call _fnc_checkExists;
        private _sidearmAttachments = GETGEAR("sidearmAttachments");//"CfgWeapons"
        [_sidearmAttachments, _cfgWeapons] call _fnc_checkExists;

        private _linkedItems = GETGEAR("linkedItems");// "Cfgmagazines"
        [_linkedItems, _cfgWeapons] call _fnc_checkExists;
        
        // Get items in inventory
        private _magsAndItems = (GETGEAR("magazines")) + (GETGEAR("items")) + (GETGEAR("backpackItems"));
        
        private _mags = [];
        {
            private _exists = false;
            if (isClass (_cfgMagazines >> _x)) then { _exists = true; _mags pushBack (toLower _x);};
            if (isClass (_cfgWeapons >> _x)) then { _exists = true; };
            if (!_exists) then {
                _output pushBack [0,format["Missing classname: %1 (for: %2 - %3 - %4)", _x,_side,_faction,_role]]; 
            }
        } forEach _magsAndItems;

        //Mag check 
        if (count _primaryWeapon > 0) then {
            private _weaponMags = getArray (_cfgWeapons >> (_primaryWeapon select 0) >> "magazines");
            _weaponMags = _weaponMags apply {toLower _x};
            private _weaponMagCount = {_x in _weaponMags} count _mags;
            if (_weaponMagCount < 3) then {
                _output pushBack [1,format["Role: %2 - %3 has less than 3 compatible mags for primary weapon.", _x,_faction,_role]]; 
            };
        };
        
        if (count _sidearmWeapon > 0) then {
            private _weaponMags = getArray (_cfgWeapons >> (_sidearmWeapon select 0) >> "magazines");
            _weaponMags = _weaponMags apply {toLower _x};
            private _weaponMagCount = {_x in _weaponMags} count _mags;
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