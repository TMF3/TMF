#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_display", ["_tab", IDC_TMF_ADMINMENU_G_DASH]];

_display call FUNC(utilityClose);

GVAR(selectedTab) = _tab;

while {count GVAR(tabPFHHandles) > 0} do {
    [GVAR(tabPFHHandles) deleteAt 0] call CBA_fnc_removePerFrameHandler;
};

{
    if (_tab isEqualTo _x) then {
        (_display displayCtrl _x) ctrlShow true;
        (_display displayCtrl _x) ctrlEnable true;
    } else {
        (_display displayCtrl _x) ctrlShow false;
        (_display displayCtrl _x) ctrlEnable false;
    };
} forEach IDCS_TMF_ADMINMENU_GRPS;

switch (_tab) do {
    case IDC_TMF_ADMINMENU_G_DASH: {
        ctrlSetFocus (_display displayCtrl IDC_TMF_ADMINMENU_DASH);
        _display call FUNC(dashboard);
    };
    case IDC_TMF_ADMINMENU_G_PMAN: {
        ctrlSetFocus (_display displayCtrl IDC_TMF_ADMINMENU_PMAN);
        _display call FUNC(playerManagement);
    };
    case IDC_TMF_ADMINMENU_G_RESP: {
        ctrlSetFocus (_display displayCtrl IDC_TMF_ADMINMENU_RESP);
        _display call FUNC(respawn);
    };
    case IDC_TMF_ADMINMENU_G_ENDM: {
        ctrlSetFocus (_display displayCtrl IDC_TMF_ADMINMENU_ENDM);
        _display call FUNC(endMission);
    };
    case IDC_TMF_ADMINMENU_G_MSGS: {
        ctrlSetFocus (_display displayCtrl IDC_TMF_ADMINMENU_MSGS);
        _display call FUNC(messageLog);
    };
};
