/*
 * Name: TMF_common_fnc_drawLines
 * Author: Head
 *
 * Arguments:
 * List of positions
 * Color
 *
 * Return:
 * nil
 *
 * Description:
 *
 */
 params ["_posList","_color"];
 private _prevPos = _posList select 0;
 if(count _posList <= 1) exitWith {};
 for "_i" from 1 to (count _posList)-1 do {
     drawLine3D [_prevPos,_posList select _i,_color];
     _prevPos = _posList select _i;
 };
