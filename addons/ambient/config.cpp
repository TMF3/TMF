#include "script_component.hpp"

class CfgPatches
{
    class ADDON
    {
        name = "TMF: Ambient";
        author = "TMF Team";
        url = "http://www.teamonetactical.com";
        units[] = {
            QGVAR(ambientVehicles)
        };
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            "tmf_common",
            "tmf_ai"
        };
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgModules.hpp"
