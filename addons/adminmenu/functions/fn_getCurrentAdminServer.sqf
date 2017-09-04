#include "\x\tmf\addons\adminmenu\script_component.hpp"

if (!isServer) exitWith {};

private _adminId = -1;
{
    if (admin owner _x > 0) exitWith {
        _adminId = owner _x;
    };
} forEach allPlayers;

if (_adminId == -1) exitWith {
    GVAR(currentAdmin) = "nobody";
    remoteExecutedOwner publicVariableClient QGVAR(currentAdmin);
};

[remoteExecutedOwner, admin _adminId] remoteExec [QFUNC(getCurrentAdminClient), _adminId];
