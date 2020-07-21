private _ctrlGroup = _params select 0;
GroupMarker_ctrlGroup = _ctrlGroup;
TRACE_1("GroupMarker onLoad",_ctrlGroup);

_ctrlGroup ctrladdeventhandler ["setfocus",{with uinamespace do {GroupMarker_ctrlGroup = _this select 0;};}];
_ctrlGroup ctrladdeventhandler ["killfocus",{with uinamespace do {GroupMarker_ctrlGroup = nil;};}];
