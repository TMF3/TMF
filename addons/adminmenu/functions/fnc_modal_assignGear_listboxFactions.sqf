#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;

params ["_ctrlCheckBox", "_onlyPresent"];

private _factions = [];

if (_onlyPresent isEqualTo 1) then {
    private _missionFactionsFound = [];
    {
        private _faction = _x getVariable [QEGVAR(assigngear,faction), ""];
        if !(_faction isEqualTo "") then {
            _missionFactionsFound pushBackUnique toLower _faction;
        };
    } forEach allPlayers;

    {
        private _displayName = getText (missionConfigFile >> "CfgLoadouts" >> _x >> "displayName");
        private _fromMissionConfig = 1;
        if (_displayName isEqualTo "") then {
            _displayName = getText (configFile >> "CfgLoadouts" >> _x >> "displayName");
            _fromMissionConfig = 0;
        };

        _factions pushBack [_displayName, _x, _fromMissionConfig];
    } forEach _missionFactionsFound;
} else {
    private _missionConfigFactions = [];
    {
        _missionConfigFactions pushBack toLower configName _x;
        _factions pushBack [getText (_x >> "displayName"), configName _x, 1];
    } forEach ("true" configClasses (missionConfigFile >> "CfgLoadouts"));

    {
        if !((toLower configName _x) in _missionConfigFactions) then {
            _factions pushBack [getText (_x >> "displayName"), configName _x, 0];
        };
    } forEach ("true" configClasses (configFile >> "CfgLoadouts"));
};

_factions sort true;

private _ctrlComboFaction = _ctrlCheckBox getVariable [QGVAR(association), controlNull];
{
    _x params ["_displayName", "_className", "_fromMissionConfig"];
    if (_fromMissionConfig isEqualTo 1) then {
        _displayName = format ["%1 *", _displayName];
    };

    _ctrlComboFaction lbAdd _displayName;
    _ctrlComboFaction lbSetData [_forEachIndex, _className];
    _ctrlComboFaction lbSetValue [_forEachIndex, _fromMissionConfig];
} forEach _factions;

private _numFactions = count _factions;
while {lbSize _ctrlComboFaction > _numFactions} do {
    _ctrlComboFaction lbDelete _numFactions;
};

if (_numFactions > 0 && ((lbCurSel _ctrlComboFaction) < 0 || (lbCurSel _ctrlComboFaction) >= _numFactions)) then {
    _ctrlComboFaction lbSetCurSel 0;
};
