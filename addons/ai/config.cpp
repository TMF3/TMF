#include "script_component.hpp"

class cfgPatches
{
    class ADDON
    {
        name = "TMF: AI";
        author = "Nick";
        url = "http://www.teamonetactical.com";
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"tmf_common"};
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgWaypoints.hpp"
#include "CfgModules.hpp"
