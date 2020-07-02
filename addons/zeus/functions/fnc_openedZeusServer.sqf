#include "\x\tmf\addons\zeus\script_component.hpp"

if !(isServer) exitWith {};

params [["_curator",objNull]];


if (!(missionNamespace getVariable [QGVAR(playerWatchInit),false])) then {
    GVAR(curatorsToGivePlayersTo) = [_curator];
    
    [{
        // Player units.
        private _playerUnits = allPlayers + switchableUnits + playableUnits;
        _playerUnits = _playerUnits arrayIntersect _playerUnits;

        {
            _x addCuratorEditableObjects [_playerUnits,true];
        } forEach GVAR(curatorsToGivePlayersTo);
        
    }, 5, []] call CBA_fnc_addPerFrameHandler;
    GVAR(playerWatchInit) = true;
} else {
    GVAR(curatorsToGivePlayersTo) pushBackUnique _curator;
};
