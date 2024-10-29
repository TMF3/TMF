#include "\x\tmf\addons\chat\script_component.hpp"
/*
* name = TMF_assignGear_fnc_chat_loadout
* Author = Freddo
*
* Command syntaxes:
* #loadout - Opens RscGearselector
* #loadout <role> - Assigns role from current faction
* #loadout <player> - Copies loadout from other player
* #loadout <faction> <role> - Assigns role from defined faction
*
* Description:
* Opens up the RscGearselector interface,
* assigns a loadout,
* or copies another players loadout
*
* Return:
* None
*/

IS_CMND_AVAILABLE(GVAR(loadoutUsage), "#loadout");

params ["_input"];

LOG_1("executed command #loadout with input: %1", str _input);

private _inputArr = _input splitstring " ";
private _gearselector = EFUNC(assigngear,gearselector);
switch (count _inputArr) do {
    case 0: _gearselector;
    case 1: {
        _inputArr params ["_in1"];
        
        private _faction = CURUNIT getVariable [QEGVAR(assigngear, faction), ""];
        private _cfg = if (isClass (missionConfigFile >> "Cfgloadouts" >> _faction >> _in1)) then [{
            missionConfigFile
        }, {
            configFile
        }];
        if (isClass (_cfg >> "Cfgloadouts" >> _faction >> _in1)) then {
            // input corresponds with a loadout
            [CURUNIT, _faction, _in1] call EFUNC(assigngear,assignGear);
            systemChat format ["TMF: Assigned loadout %1", str gettext (_cfg >> "Cfgloadouts" >> _faction >> _in1 >> "displayname")];
        } else {
            private _match = [_in1] call FUNC(findMatch);
            if (isNull _match) then {
                // No loadout or player found, or more than one player
                if (_faction isEqualto "") then {
                    systemChat "TMF Error: Cannot select loadout as you do not have an assigned faction. Use #loadout <faction> <role>";
                    systemChat FORMAT_1("TMF Error: Could not find player containing %1, or more than one player found.", str _in1);
                } else {
                    systemChat FORMAT_2("TMF Error: No loadout with name %1 in %2", str _in1, _faction);
                    systemChat FORMAT_1("TMF Error: Could not find player containing %1, or more than one player found.", str _in1);
                };
            } else {
                // Copy other players loadout
                CURUNIT setUnitLoadout getUnitloadout _match;
                systemChat FORMAT_1("TMF: Copied loadout from %1", name _match);
            };
        };
    };
    case 2: {
        _inputArr params ["_in1", "_in2"];
        
        private _cfg = if (isClass (missionConfigFile >> "Cfgloadouts" >> _in1 >> _in1)) then [{
            missionConfigFile
        }, {
            configFile
        }];
        if (isClass (_cfg >> "Cfgloadouts" >> _in1 >> _in2)) then {
            // input corresponds with a loadout
            [CURUNIT, _in1, _in2] call EFUNC(assigngear,assignGear);
            systemChat FORMAT_2("TMF: Assigned loadout %1 from %2", str gettext (_cfg >> "Cfgloadouts" >> _in1 >> _in2 >> "displayname"), str gettext (_cfg >> "Cfgloadouts" >> _in1 >> "displayname"));
        } else {
            if !(isClass (_cfg >> "Cfgloadouts" >> _in1)) then {
                systemChat FORMAT_1("TMF Error: No faction with name %1", str _in1);
            } else {
                systemChat FORMAT_2("TMF Error: No loadout with name %1 in %2", str _in2, str _in1);
            };
        };
    };
};