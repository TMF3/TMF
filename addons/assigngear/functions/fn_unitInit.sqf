#include "\x\tmf\addons\assigngear\script_component.hpp"

/*
 * Name = TMF_assignGear_fnc_unitInit
 * Author = Freddo
 *
 * Arguments:
 * 0: Object. Unit to assign gear to
 *
 * Return:
 * Boolean. If loadout was assigned then true
 *
 * Description:
 * Assigns AI gear to unit if available
 */

params ["_unit"];

if
(
    isNull _unit ||
    {isNil (QGVAR(aiGear_) + str side _unit)} ||
    {!local _unit} ||
    {isPlayer _unit} ||
    {_unit in (playableUnits + [player])} ||
    {_unit getVariable [QGVAR(done), false]} ||
    {_unit getVariable ["TMF_aiGear_disabled", false]}
) exitWith {false};

private _config = missionNamespace getVariable (QGVAR(aiGear_) + str side _unit);

[_unit, _config] call FUNC(assignAIGear);

true
