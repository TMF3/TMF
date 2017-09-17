#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_ctrlGroup"];

(ctrlPosition _ctrlGroup) params ["", "", "_ctrlGrpWidth", "_ctrlGrpHeight"];

private _display = uiNamespace getVariable [QGVAR(modalDisplay), displayNull];
private _ctrlEdit = _display ctrlCreate [QGVAR(RscEditMultiCode), -1, _ctrlGroup];
_ctrlEdit ctrlSetPosition [0.1 * TMF_ADMINMENU_STD_WIDTH, 1.1 * TMF_ADMINMENU_STD_HEIGHT, _ctrlGrpWidth - (0.2 * TMF_ADMINMENU_STD_WIDTH), _ctrlGrpHeight - (2.3 * TMF_ADMINMENU_STD_HEIGHT)];
_ctrlEdit ctrlCommit 0;
_ctrlEdit ctrlSetText (missionNamespace getVariable [QGVAR(utility_runcode_last), ""]);

private _ctrlHintEdit = _display ctrlCreate [QGVAR(RscText), -1, _ctrlGroup];
_ctrlHintEdit ctrlSetPosition [0, 0, _ctrlGrpWidth, TMF_ADMINMENU_STD_HEIGHT];
_ctrlHintEdit ctrlCommit 0;
_ctrlHintEdit ctrlSetText "'_this' is the targetted player object";

private _bottomY = _ctrlGrpHeight - TMF_ADMINMENU_STD_HEIGHT;

private _ctrlHintCombo = _display ctrlCreate [QGVAR(RscText), -1, _ctrlGroup];
_ctrlHintCombo ctrlSetPosition [0, _bottomY, 0.15 * _ctrlGrpWidth, TMF_ADMINMENU_STD_HEIGHT];
_ctrlHintCombo ctrlCommit 0;
_ctrlHintCombo ctrlSetText "Execute on:";

private _ctrlCombo = _display ctrlCreate [QGVAR(RscCombo), -1, _ctrlGroup];
_ctrlCombo ctrlSetPosition [0.15 * _ctrlGrpWidth, _bottomY, 0.25 * _ctrlGrpWidth, TMF_ADMINMENU_STD_HEIGHT];
_ctrlCombo ctrlCommit 0;
_ctrlCombo lbAdd "Your Client";
_ctrlCombo lbAdd "Targets' Clients";
_ctrlCombo lbAdd "Server";
_ctrlCombo lbAdd "All Clients and Server";
_ctrlCombo lbSetCurSel 0;

private _ctrlButton = _display ctrlCreate [QGVAR(RscButtonMenu), -1, _ctrlGroup];
_ctrlButton ctrlSetPosition [0.8 * _ctrlGrpWidth, _bottomY, 0.2 * _ctrlGrpWidth, TMF_ADMINMENU_STD_HEIGHT];
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
        private _target = [clientOwner, _x, 2, 0] select (lbCurSel _ctrlCombo);
        if (_target isEqualType objNull) then { // individual remoteExec's
            {
                [_x, compile _editText] remoteExec ["BIS_fnc_call", _target];
            } forEach GVAR(utilityData);
        } else { // remoteExec once
            [[GVAR(utilityData), compile _editText], {
                params ["_data", "_code"];
                {
                    _x call _code;
                } forEach _data;
            }] remoteExec ["BIS_fnc_call", _target];
        };

        systemChat format ["[TMF Admin Menu] Code was executed on %1", _ctrlCombo lbText (lbCurSel _ctrlCombo)];
        GVAR(utility_runcode_last) = _editText;
    };
}];
