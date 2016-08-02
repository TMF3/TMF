params ["_dir"];
if(_dir > 360) then {_dir = abs(360-_dir)};
if(_dir < 0) then {_dir = 360+_dir};
_dir = [_dir,45] call BIS_fnc_roundDir;
_cardianl = switch (_dir) do {
    case 0: {
    	"N"
    };
    case 45: {
    	"NE"
    };
    case 90: {
    	"E"
    };
    case 135: {
    	"SE"
    };
    case 180: {
    	"S"
  };
    case 225: {
    	"SW"
    };
    case 270: {
    	"W"
  };
  case 315: {
  	"NW"
  };
  case 360: {
  	"N"
  };
};
_cardianl
