#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_ctrlGroup"];

(ctrlPosition _ctrlGroup) params ["", "", "_ctrlGrpWidth", "_ctrlGrpHeight"];

private _ctrlLabelTraits = _display ctrlCreate [QGVAR(RscText), -1, _ctrlGroup];
GVAR(utilityTabControls) pushBack _ctrlLabelTraits;
_ctrlLabelTraits ctrlSetPosition [0, 0, (0.25 * _ctrlGrpWidth), TMF_ADMINMENU_STD_HEIGHT];
_ctrlLabelTraits ctrlCommit 0;
_ctrlLabelTraits ctrlSetText "Assign Players' Traits";

private _ctrlComboTraitLabelW = 0.4 * _ctrlGrpWidth;
private _ctrlComboTraitX = 0.5 * _ctrlGrpWidth;
private _ctrlComboTraitY = 2.2 * TMF_ADMINMENU_STD_HEIGHT;
private _ctrlComboTraitW = 0.5 * _ctrlGrpWidth;
private _traitComboCtrls = [];

{
    private _ctrlLineY = _ctrlComboTraitY + _forEachIndex * (1.1 * TMF_ADMINMENU_STD_HEIGHT);

    private _ctrlComboTraitLabel = _display ctrlCreate [QGVAR(RscTextLarge), -1, _ctrlGroup];
    GVAR(utilityTabControls) pushBack _ctrlComboTraitLabel;
    _ctrlComboTraitLabel ctrlSetPosition [0.1 * TMF_ADMINMENU_STD_WIDTH, _ctrlLineY, _ctrlComboTraitLabelW, TMF_ADMINMENU_STD_HEIGHT];
    _ctrlComboTraitLabel ctrlCommit 0;
    _ctrlComboTraitLabel ctrlSetText _x;

    private _ctrlComboTrait = _display ctrlCreate [QGVAR(RscCombo), -1, _ctrlGroup];
    GVAR(utilityTabControls) pushBack _ctrlComboTrait;
    _traitComboCtrls pushBack _ctrlComboTrait;
    _ctrlComboTrait ctrlSetPosition [_ctrlComboTraitX, _ctrlLineY, _ctrlComboTraitW, TMF_ADMINMENU_STD_HEIGHT];
    _ctrlComboTrait ctrlCommit 0;

    _ctrlComboTrait lbSetValue [(_ctrlComboTrait lbAdd "Don't Change"), -1];
    _ctrlComboTrait lbSetCurSel 0;

    if (_x isEqualTo "Medic" && isClass (configFile >> "CfgPatches" >> "ace_medical")) then {
        _ctrlComboTrait lbSetValue [(_ctrlComboTrait lbAdd "Medic (1)"), 1];
        _ctrlComboTrait lbSetValue [(_ctrlComboTrait lbAdd "Doctor (2)"), 2];
        _ctrlComboTrait lbSetValue [(_ctrlComboTrait lbAdd "Untrained (0)"), 0];
    } else {
        _ctrlComboTrait lbSetValue [(_ctrlComboTrait lbAdd "Yes"), 1];
        _ctrlComboTrait lbSetValue [(_ctrlComboTrait lbAdd "No"), 0];
    };
} forEach ["Medic", "Engineer", "Explosive Specialist", "UAV Hacker"];

private _ctrlButton = _display ctrlCreate [QGVAR(RscButtonMenu), -1, _ctrlGroup];
GVAR(utilityTabControls) pushBack _ctrlButton;
_ctrlButton ctrlSetPosition [_ctrlGrpWidth * 0.8, _ctrlGrpHeight - TMF_ADMINMENU_STD_HEIGHT, _ctrlGrpWidth * 0.2, TMF_ADMINMENU_STD_HEIGHT];
_ctrlButton ctrlCommit 0;
_ctrlButton ctrlSetText "Assign Traits";
_ctrlButton setVariable [QGVAR(association), _traitComboCtrls];
_ctrlButton ctrlAddEventHandler ["ButtonClick", {
    params ["_ctrlButton"];
    _ctrlButton call FUNC(debounceButton);

    private _traitComboCtrls = _ctrlButton getVariable [QGVAR(association), []];
    _traitComboCtrls params ["_comboMed", "_comboEng", "_comboExp", "_comboUAV"];

    private _valueMed = _comboMed lbValue lbCurSel _comboMed;
    private _valueEng = _comboEng lbValue lbCurSel _comboEng;
    private _valueExp = _comboExp lbValue lbCurSel _comboExp;
    private _valueUAV = _comboUAV lbValue lbCurSel _comboUAV;

    {
        if (_valueMed != -1) then {
            _x setUnitTrait ["medic", _valueMed > 0];
            _x setVariable ["ace_medical_medicClass", _valueMed, true];
        };

        if (_valueEng != -1) then {
            _x setUnitTrait ["engineer", _valueEng > 0];
            _x setVariable ["ACE_isEngineer", _valueEng > 0, true];
        };

        if (_valueExp != -1) then {
            _x setUnitTrait ["explosiveSpecialist", _valueExp > 0];
            _x setVariable ["ACE_isEOD", _valueExp > 0, true];
        };

        if (_valueUAV != -1) then {
            _x setUnitTrait ["UAVHacker", _valueUAV > 0];
        };
    } forEach GVAR(utilityData);

    systemChat format ["[TMF Admin Menu] Assigned traits to %1 player(s)", count GVAR(utilityData)];
}];