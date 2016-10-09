#include "\x\tmf\addons\autotest\script_component.hpp"

private _output = [];

private _briefingArray = getMissionConfigValue ["TMF_Briefing","[]"];
if (_briefingArray isEqualTo "[]") exitWith {[]};
if (_briefingArray isEqualType "") then { _briefingArray = call compile _briefingArray;};

_briefingArray pushBack ["Admin",[],"briefing\admin.sqf"];

private _fnc_fileExists = {
    disableSerialization;
    private _ctrl = (findDisplay 0) ctrlCreate ["RscHTML", -1];
    _ctrl htmlLoad _this;
    private _exists = ctrlHTMLLoaded _ctrl;
    ctrlDelete _ctrl;
    _exists
};


private _units = playableUnits; // Check allplayable units have a briefing
private _conditions = [];
// Check briefings exist.
{
    _x params ["_name", "_cond", "_scriptPath"];
    if ((_scriptPath) call _fnc_fileExists) then {
        //TODO: error check the briefing script for errors.
        //call compile preprocessFileLineNumbers _scriptPath;
    } else {
        _output pushBack [0,format["Briefing %1 - file missing %2", _name, _scriptPath]]; 
    };
    
    // Weed out units that are acceptable to the condition
    {
        if (_x isEqualType "") then {
            private _faction = _x;
            _units = _units select {_faction != (faction (leader _x))};
        };
        if (_x isEqualType 0) then {
            private _side = _x call tmf_common_fnc_numToSide;
            _units = _units select {_side != side _x};
        };
        if (_x isEqualType east) then {
            private _side = _x;
            _units = _units select {_side != side _x};
        };
    } forEach _cond; //Nested conditions.
} forEach _briefingArray;
                          

// Check unit conditions.
{
    private _unit = _x;
    private _unitGroup = group _unit;
    
    private _groupCond = _unitGroup getVariable ["TMF_Briefinglist", []];
    if (_groupCond isEqualType "") then { _groupCond = call compile _groupCond; };
    private _unitCond = _unit getVariable ["TMF_Briefinglist", []];
    if (_unitCond isEqualType "") then { _unitCond = call compile _unitCond; };
    
    if (count (_groupCond + _unitCond) > 0) then {
        _units set [_forEachIndex,objNull];
    };
} forEach _units;

_units = _units - [objNull];

if (count _units > 0) then {
    _output pushBack [1,"Some units do not have an associated briefing:"];
    _output pushBack [1,format ["units (%1): %2",count _units,str _units]]; 
};

_output;