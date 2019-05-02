#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_display"];


GVAR(spectatorList) = [];
GVAR(selectedRespawnGroup) = [];
GVAR(respawn_rank) = 0; // initialize

if (isNil QGVAR(lastFactionSelection)) then {GVAR(lastFactionSelection) = [0,0];};
// GVAR(selectedRespawnGroup) format 
// Rank: Int (0-6), Object: Player, Role: Int (0 -> count respawnMenuRoles)

// Propogate the list of dead players.
if (!isMultiplayer) then {
    GVAR(spectatorList) append allUnits;  
} else {
    {
        if (isPlayer _x) then { //not all of them will be players.
            GVAR(spectatorList) pushBack _x;
        };
    } forEach ([0,0,0] nearEntities ["tmf_spectator_unit",500]);
    {
        if (!alive _x) then { //not all of them will be players.
            GVAR(spectatorList) pushBackUnique _x;  
        };
    } forEach allPlayers;
};


private _control = (_display displayCtrl IDC_TMF_ADMINMENU_RESP_FACTIONCATEGORY); /* respawnMenuFactionCategoryCombo */
lbClear _control;
private _missionConfig = (configProperties [missionConfigFile >> "CfgLoadouts","isClass _x"]);
private _index = -1;

// Handle all the factions

// Build up a pool of who is using what faction from assign gear.
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
} forEach (allPlayers);

if (count _missionConfig > 0) then {
    private _players = 0;
    {
        private _factionName = (toLower(configName _x));
            if ([_playerFactions,_factionName] call CBA_fnc_hashHasKey) then {
            _players = _players + ([_playerFactions,_factionName] call CBA_fnc_hashGet);
        };
    } forEach _missionConfig;

    private _text = "From Mission File";
    if (_players > 0) then {
        _text = format ["From Mission File (%1p)",_players];
    };
    private _index = _control lbAdd _text;
    _control lbSetData [_index, "mission"];
};

private _factionCategories = [];
private _factionCategoryPlayerCounts = [];
{
    private _category = getText (_x >> "category");
    if (_category isEqualTo "") then {_category = "Other";};
    private _configName = toLower (configName _x);
    private _players = 0;
    // Mission faction class overrides so show 0 if configFile class is of same name.
    if (!isClass (missionConfigFile >> "CfgLoadouts" >> _configName)) then {
        if ([_playerFactions,_configName] call CBA_fnc_hashHasKey) then {
            _players = [_playerFactions,_configName] call CBA_fnc_hashGet;
        };
    };

    private _idx = _factionCategories find _category;
    if (_idx == -1) then {
        _idx = _factionCategories pushBack _category;
        _factionCategoryPlayerCounts set [_idx,_players];
    } else {
        _factionCategoryPlayerCounts set [_idx,(_factionCategoryPlayerCounts select _idx) + _players];
    };
} forEach (configProperties [configFile >> "CfgLoadouts", "isClass _x"]);

// Combine array for sorting.
{ _factionCategories set [_forEachIndex,[_x,_factionCategoryPlayerCounts select _forEachIndex]]} forEach _factionCategories;

// Sort Alphabetically.
_factionCategories sort true;

{
    _x params ["_factionName","_players"];
    private _displayText = _factionName;
    if (_players > 0) then {
        _displayText = format ["%1 (%2p)",_displayText,_players];
    };
    private _index = _control lbAdd _displayText;
    _control lbSetData [_index,_factionName];
} forEach _factionCategories;

GVAR(currentFactionCategory) = "";
if (lbSize _control > 0) then {
    private _lastIndex = GVAR(lastFactionSelection) select 0;
    if (lbSize _control <= _lastIndex) then {
        _lastIndex = 0;
    };
    _control lbSetCurSel _lastIndex; // set to previously used element.
    GVAR(currentFactionCategory) = _control lbData _lastIndex;
    GVAR(lastFactionSelection) set [0,_lastIndex];
};
_control ctrlAddEventHandler ["LBSelChanged",{[ctrlParent (param [0])] call FUNC(respawn_factionCategoryChanged);}];

// Faction selector Control
private _lastIndex = GVAR(lastFactionSelection) select 1; // Store this before executing below code, otherwise it will override.

_control = (_display displayCtrl IDC_TMF_ADMINMENU_RESP_FACTION); /* respawnMenuFactionCombo */
lbClear _control;
_control ctrlAddEventHandler ["LBSelChanged",{[ctrlParent (param [0])] call FUNC(respawn_factionChanged);}];

[_display] call FUNC(respawn_factionCategoryChanged);

if (lbSize _control > 0) then {
    private _newIdx = lbCurSel _control;
    if (lbSize _control > _lastIndex) then {
        _control lbSetCurSel _lastIndex; // set to previously used element.
        _newIdx = _lastIndex;
    };
    GVAR(lastFactionSelection) set [1,_newIdx];
};
/* Fill Roles */

//_control = (_display displayCtrl 26896); /* Role control */

[_display] call FUNC(respawn_factionChanged);

/* Fill Side selection */

private _west = 0; private _east = 0; private _resistance = 0; private _civilian = 0;
{
    switch (side _x) do {
        case blufor: {_west = _west + 1;};
        case opfor: {_east = _east + 1;};
        case independent: {_resistance = _resistance + 1;};
        case civilian: {_civilian = _civilian + 1;};
    };
} forEach (allPlayers select {alive _x});


_control = (_display displayCtrl IDC_TMF_ADMINMENU_RESP_SIDE); /* Side control */
lbClear _control;

private _idx = _control lbAdd format["BLUFOR (%1p)",_west];
_control lbSetValue [_idx,1];
_control lbSetColor [_idx,(west) call EFUNC(common,sideToColor)];
private _idx = _control lbAdd format["OPFOR (%1p)",_east];
_control lbSetValue [_idx,0];
_control lbSetColor [_idx,(east) call EFUNC(common,sideToColor)];
private _idx = _control lbAdd format["GREENFOR (%1p)",_resistance];
_control lbSetValue [_idx,2];
_control lbSetColor [_idx,(independent) call EFUNC(common,sideToColor)];
private _idx = _control lbAdd format["Civilian (%1p)",_civilian];
_control lbSetValue [_idx,3];
if (!isNil QGVAR(selectedSide)) then {
    _control lbSetCurSel ([1,0,2,3] find GVAR(selectedSide));
} else {
    _control lbSetCurSel 0;
    GVAR(selectedSide) = 1;
};
_control ctrlAddEventHandler ["LBSelChanged",{GVAR(selectedSide) = (_this select 0) lbValue (_this select 1);}];

//Default Rank listbox
// _control = (_display displayCtrl 26897);

// {
//     _control lbAdd _x;
// } forEach ["Pvt.", "Cpl.", "Sgt.", "Lt.", "Cpt.", "Mjr.", "Col."];

// {
//     _control lbSetPicture [_forEachIndex, "\A3\Ui_f\data\GUI\Cfg\Ranks\" + _x];
// } forEach ["private_gs.paa", "corporal_gs.paa", "sergeant_gs.paa", "lieutenant_gs.paa", "captain_gs.paa", "major_gs.paa", "colonel_gs.paa"];

// _control lbSetCurSel 0;

(_display displayCtrl IDC_TMF_ADMINMENU_RESP_SPECTATORTEXT) ctrlSetText format["Players in Spectator: %1",count GVAR(spectatorList) ];

// Marker Type
_control = (_display displayCtrl IDC_TMF_ADMINMENU_RESP_MARKERTYPE);
lbClear _control;
{
    private _idx = _control lbAdd (_x select 1);
    _markerImg = (_x select 0);
    if (_markerImg != "") then {
        _control lbSetPicture[_idx,_markerImg]; 
        _control lbSetColor[_idx,[1,1,1,1]];
    };
} forEach [
    ["\A3\ui_f\data\map\markers\nato\b_hq.paa","HQ","hq"],
    ["\A3\ui_f\data\map\markers\nato\b_inf.paa","Infantry","inf"],
    ["\A3\ui_f\data\map\markers\nato\b_support.paa","MG Team","mg_m"],
    ["\A3\ui_f\data\map\markers\nato\b_motor_inf.paa","Missle (AT/AA) Team","antitank"],
    ["\A3\ui_f\data\map\markers\nato\b_recon.paa","Sniper","recon"],
    ["\A3\ui_f\data\map\markers\nato\b_mortar.paa","Mortar Team","mortar"],
    ["\A3\ui_f\data\map\markers\nato\b_motor_inf.paa","APC/IFV","inf_mech"],
    ["\A3\ui_f\data\map\markers\nato\b_armor.paa","Armour","armor"],
    ["\A3\ui_f\data\map\markers\nato\b_air.paa","Heli","helo_cargo"],
    ["\A3\ui_f\data\map\markers\nato\b_plane.paa","Airplane/Jet","fixedwing"]   
];


_control ctrlAddEventHandler ["LBSelChanged",{GVAR(MarkerIdx) = (_this select 1);}];
if (!isNil QGVAR(MarkerIdx)) then {
    _control lbSetCurSel GVAR(MarkerIdx);
} else {
    _control lbSetCurSel 0;
};

// Marker Colours
_control = (_display displayCtrl IDC_TMF_ADMINMENU_RESP_MARKERCOLOUR);
lbClear _control;
{
    private _idx = _control lbAdd (_x select 1);
    _control lbSetColor [_idx,(_x select 0)];
} forEach [
    [[1,0,0,1],"Red","red"],
    [[0,0,1,1],"Blue","blue"],
    [[0,1,0,1],"Green","green"],
    [[1,1,0,1],"Yellow","yellow"]
];

_control ctrlAddEventHandler ["LBSelChanged",{GVAR(MarkerColour) = (_this select 1);}];
if (!isNil QGVAR(MarkerColour)) then {
    _control lbSetCurSel GVAR(MarkerColour);
} else {
    _control lbSetCurSel 0;
};

// Group ID
_control = (_display displayCtrl IDC_TMF_ADMINMENU_RESP_GROUPNAME);
if (isNil QGVAR(groupName)) then {
    GVAR(groupName) = "INSERT_GROUP_NAME";
} else {
    _control ctrlSetText GVAR(groupName);
};
_control ctrlAddEventHandler ["KeyUp",{GVAR(groupName) = ctrlText (_this select 0);}];

// Marker Name
_control = (_display displayCtrl IDC_TMF_ADMINMENU_RESP_GROUPMARKERNAME);
if (isNil QGVAR(markerName)) then {
    GVAR(markerName) = "INSERT_MARKER_NAME";
} else {
    _control ctrlSetText GVAR(markerName);
};
_control ctrlAddEventHandler ["KeyUp",{GVAR(markerName) = ctrlText (_this select 0);}];

if (!isNil QGVAR(respawnGroupMarkerCheckBoxVal)) then {
    (_display displayCtrl IDC_TMF_ADMINMENU_RESP_GROUPMARKERCHECKBOX) cbSetChecked GVAR(respawnGroupMarkerCheckBoxVal);
} else {
    GVAR(respawnGroupMarkerCheckBoxVal) = false;
};

[_display] call FUNC(respawn_refreshSpectatorList);

//Use PFH to keep the lists updated ;0
[{
    params["_input", "_pfhID"];
    _input params ["_oldSpectList"];
    _display = findDisplay IDD_TMF_ADMINMENU;
    if (isNull (findDisplay IDD_TMF_ADMINMENU)) exitWith { [_pfhID] call CBA_fnc_removePerFrameHandler;} ;

    //Recompute who is alive and Dead.
    
    private _deadList = [];
    if (!isMultiplayer) then {
        _deadList append allUnits;
    } else {
        {
            if (isPlayer _x) then { //not all of them will be players.
                _deadList pushBack _x;  
            };
        } forEach ([0,0,0] nearEntities ["tmf_spectator_unit",500]);
        {
            if (!alive _x) then { //not all of them will be players.
                _deadList pushBackUnique _x;
            };
        } forEach allPlayers;
    };

    if (({_x in GVAR(spectatorList) } count _deadList) == count _deadList) exitWith {};
    
    GVAR(spectatorList) = _deadList;
    _input set [0,_deadList];
                
    (_display displayCtrl IDC_TMF_ADMINMENU_RESP_SPECTATORTEXT) ctrlSetText format["Players in Spectator: %1",count GVAR(spectatorList) ];
    
    //CHeck specatator List
    [_display] call FUNC(respawn_refreshSpectatorList);
    [_display] call FUNC(respawn_refreshGroupBox);
    
},  0.4,[]] call CBA_fnc_addPerFrameHandler;
