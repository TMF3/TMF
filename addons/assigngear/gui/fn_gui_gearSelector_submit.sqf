#include "\x\tmf\addons\assignGear\script_component.hpp"

params ["_display"];

private _factionCtrl = _display displayCtrl IDC_RSCGEARSELECTOR_FACTION;
private _roleCtrl = _display displayCtrl IDC_RSCGEARSELECTOR_ROLE;
[
    player,
    _factionCtrl lbData (lbCurSel _factionCtrl),
    _roleCtrl lbData (lbCurSel _roleCtrl)
] call FUNC(assignGear);

_display closeDisplay 1;
