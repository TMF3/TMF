if (isServer) then {
	tmf_adminMenu_activeClients = [];
	
	private _id = addMissionEventHandler ["HandleDisconnect", {
		private _clientOwnerId = _this select 4;
		tmf_adminMenu_activeClients = tmf_adminMenu_activeClients - [_clientOwnerId];

		if (count tmf_adminMenu_activeClients == 0 && {!isNil "tmf_adminMenu_fps_pfh"}) then {
			[tmf_adminMenu_fps_pfh] call CBA_fnc_removePerFrameHandler;
			tmf_adminMenu_fps_pfh = nil;
		};
	}];
};

if (hasInterface) then {
	"tmf_adminMenu_fps" addPublicVariableEventHandler {
		disableSerialization;
		
		private _ctrl = (uiNamespace getVariable ["tmf_adminMenu_display", displayNull]) displayCtrl 56105;
		if (isNull _ctrl) exitWith {};
		
		_ctrl ctrlSetText format ["%1 SFPS", _this select 1];
	};
	
	"tmf_adminMenu_currentAdmin" addPublicVariableEventHandler {
		disableSerialization;
		
		private _ctrl = (uiNamespace getVariable ["tmf_adminMenu_display", displayNull]) displayCtrl 561052;
		if (isNull _ctrl) exitWith {};
		
		_ctrl ctrlSetText (_this select 1);
	};
};