#include "script_component.hpp"

class CfgPatches
{
    class ADDON
    {
        name = "TMF: Respawn";
        author = "Snippers";
        url = "http://www.teamonetactical.com";
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"tmf_common"};
        VERSION_CONFIG;
    };
};

#include "Cfg3DEN.hpp"
#include "CfgEventHandlers.hpp"

#include "defines.hpp"
#include "dialogs.hpp"
