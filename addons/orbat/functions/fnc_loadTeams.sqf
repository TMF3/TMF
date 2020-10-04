#include "\x\tmf\addons\orbat\script_component.hpp"
/*
 * Name = TMF_orbat_fnc_loadTeams
 * Author = Snippers
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
disableSerialization;
params ["_control",["_attributeValue",""]];

// Clear control
lbClear _control;


private _orbatSettingsArray = ("TMF_ORBAT_Settings" get3DENMissionAttribute "TMF_ORBATSettings");
if (_orbatSettingsArray isEqualType "") then {
    _orbatSettingsArray = call compile _orbatSettingsArray;
};

private _usingFactions = true;
if (count _orbatSettingsArray > 0) then {
    if ((((_orbatSettingsArray) select 0) select 0) isEqualType 0) then {
        _usingFactions = false;
    };
};

// Allow not being on the ORBAT.
private _index = _control lbAdd "None";
_control lbSetData [_index,""];

private _found = false; // Used to track whether or not an entry has been selected, if not at end select index.

if (_usingFactions) then {
    private _factions = []; {_factions pushBackUnique (toLower (faction _x));} forEach allUnits;
    _factions = _factions apply {
        private _faction = _x;
        [
            {toLower (faction _x) == _faction && _x in (playableUnits + [player])} count allUnits,
            {toLower (faction _x) == _faction} count allUnits,
            _x
        ]
    };
    _factions sort false;
    {
        _x params ["_playerCount","_unitCount","_faction"];
        private _displayName = getText (configfile >> "CfgFactionClasses" >> _faction >> "displayName");
        _displayName = format ["%1 - [Players: %2 All Units: %3]",_displayName,_playerCount,_unitCount];
        private _index = _control lbAdd _displayName;
        private _value = _faction;
        _control lbSetData [_index,_value];
        //_control lbSetTooltip [_index, _tooltip];
        if (_value isEqualTo _attributeValue) then {_control lbSetCurSel _index; _found = true;};
    } forEach _factions;
} else {
    private _sides = [east,west,civilian,independent] apply {
        private _side = _x;
        [
            {side _x == _side && _x in (playableUnits + [player])} count allUnits,
            {side _x == _side} count allUnits,
            _side
        ]
    };
    _sides sort false;
    {
        _x params ["_playerCount","_unitCount","_side"];
        private _displayName = _side call EFUNC(common,sideToString);
        _displayName = format ["%1 - [Players: %2 All Units: %3]",_displayName,_playerCount,_unitCount];
        private _index = _control lbAdd _displayName;
        private _value = str (_side call EFUNC(common,sideToNum));
        _control lbSetData [_index,_value];
        //_control lbSetTooltip [_index, _tooltip];
        if (_value isEqualTo _attributeValue) then {_control lbSetCurSel _index; _found = true;};
    } forEach _sides;
};

if (!_found and (lbSize _control > 0)) then {
    _control lbSetCurSel 0; // set to first element.
};
////////////////////////////
