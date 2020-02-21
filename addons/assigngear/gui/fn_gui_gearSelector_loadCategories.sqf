
#include "\x\tmf\addons\assignGear\script_component.hpp"

disableSerialization;
params ["_display", "_initialFaction"];

private _ctrl = _display displayCtrl IDC_RSCGEARSELECTOR_CATEGORY;
lbClear _ctrl;

// Add mission category to top
private _hasMission = false;
if (count ("true" configClasses (missionConfigFile >> "CfgLoadouts")) > 0) then {
    _ctrl lbAdd "From Mission File";
    _hasMission = true;
};

// Add configFile categories
private _categories = [];
{
    if (isText (_x >> "category")) then {
        _categories pushBackUnique getText (_x >> "category");
    } else {
        _categories pushBackUnique "Other";
    };
} forEach ("true" configClasses (configFile >> "CfgLoadouts"));

_categories sort true;

{ _ctrl lbAdd _x} forEach _categories;

// Select the category containing initial faction
if !(isNil "_initialFaction") then {
    if (isClass (missionConfigFile >> "CfgLoadouts" >> _initialFaction)) then { _ctrl lbSetCurSel 0} else {
        private _currCat = ((configFile >> "CfgLoadouts" >> _initialFaction >> "category") call BIS_fnc_GetCfgData) param [0, "Other"];
        private _currCatIndex = (_categories find _currCat) + ([0,1] select _hasMission);
        _ctrl lbSetCurSel _currCatIndex;

        [_display, _currCatIndex, _initialFaction] call FUNC(gui_gearSelector_loadFactions);
    };
} else {
    _ctrl lbSetCurSel 0;
};
