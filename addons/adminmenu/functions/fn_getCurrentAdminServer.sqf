if (!isRemoteExecuted && {isMultiplayer}) exitWith {};

private _adminId = -1;
{
	if (admin owner _x > 0) exitWith {
		_adminId = owner _x;
	};
} forEach allPlayers;

if (_adminId == -1) exitWith {
	GVAR(currentAdmin) = "nobody";
	remoteExecutedOwner publicVariableClient GVAR(currentAdmin);
};

[remoteExecutedOwner, admin _adminId] remoteExec [QFUNC(getCurrentAdminClient), _adminId];