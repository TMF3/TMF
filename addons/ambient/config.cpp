#include "script_component.hpp"

class CfgPatches
{
    class ADDON
    {
        name = "TMF: Ambient";
        author = "TMF Team";
        url = "http://www.teamonetactical.com";
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"tmf_common"};
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
