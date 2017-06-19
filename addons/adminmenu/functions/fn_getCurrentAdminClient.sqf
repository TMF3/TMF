if (!isRemoteExecuted && isMultiplayer) exitWith {};

params ["_origin", "_adminLevel"];

GVAR(currentAdmin) = profileName;
if (_adminLevel == 1) then {
	GVAR(currentAdmin) = GVAR(currentAdmin) + " (voted)";
};

_origin publicVariableClient GVAR(currentAdmin);