#include "\x\tmf\addons\adminmenu\script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: TMF_adminmenu_fnc_messageLog_print

Description:
    Prints current selected log entry to RPT

Parameters:
    _ctrl - Print button control

Examples:
    (begin example)
        [_ctrl] call TMF_adminmenu_fnc_messageLog_print;
    (end)

Author:
    Freddo
---------------------------------------------------------------------------- */
disableSerialization;
params ["_ctrl"];

private _display = ctrlParent _ctrl;
private _lbCtrl = _display displayCtrl IDC_TMF_ADMINMENU_MSGS_LIST;
private _curSel = lbCurSel _lbCtrl;
TRACE_3("messageLog print",_display,_lbCtrl,_curSel);

private _imgPath = toLower (_lbCtrl lbPictureRight _curSel);
private _return = format [
    "[TMF Adminmenu] Printed entry: %1%2",
    ["","[WARNING] "] select (_imgPath find "warning.paa" != -1),
    (_lbCtrl lbText _curSel)
];

LOG_1("Printed logged message to RPT: ""%1""",_return);
diag_log _return;
_return
