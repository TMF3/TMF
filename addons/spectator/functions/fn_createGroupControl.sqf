#include "\x\tmf\addons\spectator\script_component.hpp"
params ["_grp"];
disableSerialization;

private _grpCache = _x getVariable [QGVAR(grpCache),[0,[0,0,0],[1,1,1,1],true]];
_grpCache params ["_grpTime","_avgpos","_color","_isAI"];
if(count _avgpos <= 0 || time > _grpTime) then {
    _grpCache = ([_x] call FUNC(updateGroupCache));
};
_grpCache params ["_grpTime","_avgpos","_color","_isAI"];

private _control = (findDisplay 5454) ctrlCreate [QGVAR(EntityTag), -1];
_control ctrlShow false;

private _twGrpMkr = [_x] call EFUNC(orbat,getGroupMarkerData);
if(count _twGrpMkr == 3) then {
  _twGrpMkr params ["_grpTexture","_gname"];
   [_control,_grpTexture,[1,1,1,1]] call FUNC(controlSetPicture);
   [_control,_gname] call FUNC(controlSetText);
}
else {
  [_control,"\A3\ui_f\data\map\markers\nato\b_unknown.paa",_color] call FUNC(controlSetPicture);
  [_control,groupId _grp] call FUNC(controlSetText);
};
[_control,"",[],true] call FUNC(controlSetText);
_grp setVariable [QGVAR(tagControl), [_control]];
_control setVariable [QGVAR(attached),_grp];
GVAR(controls) pushBack _control;
