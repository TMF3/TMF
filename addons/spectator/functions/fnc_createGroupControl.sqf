#include "\x\tmf\addons\spectator\script_component.hpp"
params ["_grp"];
disableSerialization;

private _control = (uiNamespace getVariable [QGVAR(display),displayNull]) ctrlCreate [QGVAR(GroupTag), -1];
_control ctrlShow false;

private _twGrpMkr = [_x] call EFUNC(orbat,getGroupMarkerData);
if (count _twGrpMkr == 3) then {
    _twGrpMkr params ["_grpTexture","_gname"];
    [_control,_grpTexture,[1,1,1,1]] call FUNC(controlSetPicture);
    [_control,_gname] call FUNC(controlSetText);
}
else {
    private _grpCache = _x getVariable [QGVAR(grpCache),[[], [1,1,1,1], true]];
    private _grpPos = _grpCache # 0;
    if (count _grpPos <= 0) then {
        _grpCache = ([_x] call FUNC(updateGroupCache));
    };
    [_control,"\A3\ui_f\data\map\markers\nato\b_unknown.paa", _grpCache # 1] call FUNC(controlSetPicture);
    [_control,groupId _grp] call FUNC(controlSetText);
};
[_control,"",[],true] call FUNC(controlSetText);
_grp setVariable [QGVAR(tagControl), [_control]];
_control setVariable [QGVAR(attached),_grp];
GVAR(controls) pushBack _control;
