#include "defines.hpp"
#include "\x\tmf\addons\spectator\script_component.hpp"

disableSerialization;
private _isOpen = [] call FUNC(isOpen);
if(!_isOpen) exitWith {{ctrlDelete _x} foreach GVAR(controls)};
if(_isOpen) then {[] call TMF_spectator_fnc_handleUnitList};


ctrlSetFocus (uiNamespace getVariable QGVAR(unitlist));

[] call FUNC(handleCamera);

// update compass
(uiNamespace getVariable QGVAR(compass)) ctrlSetText ([(getDir GVAR(camera))] call FUNC(getCardinal));
(uiNamespace getVariable QGVAR(compassL)) ctrlSetText ([(getDir GVAR(camera))-45] call FUNC(getCardinal));
(uiNamespace getVariable QGVAR(compassR)) ctrlSetText ([(getDir GVAR(camera))+45] call FUNC(getCardinal));

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

[] call FUNC(drawTags);
GVAR(freecam_timestamp) = time;
