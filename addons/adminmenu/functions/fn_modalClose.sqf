#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params [["_display", uiNamespace getVariable QGVAR(display)]];

if (!isNil QGVAR(modalEscapeEH)) then {
	[GVAR(modalEscapeEH), "keydown"] call CBA_fnc_removeKeyHandler;
	GVAR(modalEscapeEH) = nil;
};

if (!isNil QGVAR(modalControls)) then {
	{
		ctrlDelete _x;
	} forEach GVAR(modalControls);
};

{
	(_display displayCtrl _x) ctrlShow false;
	(_display displayCtrl _x) ctrlEnable false;
} forEach IDCS_TMF_ADMINMENU_MODAL;

if (!isNil QGVAR(selectedTab)) then {
	ctrlSetFocus (_display displayCtrl GVAR(selectedTab));
};
