#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_ctrlGroup"];

GVAR(utility_teleport_toggle) = false;

(ctrlPosition _ctrlGroup) params ["_ctrlGrpX", "_ctrlGrpY", "_ctrlGrpWidth", "_ctrlGrpHeight"];
_ctrlGroup ctrlEnable false;

private _display = uiNamespace getVariable [QGVAR(modalDisplay), displayNull];
private _ctrlMap = _display ctrlCreate ["RscMapControl", -1];
_ctrlMap ctrlSetPosition [_ctrlGrpX, _ctrlGrpY, _ctrlGrpWidth, _ctrlGrpHeight - (2.2 * TMF_ADMINMENU_STD_HEIGHT)];
_ctrlMap ctrlCommit 0;
_ctrlMap ctrlAddEventHandler ["mouseButtonClick", {
    params ["_ctrlMap", "", "_pos_x", "_pos_y"];

    private _toggle = missionNamespace getVariable [QGVAR(utility_teleport_toggle), false];
    if (_toggle) then {
        GVAR(utility_teleport_toggle) = !_toggle;
        (_ctrlMap getVariable [QGVAR(association), controlNull]) ctrlSetText (["Enable Teleport", "Disable Teleport"] select GVAR(utility_teleport_toggle));

        private _pos = (_ctrlMap ctrlMapScreenToWorld [_pos_x, _pos_y]) findEmptyPosition [0, 25];
        {
            _x setPos _pos;
            "[TMF Admin Menu] You were teleported" remoteExec ["systemChat", _x];
        } forEach GVAR(utilityData);

        systemChat format ["[TMF Admin Menu] Teleported %1 players", count GVAR(utilityData)];
    };
}];
_ctrlMap ctrlAddEventHandler ["draw", {
    params ["_ctrlMap"];
    private _units = switchableUnits;
    _units append playableUnits;
    private _pos = [];
    {
        if ((missionNamespace getVariable [QGVAR(teleport_mapDrawAllSides), 0]) isEqualTo 1 || (side _x) isEqualTo (side player)) then {
            _pos = getPos _x;
            _ctrlMap drawIcon ["\a3\ui_f\data\Map\Markers\Military\dot_CA.paa", [0,0,0,1], _pos, 24, 24, 0];
            _ctrlMap drawIcon ["\a3\ui_f\data\Map\Markers\Military\dot_CA.paa", (side _x) call FUNC(sideToColor), _pos, 20, 20, 0];
        };
    } forEach _units;
}];

private _ctrlCheckDrawAllSides = _display ctrlCreate ["RscCheckBox", -1];
_ctrlCheckDrawAllSides ctrlSetPosition [_ctrlGrpX, _ctrlGrpY + _ctrlGrpHeight - (2.2 * TMF_ADMINMENU_STD_HEIGHT), TMF_ADMINMENU_STD_WIDTH, TMF_ADMINMENU_STD_HEIGHT];
_ctrlCheckDrawAllSides ctrlCommit 0;
_ctrlCheckDrawAllSides ctrlAddEventHandler ["CheckedChanged", {
    GVAR(teleport_mapDrawAllSides) = param [1];
}];

private _ctrlLabelDrawAllSides = _display ctrlCreate [QGVAR(RscText), -1];
_ctrlLabelDrawAllSides ctrlSetPosition [_ctrlGrpX + TMF_ADMINMENU_STD_WIDTH, _ctrlGrpY + _ctrlGrpHeight - (2.2 * TMF_ADMINMENU_STD_HEIGHT), _ctrlGrpWidth - TMF_ADMINMENU_STD_WIDTH, TMF_ADMINMENU_STD_HEIGHT];
_ctrlLabelDrawAllSides ctrlCommit 0;
_ctrlLabelDrawAllSides ctrlSetText "Draw enemy players on map";

private _ctrlHint = _display ctrlCreate [QGVAR(RscText), -1];
_ctrlHint ctrlSetPosition [_ctrlGrpX, _ctrlGrpY + _ctrlGrpHeight - TMF_ADMINMENU_STD_HEIGHT, 0.8 * _ctrlGrpWidth, TMF_ADMINMENU_STD_HEIGHT];
_ctrlHint ctrlCommit 0;
_ctrlHint ctrlSetText "After locating the destination area, press the Enable Teleport button and then click the desired location on the map.";

private _ctrlButton = _display ctrlCreate [QGVAR(RscButtonMenu), -1];
_ctrlButton ctrlSetPosition [_ctrlGrpX + 0.8 * _ctrlGrpWidth, _ctrlGrpY + _ctrlGrpHeight - TMF_ADMINMENU_STD_HEIGHT, 0.2 * _ctrlGrpWidth, TMF_ADMINMENU_STD_HEIGHT];
_ctrlButton ctrlCommit 0;
_ctrlButton ctrlSetText "Enable Teleport";
_ctrlButton ctrlAddEventHandler ["buttonClick", {
    params ["_ctrlButton"];
    GVAR(utility_teleport_toggle) = !(missionNamespace getVariable [QGVAR(utility_teleport_toggle), false]);
    _ctrlButton ctrlSetText (["Enable Teleport", "Disable Teleport"] select GVAR(utility_teleport_toggle));
}];

_ctrlMap setVariable [QGVAR(association), _ctrlButton];
