#include "\x\tmf\addons\assignGear\script_component.hpp"

disableSerialization;
params ["_display", "_selectedIndex"];

private _ctrl = _display displayCtrl IDC_RSCGEARSELECTOR_ROLE;
lbClear _ctrl;
private _faction = (_display displayCtrl IDC_RSCGEARSELECTOR_FACTION) lbData _selectedIndex;

private _cfg = if (isClass (missionConfigFile >> "CfgLoadouts" >> _faction)) then [{missionConfigFile}, {configFile}];

{
    private _index = _ctrl lbAdd getText (_x >> "displayName");
    _ctrl lbSetData [_index, configName _x];
} forEach ("true" configClasses (_cfg >> "CfgLoadouts" >> _faction));

_ctrl lbSetCurSel 0;
