//fn_testGear
//
#include "\x\tmf\addons\autotest\script_component.hpp"


private _cfgWeapons = configFile >> "CfgWeapons";
private _cfgVehicles = configFile >> "CfgVehicles";
private _cfgGlasses = configFile >> "CfgGlasses";
private _cfgMagazines = configFile >> "CfgMagazines";


private _output = [];

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

private _fncTestUnit = {
    params ["_faction",["_role","r"]];

    private _config = missionConfigFile >> "cfgLoadouts" >> _faction >> _role;
    if (!isClass (_config)) then { 
        _config = configFile >> "cfgLoadouts" >> _faction >> _role;
    };
    private _return = [0,0,0];
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
        [_goggles, _cfgGlasses] call _fnc_checkExists;
        private _hmd = GETGEAR("hmd"); // "CfgGlasses"
        [_hmd, _cfgWeapons] call _fnc_checkExists;
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
        // CfgWeapons >> "weaponName" >> WeaponSlotsInfo >> mass
        // CfgWeapons >> ItemName >> ItemInfo >> mass
        //TODO: factor in allowedSlots - 701 vest, 801 uniform, 901 backpacks

        private _freeBackpackSpace = -1;
        // select smallest.
        if (count _backpack > 0) then {
            private _sizes = _backpack apply {getContainerMaxLoad _x};
            _sizes sort true;
            _freeBackpackSpace = _sizes select 0;
        };
        private _freeUniformSpace = -1;
        if (count _uniform > 0) then {
            private _sizes = _uniform apply {getContainerMaxLoad _x};
            _sizes sort true;
            _freeUniformSpace = _sizes select 0;
        };
        private _freeVestSpace = -1;
        if (count _vest > 0) then {
            private _sizes = _vest apply {getContainerMaxLoad _x};
            _sizes sort true;
            _freeVestSpace = _sizes select 0;
        };
        private _mags = []; // For checking number compatible

        {
            private _mass = -1;
            call {
                if (isClass (_cfgMagazines >> _x)) exitWith {
                    _mass = getNumber (_cfgMagazines >> _x >> "mass");
                    _mags pushBack (toLower _x);
                };
                if (isClass (_cfgWeapons >> _x)) exitWith {
                    _mass = getNumber (_CfgWeapons >> _x >> "ItemInfo" >> "mass");
                    if (_mass isEqualTo 0) then {
                        _mass = getNumber (_CfgWeapons >> _x >> "WeaponSlotsInfo" >> "mass");
                    };
                };
                if (isClass (_cfgGlasses >> _x)) exitWith {
                    _mass = getNumber (_cfgGlasses >> _x >> "mass");
                };
            };
            if (_mass >= 0) then {
                if (_mass <= _freeBackpackSpace) then {
                    _freeBackpackSpace = _freeBackpackSpace - _mass;
                } else {
                    _output pushBack [0,format["'%1' won't fit in backpack (for: %2 - %3)", _x,_faction,_role]];
                };
            } else {
                _output pushBack [0,format["Missing classname: %1 (for: %2 - %3)", _x,_faction,_role]];
            };
        } forEach (GETGEAR("backpackItems"));

        private _magsAndItems = (GETGEAR("magazines")) + (GETGEAR("items"));

        
        {
            private _mass = -1;
            if (isClass (_cfgMagazines >> _x)) then {
                _mass = getNumber (_cfgMagazines >> _x >> "mass");
                _mags pushBack (toLower _x);
            };
            if (isClass (_cfgWeapons >> _x)) then {
                _mass = getNumber (_CfgWeapons >> _x >> "ItemInfo" >> "mass");
                if (_mass isEqualTo 0) then {
                    _mass = getNumber (_CfgWeapons >> _x >> "WeaponSlotsInfo" >> "mass");
                };
            };
            if (_mass >= 0) then {
                if (_mass <= _freeUniformSpace) then {
                    _freeUniformSpace = _freeUniformSpace - _mass;
                } else {
                    if (_mass <= _freeVestSpace) then {
                        _freeVestSpace = _freeVestSpace - _mass;
                    } else {
                        if (_mass <= _freeBackpackSpace) then {
                            _freeBackpackSpace = _freeBackpackSpace - _mass;
                        } else {
                            _output pushBack [0,format["'%1' won't fit (for: %2 - %3)", _x,_faction,_role]];
                        };
                    };
                };
            } else {
                _output pushBack [0,format["Missing classname: %1 (for: %2 - %3)", _x,_faction,_role]];
            };
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

        _return = [_freeUniformSpace,_freeVestSpace,_freeBackpackSpace];
    } else {
        _output pushBack [0,format["Missing kit %1 - %2",_faction,_role]];
    };
    _return;
};

// do arrays, error type and text
// errortypes: 0 = red, 1 = warning
private _loadoutsTested = [];
private _loadoutFreespace = [];
{
    private _unit = _x;
    (_unit get3DENAttribute 'TMF_assignGear_enabled') params [["_enabled",false]];

    if (_enabled) then {
        (_unit get3DENAttribute 'TMF_assignGear_role') params [["_role","r"]];
        (_unit get3DENAttribute 'TMF_assignGear_faction') params [["_faction",toLower(faction _unit)]];
        
        private _index = _loadoutsTested pushBackUnique [_faction, _role];
        private _freespace = []; // Uniform,Vest,Backpack;
        if (_index != -1) then {
            _freespace = [_faction,_role] call _fncTestUnit;
            _loadoutFreespace pushBack _freespace;
            _unit call EFUNC(assigngear,assignGear);
            private _weight = (loadAbs _unit) * 0.1;
            _weight = (round (_weight * (1/2.2046) * 100)) / 100; // ACE calculation
            if (_weight >= 35) then {
                _output pushBack [1,format["Heavy role %1kg (for: %2 - %3)",_weight,_faction,_role]];
            };
        } else {
            _freespace = _loadoutFreespace select (_loadoutsTested find [_faction, _role]);
        };
        private _radios = [_unit] call EFUNC(acre2,edenUnitToRadios);
        _freespace params ["_freeUniformSpace","_freeVestSpace","_freeBackpackSpace"];
        {
            private _mass = -1;
            if (isClass (_cfgMagazines >> _x)) then {
                _mass = getNumber (_cfgMagazines >> _x >> "mass");
                _mags pushBack (toLower _x);
            };
            if (isClass (_cfgWeapons >> _x)) then {
                _mass = getNumber (_CfgWeapons >> _x >> "ItemInfo" >> "mass");
                if (_mass isEqualTo 0) then {
                    _mass = getNumber (_CfgWeapons >> _x >> "WeaponSlotsInfo" >> "mass");
                };
            };
            if (_mass >= 0) then {
                if (_mass <= _freeUniformSpace) then {
                    _freeUniformSpace = _freeUniformSpace - _mass;
                } else {
                    if (_mass <= _freeVestSpace) then {
                        _freeVestSpace = _freeVestSpace - _mass;
                    } else {
                        if (_mass <= _freeBackpackSpace) then {
                            _freeBackpackSpace = _freeBackpackSpace - _mass;
                        } else {
                            _output pushBack [0,format["'%1' radio won't fit for: %2 (%3)", _x,_unit,group _unit]];
                        };
                    };
                };
            } else {
                _output pushBack [0,format["Missing radio classname: %1 (for: %2)", _x,_unit]];
            };
        } forEach _radios;
    };
} forEach allUnits;





_output pushBack [-1,"AssignGear checks complete."];

_output;