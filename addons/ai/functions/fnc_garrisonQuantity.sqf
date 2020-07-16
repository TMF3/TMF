if(is3DEN) exitWith {};
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

private _aiNumberToSpawn = _logic getVariable ["aiNumberToSpawn", 0];
//private _unitRatio = _logic getVariable ["unitRatio", 0.7];
private _debug = _logic getVariable ["Debug",false];
private _areas = (synchronizedObjects _logic) select {side _x == sideLogic && _x isKindOf QGVAR(area)};
_areas pushBack _logic; // Add the garrison module as viable area.
private _unitData = _logic getVariable [QGVAR(unitData),[]];
private _side = ((_unitData select 0) select 0);
private _mainGroup = createGroup _side;
[_mainGroup,QGVAR(garrisonGroup),true] call tmf_common_fnc_initGroupVar;
private _holdPos = _logic getVariable ["hold", false];

private _buildings = [];
{
    private _areaLogic = _x;
    (_areaLogic getVariable ["objectArea",[0,0,0,false,0]]) params ["_a","_b","_dir","_isrect"];

    private _nearObjects = ((getPos _x) nearObjects ["Static", _a * _b]) select {count (_x buildingPos -1) > 0 && {(getPos _x) inArea [getPos _areaLogic,_a , _b, _dir, _isrect]}};
    _buildings append _nearObjects;

} forEach _areas;

//TODO building filter? max/min spots (no lone wolves)

[_buildings,true] call CBA_fnc_shuffle;
private _availableBuildings = [];

private _freeBuildingSpaces = 0;
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
        _freeBuildingSpaces = _freeBuildingSpaces + count _freePoses;
    };

} forEach _buildings;
// Filter building claimed spots.


if (_aiNumberToSpawn > _freeBuildingSpaces) then {
    systemChat "TMF Garrison - Insufficent free building positions check your map for location and details.";
    private _mkr = createMarkerLocal [str (random 99999),getPos _logic];
    _mkr setMarkerShape "ICON";
    _mkr setMarkerType "mil_dot";
    _mkr setMarkerSize [0.5,0.5];
    _mkr setMarkerColor "ColorRed";
    _mkr setMarkerText format ["Error - TMF Garrison Module - Unable to find sufficent building places (%1 available / %2 needed)", _freeBuildingSpaces, _aiNumberToSpawn];
};
private _garrisonedBuildings = [];
for "_i" from 1 to (_aiNumberToSpawn min _freeBuildingSpaces) do {
    private _building = selectRandom _freeBuildings;
    private _freeBuildingPositions = _building getVariable [QGVAR(freeSpawnPoses),[]];
    // Select position
    private _posToUse = _freeBuildingPositions deleteAt 0;
    _building setVariable [QGVAR(freeSpawnPoses),_freeBuildingPositions];

    if (count _freeBuildingPositions == 0) then {
        // If building no longer has free spaces remove it from future selection.
        _freeBuildings = _freeBuildings - [_building];
    };

    private _unitData = selectRandom _unitData;
    _unitData params ["","_unitClassname","_unitLoadout"];
    private _unit = _mainGroup createUnit [_unitClassname, _posToUse, [], 0, "NONE"];
    _unit setPosATL _posToUse;
    _unit setUnitLoadout [_unitLoadout,false];

    if(_holdPos) then {
        _unit disableAI "PATH";
        _unit setUnitPos "UP";
    };
    _building setVariable
    [
        QGVAR(garrisonedUnits),
        (_building getVariable [QGVAR(garrisonedUnits),[]]) + [_unit]
    ];

    _garrisonedBuildings pushBackUnique _building;

    if(_debug) then {
        private _mkr = createMarker [str (random 999),_posToUse];
        _mkr setMarkerShape "ICON";
        _mkr setMarkerType "mil_dot";
        _mkr setMarkerSize [0.5,0.5];
        _mkr setMarkerColor "ColorRed";
        _mkr setMarkerText (_unitClassname);
    };
};
if((_logic getVariable ["unfreeze", false])) then {
    {
        private _building = _x;
        private _buildingCenter = _building modelToWorld (boundingCenter _building);
        _buildingCenter set [2,0]; // set to ground
        private _buildingSize = (boundingBox _building) # 2;
        private _trigger = createTrigger ["EmptyDetector", _buildingCenter, false];
        _trigger setVariable [QGVAR(side), _side];
        _trigger setVariable [QGVAR(units), _building getVariable [QGVAR(garrisonedUnits), []]];
        _trigger setTriggerInterval 2; // set interval to 2 seconds
        _trigger setTriggerArea [_buildingSize * 3, _buildingSize * 3, 0, false, 10];
        _trigger setTriggerActivation ["ANYPLAYER","PRESENT",false];
        _trigger setTriggerStatements [
            QUOTE(private _side = (thisTrigger getVariable [ARR_2(QQGVAR(side), opfor)]); this && ({ side _x != _side} count thisList) > 0),
            QUOTE({ _x enableAI 'PATH'; _x setUnitPos 'AUTO'; } forEach (thisTrigger getVariable [ARR_2(QQGVAR(units), [])]);),
            ""
        ];
    } forEach _garrisonedBuildings;
};

// Ensure side is corrected -- https://feedback.bistudio.com/T70739.
private _units = units _mainGroup;
_units join _mainGroup;
    
_logic setVariable ["spawned_units",_units,true]; // global set variable
