#include "defines.hpp"
#include "\x\tmf\addons\spectator\script_component.hpp"

disableSerialization;
private _isOpen = [] call FUNC(isOpen);
if(!_isOpen) exitWith {{ctrlDelete _x} foreach GVAR(controls)};
if(_isOpen) then {[] call TMF_spectator_fnc_handleUnitList};


with uiNamespace do { ctrlSetFocus GVAR(unitlist);};

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



{
    _x ctrlSetStructuredText parseText "";
} forEach (uiNamespace getVariable [QGVAR(labels),[]]);

for "_i" from 1 to 6 do {
    _index = count GVAR(killedUnits) - _i;
    if(_index < (count GVAR(killedUnits)) && _index >= 0 ) then {
        _data = GVAR(killedUnits) select (count GVAR(killedUnits) - _i);
        _data params ["_unit","_time","_killer","_deadSide","_killerSide","_dName","_kName","_weapon"];
        _time = time - _time;
        if(_time <= 12 && _i < 6) then {
            private _control = (uiNamespace getvariable [QGVAR(labels),[]]) select _i;
            if(_killer == _unit || isNull _killer) then {
                _control ctrlSetStructuredText parseText format ["<img image='\a3\Ui_F_Curator\Data\CfgMarkers\kia_ca.paa'/><t color='%2'>%1</t>",_dName,_deadSide call CFUNC(sidetohexcolor)];
            } else {
                _control ctrlSetStructuredText parseText format ["<t color='%4'>%1</t>  [%3]  <t color='%5'>%2</t>",_kName,_dName,_weapon,_killerSide call CFUNC(sidetohexcolor),_deadSide call CFUNC(sidetohexcolor)];
            };
        };
        if(_time > 12) then {
            GVAR(killedUnits) set [_index,0];
        };
    };
};
GVAR(killedUnits) = GVAR(killedUnits) - [0];

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
