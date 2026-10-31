#include "\x\tmf\addons\briefing\script_component.hpp"
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
        [getText (_cfg >> "displayName"),"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_-(),. "] call BIS_fnc_filterString
    ];
    if ((_veh getVariable [QEGVAR(orbat,vehicleCallsign),-1]) isNotEqualTo -1) then {
        _vehName = _vehName + " (" + ([getText(_cfg >> "displayName"),"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_-(),. "] call BIS_fnc_filterString) + ")";
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
        if ((getNumber(_cfgTurret >> "isPersonTurret") > 0) && (getNumber(_cfg >> "hideProxyInCombat") isEqualTo 0)) then {
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
    if (_getInProxyOrder isEqualTo []) then {
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
    private _passengerLines = [];
    {
        private  _idx = _x;
        private _locked = _veh lockedCargo (_x - 1);
        private _unitText = (crew _veh) select {(_veh getCargoIndex _x) isEqualTo _idx};
        if (_unitText isNotEqualTo []) then {
            _unitText = name (_unitText select 0);
        } else {
            _unitText = "Empty";
        };
        _passengerLines pushBack format["    Passenger #%1: %2<br/>",_idx,_unitText]; // Possibly work out columns here?
    } forEach _cargoProxyIdxs;
    _text = _text + (_passengerLines joinString "");

    // Vehicle weapons
    _text = _text + "<br/><font size='18'>Vehicle weapons:</font><br/>";
    
    // Driver weapons
    if ((getNumber (_cfg >> "hasDriver")) > 0) then {
        private _weapons = _veh weaponsTurret [-1];
        if (_weapons isNotEqualTo []) then {
            _text = format ["%1%2:<br/>", _text, ["Driver","Pilot"] select _isAir];
            
            {
                private _weapon = _x;
                private _turretMagazines = _veh magazinesTurret [-1];
                private _compatibleMagazines = [_x] call CBA_fnc_compatibleMagazines;
                private _weaponMagazines = (_turretMagazines select {_x in _compatibleMagazines}) call BIS_fnc_consolidateArray;
                
                if ((count _weaponMagazines) > 0) then {
                    private _weaponName = getText (configFile >> "CfgWeapons" >> _weapon >> "displayName");
                    if (_weaponName isNotEqualTo "") then {
                        _text = format ["%1  <img image='\A3\ui_f\data\gui\rscCommon\rscTree\hiddenTexture_ca.paa' height='16'/>%2<br/>", _text, _weaponName];
                    };
                    
                    {
                        _x params ["_magazineClass", "_magazineCount"];
                        _text = format ["%1          %2 [%3 rounds]<br/>", _text, getText (configFile >> "CfgMagazines" >> _magazineClass >> "displayName"), getNumber (configFile >> "CfgMagazines" >> _magazineClass >> "count") * _magazineCount];
                    } forEach _weaponMagazines;
                };
            } forEach _weapons;
        };
    };
    
    // Turret weapons
    {
        private _turretPath = _x;

        if !(_veh lockedTurret _turretPath) then { // RHS uses locked turrets for turning in/out (?)
            private _turretWeapons = _veh weaponsTurret _turretPath;

            if (_turretWeapons isNotEqualTo []) then {
                private _turretMagazines = _veh magazinesTurret _turretPath;

                private _turretCfg = _cfg;
                { _turretCfg = (_turretCfg >> "Turrets") select _x; } forEach _turretPath;
                private _turretName = [getText (_turretCfg >> "gunnerName")] call CBA_fnc_capitalize;
                _text = format ["%1%2:<br/>", _text, _turretName];

                {
                    _text = format ["%1  <img image='\A3\ui_f\data\gui\rscCommon\rscTree\hiddenTexture_ca.paa' height='16'/>%2<br/>", _text, getText (configFile >> "CfgWeapons" >> _x >> "displayName")];

                    private _compatibleMagazines = [_x] call CBA_fnc_compatibleMagazines;
                    private _weaponMagazines = (_turretMagazines select {_x in _compatibleMagazines}) call BIS_fnc_consolidateArray;
                    
                    if (count _weaponMagazines > 0) then {
                        {
                            _x params ["_magazineClass", "_magazineCount"];
                            _text = format ["%1          %2 [%3 rounds]<br/>", _text, getText (configFile >> "CfgMagazines" >> _magazineClass >> "displayName"), getNumber (configFile >> "CfgMagazines" >> _magazineClass >> "count") * _magazineCount];
                        } forEach _weaponMagazines;
                    } else {
                        _text = format ["%1          no magazines<br/>", _text];
                    };
                } forEach _turretWeapons;
            };
        };
    } forEach allTurrets _veh;

    // Vehicle Cargo >> Backpack, Weapon, Magazine, Item
    private _cargoLines = ["<br/><font size='18'>Vehicle cargo:</font><br/>"];
    {
        _x params ["_title", "_cargo", "_cfgClass"];
        _cargo params ["_classes", "_counts"];
        if (_classes isNotEqualTo []) then {
            _cargoLines pushBack (_title + ":<br/>");
            {
                private _name = [getText (configFile >> _cfgClass >> _x >> "displayName"),"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_-(),. "] call BIS_fnc_filterString;
                _cargoLines pushBack format ["    %1 [%2]<br/>", _name, _counts select _forEachIndex];
            } forEach _classes;
        };
    } forEach [
        ["Backpacks", getBackpackCargo _veh, "CfgVehicles"],
        ["Weapons", getWeaponCargo _veh, "CfgWeapons"],
        ["Magazines", getMagazineCargo _veh, "CfgMagazines"],
        ["Items", getItemCargo _veh, "CfgWeapons"]
    ];
    _text = _text + (_cargoLines joinString "");

    _target createDiaryRecord ["loadout", ["["+_vehName+"]", "<font size='12'>NOTE: The information shown below is only accurate at mission start.</font><br/>" + _text]];
} forEach _vehicles;
