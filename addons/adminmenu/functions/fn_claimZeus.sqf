#include "\x\tmf\addons\adminmenu\script_component.hpp"

if (isNull (getAssignedCuratorLogic player)) then {
    player remoteExec [QFUNC(makeZeusServer), 2];
    systemChat "[TMF Admin Menu] You now have access to Zeus";

    [["%1 claimed zeus",profileName], true,"[TMF Admin Menu] "] call FUNC(log);
} else {
    systemChat "[TMF Admin Menu] You already have access to Zeus";
};
