["TMF", QGVAR(openKey), ["Open Admin Menu", "Only available for admins and singleplayer"],
{
	_authorized = true;
	
    if (_authorized) then {
		(findDisplay 46) createDisplay QUOTE(ADDON);
	} else {
		systemChat "[TMF Admin Menu] You are not authorized to use the admin menu";
	};

	false
},
{false},
[59, [true, false, false]], false, 0] call CBA_fnc_addKeybind; // Shift + F1