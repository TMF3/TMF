#include "script_component.hpp"

class cfgPatches
{
    class ADDON
    {
        name = "TMF: Spectator";
        author = "Head";
        url = "http://www.teamonetactical.com";
        units[] = {};
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
        onPlayerRespawn  = "tmf_spectator_fnc_init";
        onPlayerKilled = "";
    };
};




#include "CfgEventHandlers.hpp"
#include "CfgFunctions.hpp"
#include "Cfg3DEN.hpp"
#include "display3DEN.hpp"
#include "dialog.hpp"
#include "CfgVehicles.hpp"
#include "tags.hpp"