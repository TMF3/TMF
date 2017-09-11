//Create Briefing Page ORBAT Parser

//Example....
/*OrbatSettings_Array = [
    [west,[
            [0,"1PLT","tw_snip\textures\yellow.paa","tw_snip\textures\modif_3dot.paa",0],
            [
                [[1,"A","tw_snip\textures\red_inf.paa","tw_snip\textures\modif_dot.paa",0],[]]
            ]
           ]],
    [east,[
            [2,"2PLT","tw_snip\textures\yellow.paa","tw_snip\textures\modif_3dot.paa",0],
            [
                [[3,"A","tw_snip\textures\red_inf.paa","tw_snip\textures\modif_dot.paa",0],[]]
            ]
           ]]
];*/
#include "\x\tmf\addons\orbat\script_component.hpp"

params [["_unit", player]];

private _ourIdx = -1;
private _groups = [];
{
    _x params ["_condition", "_array"];

    if (_condition isEqualType 0 and {(_condition call EFUNC(common,numToSide)) == (side _unit)}) exitWith {
        private _side = _condition call EFUNC(common,numToSide);
        _ourIdx = _forEachIndex;
        _groups = allGroups select {side _x == _side};
    };
    if ((side _unit) isEqualTo _condition) exitWith {
        private _side = _condition;
        _ourIdx = _forEachIndex;
        _groups = allGroups select {side _x == _side};
    };
    if ((faction (leader (group _unit)) isEqualTo _condition)) exitWith {
        private _faction = _condition;
        _ourIdx = _forEachIndex;
        _groups = allGroups select {faction (leader _x) == _faction};
    };
} forEach (GVAR(orbatRawData));

if (_ourIdx == -1) exitWith {}; 


//Associate groups to hierarchy (use toPlace)
private _ourData = (GVAR(orbatRawData) select _ourIdx) select 1; //list of children
private _toPlace = [];
private _reserveId = (_ourData select 0) select 0;


// Scan for valid indexes.
private _validParents = [];
fnc_findValidParents = {
    if (count _this == 0) exitWith {false};
    
    _this params ["_data", ["_children",[]]];
    _data params ["_uniqueID"];
    _validParents pushBackUnique _uniqueID;
  
    {
        _x call fnc_findValidParents;
    } forEach _children;
    
    _data pushBack _added;
};

_ourData call fnc_findValidParents;
_validParents = _validParents - [-1];

private _playableUnits = (playableUnits+switchableUnits);
{
    private _var = _x getVariable ["TMF_OrbatParent",-1];
    if ({_x in _playableUnits} count (units _x) > 0) then {
        if (_var in _validParents) then {
            _toPlace pushBack [_var, _x];
        } else {
            _toPlace pushBack [_reserveId, _x];
        };
    };

} forEach _groups;

//Identify which ones to add.

//Same as in orbat_tracker fn_setup.sqf
fnc_processOrbatTrackerBriefingRawData = {
    if (count _this == 0) exitWith {false};
    private _added = false;

    _this params ["_data", ["_children",[]]];
    _data params ["_uniqueID", "_markerName", "_texture1", "_texture2"];

    //find uniquID in to place
    {
        if (_x select 0 == _uniqueID) exitWith {
            _added = true;
        };
    } forEach _toPlace;


    {
        if (_x call fnc_processOrbatTrackerBriefingRawData) then { _added = true;};
    } forEach _children;

    _data pushBack _added;

    _added;
};

_ourData call fnc_processOrbatTrackerBriefingRawData;


// [NODE,[NODE,CHILD],[NODE],[NODE]]
fnc_processOrbatTrackerBriefingRawData = {
    private _briefingText = "";
    if (count _this == 0) exitWith {_briefingText};

    params ["_entry", "_indent"];
    _entry params ["_data", "_children"];
    _data params ["_uniqueID", ["_markerName",""], ["_texture1",""], ["_texture2", ""], ["_fullName",""], "", "_toAdd"];


    if (!_toAdd) exitWith {_briefingText};

    //Add current Entry:

    if (_texture1 != "") then {
        _briefingText = _briefingText + format["<br/>%3<font size='18'><img image='%1' height='18'></img> %2</font><br/>", _texture1, _fullName, _indent];
        _indent = _indent + "      ";
    };

    private _childrenBriefings = [];

    // Process Children (Virtual)
    {
        if (count _x > 0) then {
            private _data = (_x select 0);
            if (count _data > 5) then {
                private _sortId = _data select 5; // ID
                if (isNil "_sortId") then { _sortId = 0;};
                _childrenBriefings pushBack [_sortId, ([_x, _indent] call fnc_processOrbatTrackerBriefingRawData)];
            };
        };
    } forEach _children;

    // Process Children (Groups)
    {
        _x params ["_id", "_entity"];
        if (_id == _uniqueID) then {
            private _markerEntry = _entity getVariable ["TMF_groupMarker",[]];
            if (_markerEntry isEqualType "") then { _markerEntry = call compile _markerEntry; };
            private _groupTexture = "";
            private _sortId = 0;
            if (count _markerEntry > 0) then {
                _groupTexture = _markerEntry select 0;
                if (count _markerEntry > 2) then {
                    _sortId = _markerEntry select 3;
                    if (isNil "_sortId") then { _sortId = 0; };
                };
            };
            if (_groupTexture == "") then {
                if (_texture1 != "") then {
                    _groupTexture = _texture1;
                } else {
                    _groupTexture = "\x\tmf\addons\orbat\textures\empty.paa";
                };
            };

            private _thisBriefing = format["%3<img image='%1' height='18'></img><font size='18'> %2</font>", _groupTexture, groupID _entity, _indent];
            private _vehicles = (units _entity select {!(vehicle _x isEqualTo _x)}) apply {vehicle _x};
            _vehicles = _vehicles arrayIntersect _vehicles;
            {
                // check if vehicle has callsign. If not, use displayName
                private _vehString = [getText (configFile >> "CfgVehicles" >> (typeOf _x) >> "displayname"),"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_- "] call BIS_fnc_filterString;
                private _vehName = _x getVariable [
                    QGVAR(vehicleCallsign),
                    _vehString
                ];

                if !((_x getVariable [QEGVAR(orbat,vehicleCallsign),-1]) isEqualTo -1) then {
                    _vehName = _vehName + " (" + _vehString + ")";
                };

                private _vehIcon = getText(configfile >> "CfgVehicles" >> typeof _x >> "picture");
                private _maxSlots = getNumber(configfile >> "CfgVehicles" >> typeof _x >> "transportSoldier") + (count allTurrets [_x, true] - count allTurrets _x);
                private _freeSlots = _x emptyPositions "cargo";
                private _driverPresent = [0,1] select !(isNull (driver _x));
                _thisBriefing = _thisBriefing + format [" (<img image='%2' height='16'></img>%1 [%3+%4/%5])",_vehName,_vehIcon,(count allTurrets _x)+_driverPresent,(_maxSlots-_freeSlots),_maxSlots+(count allTurrets _x)];
            } forEach _vehicles;
            _thisBriefing = _thisBriefing + "<br/>";
            {
                //Retrieve specialist marker otherwise use default vanilla icon
                private _markerEntry = _x getVariable ["TMF_SpecialistMarker",[]];
                if (_markerEntry isEqualType "") then { _markerEntry = call compile _markerEntry; };
                private _unitImg = getText (configFile >> "CfgVehicleIcons" >> getText (configFile >> "CfgVehicles" >> (typeOf _x) >> "icon"));
                if (leader _entity == _x) then {
                    _unitImg = "\A3\ui_f\data\map\vehicleicons\iconManLeader_ca.paa";
                };

                if (count _markerEntry > 0) then {
                    if ((_markerEntry select 0) != "") then {
                        _unitImg = _markerEntry select 0;
                    };
                };

                private _unitText = format["      %3<img image='%1' height='16'></img> %2 (", _unitImg, name _x, _indent];

                if (primaryWeapon _x != "") then {
                    (primaryWeaponItems _x) params ["_muzzel", "", "_optic", "_bipod"];
                    private _weaponIcon = switch ((([primaryWeapon _x] call BIS_fnc_itemType) select 1)) do {
                        case "MachineGun": {"\x\tmf\addons\orbat\weapon_textures\autorifle"};
                        case "BombLauncher";
                        case "Cannon";
                        case "Launcher";
                        case "RocketLauncher": {
                            if ((getNumber (configFile >> "CfgWeapons" >> (primaryWeapon _x) >> "rhsdisposable") == 1) or
                                (getNumber (configFile >> "CfgWeapons" >> (primaryWeapon _x) >> "tf47_disposable") == 1) or
                                (isText (configFile >> "CfgWeapons" >> (primaryWeapon _x) >> "UK3CB_used_launcher")) or
                                (isText (configFile >> "CfgWeapons" >> (primaryWeapon _x) >> "ACE_UsedTube"))) then {"\x\tmf\addons\orbat\weapon_textures\lat"} else {"\x\tmf\addons\orbat\weapon_textures\mat"}
                            };
                        case "GrenadeLauncher": {"\x\tmf\addons\orbat\weapon_textures\gl"};
                        case "MissileLauncher": {"\x\tmf\addons\orbat\weapon_textures\hat"};
                        case "SniperRifle":{"\x\tmf\addons\orbat\weapon_textures\sniper"};
                        case "SubmachineGun":{"\x\tmf\addons\orbat\weapon_textures\smg"};
                        case "Shotgun":{"\x\tmf\addons\orbat\weapon_textures\shotgun"};
                        case "AssaultRifle"; //{"\x\tmf\addons\orbat\weapon_textures\carbine"}; carbine too hard to know
                        default {if (_bipod != "") then {"\x\tmf\addons\orbat\weapon_textures\dmr"} else { "\x\tmf\addons\orbat\weapon_textures\rifleman"}};
                        //"AssaultRifle"
                    };
                    // Handle grenadiers
                    if (count (getArray (configFile >> "CfgWeapons" >> (primaryWeapon _x) >> "muzzles") - ["SAFE"]) > 1) then {
                        _weaponIcon = "\x\tmf\addons\orbat\weapon_textures\rifleman_ugl";
                    };

                    private _postfix = "_st.paa";
                    if (_muzzel != "") then {
                        _postfix = "_su.paa";
                        if (_optic != "") then {
                            _postfix = "_al.paa";
                        };
                    } else {
                        if (_optic != "") then {
                            _postfix = "_sc.paa";
                        };
                    };
                    _weaponIcon = _weaponIcon + _postfix;
                    private _weaponText = getText(configFile >> "CfgWeapons" >> (primaryWeapon _x) >> "displayName") + format[" <img image='%1'></img>", _weaponIcon]; // height='14'
                    _unitText = _unitText + _weaponText;
                };
                if (secondaryWeapon _x != "") then {
                    (secondaryWeaponItems _x) params ["", "", "_optic", ""];
                    if (primaryWeapon _x != "") then {
                        _unitText = _unitText + ", ";
                    };
                    private _weaponIcon = switch ((([secondaryWeapon _x] call BIS_fnc_itemType) select 1)) do {
                        case "MachineGun": {"\x\tmf\addons\orbat\weapon_textures\autorifle"};
                        case "BombLauncher";
                        case "Cannon";
                        case "Launcher";
                        case "RocketLauncher": {
                            if ((getNumber (configFile >> "CfgWeapons" >> (secondaryWeapon _x) >> "rhs_disposable") == 1) or
                                (getNumber (configFile >> "CfgWeapons" >> (secondaryWeapon _x) >> "tf47_disposable") == 1) or
                                (isText (configFile >> "CfgWeapons" >> (secondaryWeapon _x) >> "UK3CB_used_launcher")) or
                                (isText (configFile >> "CfgWeapons" >> (secondaryWeapon _x) >> "ACE_UsedTube"))) then {"\x\tmf\addons\orbat\weapon_textures\lat"} else {"\x\tmf\addons\orbat\weapon_textures\mat"}
                            };
                        case "GrenadeLauncher": {"\x\tmf\addons\orbat\weapon_textures\gl"};
                        case "MissileLauncher": {"\x\tmf\addons\orbat\weapon_textures\hat"};
                        case "SniperRifle":{"\x\tmf\addons\orbat\weapon_textures\sniper"};
                        case "AssaultRifle"; //{"\x\tmf\addons\orbat\weapon_textures\carbine"}; Need a method to find if a weapon is a carbine
                        case "SubmachineGun":{"\x\tmf\addons\orbat\weapon_textures\smg"};
                        case "Shotgun":{"\x\tmf\addons\orbat\weapon_textures\shotgun"};
                        default {};
                    };
                    private _postfix = "_st.paa";

                    if (_optic != "") then {
                        _postfix = "_sc.paa";
                    };
                    _weaponIcon = _weaponIcon + _postfix;
                    private _weaponText = getText(configFile >> "CfgWeapons" >> (secondaryWeapon _x) >> "displayName") + format[" <img image='%1'></img>", _weaponIcon];
                    _unitText = _unitText + _weaponText;
                };
                // Handgun
                if (handgunWeapon _x != "") then {
                    if (secondaryWeapon _x != "" or primaryWeapon _x != "") then {
                        _unitText = _unitText + ", ";
                    };
                    (handgunItems _x) params ["_muzzel", "", "_optic", ""];
                    private _weaponIcon = "\x\tmf\addons\orbat\weapon_textures\pistol_st.paa";
                     if (_muzzel != "") then {
                        _weaponIcon = "\x\tmf\addons\orbat\weapon_textures\pistol_su.paa";
                        if (_optic != "") then {
                            _weaponIcon = "\x\tmf\addons\orbat\weapon_textures\pistol_al.paa";
                        };
                    } else {
                        if (_optic != "") then {
                            _weaponIcon = "\x\tmf\addons\orbat\weapon_textures\pistol_sc.paa";
                        };
                    };
                    private _weaponText = getText(configFile >> "CfgWeapons" >> (handgunWeapon _x) >> "displayName") + format[" <img image='%1'></img>", _weaponIcon];
                    _unitText = _unitText + _weaponText;
                };
                // TODO backpacks.. TOW/AGL/Mortars
               /* if (backpack _x != "") then {
                    private _backpack = backpack _x;
                    private _backpackParents = [(configFile >> "CfgVehicles" >> _backpack)] call BIS_fnc_returnParents; { _backpackParents set [_forEachIndex, configName _x]} forEach _backpackParents;
                    private _backpackIcon = "";
                    //"B_HMG_01_support_F","Bag_Base",
                    //Motar tube
                    if (_backpack in ["B_Mortar_01_weapon_F"]) then {
                        _backpackIcon = "";
                    };
                    //Mortar launcher
                    if (_backpack in ["O_Mortar_01_support_F"]) then {
                        _backpackIcon = "";
                    };
                   // if (_backpackParents)

                };*/
                //Backpack: "StaticGrenadeLauncher","StaticWeapon", "StaticMGWeapon"
                if (_x == _unit) then { //highlight player.
                    _unitText = "<font color='#f7da00'>" + _unitText + "</font>";
                };
                _unitText = _unitText + ")<br/>";

                _thisBriefing = _thisBriefing + _unitText;
            } forEach (units _entity);

            _childrenBriefings pushBack [_sortId, _thisBriefing];

            _toPlace set [_forEachIndex,-1];
        };
    } forEach _toPlace;
    _toPlace = _toPlace - [-1];

    _childrenBriefings sort true;

    {
        _briefingText = _briefingText + (_x select 1);
    } forEach _childrenBriefings;

    _briefingText;
};

private _briefingText = [_ourData, ""] call fnc_processOrbatTrackerBriefingRawData;
_briefingText = "Note: This is only valid at time of creation.<br/><font size='18'>ORBAT:</font><br/>" + _briefingText;
_unit createDiaryRecord ["diary", ["ORBAT", _briefingText]];
fnc_processOrbatTrackerBriefingRawData = nil;

