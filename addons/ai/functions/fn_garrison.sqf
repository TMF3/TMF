#include "\x\tmf\addons\AI\script_component.hpp"
params ["_logic","_units","_activated"];


_headless = (synchronizedObjects _logic) select {_x isKindOf "HeadlessClient_F" && !local _x};
if(count _headless > 0 && isServer) exitWith {
    _this remoteExec [QFUNC(garrison), _headless select 0];
};

if(!(_logic getVariable [QGVAR(init),false])) then
{
    private _grps = [];
    {_grps pushBackUnique group _x} foreach (synchronizedObjects _logic);
    private _units = [];
    {
        if(side _x != sideLogic) then
        {
            {
                _units pushBack [side _x,typeof _x,getUnitLoadout _x];
                deleteVehicle _x;
            } foreach units _x;
        };
    } foreach _grps;
    _logic setVariable [QGVAR(units),_units];
    _logic setVariable [QGVAR(init),true];
};

if(!_activated) exitWith {};

_houseRatio = _logic getVariable ["houseratio", 0.7];
_unitRatio = _logic getVariable ["unitRatio", 0.7];
_debug = _logic getVariable ["Debug",false];
_areas = (synchronizedObjects _logic) select {side _x == sideLogic && _x isKindOf QGVAR(area)};
_units = _logic getVariable [QGVAR(units),[]];
_mainGroup = createGroup ((_units select 0) select 0);
_holdPos = _logic getVariable ["hold", false];
if(count _areas > 0) then {
    {
        _areaLogic = _x;
        (_areaLogic getvariable ["objectArea",[0,0,0,false,0]]) params ["_a","_b","_dir","_isrect"];
        _houses = ((getpos _x) nearObjects ["House", _a * _b]) select {count (_x buildingPos -1) > 0 && (getpos _x) inArea [getpos _areaLogic,_a , _b, _dir, _isrect]};
        _numberOfHouses =  count _houses * _houseRatio;
        while {_numberOfHouses > 0} do {
            _house = selectRandom _houses;
            _bPoses = _house buildingPos -1;
            _numberOfUnits = count _bPoses * _unitRatio;
            while {_numberOfUnits > 0} do {
                _bPosIndex = floor random count _bPoses;
                _bPos = _bPoses select _bPosIndex;

                _unitData = selectRandom _units;
                _unit = _mainGroup createUnit [_unitData select 1, _bPos, [], 0, "NONE"];
                _unit setPosATL _bPos;

                if(_holdPos) then {
                    _unit disableAI "PATH";
                    _unit setUnitPos "UP";
                };

                if(_debug) then {
                    _mkr = createMarker [str (random 999),_bPos];
                    _mkr setMarkerShape "ICON";
                    _mkr setMarkerType "mil_dot";
                    _mkr setMarkerSize [0.5,0.5];
                    _mkr setMarkerColor "ColorRed";
                    _mkr setMarkerText (_unitData select 1);
                };

                _bPoses set [_bPosIndex,0];
                _bPoses = _bPoses - [0];
                _numberOfUnits = _numberOfUnits -1;
            };

            _numberofHouses = _numberofHouses -1;
            _houses = _houses - [_houses];
        };
    } foreach _areas;
};
