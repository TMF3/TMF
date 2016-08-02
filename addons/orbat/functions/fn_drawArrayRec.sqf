#include "\x\tmf\addons\orbat\script_component.hpp"

params["_in", "_mapControl"];
if (count _in == 0) exitWith {};

_in params ["_rootData"];
_rootData params ["_text", "_texture1", "_color", "_size", "_pos", "_minSiblingPos", "_maxChildPos", "_texture2"];

private _hasChildren = count _in > 1;
private _drawMe = !_hasChildren; // no children = draw me.

//Calculate the distances using the cached postions.
private _myPos = _mapControl posWorldToScreen _pos;
private _minSiblingDist = _myPos distanceSqr (_mapControl posWorldToScreen _minSiblingPos);

if (_hasChildren) then {
    private _maxChildCenterDist = _myPos distanceSqr (_mapControl posWorldToScreen _maxChildPos);
    if (_maxChildCenterDist < 0.0025) then {
        _drawMe = true;  
    };
	if (_texture1 isEqualTo "") then { _drawMe = false;};
};

// Draw this.
if (_drawMe) then {
	_size params ["_sizeX","_sizeY"];
	
	//Draw Text label (with shadow)
	if (_minSiblingDist >=  0.0014) then {
		_mapControl drawIcon ["#(argb,8,8,3)color(0,0,0,0)",[1,1,1,1],_pos, _sizeX, _sizeY,0,_text,2,0.035,'PuristaSemibold','right'];
	}; 
	
	//Draw Icon
	_mapControl drawIcon [_texture1, _color, _pos, _sizeX, _sizeY, 0];
	
	//Draw texture 2 on top.
	if (_texture2 != "") then {
		_mapControl drawIcon [_texture2,[1,1,1,1],_pos, _sizeX, _sizeY,0,"",0];  
	};
} else { // Draw the children instead.
	for "_i" from 1 to (count _in - 1) do {
		[(_in select _i), _mapControl] call FUNC(drawArrayRec); 
	};
};