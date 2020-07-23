#include "\x\tmf\addons\spectator\script_component.hpp"
if(!([] call FUNC(isOpen))) exitWith {};
disableSerialization;
private _treeView = (uiNamespace getVariable [QGVAR(unitlist),controlNull]);

if(GVAR(clearGroups)) then {
    GVAR(clearGroups) = false;
    tvClear _treeView;
};
private _grps = allGroups select {side _x in GVAR(sides) && (units _x) findIf {alive _x} >= 0};
if (GVAR(playersOnly)) then {
   _grps = _grps arrayIntersect (playableUnits apply {group _x});
};
private _lookupGroups = _grps apply {[_x call BIS_fnc_netId, _x]};

private _toDelete = [];
private _foundGroups = [];
private _items = [];
for "_index" from 0 to (_treeView tvCount []) do {
    private _netId = _treeView tvData [_index];

    _grpIndex = _lookupGroups findIf {(_x # 0) == _netId };
    if(_grpIndex >= 0) then {
        private _grp = ((_lookupGroups # _grpIndex) # 1);
        _foundGroups pushBack _grp;
        if(((units _grp) findIf {alive _x}) >= 0) then {
            private _deleteRows = [];
            for "_childIndex" from 0 to (_treeView tvCount [_index]) do {
                private _unitId = _treeView tvData [_index, _childIndex];
                private _unit = _unitId call BIS_fnc_objectFromNetId;
                if(!alive _unit || (group _unit) != _grp) then {
                    _deleteRows pushBack _childIndex;
                } else {
                    private _icon = getText (configFile >> "CfgVehicles" >> typeof (vehicle _unit) >> "icon");
                    if (isText (configfile >> "CfgVehicleIcons" >> _icon )) then {
                        _icon = getText (configfile >> "CfgVehicleIcons" >> _icon );
                    };
                    _treeView tvSetPicture [[_index, _childIndex], _icon];
                }
            };
            {
                _treeView tvDelete [_index, _x];
            } forEach _deleteRows;
        } else {
            _toDelete pushBack _index;
        };
    } else {
        _toDelete pushBack _index;
    };
};

{
    _treeView tvDelete [_x];
} forEach _toDelete;

{
    [_x] call FUNC(createGroupNode);
} forEach (_grps - _foundGroups);
