#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_display", ["_tab", IDC_TMF_ADMINMENU_G_DASH]];

{
	if (_tab == _x) then {
		(_display displayCtrl _x) ctrlShow true;
		(_display displayCtrl _x) ctrlEnable true;
	} else {
		(_display displayCtrl _x) ctrlShow false;
		(_display displayCtrl _x) ctrlEnable false;
	};
} forEach IDCS_TMF_ADMINMENU_GRPS;

switch (_tab) do {
	case IDC_TMF_ADMINMENU_G_DASH: 
	{ 
		ctrlSetFocus (_display displayCtrl IDC_TMF_ADMINMENU_DASH);
		_display call FUNC(dashboard);
	};
	case IDC_TMF_ADMINMENU_G_PMAN:
	{ 
		ctrlSetFocus (_display displayCtrl IDC_TMF_ADMINMENU_PMAN);
	};
	case IDC_TMF_ADMINMENU_G_RESP:
	{ 
		ctrlSetFocus (_display displayCtrl IDC_TMF_ADMINMENU_RESP);
	};
	case IDC_TMF_ADMINMENU_G_ENDM:
	{ 
		ctrlSetFocus (_display displayCtrl IDC_TMF_ADMINMENU_ENDM);
	};
	default {};
};