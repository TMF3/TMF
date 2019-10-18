#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_ctrlBackground"];

if (isNil QGVAR(remoteControlUnits) || {GVAR(remoteControlUnits) isEqualTo []}) exitWith {
	systemChat "[TMF Admin Menu] No unit candidates for remote control";
};

private _display = ctrlParent _ctrlBackground;
private _dialogPosition = ctrlPosition _ctrlBackground;

private _ctrlList = _display ctrlCreate [QGVAR(RscListBox), -1];
_ctrlList ctrlSetPosition [(_dialogPosition # 0) + 0.1 * TMF_ADMINMENU_STD_WIDTH, (_dialogPosition # 1) + 0.1 * TMF_ADMINMENU_STD_HEIGHT, (_dialogPosition # 2) - (0.2 * TMF_ADMINMENU_STD_WIDTH), (_dialogPosition # 3) - (0.2 * TMF_ADMINMENU_STD_HEIGHT)];
_ctrlList ctrlCommit 0;
{
	private _name = _x # 1;
	private _turretPath = _x # 3;
	if !(_turretPath isEqualTo [] || _turretPath isEqualTo [-1]) then {
		_name = getText (([GVAR(remoteControlUnits) # 1, _turretPath] call BIS_fnc_turretConfig) >> "gunnerName");
	};
	private _i = _ctrlList lbAdd _name;
	_ctrlList lbSetTextRight [_i, getText (configFile >> "CfgVehicles" >> typeOf (_x # 0) >> "displayName")];
	_ctrlList lbSetTooltip [_i, format ["Turret Path: %1\nFFV: %2", _x # 3, _x # 4]];
	_ctrlList lbSetPicture [_i, format ["\A3\Ui_f\data\GUI\Cfg\Ranks\%1_gs.paa", rank (_x  # 0)]];
	_ctrlList lbSetPictureColor [_i, [1, 1, 1, 1]];
} forEach (GVAR(remoteControlUnits) # 0);
_ctrlList lbSetCurSel 0;

private _ctrlOK = _display ctrlCreate [QGVAR(RscButtonMenu), -1];
_ctrlOK ctrlSetText "Control";
_ctrlOK ctrlSetPosition [(_dialogPosition # 0) + 0.67 * (_dialogPosition # 2), (_dialogPosition # 1) + (_dialogPosition # 3) + 0.1 * TMF_ADMINMENU_STD_HEIGHT, 0.33 * (_dialogPosition # 2), TMF_ADMINMENU_STD_HEIGHT];
_ctrlOK ctrlCommit 0;
_ctrlOK setVariable [QGVAR(association), _ctrlList];
_ctrlOK ctrlAddEventHandler ["buttonClick", {
	params ["_ctrlOK"];

	private _listIndex = lbCurSel (_ctrlOK getVariable [QGVAR(association), controlNull]);
	private _unit = ((GVAR(remoteControlUnits) # 0) # _listIndex) # 0;
	
	closeDialog 0;

	[_unit, true, true] call FUNC(remoteControl);
	GVAR(remoteControlUnits) = nil;
}];