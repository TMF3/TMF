#include "\x\tmf\addons\autotest\script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: TMF_autotest_fnc_testDLC

Description:
    Checks units/vehicles DLC usage

Returns:
    Warning array [Array of Warnings]

Author:
    Freddo
---------------------------------------------------------------------------- */

LOG("Running DLC tests");
private _warnings = [];

private _allUnits = (playableUnits + [player]);
private _unitsDLCInfo = _allUnits apply {[_x,getPersonUsedDLCs _x]};
private _dlcHash = uiNamespace getVariable QGVAR(dlcHash);
private _missionSummary = "Multiplayer" get3DENMissionAttribute "IntelOverviewText";

// Check units for DLC
{
    _x params ["_unit","_dlcArr"];
    TRACE_2("Checking unit for DLC",_unit,_dlcArr);

    // Get DLC short names from preStart hash
    _dlcArr = _dlcArr apply { [_dlcHash, _x] call CBA_fnc_hashGet };

    private _roleDescription = (_unit get3DENAttribute "description") select 0;
    _dlcArr = _dlcArr select {
        !([_x, _roleDescription] call BIS_fnc_inString) && // DLC usage mentioned in role description
        !([_x, _missionSummary] call BIS_fnc_inString)  && // DLC usage mentioned in mission summary
    };

    if !(_dlcArr isEqualTo []) then {
        TRACE_2("Unit has unlisted DLC",_unit,_dlcArr);
        _warnings pushBack [
            0,
            format ["%1 needs notice for following DLC: %2", _unit, _dlcArr]
        ];
    };
} forEach (_unitsDLCInfo select {!(_x # 1 isEqualTo [])});

private _vehicleDLCInfo = vehicles apply {[_x,getObjectDLC _x]};
private _roleDescriptions = _allUnits apply {(_x get3DENAttribute "description") select 0};
private _searchTexts = [_missionSummary] + _roleDescriptions;
private _problemVehs = 0;
private _problemVehsDLC = [];

// Check placed vehicles for DLC
{
    _x params ["_veh", "_dlc"];
    TRACE_2("Checking vehicle for DLC",_veh,_dlc);

    // Get DLC short names from preStart hash
    _dlc = [_dlcHash, _dlc] call CBA_fnc_hashGet;

    private _index = _searchTexts findIf {[_dlc,_x] call BIS_fnc_inString};

    if (_index == -1) then {
        TRACE_2("Vehicle found using unlisted DLC",_veh,_dlc);
        _problemVehs = _problemVehs + 1;
        _problemVehsDLC pushBackUnique _dlc;
    };
} forEach (_vehicleDLCInfo select {!isNil {(_x # 1)}});

if (_problemVehs > 0) then {
    if (_problemVehs > 1) then {
        _warnings pushBack [
            1,
            format ["There are %1 vehicles present from unmentioned DLC: %2", _problemVehs, _problemVehsDLC]
        ];
    } else {
        _warnings pushBack [
            1,
            format ["There is %1 vehicle present from unmentioned DLC: %2", _problemVehs, _problemVehsDLC]
        ];
    };
};

LOG_1("Finished DLC Tests: %1", _warnings);

_warnings
