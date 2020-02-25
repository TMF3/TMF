/*
 * Name = TMF_assignGear_fnc_chat_loadout
 * Author = Freddo
 *
 * Parameters:
 * 0: Number. - Number to check
 * 1: String. - Command for systemChat output.
 *
 * Description:
 * Checks CBA setting if command is currently allowed.
 *
 * Return:
 * Boolean. - Whether command is available
 */

#include "\x\tmf\addons\chat\script_component.hpp"

if (0 != call BIS_fnc_admin || call EFUNC(adminmenu,isAuthorized)) exitWith {true};

params ["_var", "_command"];

private _enabled = true;

switch (_var) do {
    case 0: { // Never available
        if true exitWith {
            systemChat FORMAT_1("TMF: %1 is disabled.", _command);
            _enabled = false;
        };
    };
    case 1: { // Available during safestart
        if !(call EFUNC(safestart,isActive)) exitWith {
            systemChat FORMAT_1("TMF: %1 is only available during Safe Start.", _command);
            _enabled = false;
        };
    };
    case 2: { // Available during safestart and after respawning
        if (
            player getVariable [QGVARMAIN(lastRespawn), 0] < time - 300 &&
            {!(call EFUNC(safestart,isActive))}
        ) exitWith {
            systemChat FORMAT_1("TMF: %1 is only available during Safe Start and within 5 minutes of respawn.", _command);
            _enabled = false;
        };
    };
};

_enabled
