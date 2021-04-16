#include "\x\tmf\addons\ai\script_component.hpp"
params ["_logic"];


private _hunters = [];
private _hunterVal = _logic getVariable ["Hunters", -1];
if (_hunterVal == -1) then {
    _hunters = synchronizedObjects _logic;
    {
        private _vehicle = vehicle _x;
        {
            _hunters pushBackUnique _x;
        } forEach (crew _vehicle);
    } forEach _hunters;
} else {
    private _side = switch (_hunterVal) do {
        case 0: {east};
        case 1: {west};
        case 2: {resistance};
        default {civilian};
    };
    _hunters = allUnits select {side _x == _side};
};
// filter out player units and playable
_hunters = ((_hunters - playableUnits) - switchableUnits) - [player];

{
    _x disableAI "AUTOCOMBAT";
} forEach _hunters;
