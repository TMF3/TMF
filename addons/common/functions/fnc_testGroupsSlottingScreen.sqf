/*
 * Name: TMF_common_fnc_testGroupsSlottingScreen
 * Author: Snippers
 *
 * Arguments:Index of side
 *
 * Return:
 * Side
 *
 * Description:
 * checks if groups will have a custom name in the slotting screen.
 */
#include "\x\tmf\addons\autotest\script_component.hpp"

private _output = [];

// Deprecated in newer versions, replaced by CBA system
// https://github.com/CBATeam/CBA_A3/wiki/Name-Groups-in-Lobby
if ([1,0,1] isEqualTo getArray (missionConfigFile >> "tmf_version")) then {
    // Find groups with playableUnits
    private _groups = [];
    {_groups pushBackUnique (group _x);} forEach playableUnits;

    private _outputGroups = [];
    {
        private _group = _x;
        private _descriptions = [];
        private _skip = false;
        {
            private _description = (_x get3DENAttribute "description") select 0;
            if (_description find "@" != -1) exitWith {_skip = true};
            _descriptions pushBack _description;
        } forEach (units _group select {_x in playableUnits});
        if (!_skip) then {
            _descriptions = _descriptions apply {(/*toLower*/ _x) splitString " "};
            if (count (units _group) > 1) then {
                private _common = _descriptions select 0;
                {
                    // Ensure common is not more tokens than the present description.
                    _common resize ((count _x) min (count _common));
                    for "_idx2" from 0 to (count _common -1) do {
                        //diag_log str [_idx2,"c",_common,"d",_descriptions];
                        if (_common select _idx2 != _x select _idx2) exitWith { _common resize _idx2;}
                    };
                } forEach _descriptions;
                //diag_log str ["group",_common,"d",_descriptions];
                //_common = _common apply {/*toUpper*/ (_x select [0,1]) + (_x select [1])};
                if (count _common == 0) then {
                    // No common part.
                    _outputGroups pushBackUnique _group;
                };
            };
        };
    } forEach _groups;

    if (count _outputGroups > 0) then {
        _output pushBack [1,"Some groups do not have a slotting screen name:"];
        private _string = "";
        {
            _string = _string + ((side _x) call BIS_fnc_sideName) + " - " + groupID _x + ", ";
        } forEach _outputGroups;
        _output pushBack [1,format ["groups (%1): %2",count _outputGroups,_string]];
    };
};

_output;
