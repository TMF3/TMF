/*
 * Name = TMF_assignGear_fnc_loadFactions
 * Author = Head, Nick
 *
 * Arguments:
 * UI function do not use
 *
 * Return:
 * UI function do not use
 *
 * Description:
 * UI function do not use
 */
#include "\x\tmf\addons\assignGear\script_component.hpp"

disableSerialization;
params ["_control",["_activeFactionCategory",""]];

// Clear control
lbClear _control;

if (_activeFactionCategory == "") then {
    _activeFactionCategory = GVAR(currentFactionCategory);
};



// Get the selected unit
private _selected = get3DENSelected "object";
private _activeFaction = "";
if (count _selected > 0) then {
    _activeFaction = (((_selected select 0) get3DENAttribute "TMF_assignGear_faction") select 0);
    if (isNil "_activeFaction") then { _activeFaction = "";};
};
_activeFaction = toLower _activeFaction;

private _factions = [];




private _found = false;

if (_activeFactionCategory == "mission") then {
    // use missionConfigFile
    {
        private _factionName = (toLower(configName _x));
        _factions pushBackUnique [getText(_x >> "displayName"),_factionName,getText(_x >> "tooltip")];
    } forEach (configProperties [missionConfigFile >> "CfgLoadouts","isClass _x"]);

} else {
    // Then configFile
    {
        private _category = toLower (getText (_x >> "category"));
        if (_category == "") then {_category = "Other";};
        if (_activeFactionCategory == _category) then {
            private _factionName = (toLower(configName _x));
            _factions pushBackUnique [getText(_x >> "displayName"),_factionName,getText(_x >> "tooltip")];
        };
    } forEach (configProperties [configFile >> "CfgLoadouts","isClass _x"]);
};

//Alphabetical sort.
_factions sort true;

{
    _x params ["_displayName","_configName","_tooltip"];
    private _index = _control lbAdd _displayName;
    _control lbSetData [_index, _configName];
    _control lbSetTooltip [_index, _tooltip];
    if (_configName isEqualTo _activeFaction) then {_control lbSetCurSel _index; _found = true;};
} forEach _factions;
// missionConfigFile first, only add unique factions now

if (!_found and (lbSize _control > 0)) then {
    _control lbSetCurSel 0; // set to first element.
};
