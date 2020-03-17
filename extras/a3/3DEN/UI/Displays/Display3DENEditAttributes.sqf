#include "\a3\3DEN\UI\resincl.inc"

_mode = _this select 0;
_params = _this select 1;
_class = _this select 2;

switch _mode do {

	case "onLoad": {
		_display = _params select 0;
		_display call bis_fnc_3dentutorial;
		[] call bis_fnc_3DENIntel;
	};

	case "onUnload": {

		//--- Engine restarts the scene after closing the intel window, restore the vision mode
		-2 spawn bis_fnc_3DENVisionMode
	};
};