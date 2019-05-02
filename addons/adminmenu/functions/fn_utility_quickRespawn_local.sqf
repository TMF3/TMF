#include "\x\tmf\addons\adminmenu\script_component.hpp"

private _oldUnit = player;
private _oldUnitdata = _oldUnit getVariable [QEGVAR(spectator,unitData), false];

if (_oldUnitdata isEqualType []) then {
    _oldUnitdata params ["_group", "_faction", "_role", "_side", "_pos", "_objectParent"];

    private _unitType = switch (_side) do {
        case blufor: {"B_Soldier_F"};
        case opfor: {"O_Soldier_F"};
        case independent: {"I_soldier_F"};
        default {"C_man_1"};
    };
    private _newUnit = _group createUnit [_unitType, _pos, [], 0, "NONE"];
    _newUnit setVariable [QGVARMAIN(isRespawnUnit), true];

    if (!isNull _objectParent && {alive _objectParent}) then {
        _newUnit moveInAny _objectParent;
    };

    if !(_faction isEqualTo "" || _role isEqualTo "") then {
        [_newUnit, _faction, _role] call EFUNC(assigngear,assigngear);
    };

    setPlayable _newUnit;
    selectPlayer _newUnit;
    deleteVehicle _oldUnit;

    // Re-enable other text/marker channels
    private _radioChannelIndexSpectator = missionNamespace getVariable [QEGVAR(spectator,radioChannel), -1];
    if (_radioChannelIndexSpectator != -1) then {
        _radioChannelIndexSpectator radioChannelRemove [player];
        {
            _x enableChannel true;
        } forEach [1,2,3,4,5];
    };


    [{ // Close spectator
        while {dialog} do {closeDialog 0;};
        [_this select 1] call CBA_fnc_removePerFrameHandler;
    }, 0, 0] call CBA_fnc_addPerFrameHandler;

    // ACRE setup
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

    // Run Briefing Scripts.
    [{
        // Run briefing script for our new unit.
        [player] call EFUNC(briefing,generateBriefing);
        [player] call EFUNC(orbat,createBriefingPage);
    }, [], 4] call CBA_fnc_waitAndExecute;

    // Reset Orbat.
    // Re-initalize our group markers
    [player, true] call EFUNC(orbat,setup);

    // Add all the respawned groups to the map markers as well.
    [] call FUNC(respawnGroupMarkerUpdate);
} else {
    systemChat "[TMF Admin Menu] Quick Respawn failed: old unit data unavailable";
};
