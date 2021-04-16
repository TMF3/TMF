#include "script_component.hpp"

class cfgPatches
{
    class ADDON
    {
        name = "TMF: Chat commands";
        author = "Freddo";
        url = "http://www.teamonetactical.com";
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"tmf_common"};
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
