#include "\x\tmf\addons\adminmenu\script_component.hpp"

if !(isServer) exitWith {};

params ["_unit"];
if (isNull _unit) exitWith {};
if (!isNull (getAssignedCuratorLogic _unit)) exitWith {}; // already is a curator

private _isValidCurator = false;
{
    _isValidCurator = false;
    if (_x getVariable [QGVAR(zeus), false]) then {
        if (isNull (getAssignedCuratorUnit _x)) then {
            _isValidCurator = true;
        } else {
            if (!isPlayer (getAssignedCuratorUnit _x)) then {
                _isValidCurator = true;
            };
        };
    };

    if (_isValidCurator) exitWith {
        unassignCurator _x;
        _unit assignCurator _x;
        //_x remoteExec [QFUNC(zeusSetupSync), _unit];
        "[TMF Admin Menu] You were given access to Zeus" remoteExec ["systemChat", _unit];
    };
} forEach allCurators;

if (!_isValidCurator) then {
    if (isNil QGVAR(sideCenter)) then {
        GVAR(sideCenter) = createCenter sideLogic;
    };

    private _curator = (createGroup GVAR(sideCenter)) createUnit ["ModuleCurator_F", [0,0,0], [], 0, ""];
    _curator setVariable ["Addons", 3, true];
    _curator setVariable [QGVAR(zeus), true, true];
    _curator setVariable ["showNotification", false, true];

    _curator setCuratorWaypointCost 0;
    {
        _curator setCuratorCoef [_x, 0];
    } forEach ["place","edit","delete","destroy","group","synchronize"];

    _unit assignCurator _curator;
    "[TMF Admin Menu] You were given access to Zeus" remoteExec ["systemChat", _unit];
};
