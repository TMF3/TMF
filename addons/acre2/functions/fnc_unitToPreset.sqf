/*
 * Name: TMF_acre2_fnc_unitToPreset
 * Author: Snippers
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 *
 * Return:
 * Preset Index (-1 if not found) <NUMBER>
 *
 * Description:
 * Returns the preset number for the specified unit.
 */
#include "\x\tmf\addons\acre2\script_component.hpp"

params[["_unit",objNull]];


private _unitGroup = group _unit;
private _ourPresetIndex = -1;
private _unitCond = _unit getVariable ["TMF_Network",-1];
private _groupCond = _unitGroup getVariable ["TMF_Network",-1];
if (is3DEN) then {
    _unitCond = (_unit get3DENAttribute "TMF_Network") param [0,-1];
    _groupCond = (_unitGroup get3DENAttribute "TMF_Network") param [0,-1];
};

private _networksWithRadioChannels = getMissionConfigValue ['TMF_AcreSettings', []];
if (_networksWithRadioChannels isEqualType "") then { _networksWithRadioChannels = call compile _networksWithRadioChannels};

{
    private _radioPresetSetting = _x;
    private _radioPresetIdx = _forEachIndex;
    _radioPresetSetting params ["_conditions"];
    private _passes = [_unit, _conditions] call EFUNC(common,evaluateCondArray);
    
    if (_groupCond == _radioPresetIdx) then { _passes = true; };
    if (_unitCond == _radioPresetIdx) then { _passes = true; };
    if (_passes) exitWith {
        _ourPresetIndex = _radioPresetIdx;
    };
} forEach _networksWithRadioChannels;

_ourPresetIndex;
