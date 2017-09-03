#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_display", "_ctrlGroup"];

(ctrlPosition _ctrlGroup) params ["", "", "_ctrlGrpWidth", "_ctrlGrpHeight"];

private _ctrlEdit = _display ctrlCreate ["RscEditMulti", -1, _ctrlGroup];
GVAR(utilityTabControls) = [_ctrlEdit];
private _ctrlEditPos = [0.1 * TMF_ADMINMENU_STD_WIDTH, 0.1 * TMF_ADMINMENU_STD_HEIGHT, _ctrlGrpWidth - (0.2 * TMF_ADMINMENU_STD_WIDTH), _ctrlGrpHeight - (1.3 * TMF_ADMINMENU_STD_HEIGHT)];
_ctrlEdit ctrlSetPosition _ctrlEditPos;
_ctrlEdit ctrlCommit 0;

private _ctrlCombo = _display ctrlCreate [QGVAR(RscCombo), -1, _ctrlGroup];
GVAR(utilityTabControls) pushBack _ctrlCombo;
_ctrlCombo ctrlSetPosition [_ctrlGrpWidth * 0.55, _ctrlGrpHeight - TMF_ADMINMENU_STD_HEIGHT, _ctrlGrpWidth * 0.3, TMF_ADMINMENU_STD_HEIGHT];
_ctrlCombo ctrlCommit 0;
_ctrlCombo lbAdd "Show in Chat";
_ctrlCombo lbAdd "Show in Hint";
_ctrlCombo lbAdd "Show in Subtitle from 'PAPA BEAR'";
_ctrlCombo lbSetCurSel 0;

private _ctrlButton = _display ctrlCreate [QGVAR(RscButtonMenu), -1, _ctrlGroup];
GVAR(utilityTabControls) pushBack _ctrlButton;
_ctrlButton ctrlSetPosition [(_ctrlGrpWidth * 0.85) + (0.1 * TMF_ADMINMENU_STD_HEIGHT), _ctrlGrpHeight - TMF_ADMINMENU_STD_HEIGHT, (_ctrlGrpWidth * 0.15) - (0.1 * TMF_ADMINMENU_STD_HEIGHT), TMF_ADMINMENU_STD_HEIGHT];
_ctrlButton ctrlCommit 0;
_ctrlButton ctrlSetText "Send Message";
_ctrlButton ctrlAddEventHandler ["buttonClick", {
	disableSerialization;
	private _editText = ctrlText (GVAR(utilityTabControls) select 0);
	if (_editText isEqualTo "") then {
		systemChat "[TMF Admin Menu] Message can't be empty";
	} else {
		private _venue = ["systemChat", "hint", "BIS_fnc_showSubtitle"] select (lbCurSel (GVAR(utilityTabControls) select 1));

		{
			_x ctrlEnable false;
		} forEach GVAR(utilityTabControls);

		if (_venue isEqualTo "hint") then {
			_editText = format ["[TMF Admin Message]\n\n%1", _editText];
		} else {
			_editText = format ["[TMF Admin Message] %1", _editText];
		};

		if (_venue isEqualTo "BIS_fnc_showSubtitle") then {
			["PAPA BEAR", _editText] remoteExec [_venue, GVAR(utilityData)];
		} else {
			_editText remoteExec [_venue, GVAR(utilityData)];
		};

		systemChat "[TMF Admin Menu] Message sent to player(s)";
	};
}];
