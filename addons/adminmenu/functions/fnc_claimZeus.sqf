#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
if !canSuspend exitWith {
    _this spawn FUNC(claimZeus);
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

if (isNull (getAssignedCuratorLogic player)) then {
    player remoteExec [QFUNC(makeZeusServer), 2];
    systemChat "[TMF Admin Menu] You now have access to Zeus";

    [format ["%1 claimed zeus",profileName], false,"Admin Menu"] call FUNC(log);
} else {
    systemChat "[TMF Admin Menu] You already have access to Zeus";
};
