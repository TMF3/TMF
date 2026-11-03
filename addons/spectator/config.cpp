#include "script_component.hpp"

class CfgPatches
{
    class ADDON
    {
        name = "TMF: Spectator";
        author = "Head";
        url = "http://www.teamonetactical.com";
        units[] = {QGVAR(module)};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"tmf_common"};
        VERSION_CONFIG;
    };
};

class CfgRespawnTemplates
{
    class TMF_Spectator
    {
        displayName = "TMF Spectator";
        onPlayerRespawn  = QFUNC(init);
        onPlayerKilled = "";
    };
};
#include "autotest.hpp"
#include "CfgEventHandlers.hpp"
#include "dialog.hpp"
#include "CfgVehicles.hpp"
#include "tags.hpp"
