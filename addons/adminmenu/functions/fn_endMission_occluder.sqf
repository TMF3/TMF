#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_display", ["_checkboxIDC", IDC_TMF_ADMINMENU_ENDM_FROMMISSION, [0]]];

private _occluderText = switch (_checkboxIdc) do {
    case IDC_TMF_ADMINMENU_ENDM_FROMMISSION: { "Using Ending from Mission" };
    case IDC_TMF_ADMINMENU_ENDM_SIDESPECIFIC: { "Using Side-Specific Ending" };
    case IDC_TMF_ADMINMENU_ENDM_CUSTOM: { "Using Custom Ending" };
    default { "..." };
};

{
    (_display displayCtrl _x) ctrlSetText _occluderText;
} forEach IDCS_TMF_ADMINMENU_ENDM_OCCLUDERS;

private _useFromMission = (_checkboxIdc isEqualTo IDC_TMF_ADMINMENU_ENDM_FROMMISSION);
(_display displayCtrl IDC_TMF_ADMINMENU_ENDM_FROMMISSION) cbSetChecked _useFromMission;
(_display displayCtrl IDC_TMF_ADMINMENU_ENDM_LIST) ctrlEnable _useFromMission;
(_display displayCtrl IDC_TMF_ADMINMENU_ENDM_FROMMISSION_ISDEFEAT) ctrlEnable _useFromMission;
(_display displayCtrl IDC_TMF_ADMINMENU_ENDM_OCCLUDER_LU) ctrlEnable !_useFromMission;
(_display displayCtrl IDC_TMF_ADMINMENU_ENDM_OCCLUDER_LU) ctrlShow !_useFromMission;

private _useSideSpecific = (_checkboxIdc isEqualTo IDC_TMF_ADMINMENU_ENDM_SIDESPECIFIC);
(_display displayCtrl IDC_TMF_ADMINMENU_ENDM_SIDESPECIFIC) cbSetChecked _useSideSpecific;
{
    (_display displayCtrl _x) ctrlEnable _useSideSpecific;
} forEach IDCS_TMF_ADMINMENU_ENDM_SIDESPECIFIC;
(_display displayCtrl IDC_TMF_ADMINMENU_ENDM_OCCLUDER_R) ctrlEnable !_useSideSpecific;
(_display displayCtrl IDC_TMF_ADMINMENU_ENDM_OCCLUDER_R) ctrlShow !_useSideSpecific;

private _useCustom = (_checkboxIdc isEqualTo IDC_TMF_ADMINMENU_ENDM_CUSTOM);
(_display displayCtrl IDC_TMF_ADMINMENU_ENDM_CUSTOM) cbSetChecked _useCustom;
(_display displayCtrl IDC_TMF_ADMINMENU_ENDM_CUSTOM_TITLE) ctrlEnable _useCustom;
(_display displayCtrl IDC_TMF_ADMINMENU_ENDM_CUSTOM_SUBTEXT) ctrlEnable _useCustom;
(_display displayCtrl IDC_TMF_ADMINMENU_ENDM_CUSTOM_ISDEFEAT) ctrlEnable _useCustom;
(_display displayCtrl IDC_TMF_ADMINMENU_ENDM_OCCLUDER_LD) ctrlEnable !_useCustom;
(_display displayCtrl IDC_TMF_ADMINMENU_ENDM_OCCLUDER_LD) ctrlShow !_useCustom;
