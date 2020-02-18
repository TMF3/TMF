/*
 * Name = TMF_assignGear_fnc_cacheLoadout
 * Author = Freddo
 *
 * Arguments:
 * 0: String (optional). CfgLoadouts faction
 * 1: String (optional). CfgLoadouts role
 *
 * Return:
 * Code. Compiled loadout function
 *
 * Description:
 * Caches a loadout to the TMF namespace,
 * for use with TMF_assignGear_fnc_assignLoadout
 */
#include "\x\tmf\addons\assignGear\script_component.hpp"

#define CFGROLE (_cfg >> "CfgLoadouts" >> _faction >> _role)
#define CFGPARSE (configFile >> "CfgLoadoutsParser")

params ["_faction", "_role"];

private _cfg = if (isClass (missionConfigFile >> "CfgLoadouts" >> _faction >> _role)) then [{missionConfigFile}, {configFile}];

ASSERT_TRUE(isClass CFGROLE, format [ARR_3("Loadout not present: %1 %2", _faction, _role)]);

private _loadout = ("loadout_" + _faction + "_" + _role);

/*
    Find properties present in both CfgLoadouts role and CfgLoadoutsParser
    Then sort them by priority with, lower number being higher priority.
*/
private _cfgProperties = [
  (configProperties [CFGROLE] apply {toLower configName _x}) arrayIntersect (("true" configClasses CFGPARSE) apply {toLower configName _x}),
  [],
  {getNumber (CFGPARSE >> _x >> "priority")}
] call BIS_fnc_sortBy;
private _codeArr = [];

// Default code
_codeArr pushBack "private _defGoggles = goggles _this; _this setUnitLoadout (configFile >> 'EmptyLoadout');";

{
    private _property = (CFGROLE >> _x) call BIS_fnc_getCfgData;
    if !(isNil "_property" || {_property in ["", [], -1]}) then {
        _codeArr pushBack format [getText (CFGPARSE >> _x >> "code"), _property];
    };
} forEach _cfgProperties;

_code = compile (_codeArr joinString " ");

GVAR(namespace) setVariable [_loadout, _code, true];

_code
