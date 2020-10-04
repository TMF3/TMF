#include "\x\tmf\addons\spectator\script_component.hpp"
/*
 * Name: TMF_spectator_fnc_drawVehicleMarker
 * Author: Head
 *
 * Arguments:
 * mapControl, grp, sideColor, pos
 *
 * Return:
 * N/A
 */
params ["_map","_veh", "_color", "_grpPos"];
private _pos = (getPosVisual _veh);
private _size = 19;
private _icon = _veh getVariable [QGVAR(mapIcon),""];
if(_icon == "") then {
    _icon = getText (configfile >> "CfgVehicles" >> typeOf (vehicle _veh) >> "icon");
    _veh setVariable [QGVAR(mapIcon),_icon];
};
private _vehicleName = _veh getVariable [QGVAR(_vehicleName),""];
if(_vehicleName == "") then {
    _vehicleName = getText ( configFile >> "CfgVehicles" >> typeOf _veh >> "displayname");
    _veh setVariable [QGVAR(_vehicleName),_vehicleName];
};
if(isPlayer (effectiveCommander _veh)) then {
    _vehicleName = name (effectiveCommander _veh);
};
private _name = format ["%1 [%2]",_vehicleName, count crew _veh];
_map drawIcon [_icon,_color,_pos,_size,_size,getDir _veh,"",0, 0.04, MAP_FONT];
_map drawIcon ["#(argb,8,8,3)color(0,0,0,0)",[1,1,1,1],_pos,_size,_size,0, _name,0, 0.04,MAP_FONT];
if(GVAR(showlines)) then {_map drawLine [_pos,_grpPos,_color]};