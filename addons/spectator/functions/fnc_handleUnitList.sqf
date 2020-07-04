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
};
private _newGroups = [];
if(!GVAR(playersOnly)) then {
    _newGroups = (allGroups select {side _x in tmf_spectator_sides && {alive _x} count units _x > 0}) - GVAR(groups);
} else { 
    _newGroups = (allGroups select {side _x in tmf_spectator_sides && {alive _x && {{isPlayer _x || _x in playableUnits} count (units _x) > 0}} count units _x > 0 }) - GVAR(groups);
};

private _grps = (GVAR(groups)+_newGroups);
//Reset/redraw all.
tvClear _unitListControl;
GVAR(groups) = [];
//Remove AI
if (GVAR(playersOnly)) then { _grps = _grps select {{isPlayer _x || _x in playableUnits} count (units _x) > 0}; };
// create tee nodes
{
    [_x] call FUNC(createGroupNode);
} forEach _grps;

private _deadGroups = [];
{
    private _path = [_forEachIndex];
    private _count = _unitListControl tvCount _path;
    private _units = (units _x select {alive _x});
    if(_count != count _units) then {
        // Erase all unit entries in the tree.
        for "_i" from 0 to _count do {
            _unitListControl tvDelete [_forEachIndex,0];
        };

        if(count _units > 0) then {
            //Re-create units
            {
                [_x,_path select 0] call FUNC(createUnitNode);
            } forEach _units;
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
