#include "\x\tmf\addons\orbat\script_component.hpp"
//TODO - implement for respawn module. Should work now?

// Function to add groupMarkers to the TMF group marker system.

params["_parent","_ourName","_style","_gSize",["_entity",objNull]];

// MAXDISTPOST -> furtherest away child from mean, MinDistPos -> Closest sibling
// NAME, TEXTURE, COLOUR, SIZE, POS, MINDISTPO (neighoubrS, MAXDISTPOS (neighbour), RANK, <ENTITY>


private _line = [_ourName,_style select 0,_style select 1,_style select 2,[0,0,0],[0,0,0],[0,0,0],_gSize];

//End result
//_rootData params ["_text", "_texture1", "_texture2", "_color", "_size", "_pos"];

if (!isNull _entity) then {
    _line pushBack _entity;
    private _pos = [0,0,0];
    if(_entity isEqualType grpNull) then {_pos = getPos leader _entity};
    if(_entity isEqualType objNull) then {_pos = getPos _entity};
    _line set [4,_pos];
};

private _place = [];
if (_parent != "") then {
	_place = [GVAR(orbatMarkerArray), _parent] call BIS_fnc_findNestedElement;
};
if (count _place == 0) then {
	if (count GVAR(orbatMarkerArray) == 0) then {
		GVAR(orbatMarkerArray) pushBack _line;
	} else {
		GVAR(orbatMarkerArray) pushBack [_line];
	};
} else {
    private _subArray = GVAR(orbatMarkerArray);
    for "_i" from 0 to ((count _place)-3) do {
        _subArray = _subArray select (_place select _i);
    };
    _subArray pushBack [_line];
};

