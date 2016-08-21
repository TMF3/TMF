#include "\x\tmf\addons\spectator\script_component.hpp"
params ["_logic","_units","_activated"];
_icon = _logic getVariable ["Icon","\A3\ui_f\data\map\markers\nato\b_unknown.paa"];
_text = _logic getVariable ["Text",""];
_color = call compile (_logic getVariable ["Color","[1,0,0,1]"]);

_logic setVariable [QGVAR(objectiveData), [_icon,_text,_color]];

if(_activated) then {
    if(isNil QGVAR(objectives)) then {GVAR(objectives) = [_logic];} else {GVAR(objectives) pushback _logic};
} else {
    if(!isNil QGVAR(objectives) && {_logic in GVAR(objectives)}) then {GVAR(objectives) = GVAR(objectives) - [_logic];};
};
