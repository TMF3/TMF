//fn_testGear
//
#include "\x\tmf\addons\autotest\script_component.hpp"

private _output = [];

private _fncTestUnit = {
    params ["_faction",["_role","r"]];

    private _config = missionConfigFile >> "cfgLoadouts" >> _faction >> _role;
    if (!isClass (_config)) then {
        _config = configFile >> "cfgLoadouts" >> _faction >> _role;
    };
    private _return = [0,0,0];
    if (isClass _config) then {

        // Check Equipment
        _output append ([GETGEAR("uniform"), CFGWEAPONS, _faction, _role] call FUNC(checkExists));
        _output append ([GETGEAR("vest"), CFGWEAPONS, _faction, _role] call FUNC(checkExists));
        _output append ([GETGEAR("backpack"), CFGVEHICLES, _faction, _role] call FUNC(checkExists));
        _output append ([GETGEAR("headgear"), CFGWEAPONS, _faction, _role] call FUNC(checkExists));
        _output append ([GETGEAR("goggles"), CFGGLASSES, _faction, _role] call FUNC(checkExists));
        _output append ([GETGEAR("hmd"), CFGWEAPONS, _faction, _role] call FUNC(checkExists));
        _output append ([GETGEAR("insignias"), _faction, _role] call FUNC(checkExists_insignia));
        _output append ([GETGEAR("faces"), _faction, _role] call FUNC(checkExists_faces));

        // Check Primary Weapon
        _output append ([GETGEAR("primaryWeapon"), CFGWEAPONS, _faction, _role, PRIMARYSLOT] call FUNC(checkExists));
        _output append ([GETGEAR("scope"), CFGWEAPONS, _faction, _role] call FUNC(checkExists));
        _output append ([GETGEAR("bipod"), CFGWEAPONS, _faction, _role] call FUNC(checkExists));
        _output append ([GETGEAR("attachment"), CFGWEAPONS, _faction, _role] call FUNC(checkExists));
        _output append ([GETGEAR("silencer"), CFGWEAPONS, _faction, _role] call FUNC(checkExists));

        // Check Secondary Weapon
        _output append ([GETGEAR("secondaryWeapon"),CFGWEAPONS, _faction, _role, SECONDARYSLOT] call FUNC(checkExists));
        _output append ([GETGEAR("secondaryAttachments"),CFGWEAPONS, _faction, _role] call FUNC(checkExists));

        // Check Sidearm Weapon
        _output append ([GETGEAR("sidearmWeapon"),CFGWEAPONS, _faction, _role, HANDGUNSLOT] call FUNC(checkExists));
        _output append ([GETGEAR("sidearmAttachments"),CFGWEAPONS, _faction, _role] call FUNC(checkExists));

        // Linked "weapons"/items
        _output append ([GETGEAR("linkedItems"), CFGWEAPONS, _faction, _role] call FUNC(checkExists));

        // Get items in inventory
        // CfgWeapons >> "weaponName" >> WeaponSlotsInfo >> mass
        // CfgWeapons >> ItemName >> ItemInfo >> mass
        //TODO: factor in allowedSlots - 701 vest, 801 uniform, 901 backpacks


        // Select smallest containers

        private _freeBackpackSpace = -1;
        private _backpack = GETGEAR("backpack");
        if (count _backpack > 0) then {
            private _sizes = _backpack apply {getContainerMaxLoad _x};
            _sizes sort true;
            _freeBackpackSpace = (_sizes # 0);
        };
        private _freeUniformSpace = -1;
        private _uniform = GETGEAR("uniform");
        if (count _uniform > 0) then {
            private _sizes = _uniform apply {getContainerMaxLoad _x};
            _sizes sort true;
            _freeUniformSpace = (_sizes # 0);
        };

        private _vest = GETGEAR("vest");
        private _freeVestSpace = -1;
        if (count _vest > 0) then {
            private _sizes = _vest apply {getContainerMaxLoad _x};
            _sizes sort true;
            _freeVestSpace = (_sizes # 0);
        };
        private _mags = []; // For checking number compatible

        {
            private _mass = -1;
            call {
                if (isClass (CFGMAGAZINES >> _x)) exitWith {
                    _mass = getNumber (CFGMAGAZINES >> _x >> "mass");
                    PUSH(_mags,toLower _x);
                };
                if (isClass (CFGWEAPONS >> _x)) exitWith {
                    _mass = getNumber (CFGWEAPONS >> _x >> "ItemInfo" >> "mass");
                    if (_mass isEqualTo 0) then {
                        _mass = getNumber (CFGWEAPONS >> _x >> "WeaponSlotsInfo" >> "mass");
                    };
                };
                if (isClass (CFGGLASSES >> _x)) exitWith {
                    _mass = getNumber (CFGGLASSES >> _x >> "mass");
                };
            };
            if (_mass >= 0) then {
                if (_mass <= _freeBackpackSpace) then {
                    SUB(_freeBackpackSpace,_mass);
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
            if (isClass (CFGMAGAZINES >> _x)) then {
                _mass = getNumber (CFGMAGAZINES >> _x >> "mass");
                PUSH(_mags,toLower _x);
            };
            if (isClass (CFGWEAPONS >> _x)) then {
                _mass = getNumber (CFGWEAPONS >> _x >> "ItemInfo" >> "mass");
                if (_mass isEqualTo 0) then {
                    _mass = getNumber (CFGWEAPONS >> _x >> "WeaponSlotsInfo" >> "mass");
                };
            };
            if (_mass >= 0) then {
                if (_mass <= _freeUniformSpace) then {
                    SUB(_freeUniformSpace,_mass);
                } else {
                    if (_mass <= _freeVestSpace) then {
                        SUB(_freeVestSpace,_mass);
                    } else {
                        if (_mass <= _freeBackpackSpace) then {
                            SUB(_freeBackpackSpace,_mass);
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
            private _weaponMags = [_primaryWeapon # 0] call CBA_fnc_compatibleMagazines;
            MAP(_weaponMags,toLower _x);
            private _weaponMagCount = {_x in _weaponMags} count _mags;
            if (_weaponMagCount < 3) then {
                _output pushBack [1,format["Role: %2 - %3 has less than 3 compatible mags for primary weapon.", _x,_faction,_role]];
            };
        };

        if (count _sidearmWeapon > 0) then {
            private _weaponMags = [_sidearmWeapon # 0] call CBA_fnc_compatibleMagazines;
            MAP(_weaponMags,toLower _x);
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
            PUSH(_loadoutFreespace,_freespace);
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
            if (isClass (CFGMAGAZINES >> _x)) then {
                _mass = getNumber (CFGMAGAZINES >> _x >> "mass");
                PUSH(_mags,toLower _x);
            };
            if (isClass (CFGWEAPONS >> _x)) then {
                _mass = getNumber (CFGWEAPONS >> _x >> "ItemInfo" >> "mass");
                if (_mass isEqualTo 0) then {
                    _mass = getNumber (CFGWEAPONS >> _x >> "WeaponSlotsInfo" >> "mass");
                };
            };
            if (_mass >= 0) then {
                if (_mass <= _freeUniformSpace) then {
                    SUB(_freeUniformSpace,_mass);
                } else {
                    if (_mass <= _freeVestSpace) then {
                        SUB(_freeVestSpace,_mass);
                    } else {
                        if (_mass <= _freeBackpackSpace) then {
                            SUB(_freeBackpackSpace,_mass);
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

_output
