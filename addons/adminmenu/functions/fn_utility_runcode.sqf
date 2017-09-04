#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_display", "_ctrlGroup"];

private _ctrlGrpPos = ctrlPosition _ctrlGroup;
_ctrlGrpPos params ["", "", "_ctrlGrpWidth", "_ctrlGrpHeight"];

private _ctrlEdit = _display ctrlCreate [QGVAR(RscEditMultiCode), -1, _ctrlGroup];
GVAR(utilityTabControls) = [_ctrlEdit];
_ctrlEdit ctrlSetPosition [0.1 * TMF_ADMINMENU_STD_WIDTH, 1.1 * TMF_ADMINMENU_STD_HEIGHT, _ctrlGrpWidth - (0.2 * TMF_ADMINMENU_STD_WIDTH), _ctrlGrpHeight - (2.3 * TMF_ADMINMENU_STD_HEIGHT)];
_ctrlEdit ctrlCommit 0;

private _ctrlHintEdit = _display ctrlCreate [QGVAR(RscText), -1, _ctrlGroup];
GVAR(utilityTabControls) pushBack _ctrlHintEdit;
_ctrlHintEdit ctrlSetPosition [0, 0, _ctrlGrpWidth, TMF_ADMINMENU_STD_HEIGHT];
_ctrlHintEdit ctrlCommit 0;
_ctrlHintEdit ctrlSetText "'_this' is the targetted player object";

private _newW = 0.25 * _ctrlGrpWidth;
private _newY = _ctrlGrpHeight - TMF_ADMINMENU_STD_HEIGHT;

private _ctrlHintCombo = _display ctrlCreate [QGVAR(RscText), -1, _ctrlGroup];
GVAR(utilityTabControls) pushBack _ctrlHintCombo;
_ctrlHintCombo ctrlSetPosition [0, _newY, _newW, TMF_ADMINMENU_STD_HEIGHT];
_ctrlHintCombo ctrlCommit 0;
_ctrlHintCombo ctrlSetText "Execute Code on...";

private _ctrlCombo = _display ctrlCreate [QGVAR(RscCombo), -1, _ctrlGroup];
GVAR(utilityTabControls) pushBack _ctrlCombo;
_ctrlCombo ctrlSetPosition [_newW, _newY, _newW, TMF_ADMINMENU_STD_HEIGHT];
_ctrlCombo ctrlCommit 0;
_ctrlCombo lbAdd "Your Client";
_ctrlCombo lbAdd "Targets' Clients";
_ctrlCombo lbAdd "Server";
_ctrlCombo lbAdd "All Clients and Server";
_ctrlCombo lbSetCurSel 0;

private _ctrlButton = _display ctrlCreate [QGVAR(RscButtonMenu), -1, _ctrlGroup];
GVAR(utilityTabControls) pushBack _ctrlButton;
_ctrlButton ctrlSetPosition [3 * _newW, _newY, _newW, TMF_ADMINMENU_STD_HEIGHT];
_ctrlButton ctrlCommit 0;
_ctrlButton ctrlSetText "Execute";
_ctrlButton ctrlAddEventHandler ["buttonClick", {
    params ["_button"];
    _button ctrlEnable false;

    private _foo = [_button] spawn {
        disableSerialization;
        params ["_button"];
        uiSleep 0.5;
        _button ctrlEnable true;
    };

    private _editText = ctrlText (GVAR(utilityTabControls) select 0);
    if (_editText isEqualTo "") then {
        systemChat "[TMF Admin Menu] Code field is empty";
    } else {
        private _combo = GVAR(utilityTabControls) select 3;
        private _target = [clientOwner, _x, 2, 0] select (lbCurSel _combo);
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

        systemChat format ["[TMF Admin Menu] Code was executed on %1", _combo lbText (lbCurSel _combo)];
    };
}];
