#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_ctrlGroup"];

(ctrlPosition _ctrlGroup) params ["", "", "_ctrlGrpWidth", "_ctrlGrpHeight"];

private _ctrlLabelRadios = _display ctrlCreate [QGVAR(RscTextLarge), -1, _ctrlGroup];
GVAR(utilityTabControls) pushBack _ctrlLabelRadios;
_ctrlLabelRadios ctrlSetPosition [0, 0, (0.5 * _ctrlGrpWidth), TMF_ADMINMENU_STD_HEIGHT];
_ctrlLabelRadios ctrlCommit 0;
_ctrlLabelRadios ctrlSetText "Add Radios";

private _ctrlLabelRadioGroup = _display ctrlCreate [QGVAR(RscText), -1, _ctrlGroup];
GVAR(utilityTabControls) pushBack _ctrlLabelRadioGroup;
_ctrlLabelRadioGroup ctrlSetPosition [0, (1.1 * TMF_ADMINMENU_STD_HEIGHT), 0.5 * _ctrlGrpWidth, TMF_ADMINMENU_STD_HEIGHT];
_ctrlLabelRadioGroup ctrlCommit 0;
_ctrlLabelRadioGroup ctrlSetText "Radios with the same (number) postfix are compatible";

private _radios = [];
{
    _radios append (_x select 0);
} forEach EGVAR(acre2,radioCoreSettings);
private _radioCtrls = [];
private _radioCtrlsY = 2.2 * TMF_ADMINMENU_STD_HEIGHT;

{
    private _radio = _x;
    private _radioGroup = (EGVAR(acre2,radioCoreSettings) findIf {_radio in (_x select 0)}) + 1; // arbitrary index to identify what group of radios it's compatible with

    private _ctrlRadioCheck = _display ctrlCreate ["RscCheckBox", -1, _ctrlGroup];
    GVAR(utilityTabControls) pushBack _ctrlRadioCheck;
    _radioCtrls pushBack _ctrlRadioCheck;
    _ctrlRadioCheck ctrlSetPosition [0, _radioCtrlsY + (_forEachIndex * TMF_ADMINMENU_STD_HEIGHT), TMF_ADMINMENU_STD_WIDTH, TMF_ADMINMENU_STD_HEIGHT];
    _ctrlRadioCheck ctrlCommit 0;
    _ctrlRadioCheck setVariable [QGVAR(association), _x];

    private _ctrlRadioName = _display ctrlCreate [QGVAR(RscText), -1, _ctrlGroup];
    GVAR(utilityTabControls) pushBack _ctrlRadioName;
    _ctrlRadioName ctrlSetPosition [TMF_ADMINMENU_STD_WIDTH, _radioCtrlsY + (_forEachIndex * TMF_ADMINMENU_STD_HEIGHT), (0.5 * _ctrlGrpWidth) - TMF_ADMINMENU_STD_WIDTH, TMF_ADMINMENU_STD_HEIGHT];
    _ctrlRadioName ctrlCommit 0;
    if (_radioGroup > 0) then {
        _ctrlRadioName ctrlSetText format ["%1 (%2)", getText (configFile >> "CfgWeapons" >> _x >> "displayName"), _radioGroup];
    } else {
        _ctrlRadioName ctrlSetText getText (configFile >> "CfgWeapons" >> _x >> "displayName");
    };
    _ctrlRadioName ctrlSetTooltip getText (configFile >> "CfgWeapons" >> _x >> "descriptionShort");
} forEach _radios;


private _networkCtrls = [];

if (!isNil QEGVAR(acre2,networksWithRadioChannels)) then {
    private _ctrlCheckNetwork = _display ctrlCreate ["RscCheckBox", -1, _ctrlGroup];
    GVAR(utilityTabControls) pushBack _ctrlCheckNetwork;
    _networkCtrls pushBack _ctrlCheckNetwork;
    _ctrlCheckNetwork ctrlSetPosition [0.5 * _ctrlGrpWidth, 0, TMF_ADMINMENU_STD_WIDTH, TMF_ADMINMENU_STD_HEIGHT];
    _ctrlCheckNetwork ctrlCommit 0;

    private _ctrlLabelNetwork = _display ctrlCreate [QGVAR(RscTextLarge), -1, _ctrlGroup];
    GVAR(utilityTabControls) pushBack _ctrlLabelNetwork;
    _ctrlLabelNetwork ctrlSetPosition [(0.5 * _ctrlGrpWidth) + TMF_ADMINMENU_STD_WIDTH, 0, (0.5 * _ctrlGrpWidth) - (1.1 * TMF_ADMINMENU_STD_WIDTH), TMF_ADMINMENU_STD_HEIGHT];
    _ctrlLabelNetwork ctrlCommit 0;
    _ctrlLabelNetwork ctrlSetText "Change Radio Network";
    _ctrlCheckNetwork ctrlCommit 0;

    private _ctrlLabelNetworkWarning = _display ctrlCreate [QGVAR(RscText), -1, _ctrlGroup];
    GVAR(utilityTabControls) pushBack _ctrlLabelNetworkWarning;
    _ctrlLabelNetworkWarning ctrlSetPosition [0.5 * _ctrlGrpWidth, (1.1 * TMF_ADMINMENU_STD_HEIGHT), 0.5 * _ctrlGrpWidth, TMF_ADMINMENU_STD_HEIGHT];
    _ctrlLabelNetworkWarning ctrlSetTextColor [1, 192/255, 77/255, 1];
    _ctrlLabelNetworkWarning ctrlCommit 0;
    _ctrlLabelNetworkWarning ctrlSetText "Warning: Change only if you know what you're doing!";

    private _ctrlListNetwork = _display ctrlCreate [QGVAR(RscListBox), -1, _ctrlGroup];
    GVAR(utilityTabControls) pushBack _ctrlListNetwork;
    _networkCtrls pushBack _ctrlListNetwork;
    _ctrlListNetwork ctrlSetPosition [0.5 * _ctrlGrpWidth, _radioCtrlsY, (0.5 * _ctrlGrpWidth) - (0.1 * TMF_ADMINMENU_STD_WIDTH), _ctrlGrpHeight - _radioCtrlsY - (2 * TMF_ADMINMENU_STD_HEIGHT)];
    _ctrlListNetwork ctrlCommit 0;

    {
        _x params ["_conditions"];

        private _netId = _forEachIndex + 1;
        private _conditionsStr = (_conditions apply { // convert different conditions to strings
            if (_x isEqualType "") then {
                format ["faction: %1", _x]
            } else {
                if (_x isEqualType 0) then {
                    toLower str (_x call EFUNC(common,numToSide))
                } else {
                    str _x
                };
            };
        }) joinString ", ";

        private _idx = _ctrlListNetwork lbAdd format ["%1: %2", _netId, _conditionsStr];
        _ctrlListNetwork lbSetValue [_idx, _netId];
        systemChat format ["Network %1: %2", _netId, _conditionsStr];
    } forEach EGVAR(acre2,networksWithRadioChannels);
};


private _ctrlButton = _display ctrlCreate [QGVAR(RscButtonMenu), -1, _ctrlGroup];
GVAR(utilityTabControls) pushBack _ctrlButton;
_ctrlButton ctrlSetPosition [_ctrlGrpWidth * 0.8, _ctrlGrpHeight - TMF_ADMINMENU_STD_HEIGHT, _ctrlGrpWidth * 0.2, TMF_ADMINMENU_STD_HEIGHT];
_ctrlButton ctrlCommit 0;
_ctrlButton ctrlSetText "Assign Radios";
_ctrlButton setVariable [QGVAR(association), [_radioCtrls, _networkCtrls]];
_ctrlButton ctrlAddEventHandler ["ButtonClick", {
    params ["_ctrlButton"];
    _ctrlButton call FUNC(debounceButton);

    (_ctrlButton getVariable [QGVAR(association), []]) params [["_radioCtrls", []], ["_networkCtrls", []]];

    private _radios = (_radioCtrls select {cbChecked _x}) apply {_x getVariable [QGVAR(association), "???"]}; // get classnames of ticked radios
    systemChat (_radios joinString ", ");
    private _network = -1;

    if !(_networkCtrls isEqualTo []) then {
        _networkCtrls params ["_ctrlNetworkCheck", "_ctrlNetworkList"];

        if (cbChecked _ctrlNetworkCheck) then {
            private _idx = lbCurSel _ctrlNetworkList;
            if (_idx < 0) exitWith {
                systemChat "[TMF Admin Menu] No network selected";
            };

            _network = _ctrlNetworkList lbValue _idx;
            systemChat format ["Selected network %1", _network];
        };
    };

    [_radios, _network] remoteExecCall [QFUNC(modal_ACRE2Languages_assign), GVAR(utilityData)];
    [["%1 Assigned radios %2 on network %3 to ",profileName,_radio,_network,GVAR(utilityData) apply {name _x}],false,"[TMF Admin Menu] "] call FUNC(log);
}];
