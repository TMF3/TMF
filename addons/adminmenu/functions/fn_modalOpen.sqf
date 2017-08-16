#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_button", "_modalFunction", ["_data", false]];
private _display = ctrlParent _button;

private _modalFunctionFull = format ["%1_fnc_modal_%2", ADDON, _modalFunction];
if (isNil _modalFunctionFull) exitWith {
	systemChat format ["A TMF Admin Menu modal function with the name '%1' is not defined.", _modalFunctionFull];
};

if ((missionNamespace getVariable [QGVAR(selectedTab), 0]) isEqualTo IDC_TMF_ADMINMENU_G_PMAN) then {
	_data = ((missionNamespace getVariable [QGVAR(playerManagement_selected), []]) apply {
		_x call BIS_fnc_objectFromNetId
	}) select {
		!isNull _x
	};
};

private _controls = IDCS_TMF_ADMINMENU_MODAL apply {_display displayCtrl _x};
{
	_x ctrlShow true;
	_x ctrlEnable true;
} forEach IDCS_TMF_ADMINMENU_MODAL;

if (isNil QGVAR(modalEscapeEH)) then {
	GVAR(modalEscapeEH) = [1, [false, false, false], {
		call FUNC(modalClose);
	}, "keydown", QGVAR(modalEscapeEH), false] call CBA_fnc_addKeyHandler;
};

ctrlSetFocus (_controls select 0);

[_display, _display displayCtrl IDC_TMF_ADMINMENU_G_MODAL, _display displayCtrl IDC_TMF_ADMINMENU_MODAL_TITLE, _data] call (missionNamespace getVariable _modalFunctionFull);
