#include "\a3\3DEN\UI\dikCodes.inc"
#include "\a3\3DEN\UI\resincl.inc"

#define COMMIT_TIME	0.1

_mode = [_this,0,"",[""]] call bis_fnc_param;
_params = [_this,1,[],[[]]] call bis_fnc_param;

switch _mode do {
	case "onLoad": {
		_display = _params select 0;

		//--- Scene Init (ToDo: Move to engine?)
		[_display] spawn {
			disableserialization;
			_display = _this select 0;

			//--- Register init event handlers
			_inits = [];
			{
				_init = gettext (_x >> "init");
				if (_init != "") then {_inits pushback [[_display],compile _init];};
			} foreach configproperties [configfile >> "Cfg3DEN" >> "EventHandlers","isclass _x"];

			//--- Call init event handlers
			{
				private ["_display","_inits"];
				(_x select 0) call (_x select 1);
			} foreach _inits;
		};
	};
};