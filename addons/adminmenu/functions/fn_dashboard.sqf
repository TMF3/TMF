#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_display"];

private _pfhDashboard = [{
	disableSerialization;
	private _display = uiNamespace getVariable [QGVAR(display), displayNull];
	if (isNull _display) exitWith { systemChat format ["pfhDashboard display null %1", time]; };

	(_display displayCtrl IDC_TMF_ADMINMENU_DASH_RUNTIME) ctrlSetText format ["%1m %2s", round ((time - (time % 60)) / 60), round (time % 60)];

	(_display displayCtrl IDC_TMF_ADMINMENU_DASH_HEADLESS) ctrlSetText str (count entities "HeadlessClient_F");
	(_display displayCtrl IDC_TMF_ADMINMENU_DASH_VIRTUALS) ctrlSetText str (count entities "VirtualCurator_F");

	//private _deadUnits = ((allPlayers - _liveUnits) - _spectators) - _headlessClients;

	private _liveUnits = allUnits;
	private _spectatorUnits = entities QEGVAR(spectator,unit);
	{
		_x params ["_ai", "_players", "_spectators", "_total"];
		private _side = [blufor, opfor, resistance, civilian] param [_forEachIndex];
		private _sideUnits = _liveUnits select {side _x == _side};

		private _numAI = {!isPlayer _x} count _sideUnits;
		(_display displayCtrl _ai) ctrlSetText str _numAI;

		private _numSideUnits = count _sideUnits;
		(_display displayCtrl _players) ctrlSetText str (_numSideUnits - _numAI);

		private _numSpectators = {(_x getVariable [QEGVAR(spectator,side), sideLogic]) isEqualTo _side} count _spectatorUnits;
		(_display displayCtrl _spectators) ctrlSetText str _numSpectators;
		(_display displayCtrl _total) ctrlSetText str (_numSideUnits + _numSpectators);
	} forEach IDCS_TMF_ADMINMENU_DASH_STATS_ALLSIDES;

	private _numAI = {!isPlayer _x} count _liveUnits;
	(_display displayCtrl IDC_TMF_ADMINMENU_DASH_STATS_TOTAL_AI) ctrlSetText str _numAI;

	private _numLiveUnits = count _liveUnits;
	(_display displayCtrl IDC_TMF_ADMINMENU_DASH_STATS_TOTAL_PLAYERS) ctrlSetText str (_numLiveUnits - _numAI);

	private _numSpectators = count _spectatorUnits;
	(_display displayCtrl IDC_TMF_ADMINMENU_DASH_STATS_TOTAL_SPECTATORS) ctrlSetText str _numSpectators;
	(_display displayCtrl IDC_TMF_ADMINMENU_DASH_STATS_TOTAL_TOTAL) ctrlSetText str (_numLiveUnits + _numSpectators);
}, 1] call CBA_fnc_addPerFrameHandler;

GVAR(tabPFHHandles) pushBack _pfhDashboard;