class GVAR(modal) {
    idd = IDD_TMF_ADMINMENU;
    movingEnable = true;
    enableDisplay = true;
    enableSimulation = true;

    onLoad = QUOTE(_this call FUNC(modalOnLoad););
    onUnload = QUOTE(_this call FUNC(modalOnUnload););
    class Controls {
        class Background: RscText {
            idc = IDC_TMF_ADMINMENU_MODAL_BACK;
            colorBackground[] = {0, 0, 0, 0};
            x = 1 * GUI_GRID_W + GUI_GRID_CENTER_X;
            y = 1 * GUI_GRID_H + GUI_GRID_CENTER_Y;
            w = 38 * GUI_GRID_W;
            h = 23 * GUI_GRID_H;
        };
        class TitleBackground: RscText {
            idc = IDC_TMF_ADMINMENU_MODAL_TBACK;
            colorBackground[] = GUI_BCG_COLOR;
            moving = true;
            x = 1.5 * GUI_GRID_W + GUI_GRID_CENTER_X;
            y = 2.6 * GUI_GRID_H + GUI_GRID_CENTER_Y;
            w = 37 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;
        };
        class Title: RscTitle {
            idc = IDC_TMF_ADMINMENU_MODAL_TITLE;
            text = "TMF Admin Menu";
            style = ST_SINGLE;
            moving = true;
            colorBackground[] = {0, 0, 0, 0};
            x = 1.5 * GUI_GRID_W + GUI_GRID_CENTER_X;
            y = 2.6 * GUI_GRID_H + GUI_GRID_CENTER_Y;
            w = 37 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;
        };
        class GroupBackground: RscText {
            idc = IDC_TMF_ADMINMENU_MODAL_GBACK;
            colorBackground[] = {0, 0, 0, 0.8};
            shadow = 2;
            colorShadow[] = {1, 1, 1, 1};
            colorText[] = {1, 1, 1, 1};
            x = 1.5 * GUI_GRID_W + GUI_GRID_CENTER_X;
            y = 3.7 * GUI_GRID_H + GUI_GRID_CENTER_Y;
            w = 37 * GUI_GRID_W;
            h = 20.3 * GUI_GRID_H;
        };
        class Group: RscControlsGroup {
            idc = IDC_TMF_ADMINMENU_G_MODAL;
            x = 1.6 * GUI_GRID_W + GUI_GRID_CENTER_X;
            y = 3.8 * GUI_GRID_H + GUI_GRID_CENTER_Y;
            w = 36.8 * GUI_GRID_W;
            h = 20.1 * GUI_GRID_H;
            class Controls {};
        };
        class Close {
            idc = IDC_TMF_ADMINMENU_MODAL_CLOSE;
            type = CT_BUTTON;
            style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;
            text = "\a3\ui_f\data\GUI\Rsc\RscDisplayArcadeMap\top_close_gs.paa";
            tooltip = "Close Utility";
            onMouseButtonClick = "closeDialog 1;";
            sizeEx = GUI_TEXT_SIZE_SMALL;
            font = GUI_FONT_NORMAL;
            colorBackground[] = {0, 0, 0, 0};
            colorBackgroundActive[] = {0, 0, 0, 0};
            colorBackgroundDisabled[] = {0, 0, 0, 0};
            colorBorder[] = {0, 0, 0, 0};
            colorDisabled[] = {0, 0, 0, 0};
            colorFocused[] = {0, 0, 0, 0};
            colorShadow[] = {0, 0, 0, 0};
            colorText[] = {1, 1, 1, 1};
            offsetX = 0;
            offsetY = 0;
            offsetPressedX = 0;
            offsetPressedY = 0;
            borderSize = 0;
            soundEnter[] = {"", 0.1, 1};
            soundPush[] = {"", 0.1, 1};
            soundClick[] = {"", 0.1, 1};
            soundEscape[] = {"", 0.1, 1};
            x = 37.5 * GUI_GRID_W + GUI_GRID_CENTER_X;
            y = 2.6 * GUI_GRID_H + GUI_GRID_CENTER_Y;
            w = 1 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;
        };
    };
};
