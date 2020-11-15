#include "\x\tmf\addons\adminmenu\script_component.hpp"
#include "\a3\ui_f\hpp\defineCommonGrids.inc"

disableSerialization;
params ["_ctrlGroup"];

(ctrlPosition _ctrlGroup) params ["", "", "_ctrlGrpWidth", "_ctrlGrpHeight"];

private _display = uiNamespace getVariable [QGVAR(modalDisplay), displayNull];
private _ctrlEdit = _display ctrlCreate [QGVAR(RscEditMultiCode), -1, _ctrlGroup];
_ctrlEdit ctrlSetPosition [0.1 * GUI_GRID_W, 1.1 * GUI_GRID_H, _ctrlGrpWidth - (0.2 * GUI_GRID_W), _ctrlGrpHeight - (2.3 * GUI_GRID_H)];
_ctrlEdit ctrlCommit 0;
_ctrlEdit ctrlSetText (missionNamespace getVariable [QGVAR(utility_runcode_last), ""]);

private _ctrlHintEdit = _display ctrlCreate [QGVAR(RscText), -1, _ctrlGroup];
_ctrlHintEdit ctrlSetPosition [0, 0, _ctrlGrpWidth, GUI_GRID_H];
_ctrlHintEdit ctrlCommit 0;
_ctrlHintEdit ctrlSetText "'_this' is the targetted player object";

private _bottomY = _ctrlGrpHeight - GUI_GRID_H;

private _ctrlHintCombo = _display ctrlCreate [QGVAR(RscText), -1, _ctrlGroup];
_ctrlHintCombo ctrlSetPosition [0, _bottomY, 0.15 * _ctrlGrpWidth, GUI_GRID_H];
_ctrlHintCombo ctrlCommit 0;
_ctrlHintCombo ctrlSetText "Execute on:";

private _ctrlCombo = _display ctrlCreate [QGVAR(RscCombo), -1, _ctrlGroup];
_ctrlCombo ctrlSetPosition [0.15 * _ctrlGrpWidth, _bottomY, 0.25 * _ctrlGrpWidth, GUI_GRID_H];
_ctrlCombo ctrlCommit 0;
_ctrlCombo lbAdd "Your Client";
_ctrlCombo lbAdd "Targets' Clients";
_ctrlCombo lbAdd "Server";
_ctrlCombo lbAdd "All Clients and Server";
_ctrlCombo lbSetCurSel 0;

private _ctrlButton = _display ctrlCreate [QGVAR(RscButtonMenu), -1, _ctrlGroup];
_ctrlButton ctrlSetPosition [0.8 * _ctrlGrpWidth, _bottomY, 0.2 * _ctrlGrpWidth, GUI_GRID_H];
_ctrlButton ctrlCommit 0;
_ctrlButton ctrlSetText "Execute";
_ctrlButton setVariable [QGVAR(association), [_ctrlEdit, _ctrlCombo]];
_ctrlButton ctrlAddEventHandler ["buttonClick", {
    params ["_ctrlButton"];
    (_ctrlButton getVariable [QGVAR(association), [controlNull, controlNull]]) params ["_ctrlEdit", "_ctrlCombo"];
    _ctrlButton call FUNC(debounceButton);

    private _editText = ctrlText _ctrlEdit;
    if (_editText isEqualTo "") then {
        systemChat "[TMF Admin Menu] Code field is empty";
    } else {
        private _code = compile _editText;
        private _selected = lbCurSel _ctrlCombo;
        private _target = call {
            if (_selected isEqualTo 0) exitWith {-1};
            if (_selected isEqualTo 1) exitWith {GVAR(utilityData)};
            if (_selected isEqualTo 2) exitWith {2};
            0
        };

        if (_target isEqualTo -1) then {
            {
                _x call _code;
            } forEach GVAR(utilityData);
        } else {
            if (_target isEqualType []) then {
                [compile _editText, {
                    params ["_code"];
                    player call _code;
                }] remoteExec ["call", GVAR(utilityData)];
            } else {
                [[GVAR(utilityData), compile _editText], {
                    params ["_players", "_code"];
                    {
                        _x call _code;
                    } forEach _players;
                }] remoteExec ["call", _target];
            };
        };

        systemChat format ["[TMF Admin Menu] Code was executed on %1", _ctrlCombo lbText (lbCurSel _ctrlCombo)];
        [format ["%1 Executed code:%2, on %3",profileName,_code,_target],false,"Admin Menu"] call FUNC(log);
        GVAR(utility_runcode_last) = _editText;
    };
}];
