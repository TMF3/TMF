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
    _cfg = if (isClass (missionConfigFile >> "CfgLoadouts" >> _faction >> _role)) then
    [
        {missionConfigFile},
        {configFile}
    ];
};

ASSERT_TRUE(isClass CFGROLE, format [ARR_3("Loadout not present: %1 %2", _faction, _role)]);

private _loadout = format ["loadout_%1_%2", _faction, _role];
private _loadoutArray = [];
{
    switch (toLower configName _x) do {
        // Equipment/appearance
        case "displayname":             {_loadoutArray set [0, _x call BIS_fnc_getCfgData]};
        case "uniform":                 {_loadoutArray set [1, _x call BIS_fnc_getCfgData]};
        case "vest":                    {_loadoutArray set [2, _x call BIS_fnc_getCfgData]};
        case "backpack":                {_loadoutArray set [3, _x call BIS_fnc_getCfgData]};
        case "headgear":                {_loadoutArray set [4, _x call BIS_fnc_getCfgData]};
        case "goggles":                 {_loadoutArray set [5, _x call BIS_fnc_getCfgData]};
        case "hmd":                     {_loadoutArray set [6, _x call BIS_fnc_getCfgData]};
        case "faces":                   {_loadoutArray set [7, _x call BIS_fnc_getCfgData]};
        case "insignias":               {_loadoutArray set [8, _x call BIS_fnc_getCfgData]};

        // Items/magazines
        case "backpackitems":           {_loadoutArray set [9, _x call BIS_fnc_getCfgData]};
        case "items":                   {_loadoutArray set [10, _x call BIS_fnc_getCfgData]};
        case "magazines":               {_loadoutArray set [11, _x call BIS_fnc_getCfgData]};
        case "linkeditems":             {_loadoutArray set [12, _x call BIS_fnc_getCfgData]};

        // Weapons
        case "primaryweapon":           {_loadoutArray set [13, _x call BIS_fnc_getCfgData]};
        case "scope":                   {_loadoutArray set [14, _x call BIS_fnc_getCfgData]};
        case "bipod":                   {_loadoutArray set [15, _x call BIS_fnc_getCfgData]};
        case "attachment":              {_loadoutArray set [16, _x call BIS_fnc_getCfgData]};
        case "silencer":                {_loadoutArray set [17, _x call BIS_fnc_getCfgData]};
        case "secondaryweapon":         {_loadoutArray set [18, _x call BIS_fnc_getCfgData]};
        case "secondaryattachments":    {_loadoutArray set [19, _x call BIS_fnc_getCfgData]};
        case "sidearmweapon":           {_loadoutArray set [20, _x call BIS_fnc_getCfgData]};
        case "sidearmattachments":      {_loadoutArray set [21, _x call BIS_fnc_getCfgData]};

        case "code":                    {_loadoutArray set [22, _x call BIS_fnc_getCfgData]};
    };
} forEach configProperties [CFGROLE];

TRACE_3("Loaded loadout from config",_cfg,_faction,_loadout);

_loadoutArray
