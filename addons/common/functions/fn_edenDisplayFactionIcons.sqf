// Display faction icons in 3DEN unit/group asset lists

#include "\x\tmf\addons\common\script_component.hpp"

disableSerialization;

if !(is3DEN) exitWith {};

private _topCtrl = (((findDisplay 313) displayCtrl 1021) controlsGroupCtrl 1039) controlsGroupCtrl 1049;
if (isNull _topCtrl) exitWith {};

private ["_i", "_faction", "_factionIcon"];
{
    for "_i" from 0 to ((_x tvCount []) - 1) do {
        _faction = _x tvData [_i];

        if !(_faction isEqualTo "") then {
            _factionIcon = getText (configFile >> "CfgFactionClasses" >> _faction >> "icon");

            if !(_factionIcon isEqualTo "") then {
                _x tvSetPictureRight [[_i], _factionIcon];
            };
        };
    };
} forEach ([56, 57, 58, 59, 61, 62, 63, 64] apply {_topCtrl controlsGroupCtrl _x});
