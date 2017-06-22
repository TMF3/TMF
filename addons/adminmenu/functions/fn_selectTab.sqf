#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_button", ["_tab", IDC_TMF_ADMINMENU_G_DASH]];
_button = _button param [0];
private _display = ctrlParent _button;

{
	if (_tab == _x) then {
		(_display displayCtrl _x) ctrlShow true;
		(_display displayCtrl _x) ctrlEnable true;
	} else {
		(_display displayCtrl _x) ctrlShow false;
		(_display displayCtrl _x) ctrlEnable false;
	};
} forEach IDCS_TMF_ADMINMENU_GRPS;

ctrlSetFocus _button;

switch (_tab) do {
	case 56200: { _display call FUNC(dashboard); };
	case 56300: {  };
	case 56400: {  };
	case 56500: {  };
	default {};
};