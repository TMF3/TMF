#include "\x\tmf\addons\adminmenu\script_component.hpp"

if (!isServer) exitWith {};
params [["_add", true, [true]]];

if (isMultiplayer) then {
	if (_add) then {
		if (isNil QGVAR(fps_pfh)) then {
			GVAR(fps_pfh) = [{
				GVAR(fps) = round diag_fps;
				
				{
					_x publicVariableClient QGVAR(fps);
				} forEach GVAR(activeClients);
			}, 1] call CBA_fnc_addPerFrameHandler;
		};

		GVAR(activeClients) pushBackUnique remoteExecutedOwner;
	} else {
		GVAR(activeClients) = GVAR(activeClients) - [remoteExecutedOwner];
		
		if (count GVAR(activeClients) == 0 && {!isNil QGVAR(fps_pfh)}) then {
			[GVAR(fps_pfh)] call CBA_fnc_removePerFrameHandler;
			GVAR(fps_pfh) = nil;
		};
	};
} else { // Singleplayer
	if (_add && isNil QGVAR(fps_pfh)) then {
		GVAR(fps_pfh) = [{
			disableSerialization;

			private _ctrl = (uiNamespace getVariable [QGVAR(display), displayNull]) displayCtrl 56105;
			if (isNull _ctrl) exitWith {};

			_ctrl ctrlSetText format ["%1 SFPS", round diag_fps];
		}, 1] call CBA_fnc_addPerFrameHandler;
	} else {
		if (!isNil QGVAR(fps_pfh)) then {
			[GVAR(fps_pfh)] call CBA_fnc_removePerFrameHandler;
			GVAR(fps_pfh) = nil;
		};
	};
};