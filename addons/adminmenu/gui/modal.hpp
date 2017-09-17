class GVAR(modal)
{
    idd = IDD_TMF_ADMINMENU;
    movingEnable = 0;
    enableDisplay = 1;
    enableSimulation = 1;

    onLoad = QUOTE(_this call FUNC(onLoadModal););
    onUnload = QUOTE(_this call FUNC(onUnloadModal););
    class controls
    {
        class Background: RscText
        {
            idc = IDC_TMF_ADMINMENU_MODAL_BACK;
            colorBackground[] = {0, 0, 0, 0.7};
            x = "1 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX + (safezoneW - ((safezoneW / safezoneH) min 1.2))/2)";
            y = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
            w = "38 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "23 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
        };
        class TitleBackground: RscText
        {
            idc = IDC_TMF_ADMINMENU_MODAL_TBACK;
            colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"};
            x = "1.5 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX + (safezoneW - ((safezoneW / safezoneH) min 1.2))/2)";
            y = "2.6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
            w = "37 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
        };
        class Title: RscTitle
        {
            idc = IDC_TMF_ADMINMENU_MODAL_TITLE;
            text = "TMF Admin Menu";
            style = 0;
            colorBackground[] = {0, 0, 0, 0};
            x = "1.5 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX + (safezoneW - ((safezoneW / safezoneH) min 1.2))/2)";
            y = "2.6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
            w = "37 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
        };
        class GroupBackground: RscText
        {
            idc = IDC_TMF_ADMINMENU_MODAL_GBACK;
            colorBackground[] = {0, 0, 0, 0.8};
            shadow = 2;
            colorShadow[] = {1, 1, 1, 1};
            colorText[] = {1, 1, 1, 1};
            x = "1.5 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX + (safezoneW - ((safezoneW / safezoneH) min 1.2))/2)";
            y = "3.7 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
            w = "37 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "20.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
        };
        class Group: RscControlsGroup
        {
            idc = IDC_TMF_ADMINMENU_G_MODAL;
            x = "1.6 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX + (safezoneW - ((safezoneW / safezoneH) min 1.2))/2)";
            y = "3.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
            w = "36.8 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "20.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            class Controls {};
        };
        class Close: RscText
        {
            idc = IDC_TMF_ADMINMENU_MODAL_CLOSE;
            type = 0;
            style = 48 + 2048;
            text = "\a3\ui_f\data\GUI\Rsc\RscDisplayArcadeMap\top_close_gs.paa";
            tooltip = "Close Modal Window";
            onMouseButtonClick = "closeDialog 1;";
            colorBackground[] = {0, 0, 0, 0};
            colorText[] = {1, 1, 1, 1};
            x = "37.5 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX + (safezoneW - ((safezoneW / safezoneH) min 1.2))/2)";
            y = "2.6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
            w = "1 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
        };
    };
