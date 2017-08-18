["TMF", QGVAR(openKey), ["Open Admin Menu", "Only available for admins and in singleplayer"],
{
	_authorized = true;
	
    if (_authorized || !isMultiplayer) then {
		if (isNull (findDisplay 312)) then {
			(findDisplay 46) createDisplay QUOTE(ADDON);
		} else {
			systemChat "[TMF Admin Menu] Can't open the admin menu while in Zeus";
		};
	} else {
		systemChat "[TMF Admin Menu] You're not authorized to use the admin menu";
	};

	false
},
{false},
[59, [true, false, false]], false, 0] call CBA_fnc_addKeybind; // Shift + F1