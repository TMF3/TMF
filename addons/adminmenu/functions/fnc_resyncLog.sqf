#include "\x\tmf\addons\adminmenu\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: TMF_adminmenu_fnc_resyncLog

Description:
    Resynchronizes the server log from the server to a client

Parameters:
    _ownerID - owner ID which will have its log resynchronized [Number or Object, default clientOwner]

Returns:
    Nil

Examples:
    (begin example)
        [clientOwner] call TMF_adminmenu_fnc_resyncLog;
    (end)

Author:
    Freddo
---------------------------------------------------------------------------- */

params [
    ["_ownerID",clientOwner,[-1,objNull]]
];

if IS_OBJECT(_ownerID) then {
    _ownerID = owner _ownerID;
};

[QGVAR(resyncLog),_ownerID] call CBA_fnc_serverEvent;
LOG("Requesting log resynchronization")
