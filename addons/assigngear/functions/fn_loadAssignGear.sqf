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
        CASE("displayname",IDX_DISPLAY_NAME);
        CASE("uniform",IDX_UNIFORM);
        CASE("vest",IDX_VEST);
        CASE("backpack",IDX_BACKPACK);
        CASE("headgear",IDX_HEADGEAR);
        CASE("goggles",IDX_GOGGLES);
        CASE("hmd",IDX_HMD);
        CASE("faces",IDX_FACES);
        CASE("insignias",IDX_INSIGNIAS);

        // Items/magazines
        CASE("backpackitems",IDX_BACKPACK_ITEMS);
        CASE("items",IDX_ITEMS);
        CASE("magazines",IDX_MAGAZINES);
        CASE("linkeditems",IDX_LINKED_ITEMS);

        // Weapons
        CASE("primaryweapon",IDX_PRIMARY_WEAPON);
        CASE("scope",IDX_SCOPE);
        CASE("bipod",IDX_BIPOD);
        CASE("attachment",IDX_ATTACHMENT);
        CASE("silencer",IDX_SILENCER);
        CASE("secondaryweapon",IDX_SECONDARY_WEAPON);
        CASE("secondaryattachments",IDX_SECONDARY_ATTACHMENTS);
        CASE("sidearmweapon",IDX_SIDEARM_WEAPON);
        CASE("sidearmattachments",IDX_SIDEARM_ATTACHMENTS);

        CASE("traits",IDX_TRAITS);

        CASE("primarymagazine", IDX_PRIMARY_MAGAZINE);
        CASE("primarygrenade", IDX_PRIMARY_GRENADE);
        CASE("secondarymagazine", IDX_SECONDARY_MAGAZINE);
        CASE("sidearmmagazine", IDX_SIDEARM_MAGAZINE);

        CASE("code",IDX_CODE);
    };
} forEach configProperties [CFGROLE];

TRACE_3("Loaded loadout from config",_cfg,_faction,_loadout);

_loadoutArray
