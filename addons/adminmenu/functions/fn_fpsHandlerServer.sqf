if (!isServer) exitWith {};
params [["_add", true, [true]]];

if (_add) then {
	if (isNil "tmf_adminMenu_fps_pfh") then {
		tmf_adminMenu_fps_pfh = [{
			tmf_adminMenu_fps = round diag_fps;
			
			{
				_x publicVariableClient "tmf_adminMenu_fps";
			} forEach tmf_adminMenu_activeClients;
		}, 1] call CBA_fnc_addPerFrameHandler;
	};

	tmf_adminMenu_activeClients pushBackUnique remoteExecutedOwner;
} else {
	tmf_adminMenu_activeClients = tmf_adminMenu_activeClients - [remoteExecutedOwner];
	
	if (count tmf_adminMenu_activeClients == 0 && {!isNil "tmf_adminMenu_fps_pfh"}) then {
		[tmf_adminMenu_fps_pfh] call CBA_fnc_removePerFrameHandler;
		tmf_adminMenu_fps_pfh = nil;
	};
};