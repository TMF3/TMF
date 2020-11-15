
enum {
    // Adminmenu tabs
    TM_ALLOW_DASHBOARD = 1,
    TM_ALLOW_PLAYERMANAGEMENT = 2,
    TM_ALLOW_RESPAWN = 4, // Also controls Quick Respawn in Player Management
    TM_ALLOW_ENDMISSION = 8,
    TM_ALLOW_LOGS = 16,
    TM_ALLOW_MENUALL = 31
};

class GVAR(authorized_players) {
    // Default values if none otherwise defined
    debugConsole = true;    // Access to debug console, also controls execute code in Player Management
    zeus = true;            // Allowed to grab or use Zeus
    spectatorRC = true;     // Allow remote controlling units while in spectator

    adminmenu = __EVAL(TM_ALLOW_MENUALL);   // Which adminmenu tabs are allowed
    //adminmenu = __EVAL(TM_ALLOW_DASHBOARD + TM_ALLOW_PLAYERMANAGEMENT);

    /*class Bear {
        uid = "12345"; // SteamID64 of players authorized to access admin tools (matches against getPlayerUID)
    };*/
};
