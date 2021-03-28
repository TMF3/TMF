class RscText;
class RscTitle: RscText {};
class RscShortcutButton;
class RscButtonMenu: RscShortcutButton {};
class RscButtonMenuCancel: RscButtonMenu {};
class RscButtonMenuOK: RscButtonMenu {};
class RscControlsGroup;
class RscListBox;
class RscListNBox;
class RscCheckBox;
class RscCombo;
class RscEdit;
class RscEditMulti: RscEdit {};
class RscPicture;
class RscToolbox;
class RscStructuredText;
class RscControlsTable;
class RscMapControl;
class RscStandardDisplay;

class GVAR(RscButtonMenu): RscButtonMenu {
    style = ST_CENTER + ST_VCENTER;
    font = GUI_FONT_NORMAL;
    sizeEx = GUI_TEXT_SIZE_MEDIUM;
    size = (GUI_GRID_H * 0.9);
    h = 1 * GUI_GRID_H;
};

class GVAR(RscText): RscText {
    sizeEx = GUI_TEXT_SIZE_SMALL;
};

class GVAR(RscTextLarge): RscText {
    sizeEx = GUI_TEXT_SIZE_MEDIUM;
};

class GVAR(RscSpectatorControlTableText): RscText {
    sizeEx = GUI_TEXT_SIZE_SMALL;
    h = 1 * GUI_GRID_H;
    w = (6/10) * TMF_ADMINMENU_RESP_W_COL1;
    x = 0;
    y = 0;
};

class GVAR(RscTextMultiline): GVAR(RscText) {
    style = ST_LEFT + ST_MULTI + ST_NO_RECT;
    lineSpacing = 1;
};

class GVAR(RscEditMultiCode): RscEditMulti {
    autocomplete = "scripting";
};

class GVAR(RscCombo): RscCombo {
    font = GUI_FONT_NORMAL;
    sizeEx = GUI_TEXT_SIZE_SMALL;
};

class GVAR(RscTextIcon): RscText {
    style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;
    type = CT_STATIC;
};

class GVAR(RscListBox): RscListBox {
    font = GUI_FONT_NORMAL;
    sizeEx = GUI_TEXT_SIZE_SMALL;
};

class GVAR(RscListNBox): RscListNBox {
    font = GUI_FONT_NORMAL;
    sizeEx = GUI_TEXT_SIZE_SMALL;
};

class ADDON: RscStandardDisplay {
    idd = IDD_TMF_ADMINMENU;

    onLoad = QUOTE(_this call FUNC(onLoad););
    onUnload = QUOTE(_this call FUNC(onUnload););
    class Controls {
        class Title: RscTitle {
            idc = -1;
            text = "TMF Admin Menu";
            style = ST_SINGLE;
            moving = true;
            colorBackground[] = {0, 0, 0, 0};
            x = 1 * GUI_GRID_W + GUI_GRID_CENTER_X;
            y = 1 * GUI_GRID_H + GUI_GRID_CENTER_Y;
            w = 15 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;
        };

        class TitleFPS: Title {
            idc = IDC_TMF_ADMINMENU_FPS;
            text = "";
            style = ST_RIGHT;
            x = 16 * GUI_GRID_W + GUI_GRID_CENTER_X;
            w = 23 * GUI_GRID_W;
        };


        // Buttons for Tabs
        class TabDashboard: RscButtonMenu {
            idc = IDC_TMF_ADMINMENU_DASH;
            text = "Dashboard";
            tooltip = "";
            onButtonClick = QUOTE([ARR_2(ctrlParent param [0],IDC_TMF_ADMINMENU_G_DASH)] call FUNC(selectTab));
            colorBackground[] = {0, 0, 0, 0};
            x = 1 * GUI_GRID_W + GUI_GRID_CENTER_X;
            y = 2.1 * GUI_GRID_H + GUI_GRID_CENTER_Y;
            w = 5.8 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;
        };
        class TabPlayerManagement: TabDashboard {
            idc = IDC_TMF_ADMINMENU_PMAN;
            text = "Player Management";
            tooltip = "Perform actions on players";
            onButtonClick = QUOTE([ARR_2(ctrlParent param [0],IDC_TMF_ADMINMENU_G_PMAN)] call FUNC(selectTab));
            x = 6.9 * GUI_GRID_W + GUI_GRID_CENTER_X;
            w = 9 * GUI_GRID_W;
        };
        class TabRespawnPlayers: TabDashboard {
            idc = IDC_TMF_ADMINMENU_RESP;
            text = "Respawn";
            tooltip = "Respawn dead players back in the game";
            onButtonClick = QUOTE([ARR_2(ctrlParent param [0],IDC_TMF_ADMINMENU_G_RESP)] call FUNC(selectTab));
            x = 16 * GUI_GRID_W + GUI_GRID_CENTER_X;
            w = 4.8 * GUI_GRID_W;
        };
        class TabEndMission: TabDashboard {
            idc = IDC_TMF_ADMINMENU_ENDM;
            text = "End Mission";
            tooltip = "Select and execute a mission ending";
            onButtonClick = QUOTE([ARR_2(ctrlParent param [0],IDC_TMF_ADMINMENU_G_ENDM)] call FUNC(selectTab));
            x = 20.9 * GUI_GRID_W + GUI_GRID_CENTER_X;
            w = 5.9 * GUI_GRID_W;
        };
        class TabMessageLog: TabDashboard {
            idc = IDC_TMF_ADMINMENU_MSGS;
            text = "Logs";
            tooltip = "Status and debug messages from TMF components";
            onButtonClick = QUOTE([ARR_2(ctrlParent param [0],IDC_TMF_ADMINMENU_G_MSGS)] call FUNC(selectTab));
            x = 26.9 * GUI_GRID_W + GUI_GRID_CENTER_X;
            w = 3 * GUI_GRID_W;
        };

        // Groups for Tabs
        class GroupBase: RscControlsGroup {
            x = 1.1 * GUI_GRID_W + GUI_GRID_CENTER_X;
            y = 3.3 * GUI_GRID_H + GUI_GRID_CENTER_Y;
            w = 0;
            h = 0;
            class Controls {};
        };

        class GroupDashboard: GroupBase {
            idc = IDC_TMF_ADMINMENU_G_DASH;
            w = TMF_GROUPBASE_W;
            h = TMF_GROUPBASE_H;
            #include "dashboard.hpp"
        };

        class GroupPlayerManagement: GroupBase {
            idc = IDC_TMF_ADMINMENU_G_PMAN;
            w = TMF_GROUPBASE_W;
            h = TMF_GROUPBASE_H;
            #include "playerManagement.hpp"
        };

        class GroupRespawn: GroupBase {
            idc = IDC_TMF_ADMINMENU_G_RESP;
            w = TMF_GROUPBASE_W;
            h = TMF_GROUPBASE_H;
            #include "respawn.hpp"
        };

        class GroupEndMission: GroupBase {
            idc = IDC_TMF_ADMINMENU_G_ENDM;
            w = TMF_GROUPBASE_W;
            h = TMF_GROUPBASE_H;
            #include "endMission.hpp"
        };

        class GroupMessageLog: GroupBase {
            idc = IDC_TMF_ADMINMENU_G_MSGS;
            w = TMF_GROUPBASE_W;
            h = TMF_GROUPBASE_H;
            #include "messageLog.hpp"
        };

        // Utility Tab
        class UtilityTitleBackground: RscText {
            idc = IDC_TMF_ADMINMENU_UTIL_TBACK;
            colorBackground[] = GUI_BCG_COLOR;
            x = 1 * GUI_GRID_W + GUI_GRID_CENTER_X;
            y = 3.2 * GUI_GRID_H + GUI_GRID_CENTER_Y;
            w = 38 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;
        };
        class UtilityTitle: RscTitle {
            idc = IDC_TMF_ADMINMENU_UTIL_TITLE;
            text = "Utility Title";
            style = ST_SINGLE;
            colorBackground[] = {0, 0, 0, 0};
            x = 1 * GUI_GRID_W + GUI_GRID_CENTER_X;
            y = 3.2 * GUI_GRID_H + GUI_GRID_CENTER_Y;
            w = 38 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;
        };
        class UtilityGroup: GroupBase {
            idc = IDC_TMF_ADMINMENU_G_UTIL;
            y = 4.3 * GUI_GRID_H + GUI_GRID_CENTER_Y;
            w = 37.8 * GUI_GRID_W;
            h = 19.6 * GUI_GRID_H;
        };
    };

    class ControlsBackground {
        class TitleBackground: RscText {
            colorBackground[] = GUI_BCG_COLOR;
            x = 1 * GUI_GRID_W + GUI_GRID_CENTER_X;
            y = 1 * GUI_GRID_H + GUI_GRID_CENTER_Y;
            w = 38 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;
        };
        class TabsBackgroundLeft: TitleBackground {
            colorBackground[] = {0, 0, 0, 1};
            y = 2.1 * GUI_GRID_H + GUI_GRID_CENTER_Y;
        };
        class MainBackground: TitleBackground {
            colorBackground[] = {0, 0, 0, 0.7};
            y = 3.2 * GUI_GRID_H + GUI_GRID_CENTER_Y;
            h = 20.8 * GUI_GRID_H;
        };
    };
};

#include "modal.hpp"



class GVAR(respawnMapDialog): RscStandardDisplay {
    idd = IDC_TMF_ADMINMENU_RESP_MAP_DISPLAY;
    movingEnable = false;
    class controlsBackground {};
    class objects {};
    class controls {
        class FullRespawnMap : RscMapControl {
            idc = IDC_TMF_ADMINMENU_RESP_MAP_CONTROL;
            type = CT_MAP;
            x = 0 * safezoneW + safezoneX;
            y = 0 * safezoneH + safezoneY;
            w = 1 * safezoneW;
            h = 1 * safezoneH;
            onDraw = QUOTE(_this call FUNC(respawn_mapDrawIcons));
            onSetFocus = QUOTE(_this spawn FUNC(respawn_mapLoaded)); //"['respawnMapLoaded'] spawn tmf_respawn_fnc_handleRespawnUI";
            onMouseButtonDown = QUOTE(_this spawn FUNC(respawn_mapClick)); //"['respawnMap_onMouseButtonDown',_this] spawn tmf_respawn_fnc_handleRespawnUI";
            onKeyUp = QUOTE(_this spawn FUNC(respawn_mapKeyUp)); //"['respawnMap_keyUp',_this] spawn tmf_respawn_fnc_handleRespawnUI";
        };
    };
};


class GVAR(adminEyeDialog): RscStandardDisplay {
    idd = IDC_TMF_ADMINMENU_ADME_MAP_DISPLAY;
    movingEnable = false;
    class controlsBackground {};
    class objects {};
    class controls {
        class FullRespawnMap : RscMapControl {
            idc = IDC_TMF_ADMINMENU_ADME_MAP_CONTROL;
            type = CT_MAP;
            x = 0 * safezoneW + safezoneX;
            y = 0 * safezoneH + safezoneY;
            w = 1 * safezoneW;
            h = 1 * safezoneH;
            onDraw = QUOTE(_this call FUNC(adminEye_draw));
            onMouseButtonDown = QUOTE(_this spawn FUNC(adminEye_onClick));
            onSetFocus = QUOTE(_this spawn FUNC(adminEye_onLoad));
            onKeyUp = QUOTE(_this spawn FUNC(adminEye_onKeyPress));
        };
    };
};


class GVAR(spectatorControlUnitDialog): RscStandardDisplay {
    idd = -1;
    class Controls {};
    class ControlsBackground {
        class Title: RscTitle {
            idc = -1;
            text = "Select Unit in Vehicle";
            moving = true;
            x = 1 * GUI_GRID_W + GUI_GRID_CENTER_X;
            y = 1 * GUI_GRID_H + GUI_GRID_CENTER_Y;
            w = 19 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;
            colorBackground[] = GUI_BCG_COLOR;
            shadow = 1;
            style = ST_SINGLE;
        };
        class Background: RscText {
            onLoad = QUOTE(_this call FUNC(remoteControl_dialog));
            x = 1 * GUI_GRID_W + GUI_GRID_CENTER_X;
            y = 2.1 * GUI_GRID_H + GUI_GRID_CENTER_Y;
            w = 19 * GUI_GRID_W;
            h = 16 * GUI_GRID_H;
            colorBackground[] = {0,0,0,0.7};
        };
    };
};
