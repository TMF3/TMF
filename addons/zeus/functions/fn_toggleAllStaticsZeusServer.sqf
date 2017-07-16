#include "\x\tmf\addons\zeus\script_component.hpp"

if !(isServer) exitWith {};

params [["_curator",objNull]];

if (!(_curator getVariable [QGVAR(addAllStatics),false])) then {
    private _objects = allMissionObjects "Static";
    _curator addCuratorEditableObjects [_objects,true];
    _curator setVariable [QGVAR(addAllStatics),true,true];
} else {
    private _objects = allMissionObjects "Static";
    _curator removeCuratorEditableObjects [_objects,true];
    _curator setVariable [QGVAR(addAllStatics),false,true];
};

