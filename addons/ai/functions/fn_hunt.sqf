#include "\x\tmf\addons\AI\script_component.hpp"
params ["_logic","_units","_activated"];

if (!_activated) exitWith {};


private _hunters = []; // allUnits select {side _x == east}
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

private _targetSide = switch (_logic getVariable ["TargetSide", 1]) do {
    case 0: {east};
    case 1: {west};
    case 2: {resistance};
    default {civilian};
};

private _position = getPos _logic;
private _range = _logic getVariable ["Range",100];
_range = ((_range) max 50) min 5000; // Ensure minimum of 50 min anx max of 5000

// Setup units.
private _oldGroups = [];
{
    private _unit = _x;
    _oldGroups pushBackUnique (group _unit);

    [_unit] joinSilent grpNull;
    _unit setUnitPos "UP";
    _unit disableAI "SUPPRESSION";
    _unit disableAI "AUTOCOMBAT"; // Already applied at init but reapply.
    _unit setBehaviour "AWARE";
    _unit setSpeedMode "FULL";

    // Just in case MM went crazy.
    _unit enableAI "PATH";
    _unit enableAI "MOVE";

    _unit allowFleeing 0;
    doStop _unit;


} forEach _hunters;

// Cleanup groups no longer used.
{
    if (count (units _x) == 0) then {deleteGroup _x;};
} forEach (_oldGroups - [grpNull]);

[["Triggered hunt on %1 units",count _hunters],false,"[TMF AI] "] call EFUNC(adminmenu,log);

// Spawn for performance reasons.

[_hunters, _targetSide, _position, _range] spawn FUNC(huntLoop);
