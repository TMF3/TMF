#include "\x\tmf\addons\assignGear\script_component.hpp"

params ["_display"];

private _loadouts = ("true" configClasses (missionConfigFile >> "CfgLoadouts")) + ("true" configClasses (configFile >> "CfgLoadouts"));
MAP(_loadouts, toLower configName _x);
UNIQUE(_loadouts);

[_display, selectRandom _loadouts] call FUNC(gui_gearSelector_loadCategories);

private _roleCtrl = _display displayCtrl IDC_RSCGEARSELECTOR_ROLE;

_roleCtrl lbSetCurSel round random lbSize _roleCtrl;
