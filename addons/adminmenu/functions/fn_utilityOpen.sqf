#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_display", "_utilityFunction", "_utilityName", ["_requireAlive", false]];

private _data = [];
if (!isNil QGVAR(selectedTab)) then {
	if (GVAR(selectedTab) isEqualTo IDC_TMF_ADMINMENU_G_PMAN && !isNil QGVAR(playerManagement_selected)) then {
		_data = GVAR(playerManagement_selected) apply {_x call BIS_fnc_objectFromNetId};

		if ((count _data) isEqualTo 0) exitWith {
			systemChat "[TMF Admin Menu] No players selected for the action!";
		};
		
		if (_requireAlive) then {
			_data = _data select {alive _x && _x isKindOf "CAManBase"};
			if ((count _data) isEqualTo 0) exitWith {
				systemChat "[TMF Admin Menu] No alive players selected for the action!";
			};
		};
	};

	(_display displayCtrl GVAR(selectedTab)) ctrlShow false;
	(_display displayCtrl GVAR(selectedTab)) ctrlEnable false;
};

GVAR(utilityTabBaseControls) = [_display displayCtrl IDC_TMF_ADMINMENU_G_UTIL, _display displayCtrl IDC_TMF_ADMINMENU_UTIL_TBACK];
private _ctrlTitle = _display displayCtrl IDC_TMF_ADMINMENU_UTIL_TITLE;
_ctrlTitle ctrlSetText _utilityName;
GVAR(utilityTabBaseControls) pushBack _ctrlTitle;

{
	_x ctrlShow true;
	_x ctrlEnable true;
} forEach GVAR(utilityTabBaseControls);
ctrlSetFocus (GVAR(utilityTabBaseControls) select 0);

if (isNil _utilityFunction) then {
	private _ctrlText = _display ctrlCreate ["RscText", -1];
	GVAR(utilityTabControls) = [_ctrlText];
	_ctrlText ctrlSetText format ["Utility with name '%1' requires undefined function '%2'", _utilityName, _utilityFunction];
} else {
	[_display, GVAR(utilityTabBaseControls) select 0, _data] call (missionNamespace getVariable _utilityFunction);
};