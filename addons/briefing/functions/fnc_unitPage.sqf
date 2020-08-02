#include "\x\tmf\addons\briefing\script_component.hpp"
/*
 *      Name: TMF_briefing_fnc_unitPage
 *      Author: Nick, Snippers
 *
 *      Arguments:
 *          0: Object. Unit to give the briefing to.
 *          1: Array of objects, units to give information about.
 *
 *      Return:
 *          None
 *
 *      Description:
 *          Generate briefing pages showing the loadout of the provided units.
 */
params ["_target","_units"];

private _fnc_weaponMags = {
    params ["_weapon"];
    
    private _compatibleMags = [_weapon] call CBA_fnc_compatibleMagazines;
    private _carriedMags = [];
    
    {
        private _idx = [_mags, _x] call BIS_fnc_findInPairs;
        if (_idx != -1) then {
            _carriedMags pushBack +(_mags select _idx);
            _mags deleteAt _idx;
        };
    } forEach _compatibleMags;
    
    _carriedMags
};

// ==========================
private _cfgMagazines = configFile >> "CfgMagazines";
private _cfgWeapons = configFile >> "CfgWeapons";
{
    private _text = "<br/>";
    private _visText = "";
    private _unit = _x;
    // Filter out field glasses
    private _weapons = (weapons _unit) select {(toLower (getText(_cfgWeapons >> _x >> "simulation"))) != "binocular"};
    // Get a nested array containing all attached weapon items
    private _weaponItems = weaponsItems _unit;
    // Get a nested array containing all unique magazines and their count
    private _mags = (primaryWeaponMagazine _unit + secondaryWeaponMagazine _unit + handgunMagazine _unit + magazines _unit) call BIS_fnc_consolidateArray;
    // Get a nested array containing all non-equipped items and their count
    private _items = (items _unit) - _weapons;
    // Remove ACRE radios (show in ACRE2 page instead) and deleted indexes;
    _items = _items - ["ItemRadio","ACRE_PRC343","ACRE_PRC148","ACRE_PRC152","ACRE_PRC77","ACRE_PRC117F","ACRE_SEM52SL"];
    _items = _items call BIS_fnc_consolidateArray;

    private _visText = "";
    private _magVisText = "";

    private _weaponText = "";
    private _otherText = "";
    private _gearText = "";
    private _itemText = "";
    // Do this before _mags is deleted from

    {
        _x params ["_magClassName","_magQuantity"];
        // Mass check isn't needed at least for now.
        //if (getNumber (_cfgMagazines >> _magClassName >> "mass") > 0) then {
            private _icon = getText(_cfgMagazines >> _magClassName >> "picture");
            if (_icon find ".paa" == -1) then { _icon = _icon + ".paa"};
            _magVisText = _magVisText + format["<img image='%1' height=48 />",_icon];
            if ((_x select 1) > 1) then {
                _magVisText = _magVisText + format[" x%1",_magQuantity];
            };
        //};
    } forEach _mags;

    // Weapons
    if (count _weapons > 0) then {
        _weaponText = _weaponText + "<font size='18'>WEAPONS</font>";
        {
            private _weapon = _x;
            private _cfg = _cfgWeapons >> _weapon;
            if (_forEachIndex > 0) then {
                _weaponText = _weaponText + "<br/>";
            };
            _weaponText = format ["%1<br/><font color='#f7da00'>%2</font>", _weaponText, getText ( _cfg >> "displayname")];

            // Get weapon icon
            private _icon = getText(_cfg >> "picture");
            if (_icon find ".paa" == -1) then { _icon = _icon + ".paa"};
            _visText = _visText + "<img image='" + _icon + "' height=48 />";

            // Weapon attachments
            private _attachments = _weaponItems select (([_weaponItems,_weapon] call BIS_fnc_findNestedElement) select 0);
            _attachments deleteAt 0; // Remove the first element as it points to the weapon itself
            {
                if (!(_x isEqualType []) && {_x != ""}) then {
                    _icon = getText(_cfgWeapons >> _x >> "picture");
                    if (_icon find ".paa" == -1) then { _icon = _icon + ".paa"};
                    _weaponText = format ["%1<br/>  <img image='\A3\ui_f\data\gui\rscCommon\rscTree\hiddenTexture_ca.paa' height='16'/>%2", _weaponText, getText (_cfgWeapons >> _x >> "displayName")];
                    _visText = format ["%1<img image='%2' height=48 />", _visText, _icon];
                };
            } forEach _attachments;
            
            private _weaponMags = _weapon call _fnc_weaponMags;
            {
                _weaponText = format ["%1<br/>          %2 [%3]", _weaponText, getText (configFile >> "CfgMagazines" >> (_x select 0) >> "displayName"), _x select 1];
            } forEach _weaponMags;

            // underbarrel gl
            private _muzzles = getArray (_cfg >> "muzzles");
            (
                ((configProperties [_cfg, "isClass _x", true]) select {(configName _x) in _muzzles}) select {"GrenadeLauncher" in ([_x, true] call BIS_fnc_returnParents)} // yikes
            ) params [["_underbarrel", configNull]];

            if (!isNull _underbarrel) then {
                _weaponText = format ["%1<br/> <img image='\A3\ui_f\data\igui\cfg\weaponicons\GL_ca.paa' height='16'/> <font color='#f7da00'>%2</font>", _weaponText, getText (_underbarrel >> "displayName")];
                
                private _weaponMags = _underbarrel call _fnc_weaponMags;
                {
                    _weaponText = format ["%1<br/>          %2 [%3]", _weaponText, getText (configFile >> "CfgMagazines" >> (_x select 0) >> "displayName"), _x select 1];
                } forEach _weaponMags;
            };
        } forEach _weapons;
        _weaponText = _weaponText + "<br/>";
        _visText = _visText;
    };

    // All magazines not tied to weapons (grenades etc.)
    if (count _mags > 0) then {
        _otherText = _otherText + "<br/><font size='18'>OTHER</font><br/>";
        {
            _otherText = format ["%1%2", _otherText, getText (_cfgMagazines >> (_x select 0) >> "displayName")];
            if ((_x select 1) > 1) then {
                _otherText = format ["%1 [%2]", _otherText, _x select 1];
            };
            _otherText = format ["%1<br/>", _otherText];
        } forEach _mags;
    };
    _visText = _visText + _magVisText;

    // Gear
    _gearText = _gearText + "<br/><font size='18'>GEAR</font><br/>";
    if !((uniform _unit) isEqualTo "") then {
        _gearText = _gearText + format ["<font color='#bbbbbb'>Uniform:</font> %1 [%2", getText (configFile >> "CfgWeapons" >> (uniform _unit) >> "displayName"), round (100 * loadUniform _unit)] + "% full]<br/>";
    };
    if !((vest _unit) isEqualTo "") then {
        _gearText = _gearText + format ["<font color='#bbbbbb'>Gear:</font> %1 [%2", getText (configFile >> "CfgWeapons" >> (vest _unit) >> "displayName"), round (100 * loadVest _unit)] + "% full]<br/>";
    };
    if !((backpack _unit) isEqualTo "") then {
        _gearText = _gearText + format ["<font color='#bbbbbb'>Backpack:</font> %1 [%2", getText (configFile >> "CfgVehicles" >> (backpack _unit) >> "displayName"), round (100 * loadBackpack _unit)] + "% full]<br/>";
    };
    if !((headgear _unit) isEqualTo "") then {
        _gearText = _gearText + format ["<font color='#bbbbbb'>Head:</font> %1<br/>", getText (configFile >> "CfgWeapons" >> (headgear _unit) >> "displayName")];
    };
    if !((hmd _unit) isEqualTo "") then {
        _gearText = _gearText + format ["<font color='#bbbbbb'>NVG:</font> %1<br/>", getText (configFile >> "CfgWeapons" >> (hmd _unit) >> "displayName")];
        _visText = _visText + "<img image='" + getText (configFile >> "CfgWeapons" >> (hmd _unit)  >> "picture") + "' height=48 />";
    };
    if !((binocular _unit) isEqualTo "") then {
        _gearText = _gearText + format ["<font color='#bbbbbb'>Binocular:</font> %1<br/>", getText (configFile >> "CfgWeapons" >> (binocular _unit) >> "displayName")];
        _visText = _visText + "<img image='" + getText (configFile >> "CfgWeapons" >> (binocular _unit)  >> "picture") + "' height=48 />";
    };

    // Misc. Items
    private _assignedItems = assignedItems _unit - [binocular _unit, hmd _unit];
    if (count _items > 0 || count _assignedItems > 0) then {
        _itemText = _itemText + "<br/><font size='18'>ITEMS</font><br/>";

        private _filter = ["ItemWatch", "ItemMap", "ItemCompass"];
        {
            _visText = format["%1<img image='%2' height=48 />", _visText, getText (_cfgWeapons >> _x >> "picture")];
        } forEach _assignedItems select {!(_x in _filter)};

        private _assignedItemsStr = (_assignedItems apply {getText (_cfgWeapons >> _x >> "displayName")}) joinString ", ";
        if !(_assignedItemsStr isEqualTo "") then {
            _itemText = format["%1%2<br/>", _itemText, _assignedItemsStr];
        };

        {
            _itemText = format ["%1%2", _itemText, getText (_cfgWeapons >> _x select 0 >> "displayName"), _x select 1];
            _visText = format ["%1<img image='%2' height=48 />", _visText, getText (_cfgWeapons >> _x select 0  >> "picture")];

            if ((_x select 1) > 1) then {
                _itemText = format ["%1 [%2]", _itemText, _x select 1];
                _visText = format["%1 x%2", _visText, _x select 1];
            };

            _itemText = format ["%1<br/>", _itemText];
        } forEach _items;
    };
    
    _text = _text + _weaponText + _otherText + _gearText + _itemText;

    private _roleName = "";
    private _faction = _unit getVariable [QEGVAR(assigngear,faction), ""];
    private _role = _unit getVariable [QEGVAR(assigngear,role), ""];
    
    if !(_faction isEqualTo "") then {
        private _classFaction = (missionConfigFile >> "CfgLoadouts" >> _faction);
        if (isNull _classFaction) then {
            _classFaction = (configFile >> "CfgLoadouts" >> _faction);
        };
        
        if (!isNull _classFaction) then {
            _roleName = getText (_classFaction >> _role >> "displayName");
        };
    };
    
    if (!isNil "ace_common_fnc_getWeight") then {
        _text = _text + format ["<br/>Total Weight: %1 (%2)", [_unit] call ace_common_fnc_getWeight, [_unit, true] call ace_common_fnc_getWeight];
    };

    // Add the created text
    private _entryString = (name _unit);
    if !(_roleName isEqualTo "") then {
        _entryString = _entryString + format [" [%1]", _roleName];
    };
    _target createDiaryRecord ["loadout", [_entryString, "<font size='12'>NOTE: The loadout shown below is only accurate at mission start.</font><br/>" + ((_visText + _text) splitString "&" joinString "&amp;")]];
} forEach _units;