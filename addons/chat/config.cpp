#include "script_component.hpp"

class cfgPatches
{
    class ADDON
    {
        name = "TMF: Chat commands";
        author = "Freddo";
        url = "http://www.teamonetactical.com";
        units[] = {
            QGVAR(adversarialSafeZone)
        };
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"tmf_common", "tmf_ai"};
        VERSION_CONFIG;
    };
};

#include "CfgFunctions.hpp"
#include "CfgEventhandlers.hpp"
#include "CfgModules.hpp"
