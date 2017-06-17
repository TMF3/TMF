if (!isRemoteExecuted && {isMultiplayer}) exitWith {};

params ["_origin", "_adminLevel"];

tmf_adminMenu_currentAdmin = profileName;
if (_adminLevel == 1) then {
	tmf_adminMenu_currentAdmin = tmf_adminMenu_currentAdmin + " (voted)";
};

_origin publicVariableClient tmf_adminMenu_currentAdmin;