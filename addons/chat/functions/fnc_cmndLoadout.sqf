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

#include "\x\tmf\addons\chat\script_component.hpp"

IS_CMND_AVAILABLE(GVAR(loadoutUsage),"#loadout");

params ["_input"];

LOG_1("Executed command #loadout with input: %1", str _input);

private _inputArr = _input splitString " ";

switch (count _inputArr) do {
    case 0: EFUNC(assigngear,gearSelector);
    case 1: {
        _inputArr params ["_in1"];

        private _faction = CURUNIT getVariable [QEGVAR(assigngear,faction), ""];
        private _cfg = if (isClass (missionConfigFile >> "CfgLoadouts" >> _faction >> _in1)) then [{missionConfigFile}, {configFile}];
        if (isClass (_cfg >> "CfgLoadouts" >> _faction >> _in1)) then {
            // Input corresponds with a loadout
            [CURUNIT, _faction, _in1] call EFUNC(assigngear,assignGear);
            systemChat format ["TMF: Assigned loadout %1", str getText (_cfg >> "CfgLoadouts" >> _faction >> _in1 >> "displayName")];
        } else {
            private _match = [_in1] call FUNC(findMatch);
            if (isNull _match) then {
                // No loadout or player found, or more than one player
                if (_faction isEqualTo "") then {
                    systemChat "TMF Error: Cannot select loadout as you do not have an assigned faction. Use #loadout <faction> <role>";
                    systemChat FORMAT_1("TMF Error: Could not find player containing %1, or more than one player found.", str _in1);
                } else {
                    systemChat FORMAT_2("TMF Error: No loadout with name %1 in %2", str _in1, _faction);
                    systemChat FORMAT_1("TMF Error: Could not find player containing %1, or more than one player found.", str _in1);
                };
            } else {
                // Copy other players loadout
                CURUNIT setUnitLoadout getUnitLoadout _match;
                systemChat FORMAT_1("TMF: Copied loadout from %1", name _match);
            };
        };
    };
    case 2: {
        _inputArr params ["_in1", "_in2"];

        private _cfg = if (isClass (missionConfigFile >> "CfgLoadouts" >> _in1 >> _in1)) then [{missionConfigFile}, {configFile}];
        if (isClass (_cfg >> "CfgLoadouts" >> _in1 >> _in2)) then {
            // Input corresponds with a loadout
            [CURUNIT, _in1, _in2] call EFUNC(assigngear,assignGear);
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
