#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_ctrlGroup"];

(ctrlPosition _ctrlGroup) params ["", "", "_ctrlGrpWidth", "_ctrlGrpHeight"];

private _display = uiNamespace getVariable [QGVAR(modalDisplay), displayNull];
private _ctrlEdit = _display ctrlCreate ["RscEditMulti", -1, _ctrlGroup];
private _ctrlEditPos = [0.1 * TMF_ADMINMENU_STD_WIDTH, 0.1 * TMF_ADMINMENU_STD_HEIGHT, _ctrlGrpWidth - (0.2 * TMF_ADMINMENU_STD_WIDTH), _ctrlGrpHeight - (1.3 * TMF_ADMINMENU_STD_HEIGHT)];
_ctrlEdit ctrlSetPosition _ctrlEditPos;
_ctrlEdit ctrlCommit 0;
_ctrlEdit ctrlSetText (missionNamespace getVariable [QGVAR(utility_message_last), ""]);

private _ctrlCombo = _display ctrlCreate [QGVAR(RscCombo), -1, _ctrlGroup];
_ctrlCombo ctrlSetPosition [0.1 * TMF_ADMINMENU_STD_WIDTH, _ctrlGrpHeight - TMF_ADMINMENU_STD_HEIGHT, _ctrlGrpWidth * 0.3, TMF_ADMINMENU_STD_HEIGHT];
_ctrlCombo ctrlCommit 0;
_ctrlCombo lbAdd "Show in Chat";
_ctrlCombo lbAdd "Show in Hint";
_ctrlCombo lbAdd "Show in Subtitle from 'PAPA BEAR'";
_ctrlCombo lbSetCurSel 0;

private _ctrlButtonPreview = _display ctrlCreate [QGVAR(RscButtonMenu), -1, _ctrlGroup];
_ctrlButtonPreview ctrlSetPosition [(_ctrlGrpWidth * 0.7) - (0.2 * TMF_ADMINMENU_STD_WIDTH), _ctrlGrpHeight - TMF_ADMINMENU_STD_HEIGHT, (_ctrlGrpWidth * 0.15), TMF_ADMINMENU_STD_HEIGHT];
_ctrlButtonPreview ctrlCommit 0;
_ctrlButtonPreview ctrlSetText "Preview";
_ctrlButtonPreview setVariable [QGVAR(association), [_ctrlEdit, _ctrlCombo]];
_ctrlButtonPreview ctrlAddEventHandler ["buttonClick", {
    params ["_ctrlButton"];
    (_ctrlButton getVariable [QGVAR(association), [controlNull, controlNull]]) params ["_ctrlEdit", "_ctrlCombo"];
    _ctrlButton call FUNC(debounceButton);

    private _editText = ctrlText _ctrlEdit;

    if (_editText isEqualTo "") then {
        systemChat "[TMF Admin Menu] Message can't be empty";
    } else {
        private _venue = ["systemChat", "hint", QFUNC(showSubtitle)] select (lbCurSel _ctrlCombo);

        if (_venue isEqualTo QFUNC(showSubtitle)) then {
            ["PAPA BEAR", _editText] call FUNC(showSubtitle);
        } else {
            if (_venue isEqualTo "hint") then {
                hint format ["\n\n%1", _editText];
            } else {
                systemChat format ["[TMF Admin Message] %1", _editText];
            };
        };

        systemChat "[TMF Admin Menu] Message previewed";
    };
}];

private _ctrlButtonCommit = _display ctrlCreate [QGVAR(RscButtonMenu), -1, _ctrlGroup];
_ctrlButtonCommit ctrlSetPosition [(_ctrlGrpWidth * 0.85), _ctrlGrpHeight - TMF_ADMINMENU_STD_HEIGHT, (_ctrlGrpWidth * 0.15) - (0.1 * TMF_ADMINMENU_STD_WIDTH), TMF_ADMINMENU_STD_HEIGHT];
_ctrlButtonCommit ctrlCommit 0;
_ctrlButtonCommit ctrlSetText "Send Message";
_ctrlButtonCommit setVariable [QGVAR(association), [_ctrlEdit, _ctrlCombo]];
_ctrlButtonCommit ctrlAddEventHandler ["buttonClick", {
    params ["_ctrlButton"];
    (_ctrlButton getVariable [QGVAR(association), [controlNull, controlNull]]) params ["_ctrlEdit", "_ctrlCombo"];
    _ctrlButton call FUNC(debounceButton);

    private _editText = ctrlText _ctrlEdit;
    GVAR(utility_message_last) = _editText; // _editText may receive local edits

    if (_editText isEqualTo "") then {
        systemChat "[TMF Admin Menu] Message can't be empty";
    } else {
        private _venue = ["systemChat", "hint", QFUNC(showSubtitle)] select (lbCurSel _ctrlCombo);

        if (_venue isEqualTo QFUNC(showSubtitle)) then {
            ["PAPA BEAR", _editText] remoteExec [_venue, GVAR(utilityData)];
        } else {
            if (_venue isEqualTo "hint") then {
                _editText = format ["\n\n%1", _editText];
            };
            (format ["[TMF Admin Message] %1", _editText]) remoteExec [_venue, GVAR(utilityData)];
        };

        systemChat "[TMF Admin Menu] Message sent to player(s)";
        [format ["%1 Sent message: ""%2"", via venue: ""%3"", to: %4",profileName,_editText,_venue,GVAR(utilityData) apply {name _x}],false,"Admin Menu"] call FUNC(log);
    };
}];
