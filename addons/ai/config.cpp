#include "script_component.hpp"

class CfgPatches
{
    class ADDON
    {
        name = "TMF: AI";
        author = "Nick";
        url = "http://www.teamonetactical.com";
        units[] = {QGVAR(area), QGVAR(area_rectangle), QGVAR(wavespawn), QGVAR(huntModule), QGVAR(Rearm), QGVAR(garrisonQuantity), QGVAR(artillery)};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"tmf_common"};
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgWaypoints.hpp"
#include "CfgModules.hpp"
