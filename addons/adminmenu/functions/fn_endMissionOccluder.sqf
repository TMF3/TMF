#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_display", ["_hideLeft", false, [false, 0]]];
if (_hideLeft isEqualType 0) then {
	_hideLeft = [false, true] select _hideLeft;
};

(_display displayCtrl IDC_TMF_ADMINMENU_ENDM_FROMMISSION) cbSetChecked !_hideLeft;
(_display displayCtrl IDC_TMF_ADMINMENU_ENDM_LIST) ctrlEnable !_hideLeft;
(_display displayCtrl IDC_TMF_ADMINMENU_ENDM_OCCLUDER_L) ctrlEnable _hideLeft;
(_display displayCtrl IDC_TMF_ADMINMENU_ENDM_OCCLUDER_L) ctrlShow _hideLeft;

(_display displayCtrl IDC_TMF_ADMINMENU_ENDM_SIDESPECIFIC) cbSetChecked _hideLeft;
{
	(_display displayCtrl _x) ctrlEnable _hideLeft;
} forEach IDCS_TMF_ADMINMENU_ENDM_RIGHT;
(_display displayCtrl IDC_TMF_ADMINMENU_ENDM_OCCLUDER_R) ctrlEnable !_hideLeft;
(_display displayCtrl IDC_TMF_ADMINMENU_ENDM_OCCLUDER_R) ctrlShow !_hideLeft;