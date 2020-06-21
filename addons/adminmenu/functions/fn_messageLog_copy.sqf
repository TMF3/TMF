#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_ctrl"];

private _display = ctrlParent _ctrl;
private _lbCtrl = _display displayCtrl IDC_TMF_ADMINMENU_MSGS_LIST;
private _curSel = lbCurSel _lbCtrl;
TRACE_3("messageLog copy",_display,_lbCtrl,_curSel);

private _warning = if ((_lbCtrl lbPictureRight _curSel) find "warning.paa" != -1) then [{"[WARNING] "},{""}];
private _return = _warning + (_lbCtrl lbText _curSel);

LOG_1("Copied logged message to clipboard: ""%1""",_return);
copyToClipboard _return;
_return
