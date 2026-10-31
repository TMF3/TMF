#include "\x\tmf\addons\chat\script_component.hpp"
/*
 * Name = TMF_chat_fnc_findMatch
 * Author = Commy2
 *
 * Arguments:
 * 0: String. - Player name to find
 *
 * Return:
 * Object. - Object linked to player name.
 *
 * Description:
 * Pick unit that matches given name
 * Reports null when no or more than one unit was found
 */

params ["_name"];

private _matches = [];

{
    if (toLower _name in toLower name _x) then {
        _matches pushBack _x;
    };
} forEach ([] call CBA_fnc_players);

if (count _matches == 1) exitWith {_matches select 0};
objNull
