#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = "TMF: Admin Menu";
        author = "Bear, Snippers";
        url = "http://www.teamonetactical.com";
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"tmf_common", "A3_UI_F"};
        VERSION_CONFIG;
    };
};

GVAR(authorized_uids)[] = {
    "76561197974275147",
    "76561198031183429",
    "76561198010479904",
    "76561198052428514",
    "76561198002666327",
    "76561198014669991"
};

#include "CfgFunctions.hpp"
#include "CfgEventHandlers.hpp"

#include "gui\adminMenu.hpp"
