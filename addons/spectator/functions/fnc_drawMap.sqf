#include "\x\tmf\addons\spectator\script_component.hpp"
/*
 * Name: TMF_spectator_fnc_drawMap
 * Author: Head
 *
 * Arguments:
 * mapControl
 *
 * Return:
 * N/A
 */
params ["_map"];


if(!GVAR(showMap)) exitWith {};

ctrlSetFocus (uiNamespace getVariable QGVAR(unitlist));

_map drawIcon [CAMERA_ICON, [0,0,0,1],getPos GVAR(camera),20,20,getDir GVAR(camera),"",0];

{
    private _grp = _x;
    private _grpCache = _grp getVariable [QGVAR(grpCache),[[],[1,1,1,1],false]];
    _grpCache params ["_grpPos","_color","_isAI"];


    // Draw the group marker if we arent an AI group.
    if(GVAR(showGroupMarkers) == 1 || {!_isAI}) then {   
        [_map, _grp, _color, _grpPos] call FUNC(drawGroupMarker);
    };
    private _units = [];
    private _vehicles = [];


    {
        private _unit = _x;
        if(!isNull objectParent _unit) then {
            _vehicles pushBackUnique objectParent _unit;
        } else {
            [_map, _unit, _color, _grpPos] call FUNC(drawUnitMarker);
        }
    } forEach (units _grp select {alive _x});

    {
        [_map, _x, _color, _grpPos] call FUNC(drawVehicleMarker);
    } forEach (_vehicles select {alive _x});

} forEach allGroups;

{
    private _data = _x getVariable [QGVAR(objectiveData),[]];
    if(count _data > 0) then {
        _data params ["_icon","_text","_color"];
        private _pos = getpos _x;
        _map drawIcon  [_icon, _color,_pos, 32, 32, 0,"", 2,0.04, MAP_FONT];
        if(_text != "") then {
            _map drawIcon ["#(argb,8,8,3)color(0,0,0,0)", [1,1,1,_color select 3],_pos, 32, 32, 0,_text, 2,0.04, MAP_FONT];
        };
    };
} foreach GVAR(objectives);

{
    _X params ["_unit","_time","_killer","_deadSide","_killerSide",["_dName", ""],"_kName","_weapon","_isPlayer"];
    _time = time - _time;
    _name = "";
    if(_isPlayer) then {_name = _dName};
    if(_time <= 10) then {
        _map drawIcon [KIA_ICON,[1,1,1,1 - (0.1 * _time)],getpos _unit,16,16,0,_name,0,0.04, MAP_FONT];
    };
} foreach GVAR(killedUnits);


if(GVAR(tracers)) then {
    {
        _x params ["_object","_posArray","_last","_time","_type"];
        _pos = _posArray select (count _posArray-1);
        if(!isNull _object) then {
            private _pos = (getPosATLVisual _object);
            if(surfaceIsWater _pos) then {_pos = getPosASLVisual _object;};
        };
        if(_type > 0) then {
            private _icon = switch (_type) do {
                case 1 : { GRENADE_ICON };
                case 2 : { SMOKE_ICON };
                case 3 : { MISSILE_ICON };
            };
            _map drawIcon [_icon, [1,0,0,1], _pos, 10, 10,0,"",0];
            _map drawLine [_posArray # 0, _pos, [1,0,0,1]];
        };
        if(_type == 0 && !isNull _object) then {
            _pos = getpos _object;
            _futurePos = _pos vectorAdd ((vectorDirVisual _object) vectorAdd (velocity _object vectorMultiply 0.3));
            _map drawLine [_pos, _futurePos, [1,0,0,1]];
        };
    } forEach GVAR(rounds);
};

[QGVAR(draw2D), [_campos]] call CBA_fnc_localEvent;
