["TMF", QGVAR(openKey), ["Open Admin Menu", "Only available for admins and in singleplayer"],
{
	_authorized = true;
    if (_authorized || isServer) then {
		if (isNull (findDisplay 312)) then {
			if (!isNil "tmf_spectator_fnc_init") then {
				closeDialog 5454;
			};

			(findDisplay 46) createDisplay QUOTE(ADDON);
		} else {
			systemChat "[TMF Admin Menu] Can't open the admin menu while in Zeus";
		};
	} else {
		systemChat "[TMF Admin Menu] You're not authorized to use the admin menu";
	};

	false
}, {false}, [59, [true, false, false]], false, 0] call CBA_fnc_addKeybind; // Shift + F1
