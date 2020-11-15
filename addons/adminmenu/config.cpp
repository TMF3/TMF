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

/*
    #define TMF_ALLOW_NONE              0
    #define TMF_ALLOW_DASHBOARD         1
    #define TMF_ALLOW_PLAYERMANAGEMENT  2
    #define TMF_ALLOW_RESPAWN           4
    #define TMF_ALLOW_ENDMISSION        8
    #define TMF_ALLOW_LOGS              16
    #define TMF_ALLOW_ALL           31
*/
class GVAR(authorized_players) {
    // Default values if none otherwise defined
    debugConsole = 1;   // Access to debug console, also controls execute code in Player Management
    zeus = 1;           // Allowed to grab or use Zeus
    spectatorRC = 1;    // Allow remote controlling units while in spectator

    adminmenu = __EVAL(TMF_ALLOW_ALL);   // Which adminmenu tabs are allowed
    //adminmenu = __EVAL(TMF_ALLOW_DASHBOARD + TMF_ALLOW_PLAYERMANAGEMENT); // Macros

    /*class Bear {
        uid = "12345"; // SteamID64 of players authorized to access admin tools (matches against getPlayerUID)
    };*/
};

#include "CfgFunctions.hpp"
#include "CfgDebriefing.hpp"
#include "CfgEventHandlers.hpp"
#include "autotest.hpp"

#include "gui\adminMenu.hpp"
