/*
 * Name = TMF_assignGear_fnc_loadFactionCategories
 * Author = Head, Nick, Snippers
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
params ["_control"];

//TODO - Auto select the correct option.

// Clear control
lbClear _control;

private _selected = (get3DENSelected 'object' + get3DENSelected 'logic');
private _activeFaction = "";
if (count _selected > 0) then {
    _activeFaction = (((_selected select 0) get3DENAttribute "TMF_assignGear_faction") select 0);
    ISNILS(_activeFaction, "");
};
_activeFaction = toLower _activeFaction;

// Check if it is loading factions for the AI loadout macro system, if so require the 'AI' class
private _condition = if ((_selected select 0) isKindOf QGVAR(moduleLoadoutMacro)) then
[
    {"isClass _x && {isClass (_x >> 'AI')}"},
    {"isClass _x"}
];

private _found = false;
GVAR(currentFactionCategory) = "";
private _missionConfig = (configProperties [missionConfigFile >> "CfgLoadouts",_condition]);
private _index = -1;

if (count _missionConfig > 0) then {
    _index = _control lbAdd "From Mission File";
    _control lbSetData [_index, "mission"];

    {
        private _factionName = (toLower(configName _x));
        if (_factionName isEqualTo _activeFaction) exitWith {
            _control lbSetCurSel _index;
            GVAR(currentFactionCategory) = "mission";
            _found = true;
        };
    } forEach _missionConfig;
};

private _factionCategories = [];
private _activeFactionCategory = "";
{
    private _category = getText (_x >> "category");
    if (_category isEqualTo "") then {_category = "Other";};

    if (toLower (configName _x) == _activeFaction) then {
        _activeFactionCategory = _category;
    };

    _factionCategories pushBackUnique _category;
} forEach (configProperties [configFile >> "CfgLoadouts", _condition]);

// Sort Alphabetically.
_factionCategories sort true;

{
    private _index = _control lbAdd _x;
    _control lbSetData [_index,_x];
    if((!_found) and _x == _activeFactionCategory) then {
        _found = true;
        _control lbSetCurSel _index;
        GVAR(currentFactionCategory) = _x;
    };
} forEach (_factionCategories);

if (!_found and (lbSize _control > 0)) then {
    _control lbSetCurSel 0; // set to first element.
    GVAR(currentFactionCategory) = _control lbData 0;
};
