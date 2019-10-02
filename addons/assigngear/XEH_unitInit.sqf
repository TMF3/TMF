#include "script_component.hpp"

params [["_unit", objNull]];

if
(
    isNull _unit ||
    {!local _unit} ||
    {isPlayer _unit} ||
    {_unit in playableUnits} ||
    {isNil (QGVAR(aiGear_) + str side _unit)} ||
    {_unit getVariable [QGVAR(done), false]}
) exitWith {};

private _config = missionNamespace getVariable (QGVAR(aiGear_) + str side _unit);

[_unit, _config] call FUNC(assignAIGear);
