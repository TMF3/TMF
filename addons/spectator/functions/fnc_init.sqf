

#include "\x\tmf\addons\spectator\script_component.hpp"

if((_this select 2) isEqualType 0) then {_this set [2, false]};
params ["_unit", "_oldUnit", ["_forced", false, [false]]];

if(typeOf _unit == "seagull") then {
    _unit setPos [0,0,5];
     [{
        params ["_seagull"];
        if (player != _seagull) then {
            deleteVehicle _seagull;
        };
    }, [_unit], 5] call CBA_fnc_waitAndExecute;
};

// On Re-Open purge any old controls (as they will exist on an old display)
if (!isNil QGVAR(controls)) then {
    {_x setVariable [QGVAR(tagControl),nil];} forEach allUnits;
    {_x setVariable [QGVAR(tagControl),nil];} forEach allGroups;
    {ctrlDelete _x} forEach GVAR(controls);
    GVAR(controls) = [];
};

if(!isNil QGVAR(unit) && {player == GVAR(unit)}) exitWith {
    createDialog QGVAR(dialog);

};

// Wait until mission is loaded properly. Prevents JIP issues.
waitUntil {!isNull ([] call BIS_fnc_DisplayMission)};

private _isJip = didJIP;

// disable this to instantly switch to the spectator script.
waitUntil {missionNamespace getVariable ["BIS_fnc_feedback_allowDeathScreen",false] || isNull (_oldUnit) || _isJip || _forced};


// Disable effects
// disable effects death effects
if(!isnil "BIS_fnc_feedback_allowPP") then { BIS_fnc_feedback_allowPP = false; };

if(_isJip) then {
    [] spawn {
        ["tmf_spectator",false] call BIS_fnc_blackOut;
        uiSleep 3;
        ["tmf_spectator"] call BIS_fnc_blackIn;
    };
};

if(isNil QGVAR(unit)) then {GVAR(unit) = objNull};


// Create a Virtual Agent to act as our player to make sure we get to keep Draw3D
if(isNull GVAR(unit) || !(typeOf GVAR(unit) isEqualTo QGVAR(unit))) then {

    if (isNull GVAR(group)) then { /* Incase spectator group is null */
        createCenter sideLogic;
        GVAR(group) = createGroup sideLogic;

        if (isNull GVAR(group)) then {
            createCenter civilian;
            GVAR(group) = createGroup civilian;
        };

        publicVariable QGVAR(group);
    };

    private _newUnit = (GVAR(group)) createUnit [QGVAR(unit), [0,0,5], [], 0, "FORM"];
    if (isNull _newUnit) then {
        // Unable to create new unit - Usually if too many groups for sideLogic exist.

        GVAR(unit) = _oldUnit;
    }
    else {
        _newUnit allowDamage false;
        _newUnit hideObjectGlobal true;
        _newUnit enableSimulationGlobal false;
        _newUnit setPos [0,0,5];

        // save some infomation regarding the units death and role etc.
        _newUnit setVariable [QGVAR(name),profileName,true];

        _newUnit setVariable [QGVAR(unitData),
            [
                group _oldUnit,
                _oldUnit getVariable [QEGVAR(assignGear,faction),""],
                _oldUnit getVariable [QEGVAR(assignGear,role),""],
                side (group _oldUnit),
                getPos _oldUnit,
                objectParent _oldUnit
            ],
            true
        ];

        selectPlayer _newUnit;
        GVAR(unit) = _newUnit;
    };
}
else {
    selectPlayer GVAR(unit);
};



// If oldunit is null set a new starting target
if(isNull _oldUnit ) then {_oldUnit = allUnits select 0};

GVAR(entrySide) = _oldUnit getVariable ["TMF_CreatedSide",side _oldUnit];

if(!isNil QGVAR(freeCam) && {!isNull GVAR(freeCam)}) exitWith {createDialog "tmf_spectator_dialog";};



GVAR(freeCam) = "camera" camCreate [position _oldUnit select 0,position _oldUnit select 1,3];
GVAR(followCam) = "camera" camCreate [position _oldUnit select 0,position _oldUnit select 1,3];
GVAR(camera) = GVAR(followCam);
GVAR(target) = _oldUnit;
#include "defines.hpp"

if(isNil QGVAR(objectives)) then { GVAR(objectives) = []; };

// UI
GVAR(showUI) = true;
GVAR(interfaceControls) = [IDC_SPECTATOR_TMF_SPECTATOR_KILLIST,IDC_SPECTATOR_TMF_SPECTATOR_UNITLABEL,IDC_SPECTATOR_TMF_SPECTATOR_UNITLIST,IDC_SPECTATOR_TMF_SPECTATOR_VISION,IDC_SPECTATOR_TMF_SPECTATOR_FILTER,IDC_SPECTATOR_TMF_SPECTATOR_BUTTON,IDC_SPECTATOR_TMF_SPECTATOR_TAGS,IDC_SPECTATOR_TMF_SPECTATOR_VIEW,IDC_SPECTATOR_TMF_SPECTATOR_COMPASS,IDC_SPECTATOR_TMF_SPECTATOR_COMPASSLEFT,IDC_SPECTATOR_TMF_SPECTATOR_COMPASSRight,IDC_SPECTATOR_TMF_SPECTATOR_MUTE,IDC_SPECTATOR_TMF_SPECTATOR_MENUBACK];

GVAR(tracers) = true;
GVAR(bulletTrails) = false;
// MAP
GVAR(showMap) = false;


GVAR(controls) = [];



GVAR(grpTagScale) = profileNamespace getVariable [QGVAR(grpTagScale),1.0];
GVAR(unitTagScale) = profileNamespace getVariable [QGVAR(unitTagScale),1.0];


showCinemaBorder false;
GVAR(camera) cameraEffect ["internal","back"];

// Set the location of the track point
private _pos = getPosVisual GVAR(target);
_pos set [2,(_pos select 2)+1.3];


GVAR(followCam) camSetTarget _pos;
GVAR(followCam) camSetRelPos [2,2,3];
GVAR(relpos) = [2,2,3];


// Set FOV
GVAR(followCam) camSetFov 1.2;
GVAR(freeCam) camSetFov 1.2;

// commit it
GVAR(freeCam) camCommit 0;
GVAR(camera) camCommit 0;
// 0 follow cam, 1 freecam, 2 firstperson
GVAR(mode) = FOLLOWCAM;
private _allowedModes = [getMissionConfigValue ["TMF_Spectator_AllowFollowCam",true],getMissionConfigValue ["TMF_Spectator_AllowFreeCam",true],getMissionConfigValue ["TMF_Spectator_AllowFPCam",true]];
{
    if(_x) exitWith {
        GVAR(mode) = _forEachIndex;
    };
} forEach _allowedModes;


// Sides Button
GVAR(sides) = [blufor,civilian,opfor,independent];
GVAR(sides_button_state) = 0;
GVAR(sides_button_mode) = [ [blufor,civilian,opfor,independent],[blufor],[opfor],[independent],[civilian]];
GVAR(sides_button_strings) = ["SHOWING ALL SIDES","SHOWING BLUFOR","SHOWING OPFOR","SHOWING INDEPENDENT","SHOWING CIVILIAN"];


if (!getMissionConfigValue ["TMF_Spectator_AllSides",true]) then {
  GVAR(sides) = [tmf_spectator_entryside];
  GVAR(sides_button_mode) = [[tmf_spectator_entryside],[]];
  GVAR(sides_button_strings) = ["SHOWING YOUR SIDE","NONE"];
};

// Vision Button
GVAR(visionMode) = 0;
GVAR(visionMode_strings) = ["NORMAL","NIGHTVISION","WHITE HOT"];

// Show Players only
GVAR(playersOnly) = false;
if (isMultiplayer) then {
    GVAR(playersOnly) = true;
};

// Mouse
GVAR(mButtons) = [false,false];
GVAR(mPos) = [0,0];
GVAR(lmPos) = [0,0];

// Follow Cam
GVAR(followcam_angle) = [0,0];
GVAR(followcam_zoom) = 0.3;
GVAR(followcam_fov) = 0.7;

// Freecam
GVAR(freecam_zoom) = 0;


GVAR(freecam_move) = [0,0,0];
GVAR(freecam_timestamp) = time;
GVAR(rounds) = [];


// WASD Q/E scroll
GVAR(movement_keys) = [false,false,false,false,false,false,0];

// Ctrl , alt , shift
GVAR(modifiers_keys) = [false,false,false];

// Tags
GVAR(tags) = true;
GVAR(showlines) = false;

GVAR(groups) = [];
GVAR(vehicles) = [];
GVAR(clearGroups) = false;
GVAR(unitUpdate) = 0;
GVAR(killedUnits) = [];
GVAR(killList_forceUpdate) = false;
GVAR(killList_update) = time;
// Set Modes
cameraEffectEnableHUD true;
showCinemaBorder false;
GVAR(mute_key) = -1;
GVAR(mute_modifers) = [false,false,false];

createDialog QGVAR(dialog);

//Add to the text channel.
GVAR(radioChannel) radioChannelAdd [player];
setCurrentChannel (GVAR(radioChannel)+5);
{
    _x enableChannel false;
} forEach [1,2,3,4,5];

if !([] call tmf_common_fnc_isAdmin) then {
    0 enableChannel false;
};

GVAR(missileIcon) = "\x\tmf\addons\spectator\images\missile.paa";
GVAR(grenadeIcon) = "\x\tmf\addons\spectator\images\grenade.paa";
GVAR(smokeIcon) = "\x\tmf\addons\spectator\images\smokegrenade.paa";


// Add EH

if (isNil QGVAR(setupEH)) then {
    addMissionEventHandler ["EntityKilled",{
        params ["_deadMan","_killer","_instigator"];

        if (isNull _instigator) then {_instigator = UAVControl vehicle _killer select 0}; // UAV/UGV player operated road kill
        if (isNull _instigator) then {_instigator = _killer}; // player driven vehicle road kill


        if(count (_deadMan getVariable [QGVAR(tagControl),[]]) > 0) then {
            ctrlDelete ((_deadMan getVariable [QGVAR(tagControl),[controlNull]]) select 0);
        };


        if(!(side _deadMan in [blufor,opfor,independent,civilian]) || !(_deadMan isKindOf "CAManBase" || _deadMan isKindOf "AllVehicles") ) exitwith {};
        if(isNull _instigator || _instigator == _deadMan) then {
            _instigator = _deadMan getVariable [QGVAR(lastDamage),objNull];
        };

        private _kName = "";
        private _dName = "";
        private _isplayer = isPlayer _deadMan;
        if(_isplayer) then {_dName = name (_deadMan);};
        if(isPlayer _instigator) then {_kName = name (_instigator);};
        if(_dName == "") then { _dName = getText (configFile >> "CfgVehicles" >> typeOf _deadMan >> "displayName"); };
        if(_kName == "") then { _kName = getText (configFile >> "CfgVehicles" >> typeOf _instigator >> "displayName"); };
        private _weapon = getText (configFile >> "CfgWeapons" >> currentWeapon _instigator >> "displayName");
        if (!isNull (objectParent _instigator)) then { _weapon = getText (configFile >> "CfgVehicles" >> typeOf (vehicle _instigator) >> "displayName");};
        GVAR(killList_forceUpdate) = true;
        GVAR(killedUnits) pushback [_deadMan,time,_instigator,side group _deadMan,side group _instigator,_dName,_kName,_weapon,_isplayer];
    }];

    ["AllVehicles", "fired", {if([] call FUNC(isOpen)) then { _this call FUNC(onFired)}}] call CBA_fnc_addClassEventHandler;
    ["AllVehicles", "hit", {if([] call FUNC(isOpen)) then {(_this select 0) setVariable [QGVAR(lastDamage),(_this select 1)]}}] call CBA_fnc_addClassEventHandler;

    GVAR(setupEH) = true;
};

GVAR(messages) = [];
GVAR(lastCompassValue) = ["A","B","C"];
GVAR(lastControlIndex) = 0;

["tmf_spectator", "onEachFrame", {
    [] call FUNC(perFrameHandler);
}] call BIS_fnc_addStackedEventHandler;

[QGVAR(init), _this] call CBA_fnc_localEvent;
if(isNil QGVAR(drawEvent)) then {
    GVAR(drawEvent) = addMissionEventHandler ["Draw3D",{ [] call FUNC(drawTags); }];
};
