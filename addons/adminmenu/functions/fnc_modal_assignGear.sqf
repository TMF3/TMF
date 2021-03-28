#include "\x\tmf\addons\adminmenu\script_component.hpp"
#include "\a3\ui_f\hpp\defineCommonGrids.inc"

disableSerialization;
params ["_ctrlGroup"];

(ctrlPosition _ctrlGroup) params ["", "", "_ctrlGrpWidth", "_ctrlGrpHeight"];

private _ctrlCheckFaction = _display ctrlCreate ["RscCheckBox", -1, _ctrlGroup];
GVAR(utilityTabControls) = [_ctrlCheckFaction];
_ctrlCheckFaction ctrlSetPosition [0, 0, GUI_GRID_W, GUI_GRID_H];
_ctrlCheckFaction ctrlCommit 0;

private _ctrlLabelFaction = _display ctrlCreate [QGVAR(RscTextLarge), -1, _ctrlGroup];
GVAR(utilityTabControls) pushBack _ctrlLabelFaction;
_ctrlLabelFaction ctrlSetPosition [GUI_GRID_W, 0, (0.25 * _ctrlGrpWidth), GUI_GRID_H];
_ctrlLabelFaction ctrlCommit 0;
_ctrlLabelFaction ctrlSetText "Change Faction";

private _ctrlCheckFromMission = _display ctrlCreate ["RscCheckBox", -1, _ctrlGroup];
GVAR(utilityTabControls) pushBack _ctrlCheckFromMission;
_ctrlCheckFromMission ctrlSetPosition [(2 * GUI_GRID_W) + (0.25 * _ctrlGrpWidth), 0, GUI_GRID_W, GUI_GRID_H];
_ctrlCheckFromMission ctrlCommit 0;
_ctrlCheckFromMission ctrlAddEventHandler ["CheckedChanged", FUNC(modal_assignGear_listboxFactions)];

private _ctrlLabelFromMission = _display ctrlCreate [QGVAR(RscText), -1, _ctrlGroup];
GVAR(utilityTabControls) pushBack _ctrlLabelFromMission;
_ctrlLabelFromMission ctrlSetPosition [(3 * GUI_GRID_W) + (0.25 * _ctrlGrpWidth), 0, (0.6 * _ctrlGrpWidth), GUI_GRID_H];
_ctrlLabelFromMission ctrlCommit 0;
_ctrlLabelFromMission ctrlSetText "List factions present in scenario only";

private _ctrlComboFaction = _display ctrlCreate [QGVAR(RscCombo), -1, _ctrlGroup];
GVAR(utilityTabControls) pushBack _ctrlComboFaction;
_ctrlComboFaction ctrlSetPosition [(0.1 * GUI_GRID_W), (1.1 * GUI_GRID_H), _ctrlGrpWidth - (0.2 * GUI_GRID_W), GUI_GRID_H];
_ctrlComboFaction ctrlCommit 0;
_ctrlCheckFromMission setVariable [QGVAR(association), _ctrlComboFaction];
_ctrlComboFaction ctrlAddEventHandler ["LBSelChanged", FUNC(modal_assignGear_listboxRoles)];

private _ctrlLabelBracketNumbers = _display ctrlCreate [QGVAR(RscText), -1, _ctrlGroup];
GVAR(utilityTabControls) pushBack _ctrlLabelBracketNumbers;
_ctrlLabelBracketNumbers ctrlSetPosition [0, (2.2 * GUI_GRID_H), _ctrlGrpWidth, GUI_GRID_H];
_ctrlLabelBracketNumbers ctrlCommit 0;
_ctrlLabelBracketNumbers ctrlSetText "* denotes a mission config loadout. To change role, tick the adjacent checkbox.";

private _ctrlLabelRoles = _display ctrlCreate [QGVAR(RscTextLarge), -1, _ctrlGroup];
GVAR(utilityTabControls) pushBack _ctrlLabelRoles;
_ctrlLabelRoles ctrlSetPosition [0, (4.2 * GUI_GRID_H), (0.25 * _ctrlGrpWidth), GUI_GRID_H];
_ctrlLabelRoles ctrlCommit 0;
_ctrlLabelRoles ctrlSetText "Change Roles";

private _ctrlGrpRolesWidth = _ctrlGrpWidth - (0.2 * GUI_GRID_W);
private _ctrlGrpRoles = _display ctrlCreate ["RscControlsGroup", -1, _ctrlGroup];
GVAR(utilityTabControls) pushBack _ctrlGrpRoles;
_ctrlGrpRoles ctrlSetPosition [(0.1 * GUI_GRID_W), (5.3 * GUI_GRID_H), _ctrlGrpRolesWidth, _ctrlGrpHeight - (6.4 * GUI_GRID_H)];
_ctrlGrpRoles ctrlCommit 0;
_ctrlGrpRoles ctrlSetText "Number within brackets tell how many players use the loadout";

GVAR(utility_assigngear_rolectrls) = [];
private _ctrlLabelPlayerW = 0.4 * _ctrlGrpRolesWidth;
private _ctrlComboRoleX = 0.5 * _ctrlGrpRolesWidth;
private _ctrlComboRoleW = (0.5 * _ctrlGrpRolesWidth) - GUI_GRID_W;
private _ctrlCheckChangeX = _ctrlGrpRolesWidth - GUI_GRID_W;
{
    private _ctrlLineY = _forEachIndex * (1.1 * GUI_GRID_H);

    private _ctrlLabelPlayer = _display ctrlCreate [QGVAR(RscText), -1, _ctrlGrpRoles];
    GVAR(utilityTabControls) pushBack _ctrlLabelPlayer;
    _ctrlLabelPlayer ctrlSetPosition [0, _ctrlLineY, _ctrlLabelPlayerW, GUI_GRID_H];
    _ctrlLabelPlayer ctrlCommit 0;
    _ctrlLabelPlayer ctrlSetText format ["%1 [%2]", name _x, _x getVariable [QEGVAR(assigngear,role), "no role"]];

    private _ctrlComboRole = _display ctrlCreate [QGVAR(RscCombo), -1, _ctrlGrpRoles];
    GVAR(utilityTabControls) pushBack _ctrlComboRole;
    _ctrlComboRole ctrlSetPosition [_ctrlComboRoleX, _ctrlLineY, _ctrlComboRoleW, GUI_GRID_H];
    _ctrlComboRole ctrlCommit 0;

    private _ctrlCheckChange = _display ctrlCreate ["RscCheckBox", -1, _ctrlGrpRoles];
    GVAR(utilityTabControls) pushBack _ctrlCheckChange;
    GVAR(utility_assigngear_rolectrls) pushBack _ctrlCheckChange;
    _ctrlCheckChange ctrlSetPosition [_ctrlCheckChangeX, _ctrlLineY, GUI_GRID_W, GUI_GRID_H];
    _ctrlCheckChange ctrlCommit 0;
    _ctrlCheckChange setVariable [QGVAR(association), [_x, _ctrlComboRole]];
} forEach GVAR(utilityData);

private _ctrlButton = _display ctrlCreate [QGVAR(RscButtonMenu), -1, _ctrlGroup];
GVAR(utilityTabControls) pushBack _ctrlButton;
_ctrlButton ctrlSetPosition [_ctrlGrpWidth * 0.8, _ctrlGrpHeight - GUI_GRID_H, _ctrlGrpWidth * 0.2, GUI_GRID_H];
_ctrlButton ctrlCommit 0;
_ctrlButton ctrlSetText "Assign Gear";
_ctrlButton setVariable [QGVAR(association), [_ctrlCheckFaction, _ctrlComboFaction]];
_ctrlButton ctrlAddEventHandler ["ButtonClick", {
    params ["_ctrlButton"];
    _ctrlButton call FUNC(debounceButton);

    (_ctrlButton getVariable [QGVAR(association), [controlNull, controlNull]]) params ["_ctrlCheckFaction", "_ctrlComboFaction"];
    private _setFaction = cbChecked _ctrlCheckFaction;
    private _selectedFaction = _ctrlComboFaction lbData (lbCurSel _ctrlComboFaction);

    {
        (_x getVariable [QGVAR(association), [objNull, controlNull]]) params ["_player", "_ctrlComboRole"];

        private _playerRole = _player getVariable [QEGVAR(assignGear,role), ""];
        if (cbChecked _x || _playerRole isEqualTo "") then {
            _playerRole = _ctrlComboRole lbData (lbCurSel _ctrlComboRole);
            if (_playerRole isEqualTo "") then {
                _playerRole = "r";
            };
        };

        private _playerFaction = _player getVariable [QEGVAR(assignGear,faction), ""];
        if (_setFaction || _playerFaction isEqualTo "") then {
            _playerFaction = _selectedFaction;
        };

        [_player, _playerFaction, _playerRole] remoteExecCall [QEFUNC(assignGear,assignGear), _player];
    } forEach GVAR(utility_assigngear_rolectrls);

    systemChat format ["[TMF Admin Menu] Assigned gear to %1 players", count GVAR(utility_assigngear_rolectrls)];
}];

[_ctrlCheckFromMission, false] call FUNC(modal_assignGear_listboxFactions);
