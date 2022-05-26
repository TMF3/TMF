#include "script_component.hpp"

class cfgPatches
{
    class ADDON
    {
        name = "TMF: Common";
        author = "Nick";
        url = "http://www.teamonetactical.com";
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"tmf_main","3den"};
        VERSION_CONFIG;
    };
};
#include "Cfg3DEN.hpp"
#include "CfgEventHandlers.hpp"
#include "CfgVehicles.hpp"
#include "display3DEN.hpp"
#include "RscDisplayLoadMission.hpp"

class TMF_autotest {
    class GVAR(groupNamesSlottingScreen) {
        code = QUOTE([] call FUNC(testGroupsSlottingScreen));
    };
};
