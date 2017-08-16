#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_display", "_ctrlGrp", "_ctrlTitle", "_data"];

_ctrlTitle ctrlSetText "Player Steam Profile(s)";

private _ctrlText = _display ctrlCreate ["RscStructuredText", -1, _ctrlGrp];
_ctrlText ctrlSetPosition ctrlPosition _ctrlGrp;
_ctrlText ctrlCommit 0;
GVAR(modalControls) = [_ctrlText];

private _text = "";
{
	if ((_forEachIndex % 2) == 0) then {
		_text = format [
			"%1<t size='1' align='left'><a color='#FFC04D' href='http://steamcommunity.com/profiles/%2'>%3</a></t>", 
			_text,
			getPlayerUID _x,
			name _x
		];
	} else {
		_text = format [
			"%1<t size='1' align='right'><a color='#FFC04D' href='http://steamcommunity.com/profiles/%2'>%3</a></t><br/>", 
			_text,
			getPlayerUID _x,
			name _x
		];
	};
} forEach _data;

diag_log _text;
_ctrlText ctrlSetStructuredText parseText _text;