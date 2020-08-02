#include "\x\tmf\addons\spectator\script_component.hpp"
/*
 * Name: TMF_spectator_fnc_drawGroupMarker
 * Author: Head
 *
 * Arguments:
 * mapControl, grp, sideColor, pos
 *
 * Return:
 * N/A
 */
params ['_map', '_grp','_color', '_pos'];
 private _tmfGrpMarkerData = [_x] call EFUNC(orbat,getGroupMarkerData);
// if we have a framework orbat marker, use it.
if(count _tmfGrpMarkerData >= 3) then {
    _tmfGrpMarkerData params ["_grpTexture","_gname","_grpTextureSize"];
    _map drawIcon [_grpTexture, [1,1,1,1], _pos, 32, 32, 0,"", 2, 0.04 , MAP_FONT];
    _map drawIcon ["#(argb,8,8,3)color(0,0,0,0)", [1,1,1,1],_pos, 32, 32, 0,_gname, 0, 0.04 , MAP_FONT];
    if(_grpTextureSize != "") then { _map drawIcon [_grpTextureSize, [1,1,1,1],_pos, 32, 32, 0,"", 0, 0.04 , MAP_FONT]; };
}
else { // here we draw the default icons if TW grp makers arent present
    _map drawIcon ["\A3\ui_f\data\map\markers\nato\b_unknown.paa", _color,_pos, 32, 32, 0,"", 0, 0.04 , MAP_FONT];
    _map drawIcon ["#(argb,8,8,3)color(0,0,0,0)", [1,1,1,1], _pos, 32, 32, 0,groupID _x, 0, 0.04 , MAP_FONT];
};