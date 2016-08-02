/*
 *      Name: TMF_briefing_fnc_vehiclePage
 *      Author: Nick, Snippers
 *
 *      Arguments:
 *          0: Object. Unit to give the briefing to.
 *          1: Array of objects, vehicles to give information about.
 *
 *      Return:
 *          None
 *
 *      Description:
 *          Generate briefing pages giving information about the provided vehicles
 */
#include "\x\tmf\addons\briefing\script_component.hpp"
params ["_target","_vehicles"];

{
    private _text = "<br/>";
    private _veh = _x;
    private _type = typeOf _veh;
    private _cfg = configFile >> "CfgVehicles" >> _type;
    private _isAir = _type isKindOf "Air";

    // Callsign (displayName)
    private _vehName = _veh getVariable [
        QEGVAR(orbat,vehicleCallsign),
        [getText (_cfg >> "displayName"),"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_- "] call BIS_fnc_filterString
    ];
    if !((_veh getVariable [QEGVAR(orbat,vehicleCallsign),-1]) isEqualTo -1) then {
        _vehName = _vehName + " (" + ([getText(_cfg >> "displayName"),"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_- "] call BIS_fnc_filterString) + ")";
    };
    _text = _text + format["<font size='18'>%1</font>",_vehName];

    // Crew
    _text = _text + "<br/><font size='18'>Crew:</font><br/>";

    // Driver
    if (((getNumber(_cfg >> "hasDriver")) > 0) && {!lockedDriver _veh}) then {
        private _driverName = ["Driver","Pilot"] select _isAir;
        private _unitText = driver _veh;
        if !(isNull _unitText) then {
            _unitText = name _unitText;
        } else {
            _unitText = "Empty";
        };
        _text = _text + format["    %1: %2<br/>",_driverName,_unitText];
    };

    // Turrets
    private _proxyIdxs = [];
    {
        private _cfgTurret = _cfg;
        {_cfgTurret = (_cfgTurret >> "Turrets") select _x} forEach _x;
        private _turretName = [getText(_cfgTurret >> "gunnerName")] call CBA_fnc_capitalize;
        private _locked = _veh lockedTurret _x;
        // Handle FFV turrets and turned out positions
        if ((getNumber(_cfgTurret >> "isPersonTurret") > 0) && (getnumber(_cfg >> "hideProxyInCombat") isEqualTo 0)) then {
            // Save the idx of the turret
            _proxyIdxs pushBack getNumber(_cfgTurret >> "proxyIndex");
        };
        if !(_locked) then {
            private _unitText = _veh turretUnit _x;
            if !(isNull _unitText) then {
                _unitText = name _unitText;
            } else {
                _unitText = "Empty";
            };
            _text = _text + format["    %1: %2<br/>",_turretName,_unitText];
        };
    } forEach allTurrets [_veh,true];

    // Cargo
    private _occupiedSeats = [];
    // Find out which seats are occupied
    {
        _x params ["","_role","_idx"];
        if (_role isEqualTo "cargo") then {_occupiedSeats pushBack _idx};
    } forEach fullCrew _veh;
    // Get the order of cargo slots
    private _getInProxyOrder = getArray(_cfg >> "getInProxyOrder");
    // Get total number of cargo slots
    private _transportSoldier = getNumber(_cfg >> "transportSoldier");

    private _cargoProxyIdxs = [];
    if (count _getInProxyOrder == 0) then {
        for "_i" from 1 to _transportSoldier do { _getInProxyOrder pushBack _i};
        private _turretCount = count _proxyIdxs;
        for "_i" from (1+_turretCount) to (_transportSoldier+_turretCount) do {_cargoProxyIdxs pushBack _i};
    } else {
        {
            if !(_x in _proxyIdxs) then {_cargoProxyIdxs pushBack (_forEachIndex + 1)};
        } forEach _getInProxyOrder;
    };

    // Resize _cargoProxyIdxs as appropriate
    _cargoProxyIdxs resize (_transportSoldier min (count _cargoProxyIdxs));
    {
        private  _idx = _x;
        private _locked = _veh lockedCargo (_x - 1);
        private _unitText = (crew _veh) select {(_veh getCargoIndex _x) isEqualTo _idx};
        if ((count _unitText) > 0) then {
            _unitText = name (_unitText select 0);
        } else {
            _unitText = "Empty";
        };
        _text = _text + format["    Passenger #%1: %2<br/>",_idx,_unitText]; // Possibly work out columns here?
    } forEach _cargoProxyIdxs;

    // Vehicle weapons
    _text = _text + "<br/><font size='18'>Vehicle weapons:</font><br/>";
    // Driver weapons
    if (((getNumber(_cfg >> "hasDriver")) > 0) && {!lockedDriver _veh}) then {
        private _weapons = _veh weaponsTurret [-1];
        {
            private _weapon = _x;
            private _weaponMagazines = getArray(configFile >> "cfgWeapons" >> _weapon >> "magazines");
            private _turretMagazines = _veh magazinesTurret [-1];
            _weaponMagazines = _weaponMagazines select {_x in _turretMagazines};
            private _array = [];
            {
                private _magazine = _x;
                private _magazineText = getText(configFile >> "cfgMagazines" >> _magazine >> "displayName");
                private _count = getNumber(configFile >> "cfgMagazines" >> _magazine >> "count");
                _count = ({_x isEqualTo _magazine} count _turretMagazines)*_count;
                _array pushBack [_magazineText,_count];
            } forEach _weaponMagazines;
            if ((count _array) > 0) then {
                _text = _text + format["%1 weapons:<br/>",["Driver","Pilot"] select _isAir];
                _text = _text + format["    %1:",getText(configFile >> "cfgWeapons" >> _weapon >> "displayName")];
                {
                    _x params ["_name","_count"];
                    _text = _text + format[" %1 [x%2] ",_name,_count];
                } forEach _array;
                _text = _text + "<br/>";
            } else {_text = _text + "    None<br/>"};
        } forEach _weapons;
    };
    // Turret weapons do I even wanna do this update i did it
    {
        private _turretPath = _x;
        private _cfgTurret = configFile >> "cfgVehicles" >> typeOf _veh;
        {_cfgTurret = (_cfgTurret >> "Turrets") select _x} forEach _turretPath;
        private _turretName = [getText(_cfgTurret >> "gunnerName")] call CBA_fnc_capitalize;
        private _locked = _veh lockedTurret _x;
        if !(_locked) then {
            _text = _text + format["%1 weapons:<br/>",_turretName];
            private _weapons = _veh weaponsTurret _turretPath;
            {
                private _weapon = _x;
                private _weaponMagazines = getArray(configFile >> "cfgWeapons" >> _weapon >> "magazines");
                private _turretMagazines = _veh magazinesTurret _turretPath;
                _weaponMagazines = _weaponMagazines select {_x in _turretMagazines};
                private _array = [];
                {
                    private _magazine = _x;
                    private _magazineText = getText(configFile >> "cfgMagazines" >> _magazine >> "displayName");
                    private _count = getNumber(configFile >> "cfgMagazines" >> _magazine >> "count");
                    _count = ({_x isEqualTo _magazine} count _turretMagazines)*_count;
                    _array pushBack [_magazineText,_count];
                } forEach _weaponMagazines;
                if ((count _array) > 0) then {
                    _text = _text + format["    %1:",getText(configFile >> "cfgWeapons" >> _weapon >> "displayName")];
                    {
                        _x params ["_name","_count"];
                        _text = _text + format[" %1 [x%2] ",_name,_count];
                    } forEach _array;
                    _text = _text + "<br/>";
                };
            } forEach _weapons;
            if (count _weapons isEqualTo 0) then {_text = _text + "    None<br/>"};
        };
    } forEach allTurrets [_veh,false];

    // Vehicle Cargo >> Backpack, Weapon, Magazine, Item
    _text = _text + "<br/><font size='18'>Vehicle cargo:</font><br/>";
    private _backPackCargo = getBackpackCargo _veh;
    if ((count (_backPackCargo select 0)) > 0) then {
        _text = _text + "Backpacks:<br/>";
        _backPackCargo params ["_a","_b"];
        {
            _backPackText = [getText(configFile >> "cfgVehicles" >> _x >> "displayName"),"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_- "] call BIS_fnc_filterString;
            _text = _text + format["    %1 [%2]<br/>",_backPackText,(_b select _forEachIndex)];
        } forEach _a;
    };
    private _weaponCargo = getWeaponCargo _veh;
    if ((count (_weaponCargo select 0)) > 0) then {
        _text = _text + "Weapons:<br/>";
        _weaponCargo params ["_a","_b"];
        {
            _weaponText = [getText(configFile >> "cfgWeapons" >> _x >> "displayName"),"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_- "] call BIS_fnc_filterString;
            _text = _text + format["    %1 [%2]<br/>",_weaponText,(_b select _forEachIndex)];
        } forEach _a;
    };
    private _magazineCargo = getMagazineCargo _veh;
    if ((count (_magazineCargo select 0)) > 0) then {
        _text = _text + "Magazines:<br/>";
        _magazineCargo params ["_a","_b"];
        {
            _magazineText = [getText(configFile >> "cfgMagazines" >> _x >> "displayName"),"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_- "] call BIS_fnc_filterString;
            _text = _text + format["    %1 [%2]<br/>",_magazineText,(_b select _forEachIndex)];
        } forEach _a;
    };
    private _itemCargo = getItemCargo _veh;
    if ((count (_itemCargo select 0)) > 0) then {
        _text = _text + "Items:<br/>";
        _itemCargo params ["_a","_b"];
        {
            _itemText = [getText(configFile >> "cfgWeapons" >> _x >> "displayName"),"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_- "] call BIS_fnc_filterString;
            _text = _text + format["    %1 [%2]<br/>",_itemText,(_b select _forEachIndex)];
        } forEach _a;
    };

    _target createDiaryRecord ["loadout", ["["+_vehName+"]", "<font size='12'>NOTE: The information shown below is only accurate at mission start.</font><br/>" + _text]];
} forEach _vehicles;