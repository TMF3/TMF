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
#include "\x\tmf\addons\briefing\script_component.hpp"
params ["_target","_units"];

// ==========================

// Local function to set the proper magazine count.
private _fnc_wepMags = {
    params["_weapon"];
    private _ret = "";

    //Get possible magazines for weapon
    private _wepMags = getArray(configFile >> "CfgWeapons" >> _weapon >> "magazines");

    // Compare weapon magazines with unit magazines
    private _magArray = [];
    {
        // findInPairs returns the first index that matches the checked for magazine
        private _idx = [_mags,_x] call BIS_fnc_findInPairs;
        // If we have a match
        if (_idx != -1) then {
            // Add the number of magazines to the list
            _magArray pushBack ([_mags,[_idx, 1]] call BIS_fnc_returnNestedElement);;
            // Remove the entry
            _mags = [_mags, _idx] call BIS_fnc_removeIndex;
        };
    } forEach _wepMags;

    if (count _magArray > 0) then {
        _ret = " [";
        {
            _ret = _ret + format ["%1",_x];
            if (count _magArray > (_forEachIndex + 1)) then {_ret = _ret + "+";}
        } forEach _magArray;
        _ret = _ret + "]";
    };
    _ret
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
    _items = _items - ["ItemRadio","ACRE_PRC343","ACRE_PRC148","ACRE_PRC152","ACRE_PRC77","ACRE_PRC117F"];
    _items = _items call BIS_fnc_consolidateArray;

    private _visText = "";
    private _magVisText = "";

    private _weaponText = "";
    private _otherText = "";
    private _backPackText = "";
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
        _weaponText = _weaponText + "<font size='18'>WEAPONS:</font>";
        {
            private _weapon = _x;
            private _cfg = _cfgWeapons >> _weapon;
            _weaponText = _weaponText + format["<br/>%1",getText( _cfg >> "displayname")];
            // Add magazines for the weapon
            _weaponText = _weaponText + ([_weapon] call _fnc_wepMags);

            // Check for grenadier rifles
            private _muzzles = getArray(_cfg >> "muzzles");
            _muzzles = _muzzles apply {toLower _x};
            private _subClasses = [_cfg,0,true] call BIS_fnc_returnChildren;
            _subClasses = _subClasses select {"GrenadeLauncher" in ([_x,true] call BIS_fnc_returnParents)};
            _subClasses = _subClasses apply {configName _x};
            _subClasses = _subClasses select {(toLower _x) in _muzzles};
            {
                _weaponText = _weaponText + "<br/> <img image='\A3\ui_f\data\igui\cfg\weaponicons\GL_ca.paa' height='16'/> UGL";
                _weaponText = _weaponText + ([_x] call _fnc_wepMags);
            } forEach _subClasses;

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
                    _weaponText = _weaponText + format["<br/>  <img image='\A3\ui_f\data\gui\rscCommon\rscTree\hiddenTexture_ca.paa' height='16'/>%1",getText(_cfgWeapons >> _x >> "displayName")];
                    _visText = _visText + format["<img image='%1' height=48 />",_icon];
                };
            } forEach _attachments;
        } forEach _weapons;
        _weaponText = _weaponText + "<br/>";
        _visText = _visText + "<br/>";
    };

    // All magazines not tied to weapons (grenades etc.)
    if (count _mags > 0) then {
        _otherText = _otherText + "<br/><font size='18'>OTHER:</font><br/>";
        {
            _otherText = _otherText + format["%1 [%2]<br/>",getText(_cfgMagazines >> (_x select 0) >> "displayName"),_x select 1];
        } forEach _mags;
    };
    _visText = _visText + "<br/>" + _magVisText + "<br/>";

    // Backpacks
    if !(backpack _unit == "") then {
        _backPackText = _backPackText + "<br/><font size='18'>BACKPACK:</font><br/>";
        _backPackText = _backPackText + format["%1 [%2",getText (configFile >> "CfgVehicles" >> (backpack _unit) >> "displayName"), round(100*loadBackpack _unit)]+"% Full]<br/>";
    };

    // Misc. Items
    if (count _items > 0) then {
        _itemText = _itemText + "<br/><font size='18'>ITEMS:</font><br/>";
        {
            _itemText = _itemText + format["<img image='\A3\ui_f\data\gui\rscCommon\rscCheckBox\checkBox_unChecked_ca.paa' height='16'/>%1 [%2]<br/>",getText (_cfgWeapons >> _x select 0 >> "displayName"),_x select 1];
            _visText = _visText + "<img image='" + getText(_cfgWeapons >> _x select 0  >> "picture") + "' height=48 />";
            if ((_x select 1) > 1) then {
                _visText = _visText + format[" x%1",(_x select 1)];
            };
        } forEach _items;

        {
            _itemText = _itemText + format["<img image='\A3\ui_f\data\gui\rscCommon\rscCheckBox\checkBox_checked_ca.paa' height='16'/>%1<br/>",getText (_cfgWeapons >> _x >> "displayName")];
            _visText = _visText + format["<img image='%1' height=48 />",getText(_cfgWeapons >> _x >> "picture")];
        } forEach assignedItems _x;

        _itemText = _itemText + "<br/><img image='\A3\ui_f\data\gui\rscCommon\rscCheckBox\checkBox_checked_ca.paa' height='16'/>Indicates an equipped item.";
    };

    // Add the created text
    private _roleName = "";
    if (_unit getVariable ['TMF_assignGear_enabled',false]) then {
        private _classes = [];
        private _side = _unit getVariable [QEGVAR(assignGear,side),((side _unit) call EFUNC(common,sideToNum))];
        _side = toLower([_side] call CFUNC(sideType));

        private _faction = _unit getVariable [QEGVAR(assignGear,faction), toLower(faction _unit)];
        private _role = _unit getVariable [QEGVAR(assignGear,role), "r"];

        if(isClass (configFile >> "CfgLoadouts" >> _side >> _faction) && count _classes <= 0) then {_classes = configProperties [configFile >> "CfgLoadouts" >> _side >> _faction,"isClass _x"];};
        if(isClass (missionConfigFile >> "CfgLoadouts" >> _side >> _faction)) then {_classes = configProperties [missionConfigFile >> "CfgLoadouts" >> _side >> _faction,"isClass _x"];};
        {
            if(configName _x == _role) exitWith {_roleName = getText(_x >> "displayName");};
        } forEach _classes;
    };

    private _entryString = (name _unit);
    if (_roleName != "") then {
        _entryString = _entryString + format[" [Kit: %1]",_roleName];
    };

    if (!isNil "ace_movement_fnc_getWeight") then {
        _visText = format["Total Weight: %1 <br/>",([_unit] call ace_movement_fnc_getWeight)] + _visText;
    };

    _text = _text + _weaponText + _otherText + _backPackText + _itemText;
    _target createDiaryRecord ["loadout", [_entryString, "<font size='12'>NOTE: The loadout shown below is only accurate at mission start.</font><br/>" + _visText + _text]];
} forEach _units;