/*
 * Name = TMF_assignGear_fnc_loadAssignGear
 * Author = Freddo
 *
 * Arguments:
 * 0: String. CfgLoadouts faction
 * 1: String. CfgLoadouts role
 * 2: Configfile (optional). configfile to check, can be either missionConfigFile or configFile
 *
 * Return:
 * Array. Loadout array
 *
 * Description:
 * Loads assigngear from config
 */
#include "\x\tmf\addons\assignGear\script_component.hpp"

#define CFGROLE (_cfg >> "CfgLoadouts" >> _faction >> _role)
#define CFGPARSE (configFile >> "CfgLoadoutsParser")

params [
    "_faction",
    "_role",
    "_cfg"
];

if (isNil "_cfg") then {
    // Check if loadout is in configFile or missionConfigFile
    _cfg = if (isClass (missionConfigFile >> "CfgLoadouts" >> _faction >> _role)) then
    [
        {missionConfigFile},
        {configFile}
    ];
};

ASSERT_TRUE(isClass CFGROLE, format [ARR_3("Loadout not present: %1 %2", _faction, _role)]);

private _loadout = format ["loadout_%1_%2", _faction, _role];
private _loadoutArray = [];

// Create an array where each index is tied to a specific type of item
#define CASE(_type,_index) case _type: {_loadoutArray set [_index, _x call BIS_fnc_getCfgData]}
; // Travis doesn't like defines without ;
{
    switch (toLower configName _x) do {
        // Equipment/appearance
        CASE("displayname",0);
        CASE("uniform",1);
        CASE("vest",2);
        CASE("backpack",3);
        CASE("headgear",4);
        CASE("goggles",5);
        CASE("hmd",6);
        CASE("faces",7);
        CASE("insignias",8);

        // Items/magazines
        CASE("backpackitems",9);
        CASE("items",10);
        CASE("magazines",11);
        CASE("linkeditems",12);

        // Weapons
        CASE("primaryweapon",13);
        CASE("scope",14);
        CASE("bipod",15);
        CASE("attachment",16);
        CASE("silencer",17);
        CASE("secondaryweapon",18);
        CASE("secondaryattachments",19);
        CASE("sidearmweapon",20);
        CASE("sidearmattachments",21);

        CASE("code",22);
    };
} forEach configProperties [CFGROLE];

TRACE_3("Loaded loadout from config",_cfg,_faction,_loadout);

_loadoutArray
