#include "\x\tmf\addons\AI\script_component.hpp"
params ["_logic","_units","_activated"];

private _headless = (synchronizedObjects _logic) select {_x isKindOf "HeadlessClient_F" && !local _x};
if(count _headless > 0 && isServer) exitWith {
    _this remoteExec [QFUNC(garrison), _headless select 0];
};

if(!(_logic getVariable [QGVAR(init),false])) then
{
    private _grps = [];
    {_grps pushBackUnique group _x} forEach (synchronizedObjects _logic);
    private _unitData = [];
    {
        private _grp = _x;
        {
            _unitData pushBack [side _x,typeOf _x,getUnitLoadout _x];
            deleteVehicle _x;
        } forEach units _grp;
        deleteGroup _grp;
    } forEach (_grps select {side _x != sideLogic});
    _logic setVariable [QGVAR(unitData),_unitData];
    _logic setVariable [QGVAR(init),true];
};

if(!_activated) exitWith {};

private _houseRatio = _logic getVariable ["houseratio", 0.7];
private _unitRatio = _logic getVariable ["unitRatio", 0.7];
private _debug = _logic getVariable ["Debug",false];
private _areas = (synchronizedObjects _logic) select {side _x == sideLogic && _x isKindOf QGVAR(area)};
private _unitData = _logic getVariable [QGVAR(unitData),[]];
private _mainGroup = createGroup ((_unitData select 0) select 0);
[_mainGroup,QGVAR(garrisonGroup),true] call tmf_common_fnc_initGroupVar;
private _holdPos = _logic getVariable ["hold", false];

if(count _areas > 0) then {
    {
        private _areaLogic = _x;
        (_areaLogic getVariable ["objectArea",[0,0,0,false,0]]) params ["_a","_b","_dir","_isrect"];
        private _buildings = ((getPos _x) nearObjects ["Static", _a * _b]) select {count (_x buildingPos -1) > 0 && {(getPos _x) inArea [getPos _areaLogic,_a , _b, _dir, _isrect]}};


        private _freeBuildings = []; // List of buildings that list have free positions.
        {
            private _building = _x;
            private _freePoses = _building getVariable [QGVAR(freeSpawnPoses),-1];

            // If building has not been initialized find the free positions.
            if (_freePoses isEqualTo -1) then {
                private _buildingPoses = _x buildingPos -1;

                // TODO - Test if positions are blocked.
                [_buildingPoses,true] call CBA_fnc_shuffle; // Shuffle for easy randomisation.
                _x setVariable [QGVAR(freeSpawnPoses),_buildingPoses];
                _freePoses = _buildingPoses;

            };
            if (count _freePoses > 0) then {
                _freeBuildings pushBack _building;
            };

        } forEach _buildings;

        [_freeBuildings,true] call CBA_fnc_shuffle;
        private _numberOfHouses = round (count _freeBuildings * _houseRatio);
        for "-" from 1 to _numberOfHouses do {
            private _building = _freeBuildings deleteAt 0;
            private _freeBuildingPositions = _building getVariable [QGVAR(freeSpawnPoses),[]];
            // Select position

            _building setVariable [QGVAR(freeSpawnPoses),_freeBuildingPositions];

            private _numberOfUnits = round (count _freeBuildingPositions * _unitRatio);
            for "-" from 1 to _numberOfUnits do {
                private _posToUse = _freeBuildingPositions deleteAt 0;

                private _unitData = selectRandom _unitData;
                _unitData params ["","_unitClassname","_unitLoadout"];
                private _unit = _mainGroup createUnit [_unitClassname, _posToUse, [], 0, "NONE"];
                _unit setPosATL _posToUse;
                _unit setUnitLoadout [_unitLoadout,false];

                if(_holdPos) then {
                    _unit disableAI "PATH";
                    _unit setUnitPos "UP";
                };

                if(_debug) then {
                    private _mkr = createMarker [str (random 999),_posToUse];
                    _mkr setMarkerShape "ICON";
                    _mkr setMarkerType "mil_dot";
                    _mkr setMarkerSize [0.5,0.5];
                    _mkr setMarkerColor "ColorRed";
                    _mkr setMarkerText (_unitClassname);
                };
            };

            // Set free positions left in building.
            _building setVariable [QGVAR(freeSpawnPoses),_freeBuildingPositions];
        };
    } forEach _areas;
} else {
    ERROR_MSG("TMF Garrison module has no TMF Area connected to it.");
};

_logic setVariable ["spawned_units",units _mainGroup,true]; // global set variable
