#include "\x\tmf\addons\assignGear\script_component.hpp"
/*
 * Name = TMF_assignGear_fnc_overrideProfileItems
 * Author = Bear, Freddo
 *
 * Description:
 * Override face and goggles set by player profile with loadout definitions
 */

["CBA_loadingScreenDone", { // should ensure profile is overridden https://github.com/CBATeam/CBA_A3/wiki/Loading-Screen-Event-Handler
    [{
        if !(player getVariable [QGVAR(done),false]) exitWith {};
        if !(player getVariable [QGVAR(overridePlayerIdentity),GVAR(overridePlayerIdentity)]) exitWith {};

        private _faces = player getVariable [QGVAR(faces),[]];
        if !(_faces isEqualTo []) then {
            [player, _faces] call FUNC(setFace);
        };

        private _goggles = player getVariable [QGVAR(goggles),[]];
        if !(_goggles isEqualTo []) then {
            [player, _goggles] call FUNC(setGoggles);
        } else {
            removeGoggles player;
        };

        private _insignia = player getVariable [QGVAR(insignia),"default"];
        [player,_insignia] call FUNC(setInsignia);

        TRACE_3("Overriden player profile items",_faces,_goggles,_insignia);
    }, [], 2] call CBA_fnc_waitAndExecute;
}] call CBA_fnc_addEventHandler;
