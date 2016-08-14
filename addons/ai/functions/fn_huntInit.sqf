#include "\x\tmf\addons\AI\script_component.hpp"
params ["_logic"];


private _hunters = [];
private _hunterVal = _logic getVariable ["Hunters", -1];
if (_hunterVal == -1) then {
    _hunters = synchronizedObjects _logic;
    
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