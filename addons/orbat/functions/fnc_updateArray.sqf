#include "\x\tmf\addons\orbat\script_component.hpp"
//Update the positions and the closest/furthest away position caches recursively. Run the update in the scheluded enviornment to lower overhead.

if (count _this == 0) exitWith {};
private _meanPos = [0,0,0];
private _retPos = [];

private _in = _this;
private _rootNode = (_in select 0);
private _myPos = (_rootNode select 4);

//Old mean = _rootNode select 4;
private _maxDist = 0;
private _maxDistPos = _rootNode select 4;
if (count _in > 1) then {
    for "_i" from 1 to (count _in - 1) do {
        private _xObject = (_in select _i);
        private _ret = _xObject call FUNC(updateArray);
        _ret params ["_retPos2", "_retmaxDistPos"];
        _meanPos = _meanPos vectorAdd _retPos2;
        private _thisIdx = _i;
        private _minChildDist = 100000;
        private _minDistPos = [0,0,0];
        private _dist = (_retPos2 distanceSqr _myPos); // old mean.
        if (_dist > _maxDist) then {
            _maxDist = _dist;
            _maxDistPos = ((_xObject select 0) select 4);
        };
        _dist = (_retMaxDistPos distanceSqr _myPos); // old mean.
        if (_dist > _maxDist) then {
            _maxDist = _dist;
            _maxDistPos = _retMaxDistPos;
        };
        for "_i" from 1 to (count _in - 1) do {
            if ((_thisIdx != _i)) then {
                private _childPos = (((_in select _i) select 0) select 4);
                _dist = (_retPos2 distanceSqr _childPos);
                if (_dist < _minChildDist) then {
                    _minChildDist = _dist;
                    _minDistPos = _childPos;
                };
            };
        };
        (_xObject select 0) set [5,_minDistPos];
    };
    _rootNode set[6,_maxDistPos];
    _meanPos = _meanPos vectorMultiply (1 / ((count _in) -1)); // -1 as first one is the root node. (Get the true mean)
    _rootNode set[4,_meanPos];
    _retPos = _meanPos;
} else {
    private _thing = _rootNode select ((count _rootNode) -1);
    private _pos = [0,0,0];
    if(_thing isEqualType grpNull) then {_pos = getPos leader _thing};
    if(_thing isEqualType objNull) then {_pos = getPos _thing};
    if (_pos isNotEqualTo [0,0,0]) then {
        _rootNode set[4,_pos];
        _retPos = _pos;
    } else {
        _retPos = _myPos;
    };
};
[+_retPos, +_maxDistPos]
