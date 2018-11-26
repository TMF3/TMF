/*
 * Name = TMF_assignGear_fnc_setInsignia
 * Author = Freddo
 *
 * Arguments:
 * 0: Object. Unit
 * 1: ARRAY. Array of insignia to choose from
 *
 * Return:
 * 0: Nothing
 *
 * Description:
 * Will set a units insignia to a randomly chosen one from the supplied list.
 * 
 * Note:
 * This is a modified version of TMF_assignGear_fnc_setFace (Made by Nick)
 */
 #include "\x\tmf\addons\assignGear\script_component.hpp"
params ["_unit","_insignias"];
private _insignia = "";

if (isNil "_unit" || isNil "_insignias") exitWith {};

if (count _insignias > 0) then {
    private _unitInsignia = toLower ([_unit] call BIS_fnc_GetUnitInsignia);
    private _found = false;

    if (!_found) then {
        private _insignia = selectRandom _insignias;
        private _insigniaSetName = _insignia select [8];
        private _array = uiNamespace getVariable ["tmf_assignGear_insigniaset_" + _insigniaSetName,[]];
        if (count _array > 0) then {
            _insignia = selectRandomWeighted _array;
        };
        [_unit,_insignia] remoteExecCall ["BIS_fnc_setUnitInsignia",0,_unit];
        [_unit,_insignia] call BIS_fnc_setUnitInsignia;
    };
};
//_insignia