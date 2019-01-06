#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_display"];


private _control = (_display displayCtrl IDC_TMF_ADMINMENU_RESP_FACTION);
lbClear _control;

private _activeFactionCategory = GVAR(currentFactionCategory);

private _factions = [];

/* Fill Faction categories */
private _playerFactions = [] call CBA_fnc_hashCreate;
{
	private _faction = _x getVariable ["tmf_assignGear_faction",""];
	if (_faction != "") then {
		if ([_playerFactions,_faction] call CBA_fnc_hashHasKey) then {
			private _value = [_playerFactions,_faction] call CBA_fnc_hashGet;
			[_playerFactions,_faction,_value + 1] call CBA_fnc_hashSet;
		} else {
			[_playerFactions,_faction,1] call CBA_fnc_hashSet;
		};
	};
} forEach allPlayers;

if (_activeFactionCategory == "mission") then {
	// use missionConfigFile
	{
		private _factionName = (toLower(configName _x));
		_factions pushBackUnique [getText(_x >> "displayName"),_factionName];
	} forEach (configProperties [missionConfigFile >> "CfgLoadouts","isClass _x"]);

} else {
	// Then configFile
	{
		private _category = toLower (getText (_x >> "category"));
		if (_category == "") then {_category = "Other";};
		if (_activeFactionCategory == _category) then {
			private _factionName = (toLower(configName _x));
			_factions pushBackUnique [getText(_x >> "displayName"),_factionName];
		};
	} forEach (configProperties [configFile >> "CfgLoadouts","isClass _x"]);
};

//Alphabetical sort.
_factions sort true;

{
	_x params ["_displayName","_configName"];
	private _players = 0;
	// Mission factioni class overrides so show 0 if configFile class is of same name.
	if (_activeFactionCategory != "mission" && {isClass (missionConfigFile >> "CfgLoadouts" >> _configName)}) then {
		_players = 0;
	} else {
		if ([_playerFactions,_configName] call CBA_fnc_hashHasKey) then {
			_players = [_playerFactions,_configName] call CBA_fnc_hashGet;
		};
	};
	private _text = _displayName;
	if (_players > 0) then {
		_text = format ["%1 (%2p)",_displayName,_players];
	};
	private _index = _control lbAdd _text;
	_control lbSetData [_index, _configName];
} forEach _factions;
// missionConfigFile first, only add unique factions now

if (lbSize _control > 0) then {
	_control lbSetCurSel 0; // set to first element.
};
