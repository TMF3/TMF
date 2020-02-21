#include "\x\tmf\addons\assignGear\script_component.hpp"

disableSerialization;
params ["_display", "_selectedIndex", "_initialFaction"];

private _ctrl = _display displayCtrl IDC_RSCGEARSELECTOR_FACTION;
lbClear _ctrl;
private _category = (_display displayCtrl IDC_RSCGEARSELECTOR_CATEGORY) lbText _selectedIndex;

private _loadouts = [];
private _isMission = false;

switch (_category) do {
    case "From Mission File": { _isMission = true; _loadouts = "true" configClasses (missionConfigFile >> "CfgLoadouts") };
    case "Other": { _loadouts = "true" configClasses (configFile >> "CfgLoadouts") select {!isText (_x >> "category")} };
    default { _loadouts = "true" configClasses (configFile >> "CfgLoadouts") select {getText (_x >> "category") isEqualTo _category} };
};

// Sort alphabetically and hide duplicate configFile/missionConfigFile loadouts
MAP(_loadouts, [ARR_2(getText (_x >> "displayName"), toLower configName _x)]);
if !(_isMission) then {
    FILTER(_loadouts, !isClass (missionConfigFile >> (_x # 1)));
};
_loadouts = [_loadouts] call BIS_fnc_sortBy;

{
    private _index = _ctrl lbAdd (_x # 0);
    _ctrl lbSetData [_index, (_x # 1)];
} forEach _loadouts;

private _selectedIndex2 = 0;

if !(isNil "_initialFaction") then {
    _selectedIndex2 = _loadouts findIf {_x # 1 isEqualTo _initialFaction};
    _ctrl lbSetCurSel _selectedIndex2;
} else {
    _ctrl lbSetCurSel _selectedIndex2;
};

[_display, _selectedIndex2] call FUNC(gui_gearSelector_loadRoles);
