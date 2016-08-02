#include "\x\tmf\addons\patrol\script_component.hpp"
params ["_display","_code"];
if(_code != 1) exitWith {};

_type = lbCurSel (_display displayCtrl 1337);
_radius = parseNumber (ctrlText (_display displayCtrl 1338));
_points = parseNumber (ctrlText (_display displayCtrl 1339));
_onroad = cbChecked (_display displayCtrl 1340);



_groups = get3DENSelected "Group";
_over = get3DENMouseOver;
if(count _over > 0 && {(_over select 0) == "Group"}) then {_groups pushBackUnique (_over select 1)};
{
    [_x,getpos leader _x,_type,_radius,_points,_onroad] call FUNC(patrol);
} foreach _groups;
