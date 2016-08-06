params["_groupNum","_position","_faction","_typeOfUnit","_rank","_number","_leader","_halo","_side"];

#include "\x\tmf\addons\respawn\script_component.hpp"

//TODO - Make respawned units count towards all players dead ending <- prevent vanilla ending from happening in MP.


private _class = switch (_side) do {
    case 0: {"O_Soldier_F"};
    case 1: {"B_Soldier_F"};
    case 2: {"I_Soldier_A_F"};
    default {"C_man_1"};
};
private _rankName  = switch (_rank) do {
    case 0: {"PRIVATE"};
    case 1: {"CORPORAL"};
    case 2: {"SERGEANT"};
    case 3: {"LIEUTENANT"};
    case 4: {"CAPTAIN"};
    case 5: {"MAJOR"};
    case 6: {"COLONEL"};
    default {"PRIVATE"};
};

if (_halo) then {
	_position = _position vectorAdd [0,0,500];
	//["HALO"] call BIS_fnc_startLoadingScreen;
};

//Dummy group is required to
private _dummyGroup = createGroup (_side call EFUNC(common,numToSide));

tmf_localRespawnedUnit = objNull;
/// Create the unit
private _unitName = format["respawnedUnit%1",_number];

private _init = format["if (local this) then { [this, '%2', '%3'] call tmf_assignGear_fnc_assignGear; tmf_localRespawnedUnit = this; }; this setName '%4'; this setVariable ['tmf_isRespawnUnit',true];  %1 = this; ",_unitName, _faction, _typeOfUnit, profileName];
private _oldUnit = player;

_class createUnit [_position, _dummyGroup, _init, 0.5, _rankName];	

// Wait till the unit is created
waitUntil{!isNull tmf_localRespawnedUnit};

private _respawnedUnit = missionNamespace getVariable [_unitName,objNull];

// Close spectator/open dialogs.
while {dialog} do {closeDialog 0;};

private _radioChannelIndexSpectator = missionNamespace getVariable [QEGVAR(spectator,radioChannel), -1];
if (_radioChannelIndexSpectator != -1) then {
    _radioChannelIndexSpectator radioChannelRemove [player];
    {
        _x enableChannel true;
    } forEach [1,2,3,4,5];
};

//addSwitchableUnit localRespawnedUnit; This will create awkard mission ends.
setPlayable tmf_localRespawnedUnit; // Allow unit to referenced later with player functions (name/getPlayerUID) (Verify this works)
selectPlayer tmf_localRespawnedUnit;
//localRespawnedUnit setName _name;

deleteVehicle _oldUnit; // Delete the old spectator module
player setPos (_position);

if (_halo) then {
	[_position] spawn {
		params ["_position"];
		hint "HALO INSERTATION";
		player setPos _position;

		//["HALO"] call BIS_fnc_endLoadingScreen;
		private _jumper = player;
	  
		while {(getPos _jumper select 2) > 2} do {
			if (getPos _jumper select 2 < 150) exitWith {
				private _chute = createVehicle ["Steerable_Parachute_F", position _jumper, [], direction _jumper, 'FLY'];
                _chute setPos (getPos _jumper);
                _jumper assignAsDriver _chute;
                _jumper moveInDriver _chute;
			};
		};
	};
};

// Put in PFH to avoid blocking
if (isClass(configFile >> "CfgPatches" >> "acre_main")) then  {
    [false] call acre_api_fnc_setSpectator;
	[{
		if (isNull player) exitWith {};
		if (isNil "tmf_acre2_networksCreated") exitWith {}; //Ensure presets are created
		
		[] call EFUNC(acre2,clientInit);
		[_this select 1] call CBA_fnc_removePerFrameHandler;
	}, 0.1] call CBA_fnc_addPerFrameHandler;
};

 _groupVarName = format ["GrpRespawn_%1",_groupNum];
if (_leader) then {
    //Broadcast group var to everyone so people can join.
    missionNamespace setVariable[_groupVarName,_dummyGroup];
    publicVariable _groupVarName;
    [{
        // Run briefing script for our new unit.
        [player] call EFUNC(briefing,generateBriefing);
        [player] call EFUNC(orbat,createBriefingPage);
    }, [], 4] call CBA_fnc_waitAndExecute
} else {
    //Wait for group be created by the group leader before joining it.
    [_groupVarName, _dummyGroup] spawn {
        params["_groupVarName", "_dummyGroup"];
        // Wait for group exist.
        sleep 1; // Ensure that everything is in Sync.
        waitUntil{!isNil _groupVarName};
        [player] joinSilent (missionNamespace getVariable[_groupVarName,grpNull]);
		deleteGroup _dummyGroup;
        [{
            // Run briefing script for our new unit.
            [player] call EFUNC(briefing,generateBriefing);
            [player] call EFUNC(orbat,createBriefingPage);
        }, [], 3] call CBA_fnc_waitAndExecute
   };
};

// Re-initalize our group markers
[player, true] call EFUNC(orbat,setup);

// Add all the respawned groups to the map markers as well.
[] call FUNC(respawnGroupMarkerUpdate);


