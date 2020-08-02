#include "\x\tmf\addons\assignGear\script_component.hpp"
/*
 * Name = TMF_assignGear_fnc_overrideProfileItems
 * Author = Bear
 *
 * Description:
 * Override face and goggles set by player profile with loadout definitions
 */

["CBA_loadingScreenDone", { // should ensure profile is overridden https://github.com/CBATeam/CBA_A3/wiki/Loading-Screen-Event-Handler
    [{
        private _faction = player getVariable [QGVAR(faction), ""];
        if (_faction isEqualTo "") exitWith {};

        private _cfg = configFile >> "CfgLoadouts" >> _faction >> (player getVariable [QGVAR(role), ""]);

        private _faces = getArray (_cfg >> "faces");
        if !(_faces isEqualTo []) then {
            [player, _faces] call FUNC(setFace);
        };

        private _goggles = getArray (_cfg >> "goggles");
        if !(_goggles isEqualTo []) then {
            [player, _goggles] call FUNC(setGoggles);
        } else {
            removeGoggles player;
        };
    }, 1, 1] call CBA_fnc_waitAndExecute;
}] call CBA_fnc_addEventHandler;