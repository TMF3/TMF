#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = "TMF: Admin Menu";
        author = "Bear, Snippers";
        url = "http://www.teamonetactical.com";
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"tmf_common", "A3_UI_F", "cba_diagnostic"};
        VERSION_CONFIG;
    };
};

// SteamID64 of players authorized to access admin tools (matches against getPlayerUID)
class GVAR(authorized_players) {
    /*class Bear {
        uid = "12345";
    };*/
};

#include "CfgFunctions.hpp"
#include "CfgEventHandlers.hpp"

#include "gui\adminMenu.hpp"
