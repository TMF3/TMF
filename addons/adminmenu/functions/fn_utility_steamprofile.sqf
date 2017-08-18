#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_display", "_ctrlGroup"];

private _ctrlTextPos = [0, 0];
_ctrlTextPos append ((ctrlPosition _ctrlGroup) select [2, 2]);
private _ctrlText = _display ctrlCreate ["RscStructuredText", -1, _ctrlGroup];
GVAR(utilityTabControls) = [_ctrlText];
_ctrlText ctrlSetPosition _ctrlTextPos;
_ctrlText ctrlCommit 0;

private _text = "";
{
	if (_forEachIndex > 0) then {
		_text = format ["%1, ", _text];
	};
	
	_text = format [
		"%1<t size='1'><a color='#FFC04D' href='http://steamcommunity.com/profiles/%2'>%3</a></t>", 
		_text,
		getPlayerUID _x,
		name _x
	];
} forEach GVAR(utility_data);

diag_log _text;
_ctrlText ctrlSetStructuredText parseText _text;