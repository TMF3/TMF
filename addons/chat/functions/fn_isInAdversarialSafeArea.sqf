/*
 * Name = TMF_chat_fnc_isInAdversarialSafeArea
 * Author = Freddo
 *
 * Parameters:
 * 0: Array. - Position
 * 1: Side. - Attacking side
 *
 * Description:
 * Checks if a position is in a safe area, as an attacker
 * Used for #stage command
 *
 * Return:
 * Boolean. - Whether one can teleport into area.
 */

#include "\x\tmf\addons\chat\script_component.hpp"

params ["_position", "_side"];

private _canTp = true;
private _logicType = ["SideOPFOR_F", "SideBLUFOR_F", "SideResistance_F"] select (_side call BIS_fnc_sideID);


{
    private _syncedObjs = synchronizedObjects _x;
    if !(_logicType in (_syncedObjs apply {typeOf _x})) then {
        private _areas = _syncedObjs select {typeOf _x in [QEGVAR(ai,area), QEGVAR(ai,area_rectangle)]};
        private _index = _areas findIf {
            _position inArea ([getPos _x] + (_x getVariable ["objectarea", [0,0,0,false]]));
        };
        if (_index != -1) exitWith { _canTp = false; };
    };
} forEach (entities QGVAR(adversarialSafeZone));

_canTp
