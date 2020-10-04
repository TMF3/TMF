#include "\x\tmf\addons\spectator\script_component.hpp"

disableSerialization;
private _isOpen = [] call FUNC(isOpen);
if(!_isOpen) exitWith {{ctrlDelete _x} forEach GVAR(controls); GVAR(controls) = [];};
ctrlSetFocus (uiNamespace getVariable QGVAR(unitlist));

// Cleanup - unused controls.
private _newIdx = ((count GVAR(controls) - 1) min (GVAR(lastControlIndex)+10));
for "_idx" from GVAR(lastControlIndex) to _newIdx do {
    private _control = GVAR(controls) select _idx;
    private _thing = _control getVariable [QGVAR(attached),objNull];
    if (_thing isEqualType objNull) then {
        if(!alive _thing) then { /* alive also does a isNull check */
            ctrlDelete _control;
        };
    } else {
        if(isNull _thing) then {
            ctrlDelete _control;
        };
    };
};
if (GVAR(lastControlIndex) >= (count GVAR(controls) - 1)) then {
    GVAR(lastControlIndex) = 0;
} else {
    GVAR(lastControlIndex) = _newIdx;
};

// update compass
private _dirArray = GVAR(compassValues);
private _leftDir = ([(getDir GVAR(camera))-45] call FUNC(getCardinal));
private _idx = _dirArray find _leftDir;
_dirArray = [_leftDir, _dirArray select (_idx + 1), _dirArray select (_idx + 2)];
(uiNamespace getVariable QGVAR(compass)) params ["_compassL","_compass","_compassR"];

if (_dirArray isNotEqualTo GVAR(lastCompassValue)) then {
    _compassL ctrlSetText (_dirArray select 0);
    _compass ctrlSetText (_dirArray select 1);
    _compassR ctrlSetText (_dirArray select 2);
    GVAR(lastCompassValue) = _dirArray;
};

// update something horrible (alive also checks for isNull)

if(GVAR(mode) != FREECAM && !isNil QGVAR(target) && {alive GVAR(target)} ) then {
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
