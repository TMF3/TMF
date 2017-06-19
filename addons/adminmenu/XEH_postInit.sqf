#include "initKeybinds.sqf"

if (isServer) then {
	GVAR(activeClients) = [];
	
	private _id = addMissionEventHandler ["HandleDisconnect", {
		private _clientOwnerId = _this select 4;
		GVAR(activeClients) = GVAR(activeClients) - [_clientOwnerId];

		if (count GVAR(activeClients) == 0 && {!isNil QGVAR(fps_pfh)}) then {
			[GVAR(fps_pfh)] call CBA_fnc_removePerFrameHandler;
			GVAR(fps_pfh) = nil;
		};
	}];
};

if (hasInterface) then {
	QGVAR(fps) addPublicVariableEventHandler {
		disableSerialization;
		
		private _ctrl = (uiNamespace getVariable [QGVAR(display), displayNull]) displayCtrl 56105;
		if (isNull _ctrl) exitWith {};
		
		_ctrl ctrlSetText format ["%1 SFPS", _this select 1];
	};
	
	QGVAR(currentAdmin) addPublicVariableEventHandler {
		disableSerialization;
		
		private _ctrl = (uiNamespace getVariable [QGVAR(display), displayNull]) displayCtrl 561052;
		if (isNull _ctrl) exitWith {};
		
		_ctrl ctrlSetText (_this select 1);
	};
};