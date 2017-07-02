#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_ctrl"];

private _display = ctrlParent _ctrl;
private _ctrlIDC = ctrlIDC _ctrl;
private _list = _display displayCtrl IDC_TMF_ADMINMENU_PMAN_LIST;

if (_ctrlIDC isEqualTo IDC_TMF_ADMINMENU_PMAN_REFRESH) exitWith {
	_display call FUNC(playerManagementUpdateList);
};
if (_ctrlIDC isEqualTo IDC_TMF_ADMINMENU_PMAN_SEL_ALL) exitWith {
	GVAR(playerManagement_selected) = GVAR(playerManagement_players);
	
	for "_i" from 0 to ((lbSize _list) - 1) do {
		_list lbSetSelected [_i, true];
	};
};
if (_ctrlIDC isEqualTo IDC_TMF_ADMINMENU_PMAN_SEL_GROUP) exitWith {
	systemChat "Not Implemented";
};
if (_ctrlIDC isEqualTo IDC_TMF_ADMINMENU_PMAN_SEL_ROLE) exitWith {
	systemChat "Not Implemented";
};
if (_ctrlIDC isEqualTo IDC_TMF_ADMINMENU_PMAN_SEL_LOADOUT) exitWith {
	systemChat "Not Implemented";
};

if (_ctrlIDC isEqualTo IDC_TMF_ADMINMENU_PMAN_TELEPORT) exitWith {
	systemChat "Not Implemented";
};
if (_ctrlIDC isEqualTo IDC_TMF_ADMINMENU_PMAN_MESSAGE) exitWith {
	systemChat "Not Implemented";
};
if (_ctrlIDC isEqualTo IDC_TMF_ADMINMENU_PMAN_ASSIGNGEAR) exitWith {
	systemChat "Not Implemented";
};
if (_ctrlIDC isEqualTo IDC_TMF_ADMINMENU_PMAN_ASSIGNRADIO) exitWith {
	systemChat "Not Implemented";
};
if (_ctrlIDC isEqualTo IDC_TMF_ADMINMENU_PMAN_HEAL) exitWith {
	systemChat "Not Implemented";
};
if (_ctrlIDC isEqualTo IDC_TMF_ADMINMENU_PMAN_KICK) exitWith {
	systemChat "Not Implemented";
};
if (_ctrlIDC isEqualTo IDC_TMF_ADMINMENU_PMAN_RUNCODE) exitWith {
	systemChat "Not Implemented";
};
if (_ctrlIDC isEqualTo IDC_TMF_ADMINMENU_PMAN_GRANTZEUS) exitWith {
	systemChat "Not Implemented";
};
if (_ctrlIDC isEqualTo IDC_TMF_ADMINMENU_PMAN_ACRELANGUAGES) exitWith {
	systemChat "Not Implemented";
};

systemChat format ["[TMF Admin Menu] Player Management button code '%1' not recognized", _ctrlIDC];