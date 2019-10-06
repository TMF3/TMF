#include "script_component.hpp"

// This file is called from fn_moduleAIMacro, may need changes if edited

params [["_unit", objNull]];

if
(
    isNull _unit ||
    {isNil (QGVAR(aiGear_) + str side _unit)} ||
    {!local _unit} ||
    {isPlayer _unit} ||
    {_unit in playableUnits} ||
    {_unit getVariable [QGVAR(done), false]} ||
    {!is3den || {(_unit get3DENAttribute 'ControlSP') # 0 || (_unit get3DENAttribute 'ControlMP') # 0}}
) exitWith {};

private _config = missionNamespace getVariable (QGVAR(aiGear_) + str side _unit);

[_unit, _config] call FUNC(assignAIGear);
