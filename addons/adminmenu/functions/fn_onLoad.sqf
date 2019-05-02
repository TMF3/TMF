#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_display"];
uiNamespace setVariable [QGVAR(display), _display];

{
    (_display displayCtrl _x) ctrlEnable false;
    (_display displayCtrl _x) ctrlShow false;
} forEach IDCS_TMF_ADMINMENU_UTIL;

if (!isMultiplayer) then {
    (_display displayCtrl IDC_TMF_ADMINMENU_DASH_CURRADMIN) ctrlSetText "none (singleplayer)";
};

// Mission Maker's Notes
private _ctrlMissionNotes = (_display displayCtrl IDC_TMF_ADMINMENU_G_DASH_MISSIONNOTES) controlsGroupCtrl IDC_TMF_ADMINMENU_DASH_MISSIONNOTES;
_ctrlMissionNotes ctrlSetStructuredText parseText "<t size='1.2' color='#FFC04D'>Title</t><br/><t size='1'>Not implemented! Not implemented! Not implemented! Not implemented! Not implemented! Not implemented! Not implemented! Not implemented! Not implemented! Not implemented! Not implemented! Not implemented! Not implemented!</t>";
private _notesPos = ctrlPosition _ctrlMissionNotes;
_notesPos set [3, ctrlTextHeight _ctrlMissionNotes];
_ctrlMissionNotes ctrlSetPosition _notesPos;
_ctrlMissionNotes ctrlCommit 0;

private _ctrlCheckSafestart = _display displayCtrl IDC_TMF_ADMINMENU_DASH_SAFESTART;
(entities QEGVAR(safestart,module)) params [["_safestartModule", objNull, [objNull]]];
if (isNull _safestartModule) then {
    _ctrlCheckSafestart cbSetChecked false;
} else {
    _ctrlCheckSafestart cbSetChecked (_safestartModule getVariable [QEGVAR(safestart,enabled), false]);
};

_ctrlCheckSafestart ctrlAddEventHandler ["CheckedChanged", {
    (entities QEGVAR(safestart,module)) params [["_safestartModule", objNull, [objNull]]];

    if ((param [1]) isEqualTo 0) then {
        if (!isNull _safestartModule) then {
            [_safestartModule] call EFUNC(safestart,end);
        };
    } else {
        if (isNull _safestartModule) then {
            _safestartModule = call EFUNC(safestart,create);
        };

        _safestartModule setVariable ["Duration", -1, true];
        [_safestartModule, allUnits, true] remoteExecCall [QEFUNC(safestart,serverInit), 2];
    };
}];

private _ctrlCheckSpectatorTalk = _display displayCtrl IDC_TMF_ADMINMENU_DASH_SPECTATORTALK;
_ctrlCheckSpectatorTalk cbSetChecked ([player] call acre_api_fnc_isSpectator);
if (alive player) then {
    _ctrlCheckSpectatorTalk ctrlAddEventHandler ["CheckedChanged", {
        params ["", "_state"];
        [_state isEqualTo 1] call acre_api_fnc_setSpectator;
        systemChat format ["[TMF Admin Menu] Spectator talk toggled %1", ["off", "on"] select _state];
    }];
} else {
    _ctrlCheckSpectatorTalk ctrlEnable false;
    _ctrlCheckSpectatorTalk ctrlSetTooltip "Can't toggle when in spectator yourself.";
};

private _ctrl = _display displayCtrl IDC_TMF_ADMINMENU_PMAN_FILTER_STATE;
{
    _ctrl lbAdd _x;
} forEach ["Alive and Dead", "Alive", "Dead"];
_ctrl lbSetCurSel 0;
_ctrl ctrlAddEventHandler ["LBSelChanged", format ["[ctrlParent (param [0])] call %1;", QFUNC(playerManagement_filter)]];

_ctrl = _display displayCtrl IDC_TMF_ADMINMENU_PMAN_FILTER_SIDE;
{
    _x params ["_icon", "_text"];
    _ctrl lbAdd _text;
    _ctrl lbSetPicture [_forEachIndex, _icon];
} forEach [
    ["\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\heal_ca.paa", "All Sides"],
    ["\a3\ui_f\data\Map\Diary\Icons\playerWest_ca.paa", "BLUFOR"], // fetch from profile vars
    ["\a3\ui_f\data\Map\Diary\Icons\playerEast_ca.paa", "OPFOR"],
    ["\a3\ui_f\data\Map\Diary\Icons\playerGuer_ca.paa", "Independent"],
    ["\a3\ui_f\data\Map\Diary\Icons\playerCiv_ca.paa", "Civilian"]
];
_ctrl lbSetCurSel 0;
_ctrl ctrlAddEventHandler ["LBSelChanged", format ["[ctrlParent (param [0])] call %1;", QFUNC(playerManagement_filter)]];

// Register client as server FPS receiver
[true] remoteExec [QFUNC(fpsHandlerServer), 2];

// Show dashboard when opening the admin menu, hide other tabs
[_display] call FUNC(selectTab);
