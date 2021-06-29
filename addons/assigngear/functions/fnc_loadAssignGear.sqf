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
        // Equipment/appearance
        CASE("displayname",0);
        CASE("uniform",1);
        CASE("vest",2);
        CASE("backpack",3);
        CASE("headgear",4);
        case "goggles": {
            private _goggles = _x call BIS_fnc_getCfgData;
            if (_goggles isEqualTo []) then {
                _goggles pushBack ""; // an empty array would mean goggles being skipped in main assignGear function
            };
            _loadoutArray set [5, _goggles];
        };
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
        CASE("primarymagazine",14);
        CASE("scope",15);
        CASE("bipod",16);
        CASE("attachment",17);
        CASE("silencer",18);
        CASE("secondaryweapon",19);
        CASE("secondarymagazine",20);
        CASE("secondaryattachments",21);
        CASE("sidearmweapon",22);
        CASE("sidearmmagazine",23);
        CASE("sidearmattachments",24);

        CASE("traits",25);
        CASE("code",26);
    };
} forEach configProperties [CFGROLE];

TRACE_3("Loaded loadout from config",_cfg,_faction,_loadout);

_loadoutArray
