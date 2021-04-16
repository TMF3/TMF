#include "\x\tmf\addons\ai\script_component.hpp"
// Must be scheduled enviorment (spawned)
params ["_hunters", "_targetSide", "_position", "_range",["_targets",[]]];

private _continue = true;
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
            _unit doMove (getPosATL _closestTarget); //doMove
        };

    } forEach _hunters;
    sleep 5;
    _hunters = _hunters select {alive _x};
    if (count _hunters == 0) exitWith {_continue = false;};
    sleep 10;
};
