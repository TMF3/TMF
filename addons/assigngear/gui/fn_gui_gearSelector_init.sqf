#include "\x\tmf\addons\assignGear\script_component.hpp"

disableSerialization;
params ["_display"];

private _playerRole = CURUNIT getVariable [QGVAR(role), "r"];
private _playerFaction = CURUNIT getVariable [QGVAR(faction), faction CURUNIT];

if !(isClass (missionConfigFile >> "CfgLoadouts" >> _playerFaction) || isClass (configFile >> "CfgLoadouts" >> _playerFaction)) then {
    _playerFaction = "blu_f";
};

[_display, _playerFaction] call FUNC(gui_gearSelector_loadCategories);

// Set current role to default one
private _roleCtrl = _display displayCtrl IDC_RSCGEARSELECTOR_ROLE;
for "_i" from 0 to (lbSize _roleCtrl) do {
    if ((_roleCtrl lbData _i) isEqualTo _playerRole) exitWith {
        _roleCtrl lbSetCurSel _i;
    };
};
