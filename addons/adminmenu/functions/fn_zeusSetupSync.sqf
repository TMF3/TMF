#include "\x\tmf\addons\adminmenu\script_component.hpp"

params ["_curator"];

if (getAssignedCuratorLogic player == _curator) then {
	systemChat "[TMF Admin Menu] You were given Zeus powers";

	_curator addEventHandler ["CuratorObjectPlaced", {
		_this remoteExec [QFUNC(zeusServerObjectPlacedSync), 2];
	}];
};