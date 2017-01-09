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
        displayName = "Teamwork Spectator";
        onPlayerRespawn  = "tmf_spectator_fnc_init";
        onPlayerKilled = "";
    };
};



#include "CfgEventHandlers.hpp"
#include "CfgFunctions.hpp"

#include "Cfg3DEN.hpp"
#include "display3DEN.hpp"

#include "dialog.hpp"

#include "CfgModules.hpp"



#include "tags.hpp";



class CfgVehicles {
    class VirtualMan_F;
    class GVAR(unit) : VirtualMan_F {
        author = ADDON;
        scope = 1;
        scopeCurator = 1,
        scopeArsenal = 1;
        delete ACE_SelfActions;
        delete ACE_Actions;
    };
};