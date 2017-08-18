#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_display", "_ctrlGroup"];

private _ctrlEdit = _display ctrlCreate ["RscEditMulti", -1, _ctrlGroup];
GVAR(utilityTabControls) = [_ctrlEdit];
private _ctrlEditPos = ctrlPosition _ctrlGroup;
private _ctrlGrpHeight = _ctrlEditPos select 3;
_ctrlEditPos = [_ctrlEditPos select 0, 1.1 * TMF_ADMINMENU_STD_HEIGHT, _ctrlGrpHeight * (3/4), _ctrlGrpHeight - (1.1 * TMF_ADMINMENU_STD_HEIGHT)];
/* _ctrlEditPos set [1, 1.1 * TMF_ADMINMENU_STD_HEIGHT];
_ctrlEditPos set [2, _ctrlGrpHeight * (3/4)];
_ctrlEditPos set [3, _ctrlGrpHeight - (1.1 * TMF_ADMINMENU_STD_HEIGHT)]; */
_ctrlEdit ctrlSetPosition _ctrlEditPos;
_ctrlEdit ctrlCommit 0;

private _newX = (_ctrlGrpHeight * (3/4)) + (0.1 * TMF_ADMINMENU_STD_WIDTH);
private _newW = ((ctrlPosition _ctrlGroup) select 2) - _newX;

private _ctrlHintEdit = _display ctrlCreate [QGVAR(RscText), -1, _ctrlGroup];
GVAR(utilityTabControls) pushBack _ctrlHintEdit;
_ctrlHintEdit ctrlSetPosition [0, 0, _ctrlEditPos select 2, TMF_ADMINMENU_STD_HEIGHT];
_ctrlHintEdit ctrlCommit 0;
_ctrlHintEdit ctrlSetText "'_this' is the targetted player object";

private _ctrlHintCombo = _display ctrlCreate [QGVAR(RscText), -1, _ctrlGroup];
GVAR(utilityTabControls) pushBack _ctrlHintCombo;
_ctrlHintCombo ctrlSetPosition [_newX, 0, _newW, TMF_ADMINMENU_STD_HEIGHT];
_ctrlHintCombo ctrlCommit 0;
_ctrlHintCombo ctrlSetText "Execute Code on...";

private _ctrlCombo = _display ctrlCreate ["RscCombo", -1, _ctrlGroup];
GVAR(utilityTabControls) pushBack _ctrlCombo;
_ctrlCombo ctrlSetPosition [_newX, 1.1 * TMF_ADMINMENU_STD_HEIGHT, _newW, TMF_ADMINMENU_STD_HEIGHT];
_ctrlCombo ctrlCommit 0;
_ctrlCombo lbAdd "Your Client";
_ctrlCombo lbAdd "Targets' Clients";
_ctrlCombo lbAdd "Server";
_ctrlCombo lbAdd "All Clients and Server";
_ctrlCombo lbSetCurSel 0;

private _ctrlButton = _display ctrlCreate [QGVAR(RscButtonMenu), -1, _ctrlGroup];
GVAR(utilityTabControls) pushBack _ctrlButton;
_ctrlButton ctrlSetPosition [_newX, _ctrlGrpHeight - TMF_ADMINMENU_STD_HEIGHT, _newW, TMF_ADMINMENU_STD_HEIGHT];
_ctrlButton ctrlCommit 0;
_ctrlButton ctrlSetText "Execute";
_ctrlButton ctrlAddEventHandler ["buttonClick", {
	private _editText = ctrlText (GVAR(utilityTabControls) select 0);
	if (_editText isEqualTo "") then {
		systemChat "[TMF Admin Menu] Code can't be empty";
	} else {
		(_this select 0) ctrlEnable false;
		private _foo = (_this select 0) spawn {
			sleep 0.5;
			_this ctrlEnable true;
		};

		private _target = [clientOwner, _x, 2, 0] select (lbCurSel (GVAR(utilityTabControls) select 3));
		if (_target isEqualType objNull) then { // individual remoteExec's
			{
				[_x, compile _editText] remoteExec ["call", _target];
			} forEach GVAR(utility_data);
		} else { // remoteExec once
			[[GVAR(utility_data), compile _editText], {
				params ["_data", "_code"];
				{
					_x call _code;
				} forEach _data;
			}] remoteExec ["call", _target];
		};

		systemChat format ["[TMF Admin Menu] Code was executed on %1", lbText (GVAR(utilityTabControls) select 3)];
	};
}];