#include "\x\tmf\addons\assignGear\script_component.hpp"
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
        CASE("displayname",             IDX_DISPLAY_NAME);
        CASE("uniform",                 IDX_UNIFORM);
        CASE("vest",                    IDX_VEST);
        CASE("backpack",                IDX_BACKPACK);
        CASE("headgear",                IDX_HEADGEAR);
        case "goggles": {  
            private _goggles = _x call BIS_fnc_getCfgData;
            if (_goggles isEqualTo []) then {
                _goggles pushBack ""; // an empty array would mean goggles being skipped in main assignGear function
            };
            _loadoutArray set [IDX_GOGGLES, _goggles];
        };
        CASE("hmd",                     IDX_HMD);
        CASE("faces",                   IDX_FACES);
        CASE("insignias",               IDX_INSIGNIAS);
        CASE("backpackitems",           IDX_BACKPACK_ITEMS);
        CASE("items",                   IDX_ITEMS);
        CASE("magazines",               IDX_MAGAZINES);
        CASE("linkeditems",             IDX_LINKED_ITEMS);
        CASE("primaryweapon",           IDX_PRIMARY_WEAPON);
        CASE("primarymagazine",         IDX_PRIMARY_MAGAZINE);
        CASE("scope",                   IDX_PRIMARY_SCOPE);
        CASE("bipod",                   IDX_PRIMARY_BIPOD);
        CASE("attachment",              IDX_PRIMARY_ATTACHMENT);
        CASE("silencer",                IDX_PRIMARY_SILENCER);
        CASE("secondaryweapon",         IDX_SECONDARY_WEAPON);
        CASE("secondarymagazine",       IDX_SECONDARY_MAGAZINE);
        CASE("secondaryattachments",    IDX_SECONDARY_ATTACHMENT);
        CASE("sidearmweapon",           IDX_SIDEARM_WEAPON);
        CASE("sidearmmagazine",         IDX_SIDEARM_MAGAZINE);
        CASE("sidearmattachments",      IDX_SIDEARM_ATTACHMENT);
        CASE("traits",                  IDX_TRAITS);
        CASE("code",                    IDX_CODE);
    };
} forEach configProperties [CFGROLE];

TRACE_3("Loaded loadout from config",_cfg,_faction,_loadout);

_loadoutArray
