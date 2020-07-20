#include "\x\tmf\addons\spectator\script_component.hpp"
params["_control","_path"];
private _netId = _control tvData _path;
if(count _path > 1) then {
    private _unit = _netId call BIS_fnc_objectFromNetId;
    if(!isNull _unit) then
    {
        [ _unit ] call FUNC(setTarget);
    };
} else {
    private _group = leader (_netId call BIS_fnc_groupFromNetId);
    if(!isNull _group) then {
        [ leader _group ] call FUNC(setTarget);
    }
};