#include "\x\tmf\addons\adminmenu\script_component.hpp"

#include "initKeybinds.sqf"

GVAR(sideColors) = [
	[profilenamespace getvariable ['Map_BLUFOR_R',0], profilenamespace getvariable ['Map_BLUFOR_G',0], profilenamespace getvariable ['Map_BLUFOR_B',1], 0.8],
	[profilenamespace getvariable ['Map_OPFOR_R',1], profilenamespace getvariable ['Map_OPFOR_G',0], profilenamespace getvariable ['Map_OPFOR_B',0], 0.8],
	[profilenamespace getvariable ['Map_Independent_R',0], profilenamespace getvariable ['Map_Independent_G',1], profilenamespace getvariable ['Map_Independent_B',0], 0.8],
	[profilenamespace getvariable ['Map_Civilian_R',0.5], profilenamespace getvariable ['Map_Civilian_G',0], profilenamespace getvariable ['Map_Civilian_B',0.5], 0.8]
];

GVAR(tabPFHHandles) = [];
GVAR(playerManagement_listControls) = [];
GVAR(playerManagement_players) = [];
GVAR(playerManagement_selected) = [];

if (isMultiplayer) then {
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

			private _ctrl = (uiNamespace getVariable [QGVAR(display), displayNull]) displayCtrl IDC_TMF_ADMINMENU_FPS;
			if (isNull _ctrl) exitWith {};

			_ctrl ctrlSetText format ["%1 SFPS", _this select 1];
		};

		QGVAR(currentAdmin) addPublicVariableEventHandler {
			disableSerialization;

			private _ctrl = ((uiNamespace getVariable [QGVAR(display), displayNull]) displayCtrl IDC_TMF_ADMINMENU_G_DASH) controlsGroupCtrl IDC_TMF_ADMINMENU_DASH_CURRADMIN;
			if (isNull _ctrl) exitWith {};

			_ctrl ctrlSetText (_this select 1);
		};
	};
};
