#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_display"];


// rewrite laters


private _exportAAR = cbChecked (_display displayCtrl IDC_TMF_ADMINMENU_ENDM_EXPORTAAR);
// do something to export AAR ...

// Determine what type to use from which checkbox is ticked
private _endingType = IDC_TMF_ADMINMENU_ENDM_FROMMISSION;
if (cbChecked (_display displayCtrl IDC_TMF_ADMINMENU_ENDM_SIDESPECIFIC)) then {
    _endingType = IDC_TMF_ADMINMENU_ENDM_SIDESPECIFIC;
} else {
    if (cbChecked (_display displayCtrl IDC_TMF_ADMINMENU_ENDM_CUSTOM)) then {
        _endingType = IDC_TMF_ADMINMENU_ENDM_CUSTOM;
    };
};

private _endMissionFunc = [QEFUNC(common,endMission), "BIS_fnc_endMission"] select (isNil QEFUNC(common,endMission));

switch (_endingType) do {
    // Endings from description.ext CfgDebriefing
    case IDC_TMF_ADMINMENU_ENDM_FROMMISSION: {
        private _list = _display displayCtrl IDC_TMF_ADMINMENU_ENDM_LIST;
        private _ending = _list lbData (lbCurSel _list);
        private _isVictory = cbChecked (_display displayCtrl IDC_TMF_ADMINMENU_ENDM_FROMMISSION_ISVICTORY);
        [_value, _isVictory] remoteExec [_endMissionFunc];
    };

    // Per-side endings
    case IDC_TMF_ADMINMENU_ENDM_SIDESPECIFIC: {
        private _isDraw = cbChecked (_display displayCtrl IDC_TMF_ADMINMENU_ENDM_SIDEDRAW);
        if (_isDraw) then {
            "RespawnRoundsTie" remoteExec [_endMissionFunc];
        } else {
            private _winning = [];
            private _sides = [blufor, opfor, resistance, civilian];

            {
                if ((missionNamespace getVariable [_x, 0]) isEqualTo 1) then {
                    _winning pushBack (_sides select _forEachIndex);
                };
            } forEach [QGVAR(endingSideBlufor), QGVAR(endingSideOpfor), QGVAR(endingSideIndependent), QGVAR(endingSideCivilian)];

            [[_endMissionFunc, _winning], {
                //private _ending = ["LOOSER", "WINNER"] select (playerSide in (param [1])); // looser is BI's typo not mine ok
                //_ending call (param [0]);
                private _isVictory = playerSide in (param [1]);
                ["", _isVictory] call (param [0]); // win/lose auto from _isVictory ?
            }] remoteExec ["BIS_fnc_call", -2];

            if (!isServer) then {
                [] remoteExec [_endMissionFunc, 2];
            };
        };
    };

    // Custom text ending
    case IDC_TMF_ADMINMENU_ENDM_CUSTOM: {
        private _title = ctrlText (_display displayCtrl IDC_TMF_ADMINMENU_ENDM_CUSTOM_TITLE);
        private _subtext = ctrlText (_display displayCtrl IDC_TMF_ADMINMENU_ENDM_CUSTOM_SUBTEXT);
        private _isVictory = cbChecked (_display displayCtrl IDC_TMF_ADMINMENU_ENDM_CUSTOM_ISVICTORY);
    };
};
