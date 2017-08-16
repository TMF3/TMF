#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_display", "_modalFunction", ["_data", false]];

if (isNil _modalFunction) exitWith {
	systemChat format ["A TMF Admin Menu modal function with the name '%1' is not defined.", _modalFunction];
};

if ((missionNamespace getVariable [QGVAR(selectedTab), 0]) isEqualTo IDC_TMF_ADMINMENU_G_PMAN) then {
	_data = ((missionNamespace getVariable [QGVAR(playerManagement_selected), []]) apply {
		_x call BIS_fnc_objectFromNetId
	}) select {
		!isNull _x
	};
};

if (ctrlShown (_display displayCtrl IDC_TMF_ADMINMENU_G_MODAL)) then {
	_display call FUNC(modalClose);
};

if (!isNil QGVAR(selectedTab)) then {
	private _outsideCtrls = IDCS_TMF_ADMINMENU_BTNS;
	switch (GVAR(selectedTab)) do {
		case IDC_TMF_ADMINMENU_DASH: {
			_outsideCtrls pushBack IDC_TMF_ADMINMENU_G_DASH;
		};
		case IDC_TMF_ADMINMENU_PMAN: {
			_outsideCtrls pushBack IDC_TMF_ADMINMENU_G_PMAN;
		};
		case IDC_TMF_ADMINMENU_RESP: { 
			_outsideCtrls pushBack IDC_TMF_ADMINMENU_G_RESP;
		};
		case IDC_TMF_ADMINMENU_ENDM: { 
			_outsideCtrls pushBack IDC_TMF_ADMINMENU_G_ENDM;
		};
		case IDC_TMF_ADMINMENU_MSGS: { 
			_outsideCtrls pushBack IDC_TMF_ADMINMENU_G_MSGS;
		};
	};

	{
		(_display displayCtrl _x) ctrlEnable false;
	} forEach _outsideCtrls;
};

private _controls = IDCS_TMF_ADMINMENU_MODAL apply {_display displayCtrl _x};
{
	_x ctrlShow true;
	_x ctrlEnable true;
} forEach _controls;

if (isNil QGVAR(modalEscapeEH)) then {
	GVAR(modalEscapeEH) = [1, [false, false, false], {
		call FUNC(modalClose);
	}, "keydown", QGVAR(modalEscapeEH), false] call CBA_fnc_addKeyHandler;
};

ctrlSetFocus (_controls select 0);

[_display, _display displayCtrl IDC_TMF_ADMINMENU_G_MODAL, _display displayCtrl IDC_TMF_ADMINMENU_MODAL_TITLE, _data] call (missionNamespace getVariable _modalFunction);
