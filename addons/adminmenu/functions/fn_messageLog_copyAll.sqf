#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_ctrl"];

private _display = ctrlParent _ctrl;
private _lbCtrl = _display displayCtrl IDC_TMF_ADMINMENU_MSGS_LIST;
TRACE_2("messageLog copy",_display,_lbCtrl);

private _stringArr = [];

for "_i" from 0 to (lbSize _lbCtrl - 1) do {
    private _warning = if ((_lbCtrl lbPictureRight _curSel) find "warning.paa" != -1) then [{"[WARNING] "},{""}];
    _stringArr pushBack (_warning + (_lbCtrl lbText _i));
};

LOG("Copied all logged messages to clipboard");
private _return = _stringArr joinString toString [13,10]; // Join with a linebreak
copyToClipboard _return;
_return
