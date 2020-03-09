
/*
 * Name: TMF_spectator_fnc_drawUnitMarker
 * Author: Head
 *
 * Arguments:
 * mapControl, grp, sideColor, pos
 *
 * Return:
 * N/A
 */
#include "\x\tmf\addons\spectator\script_component.hpp"
params ["_map","_unit", "_color", "_grpPos"];
private _pos = (getPosVisual _unit);
private _icon = _unit getVariable [QGVAR(mapIcon),""];
private _size = 0.5/ctrlMapScale _map;
if(_icon == "") then {
    _icon = getText (configfile >> "CfgVehicles" >> typeOf (vehicle _unit) >> "icon");
    _unit setVariable [QGVAR(mapIcon),_icon];
};

_map drawIcon [_icon,_color,_pos,_size,_size,getdir _unit,"",0,0.04, MAP_FONT];
if(isPlayer _unit) then {
    _map drawIcon ["#(argb,8,8,3)color(0,0,0,0)",[1,1,1,1],_pos,_size,_size,0,name _x,1,0.04, MAP_FONT];
};
if(GVAR(showlines)) then {_map drawLine [_pos,_grpPos,_color]};