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
        onPlayerRespawn  = QFUNC(init);
        onPlayerKilled = "";
    };
};

class EGVAR(adminMenu,authorized_players) {
    acreBroadcast = 1; // Can broadcast to everyone within a chat channel
    acreGroupChat = 1; // Can broadcast to admins, spectators and curators
};

#include "autotest.hpp"
#include "CfgEventHandlers.hpp"
#include "display3DEN.hpp"
#include "dialog.hpp"
#include "CfgVehicles.hpp"
#include "tags.hpp"
