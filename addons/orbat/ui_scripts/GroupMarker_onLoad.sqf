#include "\x\tmf\addons\orbat\script_component.hpp"
private _ctrlGroup = _params select 0;
GroupMarker_ctrlGroup = _ctrlGroup;
TRACE_1("GroupMarker onLoad",_ctrlGroup);

_ctrlGroup ctrlAddEventHandler ["SetFocus",{with uiNamespace do {GroupMarker_ctrlGroup = _this select 0;};}];
_ctrlGroup ctrlAddEventHandler ["KillFocus",{with uiNamespace do {GroupMarker_ctrlGroup = nil;};}];
