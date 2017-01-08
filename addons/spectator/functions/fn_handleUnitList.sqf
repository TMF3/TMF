#include "\x\tmf\addons\spectator\script_component.hpp"

disableSerialization;

if(GVAR(unitUpdate) > time) exitWith {};
GVAR(unitUpdate) = time+(random 3 max 1);

private _unitListControl = (uiNamespace getVariable [QGVAR(unitlist),controlNull]);

if(GVAR(clearGroups)) then { /* Used by UI which groups to display */
    GVAR(clearGroups) = false;

    // clear everything
    tvClear _unitListControl;
    GVAR(groups) = [];
    GVAR(allunits) = [];
};
private _newGroups = [];
if(!GVAR(playersOnly)) then { _newGroups = (allGroups select {{alive _x && side _x in tmf_spectator_sides} count units _x > 0}) - GVAR(groups); }
else { _newGroups = (allGroups select {{alive _x && {side _x in tmf_spectator_sides} &&
{{isPlayer _x || _x in playableUnits} count (units _x) > 0}} count units _x > 0}) - GVAR(groups); };

// check if any new groups appeard
if((count _newGroups) > 0) then {

    _grps = (GVAR(groups)+_newGroups);
    //Reset/redraw all.
    tvClear _unitListControl;
    GVAR(groups) = [];
    //Remove AI
    if (GVAR(playersOnly)) then { _grps = _grps select {{isPlayer _x || _x in playableUnits} count (units _x) > 0}; };
    // create tee nodes
    {
        [_x] call FUNC(createGroupNode);
    } forEach _grps;
};

private _deadGroups = [];
{
    _path = [_forEachIndex];
    _count = _unitListControl tvCount _path;
    if(_count != {alive _x} count units _x) then {
        // Delete all units
        while {_count > 0} do {
            _unitListControl tvDelete [_forEachIndex,0];
            _count = _unitListControl tvCount _path;
        };

        private _units = (units _x select {alive _x});
        if(count _units > 0) then {
            //Re-create units
            {
                [_x,_path select 0] call FUNC(createUnitNode);
            } forEach (units _x select {alive _x});
        } else {
            //Mark group for deletion.
            _deadGroups pushBack [_forEachIndex,_x];
        };
    };
} forEach GVAR(groups);


{
    _x params ["_index","_grp"];
    _unitListControl tvDelete [_index - _forEachIndex]; // Use _forEachIndex to offset the index change after each deletion
    GVAR(groups) = GVAR(groups) - [_grp];
} forEach _deadGroups;

// TODO - Consider making curSel set to GVAR(target)
// _unitListControl tvSetCurSel _index;
