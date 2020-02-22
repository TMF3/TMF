/*
 * Name = TMF_assignGear_fnc_chat_loadout
 * Author = Freddo
 *
 * Command syntaxes:
 * #loadout                  - Opens RscGearSelector
 * #loadout <role>           - Assigns role from current faction
 * #loadout <player>         - Copies loadout from other player
 * #loadout <faction> <role> - Assigns role from defined faction
 *
 * Description:
 * Opens up the RscGearSelector interface,
 * assigns a loadout,
 * or copies another players loadout
 *
 * Return:
 * None
 */

#include "\x\tmf\addons\assignGear\script_component.hpp"

params ["_input"];

private _inputArr = _input splitString " ";

private _fnc_findMatch = {
    params ["_name"];

    private _matches = [];

    {
        if ([_name, name _x] call BIS_fnc_inString) then {
            _matches pushBack _x;
        };
    } forEach ([] call CBA_fnc_players);

    if (count _matches == 1) exitWith {_matches select 0};
    objNull
};

switch (count _inputArr) do {
    case 0: FUNC(gearSelector);
    case 1: {
        _inputArr params ["_in1"];

        private _faction = player getVariable [QGVAR(faction), ""];
        private _cfg = if (isClass (missionConfigFile >> "CfgLoadouts" >> _faction >> _in1)) then [{missionConfigFile}, {configFile}];
        if (isClass (_cfg >> "CfgLoadouts" >> _faction >> _in1)) then {
            // Input corresponds with a loadout
            [player, _faction, _in1] call FUNC(assignGear);
            systemChat format ["TMF: Assigned loadout %1", str getText (_cfg >> "CfgLoadouts" >> _faction >> _in1 >> "displayName")];
        } else {
            private _match = [_in1] call _fnc_findMatch;
            if (isNull _match) then {
                // No loadout or player found, or more than one player
                if (_faction isEqualTo "") then {
                    systemChat FORMAT_1("TMF Error: Cannot select loadout as you do not have an assigned faction. Use #loadout <faction> <role>");
                    systemChat FORMAT_1("TMF Error: Could not find player containing %1, or more than one player found.", str _in1);
                } else {
                    systemChat FORMAT_1("TMF Error: No loadout with name %1 in %2", str _in1, _faction);
                    systemChat FORMAT_1("TMF Error: Could not find player containing %1, or more than one player found.", str _in1);
                };
            } else {
                // Copy other players loadout
                player setUnitLoadout getUnitLoadout _match;
                systemChat FORMAT_1("TMF: Copied loadout from %1", name _match);
            };
        };
    };
    case 2: {
        _inputArr params ["_in1", "_in2"];

        private _cfg = if (isClass (missionConfigFile >> "CfgLoadouts" >> _in1 >> _in1)) then [{missionConfigFile}, {configFile}];
        if (isClass (_cfg >> "CfgLoadouts" >> _in1 >> _in2)) then {
            // Input corresponds with a loadout
            [player, _in1, _in2] call FUNC(assignGear);
            systemChat FORMAT_2("TMF: Assigned loadout %1 from %2", \
                str getText (_cfg >> "CfgLoadouts" >> _in1 >> _in2 >> "displayName"), \
                str getText (_cfg >> "CfgLoadouts" >> _in1 >> "displayName")
            );
        } else {
            if !(isClass (_cfg >> "CfgLoadouts" >> _in1)) then {
                systemChat FORMAT_1("TMF Error: No faction with name %1", str _in1);
            } else {
                systemChat FORMAT_2("TMF Error: No loadout with name %1 in %2", str _in2, str _in1);
            };
        };
    };
};
