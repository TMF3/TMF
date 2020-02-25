/*
 * Name = TMF_chat_fnc_cmndRP
 * Author = Kingsley
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Void
 *
 * Description:
 * Resets the player position.
 */

#include "\x\tmf\addons\chat\script_component.hpp"

private _safePos = (getPosATL player) findEmptyPosition [0, 25, (typeOf player)];

if (count _safePos == 3) exitWith {
    _safePos set [2, 0];
    player setPosATL _safePos;
    systemChat "TMF: Reset player position";
};
systemChat "TMF Error: Unable to reset player position";
