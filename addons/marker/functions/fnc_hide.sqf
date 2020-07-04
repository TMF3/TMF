params ["_mkrName","_side"];
if(!hasInterface) exitWith {};
if(_side != 1 && side player == west) exitWith {_mkrName setMarkerAlphaLocal 0};
if(_side != 0 && side player == east) exitWith {_mkrName setMarkerAlphaLocal 0};
if(_side != 2 && side player == resistance) exitWith {_mkrName setMarkerAlphaLocal 0};
if(_side != 3 && side player == civilian) exitWith {_mkrName setMarkerAlphaLocal 0};
if(_side == 4) exitWith {_mkrName setMarkerAlphaLocal 0};