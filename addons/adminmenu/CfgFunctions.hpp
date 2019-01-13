class CfgFunctions {
    class A3 {
        class Debug {
            class isDebugConsoleAllowed {
                file = QPATHTOF(fn_isDebugConsoleAllowed.sqf);
            };
        };
    };
    class ADDON {
        class COMPONENT {
            file = QPATHTO_FOLDER(functions);
            class claimZeus;
            class dashboard;
            class debounceButton;
            class endMission;
            class endMission_commit;
            class endMission_occluder;
            class endMission_sideSpecificLocal;
            class fpsHandlerServer;
            class getCurrentAdminClient;
            class getCurrentAdminServer;
            class keyPressed;
            class makeZeusServer;
            class onLoad;
            class onUnload;
            class playerManagement;
            class playerManagement_button;
            class playerManagement_filter;
            class playerManagement_listSelChange;
            class playerManagement_updateList;
            class remoteControl;
            class respawn;
            class respawn_addAction;
            class respawn_factionCategoryChanged;
            class respawn_factionChanged;
            class respawn_refreshFactionCategory;
            class respawn_refreshGroupBox;
            class respawn_refreshSpectatorList;
            class respawn_removeAction;
            class respawn_respawnButton;
            class respawn_toggleSpectatorVOIP;
            class respawn_mapClick;
            class respawn_mapDrawIcons;
            class respawn_mapKeyUp;
            class respawn_mapLoaded;
            class selectTab;
            class showSubtitle;
            class sideToColor;

            class modal;
            class modalOnLoad;
            class modalOnUnload;
            class modalState;
            class modal_assignGear;
            class modal_assignGear_listboxFactions;
            class modal_assignGear_listboxRoles;
            class modal_message;
            class modal_runCode;
            class modal_steamProfile;
            class modal_teleport;

            class utility;
            class utility_grantZeus;
            class utility_heal;
            class utility_quickRespawn;
            class utility_quickRespawn_local;
        };
    };
};
