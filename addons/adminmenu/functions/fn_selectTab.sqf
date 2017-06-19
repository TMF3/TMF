disableSerialization;
params ["_button", ["_tab", 56200]];
private _display = ctrlParent (_button param [0]);

{
	if (_tab == _x) then {
		(_display displayCtrl _x) ctrlShow true;
		(_display displayCtrl _x) ctrlEnable true;
	} else {
		(_display displayCtrl _x) ctrlShow false;
		(_display displayCtrl _x) ctrlEnable false;
	};
} forEach [56200, 56300, 56400, 56500];