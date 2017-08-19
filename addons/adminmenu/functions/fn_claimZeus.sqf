#include "\x\tmf\addons\adminmenu\script_component.hpp"

if (isNull (getAssignedCuratorLogic player)) then {
	player remoteExec [QFUNC(zeusServerMake), 2];
	systemChat "[TMF Admin Menu] You now have access to Zeus";
} else {
	systemChat "[TMF Admin Menu] You already have access to Zeus";
};