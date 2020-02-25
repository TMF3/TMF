/*
 * Name = TMF_chat_fnc_cmndTp
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

params [["_name",""]];

if (_name isEqualTo "") exitWith {
    systemChat "TMF Error: No argument passed. Use #tp [<player>|<group>]";
};

private _unit = [_name] call FUNC(findMatch);

if (isNull _unit) then {
    private _side = side player;
    private _grpArr = allGroups select {
        _side isEqualTo side _x &&
        [_name, groupId _x] call BIS_fnc_inString
    };
    if (count _grpArr isEqualTo 1) then {
        _unit = leader (_grpArr # 0);
    };
};

if (!isNull _unit) then {
    if (vehicle _unit != _unit) then {
        player moveInAny vehicle _unit;

        if !(player in vehicle _unit) then {
            systemChat FORMAT_1("TMF: %1's vehicle is full", name _unit);
        } else {
            systemChat FORMAT_1("TMF: Teleported into %1's vehicle", name _unit);
        };
    } else {
        private _pos = _unit getRelPos [3, 180];
        player setDir (getDir _unit);
        player setPos _pos;
        systemChat FORMAT_1("TMF: Teleported to %1", name _unit);
    };
} else {
    systemChat FORMAT_1("TMF Error: No player/group containing %1, or more than one found.", str _name);
};
