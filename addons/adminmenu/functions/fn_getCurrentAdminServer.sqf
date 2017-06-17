if (!isRemoteExecuted && {isMultiplayer}) exitWith {};

private _adminId = -1;
{
	if (admin owner _x > 0) exitWith {
		_adminId = owner _x;
	};
} forEach allPlayers;

if (_adminId == -1) exitWith {
	tmf_adminMenu_currentAdmin = "nobody";
	remoteExecutedOwner publicVariableClient tmf_adminMenu_currentAdmin;
};

[remoteExecutedOwner, admin _adminId] remoteExec ["tmf_adminMenu_getCurrentAdminClient", _adminId];
