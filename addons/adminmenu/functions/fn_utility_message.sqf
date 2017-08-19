#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_display", "_ctrlGroup"];

if (!isNil QGVAR(utilityTabControls)) then { systemChat format ["!isNil teleport : %1", str GVAR(utilityTabControls)]; };

(ctrlPosition _ctrlGroup) params ["", "", "_ctrlGrpWidth", "_ctrlGrpHeight"];

private _ctrlEdit = _display ctrlCreate ["RscEditMulti", -1, _ctrlGroup];
GVAR(utilityTabControls) = [_ctrlEdit];
private _ctrlEditPos = [0, 0, _ctrlGrpWidth, _ctrlGrpHeight - (1.1 * TMF_ADMINMENU_STD_HEIGHT)];
_ctrlEdit ctrlSetPosition _ctrlEditPos;
_ctrlEdit ctrlCommit 0;

private _ctrlCombo = _display ctrlCreate ["RscCombo", -1, _ctrlGroup];
GVAR(utilityTabControls) pushBack _ctrlCombo;
_ctrlCombo ctrlSetPosition [_ctrlGrpWidth * 0.5, _ctrlGrpHeight - TMF_ADMINMENU_STD_HEIGHT, _ctrlGrpWidth * 0.25, TMF_ADMINMENU_STD_HEIGHT];
_ctrlCombo ctrlCommit 0;
_ctrlCombo lbAdd "Show in Chat";
_ctrlCombo lbAdd "Show in Hint";
_ctrlCombo lbAdd "Show in Pop-up Dialog";
_ctrlCombo lbSetCurSel 0;

private _ctrlButton = _display ctrlCreate [QGVAR(RscButtonMenu), -1, _ctrlGroup];
GVAR(utilityTabControls) pushBack _ctrlButton;
_ctrlButton ctrlSetPosition [(_ctrlGrpWidth * 0.75) + (0.1 * TMF_ADMINMENU_STD_HEIGHT), _ctrlGrpHeight - TMF_ADMINMENU_STD_HEIGHT, (_ctrlGrpWidth * 0.25) - (0.1 * TMF_ADMINMENU_STD_HEIGHT), TMF_ADMINMENU_STD_HEIGHT];
_ctrlButton ctrlCommit 0;
_ctrlButton ctrlSetText "Send Message";
_ctrlButton ctrlAddEventHandler ["buttonClick", {
	private _editText = ctrlText (GVAR(utilityTabControls) select 0);
	if (_editText isEqualTo "") then {
		systemChat "[TMF Admin Menu] Message can't be empty";
	} else {
		{
			_x ctrlEnable false;
		} forEach GVAR(utilityTabControls);

		private _venue = ["systemChat", "hint", "hintC"] select (lbCurSel (GVAR(utilityTabControls) select 1));
		_editText remoteExec [_venue, GVAR(utility_data)];

		systemChat "[TMF Admin Menu] Message sent to player(s)";
	};
}];