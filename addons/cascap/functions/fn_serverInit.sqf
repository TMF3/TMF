#include "\x\tmf\addons\casCap\script_component.hpp"
params ["_logic","_units","_activated"];

// Grab all associated units
_units = [_logic] call CFUNC(moduleUnits);

if(_activated) then {
	// Get module settings
	private _ratio = _logic getVariable ["Ratio",0.8];
	if (_ratio > 1) then {_ratio = _ratio / 100};
	_ratio = _ratio min 1 max 0;
	private _code = _logic getVariable ["Code",""];
	_units = _units select {!isNull _x && {alive _x}};
	private _onlyPlayers = _logic getVariable ["PlayersOnly",false];
	if (_onlyPlayers) then {_units = _units arrayIntersect (allPlayers + playableUnits + switchableUnits)};

	if !(count _units > 0) exitWith {};
	// Save the watchlist to the module as way of API
	_logic setVariable [QGVAR(watchlist),_units,true];
	{
		// Save the watching modules to the units as way of API
		private _logics = _x getVariable [QGVAR(watchers),[]];
		_logics pushBackUnique _logic;
		_x setVariable [QGVAR(watchers),_logics,true];
	} forEach _units;

	_logic setVariable ["activated",false,true];

	private _handle =
	[{
		params ["_args","_handle"];
		_args params ["_logic","_units","_ratio","_code","_countStart"];
		// Get the watchlist, use the original units array as default
		private _living = _logic getVariable [QGVAR(watchlist),_units];
		// Filter out dead / null units
		_living = _living select {alive _x};
		// Update the watchlist
		_logic setVariable [QGVAR(watchlist),_living,true];
		_living = count _living;
		// If the cap is reached
		if (_living == 0 || ((_countStart - _living) / _countStart) >= _ratio) then {
			// Execute _code
			private _ret = [] spawn (compile _code);
			[_handle] call CBA_fnc_removePerFrameHandler;
			_logic setVariable ["activated",true,true];
		};
	}, 5, [_logic,_units,_ratio,_code,count _units]] call CBA_fnc_addPerFrameHandler;
};