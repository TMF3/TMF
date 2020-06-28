#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_display"];

// Per-side endings
if (cbChecked (_display displayCtrl IDC_TMF_ADMINMENU_ENDM_SIDESPECIFIC)) exitWith {
    private _isDraw = cbChecked (_display displayCtrl IDC_TMF_ADMINMENU_ENDM_SIDEDRAW);
    if (_isDraw) then {
        [QGVAR(draw)] remoteExec [QEFUNC(common,endMission)];
    } else {
        private _winners = [];
        if ((missionNamespace getVariable [QGVAR(DOUBLES(ending,blufor)), 0]) isEqualTo 1) then {
            _winners pushBack blufor;
        };
        if ((missionNamespace getVariable [QGVAR(DOUBLES(ending,opfor)), 0]) isEqualTo 1) then {
            _winners pushBack opfor;
        };
        if ((missionNamespace getVariable [QGVAR(DOUBLES(ending,resistance)), 0]) isEqualTo 1) then {
            _winners pushBack resistance;
        };
        if ((missionNamespace getVariable [QGVAR(DOUBLES(ending,civilian)), 0]) isEqualTo 1) then {
            _winners pushBack civilian;
        };

        [_winners] remoteExec [QFUNC(endMission_sideSpecificLocal)];
        [format ["%1 Ended Mission, Winners: %2",profileName, _winners],false,"Admin Menu"] call FUNC(log);
    };
};

// Custom text ending
if (cbChecked (_display displayCtrl IDC_TMF_ADMINMENU_ENDM_CUSTOM)) exitWith {
    private _title = ctrlText (_display displayCtrl IDC_TMF_ADMINMENU_ENDM_CUSTOM_TITLE);
    private _subtext = ctrlText (_display displayCtrl IDC_TMF_ADMINMENU_ENDM_CUSTOM_SUBTEXT);
    missionNamespace setVariable [QEGVAR(common,endMissionText), [_title, _subtext], true];

    private _isDefeat = cbChecked (_display displayCtrl IDC_TMF_ADMINMENU_ENDM_CUSTOM_ISDEFEAT);
    [[QGVAR(victory), QGVAR(defeat)] select _isDefeat, !_isDefeat] remoteExec [QEFUNC(common,endMission)];
    [format ["%1 Ended Mission, Title: %2, subText: %3, isDefeat: %4",profileName, _title, _subtext, _isDefeat],false,"Admin Menu"] call FUNC(log);
};

// Endings from description.ext CfgDebriefing
private _list = _display displayCtrl IDC_TMF_ADMINMENU_ENDM_LIST;
private _ending = _list lbData (lbCurSel _list);
private _isDefeat = cbChecked (_display displayCtrl IDC_TMF_ADMINMENU_ENDM_FROMMISSION_ISDEFEAT);
[_ending, !_isDefeat] remoteExec [QEFUNC(common,endMission)];
[format ["%1 Ended Mission, Endtype: %2, isDefeat: %3",profileName, _ending, _isDefeat],false,"Admin Menu"] call FUNC(log);
