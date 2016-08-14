#include "\x\tmf\addons\AI\script_component.hpp"
params ["_logic","_units","_activated"];

if (!_activated) exitWith {};


private _hunters = []; // allUnits select {side _x == east}
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

// Spawn for performance reasons.



[_hunters, _targetSide, _position, _range] spawn {
    params ["_hunters", "_targetSide", "_position", "_range"];
    
    private _continue = true;
    private _targets = [];
    while {_continue} do {
        // CHEAT
        //private _nTargets = (_position nearEntities ["CAManBase", _range]) select {side _x == _targetSide && alive _x && {!(_x getVariable ["ACE_isUnconscious", false])}};
        _targets = (_targets select {alive _x}) - [objNull];
        {
            private _unit = _x;
            private _closestTarget = _unit findNearestEnemy _unit;

            if (isNull _closestTarget) then {
                // Use another target we know about.
                private _closestFloat = _range*3;
                {
                    private _target = _x;
                    private _distanceToTarget = _target distance _unit;
                    if (_distanceToTarget < _closestFloat) then {
                        _closestTarget = _target;
                        _closestFloat = _distanceToTarget;
                    };
                } forEach _targets;
                
                // SEARCH: If we still don't have a target search.
                if (isNull _closestTarget) then {
                    if (_unit distance _position < _range) then {
                        private _dir = [_unit,_position] call BIS_fnc_dirTo;
                        _dir = _dir + (((round (random 1)) - 0.5) * 2) * (random 1 * random 1 * 180);
                        //private _dir = random 360;
                        _unit doMove (getPos (_unit) vectorAdd [(sin(_dir)*40), (cos(_dir)*40), 0]);
                    } else { // Outside move in.
                        _unit doMove _position;
                    };
                };
                /* CHEAT
                private _closestFloat = _range*3;
                {
                    _target = _x;
                    _distanceToTarget = _target distance _unit;
                    if (_distanceToTarget < _closestFloat) then {
                        _closestTarget = _target;
                        _closestFloat = _distanceToTarget;
                    };
                } forEach _nTargets;*/
            } else {
                if ((_targets pushBackUnique _closestTarget) != -1) then {
                    // Share this new contact with the rest of the group.
                    {
                        _x reveal _closestTarget;
                    } forEach _hunters;
                    
                };
            };

            if (!isNull _closestTarget) then {
                _unit doMove (getPos _closestTarget); //doMove
            };

        } forEach _hunters;
        sleep 5;
        _hunters = _hunters select {alive _x};
        if (count _hunters == 0) exitWith {_continue = false;};
        sleep 10;
    };
};