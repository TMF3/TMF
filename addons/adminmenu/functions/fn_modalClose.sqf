#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params [["_display", uiNamespace getVariable QGVAR(display)]];
if (_display isEqualType controlNull) then {
    _display = ctrlParent _display;
};

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
        (_display displayCtrl _x) ctrlEnable true;
    } forEach _outsideCtrls;

    ctrlSetFocus (_display displayCtrl GVAR(selectedTab));
};
