#include "\x\tmf\addons\orbat\script_component.hpp"

params ["_unit",
        ["_reset",false]];

if(_reset) then
{
    GVAR(orbatMarkerArray) = [];
    // Start with just platoon marker.

    GVAR(orbatRawData) = [];
    tmf_orbatTracker_id = 0;
};

// Raw Data is used for briefing creation so ensure it is set regardless.
GVAR(orbatRawData) = getMissionConfigValue ["TMF_ORBATSettings",[]];
if (GVAR(orbatRawData) isEqualType "") then { GVAR(orbatRawData) = call compile GVAR(orbatRawData)};


if ((getMissionConfigValue ["TMF_ORBATTracker",false]) isEqualTo false) exitWith {};


/*
EXAMPLE:
OrbatSettings_Array = [
            [west,[
                    [0,"1PLT","x\tmf\addons\orbat\textures\yellow.paa","x\tmf\addons\orbat\textures\modif_3dot.paa"],
                    [
                        [[1,"A","x\tmf\addons\orbat\textures\red_inf.paa","x\tmf\addons\orbat\textures\modif_dot.paa"],[]]
                    ]
                   ]],
            [east,[
                    [2,"2PLT","x\tmf\addons\orbat\textures\yellow.paa","x\tmf\addons\orbat\textures\modif_3dot.paa"],
                    [
                        [[3,"A","x\tmf\addons\orbat\textures\red_inf.paa","x\tmf\addons\orbat\textures\modif_dot.paa"],[]]
                    ]
                   ]]
        ];

*/

private _ourIdx = -1;
private _groups = [];
private _vehicles = [];
{
    _x params ["_condition", "_array"];
    if (_condition isEqualType 0 and {(_condition call EFUNC(common,numToSide)) == (side _unit)}) exitWith {
        private _side = _condition call EFUNC(common,numToSide);
        _ourIdx = _forEachIndex;
        _groups = allGroups select {side _x == _side};
        private _sideStr = str (_side call EFUNC(common,sideToNum));
        _vehicles = vehicles select {((_x getVariable ["tmf_orbat_team",""]) param [0,""]) isEqualTo _sideStr};
    };
    if ((side _unit) isEqualTo _condition) exitWith {
        private _side = _condition;
        _ourIdx = _forEachIndex;
        _groups = allGroups select {side _x == _side};
        private _sideStr = str (_side call EFUNC(common,sideToNum));
        _vehicles = vehicles select {((_x getVariable ["tmf_orbat_team",""]) param [0,""]) isEqualTo _sideStr};
    };
    if ((faction (leader (group _unit)) isEqualTo _condition)) exitWith {
        private _faction = _condition;
        _ourIdx = _forEachIndex;
        _groups = allGroups select {faction (leader _x) == _faction};
        _vehicles = vehicles select {((_x getVariable ["tmf_orbat_team",""]) param [0,""]) isEqualTo (toLower _faction)};
    };
} forEach (GVAR(orbatRawData));

// Root entry does not exist for us, so let's create one.
if (_ourIdx == -1) then {
    private _type = 0; // What are the other conditions that already exist sides (number) or factions (string)
    if (count GVAR(orbatRawData) > 0) then {
        private _firstEntry = GVAR(orbatRawData) select 0;
        if (count _firstEntry > 0) then {
            _type = _firstEntry select 0;
        };
    };
    
    // Use faction
    private _condition = (side _unit) call EFUNC(common,sideToNum);
    _groups = allGroups select {side _x == side _unit};
    if (_type isEqualType "") then {
        private _faction = faction (leader (group _unit));
        _condition = _faction;
        _groups = allGroups select {faction (leader _x) == _faction};
    };
    
    // Sub groups won't exist so ensure they are invalid.
    {_x setVariable ["TMF_OrbatParent",-1]} forEach _groups;
    
    private _newEntry = [_condition,[[0,"","","","Platoon",0],[]]];
    _ourIdx = GVAR(orbatRawData) pushBack _newEntry;
};
private _ourData = (GVAR(orbatRawData) select _ourIdx) select 1; //list of children
private _toPlace = [];
private _reserveId = (_ourData select 0) select 0;
//TODO - place any remaining unassigned groups under the master node.

// Scan for valid indexes.
private _validParents = [];
private _fnc_findValidParents = {
    if (count _this == 0) exitWith {false};
    
    _this params ["_data", ["_children",[]]];
    _data params ["_uniqueID"];
    _validParents pushBackUnique _uniqueID;
  
    {
        _x call _fnc_findValidParents;
    } forEach _children;
    
    _data pushBack _added;
};

_ourData call _fnc_findValidParents;
_validParents = _validParents - [-1];


private _playableUnits = (playableUnits+switchableUnits);

{
    if ({_x in _playableUnits} count (units _x) > 0) then {
        private _var = _x getVariable ["TMF_OrbatParent",-1];
        if (_var in _validParents) then {
            _toPlace pushBack [_var, _x];
        } else {
            _toPlace pushBack [_reserveId, _x];
        };
        
        {
            //Units use same ORABT parent as their group
            //_var = _x getVariable ["TMF_OrbatParent",-1];
            if (_var in _validParents) then {
                _toPlace pushBack [_var, _x];
            } else {
                _toPlace pushBack [_reserveId, _x];
            };
        } forEach (units _x);
    };
} forEach _groups;

{
    private _var = _x getVariable ["TMF_OrbatParent",-1];
    if (_var in _validParents) then {
        _toPlace pushBack [_var, _x];
    } else {
        _toPlace pushBack [_reserveId, _x];
    };
} forEach _vehicles;

//Identify which ones to add.

private _fnc_processOrbatTrackerRawData = {
    if (count _this == 0) exitWith {false};
    private _added = false;
    
    _this params ["_data", ["_children",[]]];
    _data params ["_uniqueID", "_markerName", "_texture1", "_texture2"];
    
    //find uniquID in to place
    {
        if (_x select 0 == _uniqueID) exitWith {
            _added = true;
        };
    } forEach _toPlace;
    

    {
        if (_x call _fnc_processOrbatTrackerRawData) then { _added = true;};
    } forEach _children;
    
    _data pushBack _added;
    
    _added;
};

_ourData call _fnc_processOrbatTrackerRawData;


// [NODE,[NODE,CHILD],[NODE],[NODE]]
_fnc_processOrbatTrackerRawData = {
    if (count _this == 0) exitWith {[]};
    
    params ["_data", "_children"];
    _data params ["_uniqueID", ["_markerName",""], ["_texture1",""], ["_texture2", ""], ["_fullName",""],"", "_toAdd"];
    
    
    if (!_toAdd) exitWith {[]};
    
    private _createdChildren = [];
    
    {
        _x params ["_id", "_entity"];
        if (_id == _uniqueID) then {
            private _isVeh = _entity in vehicles;
            if (_entity isEqualType grpNull || _isVeh) then {
                private _markerEntry = _entity getVariable ["TMF_groupMarker",[]];
                if (_markerEntry isEqualType "") then { _markerEntry = call compile _markerEntry; };
                if (count _markerEntry > 0) then {
                    _markerEntry params ["_textureC", "_markerNameC", ["_texture2C", ""]];
                    if (_textureC != "") then {
                        private _newLine = [];
                        if (_isVeh) then {
                            _newLine = [_markerNameC, _textureC, [1,1,1,1], [32,32], (getPos _entity),[0,0,0],[0,0,0], _texture2C, _entity];
                        } else {
                            _newLine = [_markerNameC, _textureC, [1,1,1,1], [32,32], (getPos leader _entity),[0,0,0],[0,0,0], _texture2C, _entity];
                        };
                        _createdChildren pushBack [_newLine];
                    };
                };
                _toPlace set [_forEachIndex,-1];
            } else {
                if (_entity isEqualType objNull) then {
                    private _markerEntry = _entity getVariable ["TMF_SpecialistMarker",[]];
                    if (_markerEntry isEqualType "") then { _markerEntry = call compile _markerEntry; };
                    if (count _markerEntry > 0) then {
                        _markerEntry params ["_textureC", "_markerNameC"];
                        if (_textureC != "") then {
                            private _newLine = [_markerNameC, _textureC, [1,1,1,1], [20,20], (getPos _entity),[0,0,0],[0,0,0], "", _entity];
                            _createdChildren pushBack [_newLine];
                        };
                    };
                    _toPlace set [_forEachIndex,-1];
                };
            };
        };
    } forEach _toPlace;
    _toPlace = _toPlace - [-1];

    
    {
        private _childData = (_x call _fnc_processOrbatTrackerRawData);
        if (count _childData > 0) then {
            _createdChildren pushBack _childData;
        };
    } forEach _children;

    private _line = call compile format["[[ '%1', '%2', [1,1,1,1], [32,32], [0,0,0], [0,0,0], [0,0,0], '%3']]",_markerName, _texture1, _texture2];
    _line append _createdChildren;
    _line
};

GVAR(orbatMarkerArray) = _ourData call _fnc_processOrbatTrackerRawData;
_fnc_processOrbatTrackerRawData = nil;
