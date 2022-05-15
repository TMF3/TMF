#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
if !canSuspend exitWith {
    _this spawn FUNC(utility_grantZeus);
};

// Because people don't understand that grabbing zeus after mission start is a bad idea
if !(
    [
        [
            "Claiming Zeus after mission start may cause certain functionality to break.",
            "As such it should only be used for debug purposes or in emergencies.",
            "To prevent any issues you should use the Game Master editor module whenever possible.",
            "",
            "Do you still wish to proceed?"
        ] joinString "<br/>",
        "WARNING",
        true,
        true,
        uiNamespace getVariable [QGVAR(display),displayNull],
        true,
        false
    ] call BIS_fnc_guiMessage
) exitWith {};

private _given = [];
private _had = [];

{
    if (isNull (getAssignedCuratorLogic _x)) then {
        _x remoteExec [QFUNC(makeZeusServer), 2];
        _given pushBack _x;
    } else {
        _had pushBack _x;
    };
} forEach GVAR(utilityData);

if (count _given > 0) then {
    _given = str (_given apply {name _x});
    _given = _given select [1, (count _given) - 2];
    systemChat format ["[TMF Admin Menu] Zeus access was given to %1", _given];
    [format ["%1 granted zeus to %2",profileName, _given],false,"Admin Menu"] call FUNC(log);
};

if (count _had > 0) then {
    _had = str (_had apply {name _x});
    _had = _had select [1, (count _had) - 2];
    systemChat format ["[TMF Admin Menu] Zeus access was already given to %1", _had];
};
