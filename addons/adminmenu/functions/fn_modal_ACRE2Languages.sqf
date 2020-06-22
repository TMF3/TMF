#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_ctrlGroup"];

(ctrlPosition _ctrlGroup) params ["", "", "_ctrlGrpWidth", "_ctrlGrpHeight"];

private _ctrlLabelLangs = _display ctrlCreate [QGVAR(RscTextLarge), -1, _ctrlGroup];
GVAR(utilityTabControls) pushBack _ctrlLabelLangs;
_ctrlLabelLangs ctrlSetPosition [0, 0, (0.5 * _ctrlGrpWidth), TMF_ADMINMENU_STD_HEIGHT];
_ctrlLabelLangs ctrlCommit 0;
_ctrlLabelLangs ctrlSetText "Assign players' ACRE2 Babel languages";

if (count acre_sys_core_languages == 0) exitWith {
    _ctrlLabelLangs = _display ctrlCreate [QGVAR(RscText), -1, _ctrlGroup];
    GVAR(utilityTabControls) pushBack _ctrlLabelLangs;
    _ctrlLabelLangs ctrlSetPosition [0, 2.1 * TMF_ADMINMENU_STD_HEIGHT, (0.25 * _ctrlGrpWidth), TMF_ADMINMENU_STD_HEIGHT];
    _ctrlLabelLangs ctrlCommit 0;
    _ctrlLabelLangs ctrlSetText "No languages configured for mission!";
};

private _langY = 2.1 * TMF_ADMINMENU_STD_HEIGHT;
private _langComboCtrls = [];

{
    _x params ["_key", "_name"];

    private _ctrlLabelName = _display ctrlCreate [QGVAR(RscText), -1, _ctrlGroup];
    GVAR(utilityTabControls) pushBack _ctrlLabelName;
    _ctrlLabelName ctrlSetPosition [0, _langY + (_forEachIndex * (1.1 * TMF_ADMINMENU_STD_HEIGHT)), (0.25 * _ctrlGrpWidth), TMF_ADMINMENU_STD_HEIGHT];
    _ctrlLabelName ctrlCommit 0;
    _ctrlLabelName ctrlSetText _name;

    private _ctrlComboAction = _display ctrlCreate [QGVAR(RscCombo), -1, _ctrlGroup];
    GVAR(utilityTabControls) pushBack _ctrlComboAction;
    _langComboCtrls pushBack _ctrlComboAction;
    _ctrlComboAction ctrlSetPosition [0.5 * _ctrlGrpWidth, _langY + (_forEachIndex * (1.1 * TMF_ADMINMENU_STD_HEIGHT)), 0.5 * _ctrlGrpWidth, TMF_ADMINMENU_STD_HEIGHT];
    _ctrlComboAction ctrlCommit 0;

    _ctrlComboAction lbSetValue [(_ctrlComboAction lbAdd "Don't Change"), -1];
    _ctrlComboAction lbSetValue [(_ctrlComboAction lbAdd "Yes"), 1];
    _ctrlComboAction lbSetValue [(_ctrlComboAction lbAdd "No"), 0];
    _ctrlComboAction lbSetCurSel 0;
    _ctrlComboAction setVariable [QGVAR(association), _key];
} forEach acre_sys_core_languages;

private _ctrlButton = _display ctrlCreate [QGVAR(RscButtonMenu), -1, _ctrlGroup];
GVAR(utilityTabControls) pushBack _ctrlButton;
_ctrlButton ctrlSetPosition [_ctrlGrpWidth * 0.8, _ctrlGrpHeight - TMF_ADMINMENU_STD_HEIGHT, _ctrlGrpWidth * 0.2, TMF_ADMINMENU_STD_HEIGHT];
_ctrlButton ctrlCommit 0;
_ctrlButton ctrlSetText "Assign Languages";
_ctrlButton setVariable [QGVAR(association), _langComboCtrls];
_ctrlButton ctrlAddEventHandler ["ButtonClick", {
    params ["_ctrlButton"];
    _ctrlButton call FUNC(debounceButton);

    private _langComboCtrls = _ctrlButton getVariable [QGVAR(association), []];
    private _langsToAdd = [];
    private _langsToRemove = [];

    {
        private _lang = _x getVariable [QGVAR(association), ""];

        switch (_x lbValue lbCurSel _x) do {
            case 0: { _langsToRemove pushBack _lang; };
            case 1: { _langsToAdd pushBack _lang; };
            default {};
        };
    } forEach _langComboCtrls;

    if (count _langsToAdd == 0) then {
        if (count _langsToRemove == 0) exitWith {
            systemChat "[TMF Admin Menu] No changes selected";
        };

        systemChat "[TMF Admin Menu] Any change that would leave players with no language to speak will fail";
    };

    [_langsToAdd, _langsToRemove] remoteExecCall [QFUNC(modal_ACRE2Languages_assign), GVAR(utilityData)];

    systemChat format ["[TMF Admin Menu] Assigned ACRE2 languages to %1 player(s)", count GVAR(utilityData)];
    [["%1 Assigned ACRE2 Languages to %2",profileName,GVAR(utilityData) apply {name _x}],false,"[TMF Admin Menu] "] call FUNC(log);
}];
