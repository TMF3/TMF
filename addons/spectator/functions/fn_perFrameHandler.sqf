#include "defines.hpp"
#include "\x\tmf\addons\spectator\script_component.hpp"

disableSerialization;
private _isOpen = [] call FUNC(isOpen);
if(!_isOpen) exitWith {{ctrlDelete _x} forEach GVAR(controls); GVAR(controls) = [];};
if(_isOpen) then {[] call TMF_spectator_fnc_handleUnitList};


ctrlSetFocus (uiNamespace getVariable QGVAR(unitlist));



for [{private _end = GVAR(lastControlIndex)+10;private _count = (count GVAR(controls))}, {GVAR(lastControlIndex) < _end && GVAR(lastControlIndex) < _count }, {GVAR(lastControlIndex) = GVAR(lastControlIndex) + 1}] do {
    private _x  = GVAR(controls) select GVAR(lastControlIndex);
    private _value = isNull (_x getVariable [QGVAR(attached),objNull]);
    if(_value) then {ctrlDelete _x};
    !_value
};
if(GVAR(lastControlIndex) >= count GVAR(controls)) then {GVAR(lastControlIndex) = 0;};


GVAR(vehicles) = GVAR(vehicles) select {!isNull _x};
// update compass
private _dirArray = ["N","NE","E","SE","S","SW","W","NW","N","NE"];
private _leftDir = ([(getDir GVAR(camera))-45] call FUNC(getCardinal));
private _idx = _dirArray find _leftDir;
_dirArray = [_leftDir, _dirArray select (_idx +1), _dirArray select (_idx +2)];
(uiNamespace getVariable "tmf_spectator_compass") params ["_compassL","_compass","_compassR"];
if (!(_dirArray isEqualTo GVAR(lastCompassValue))) then {
    _compassL ctrlSetText (_dirArray select 0);
    _compass ctrlSetText (_dirArray select 1);
    _compassR ctrlSetText (_dirArray select 2);
    GVAR(lastCompassValue) = _dirArray;
};

// update something horrible

if(GVAR(mode) != FREECAM && !isNil QGVAR(target) && {!isNull GVAR(target)} && {alive GVAR(target)} ) then {
    (uiNamespace getVariable QGVAR(unitlabel)) ctrlSetText (name GVAR(target));
} else {
    (uiNamespace getVariable QGVAR(unitlabel)) ctrlSetText "";
};


if(GVAR(killList_update) >= time || GVAR(killList_forceUpdate)) then {
    if(count GVAR(killedUnits) > 0) then {
        GVAR(killList_update) = time - ((GVAR(killedUnits) select 0) select 1); // next update
    };
    [] call FUNC(updateKillList);
};


{
    _x params ["_object","_posArray","_last","_time","_type"];

    if(!isNull _object && {diag_frameNo > (_last+1)} && {(speed _object) > 0} && { GVAR(bulletTrails) || _type != 0   }) then {
        private _pos = (getPosATLVisual _object);
        if(surfaceIsWater _pos) then {_pos = getPosASLVisual _object;};
        _posArray pushBack (_pos);
        GVAR(rounds) set [_forEachIndex,[_object,_posArray,diag_frameNo,_time,_type]];
    };
    if( _type > 0  && { isNull _object } || _type == 0 && {(time - _time) > 5} ) then { GVAR(rounds) set [_forEachIndex,0]; };
} foreach GVAR(rounds);

GVAR(rounds) = GVAR(rounds) - [0];


[] call FUNC(handleCamera);
GVAR(freecam_timestamp) = time;
