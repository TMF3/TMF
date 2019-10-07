#include "script_component.hpp"

// This file is called from fn_moduleAIMacro, may need changes if edited

params [["_unit", objNull]];

if
(
    isNull _unit ||
    {isNil (QGVAR(aiGear_) + str side _unit)} ||
    {!local _unit} ||
    {isPlayer _unit} ||
    {_unit in (playableUnits + [player])} ||
    {_unit getVariable [QGVAR(done), false]} ||
    {_unit getVariable ["TMF_aiGear_disabled", false]}
) exitWith {};

private _config = missionNamespace getVariable (QGVAR(aiGear_) + str side _unit);

[_unit, _config] call FUNC(assignAIGear);
