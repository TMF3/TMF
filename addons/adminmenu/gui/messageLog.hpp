class Controls
{
    class BackgroundMessagesList: RscText
    {
        x = 0;
        y = 0;
        w = TMF_ADMINMENU_MSGS_W_LIST;
        h = TMF_ADMINMENU_MSGS_H_LIST;
        colorBackground[] = {0, 0, 0, 0.3};
        style = "0x02";
    };

    class ListMessages: RscListBox
    {
        idc = IDC_TMF_ADMINMENU_MSGS_LIST;
        //style = 32 + 16; // LB_MULTI + ST_MULTI
        sizeEx = TMF_ADMINMENU_STD_SIZEX;
        sizeEx2 = TMF_ADMINMENU_STD_SIZEX;
        pictureColor[] = {1,1,1,1}; // Picture color
        pictureColorSelect[] = {1,1,1,1}; // Selected picture color
        pictureColorDisabled[] = {1,1,1,1}; // Disabled picture color
        rowHeight = TMF_ADMINMENU_STD_HEIGHT;
        colorText[] = {1,1,1,1};
        colorBackground[] = {1,0,0,0};
        itemBackground[] = {1,1,1,0.2};
        itemSpacing = 0;
        x = 0;
        y = 0;
        w = TMF_ADMINMENU_MSGS_W_LIST;
        h = TMF_ADMINMENU_MSGS_H_LIST;
    };

    class ButtonPrintSelected: GVAR(RscButtonMenu)
    {
        idc = IDC_TMF_ADMINMENU_MSGS_COPY;
        text = "PRINT SELECTED TO RPT";
        onButtonClick = QUOTE(_this call FUNC(messageLog_print));
        tooltip = "Prints currently selected log entry to RPT.";
        colorBackground[] = {0, 0, 0, 1};
        x = 0 * TMF_ADMINMENU_STD_WIDTH;
        y = 19.5 * TMF_ADMINMENU_STD_HEIGHT;
        w = 9 * TMF_ADMINMENU_STD_WIDTH;
    };

    class ButtonPrintAll: GVAR(RscButtonMenu)
    {
        idc = IDC_TMF_ADMINMENU_MSGS_COPYALL;
        text = "PRINT ALL TO RPT";
        tooltip = "Prints all logged entries to RPT.";
        onButtonClick = QUOTE(_this call FUNC(messageLog_printAll));
        colorBackground[] = {0, 0, 0, 1};
        x = 9.1 * TMF_ADMINMENU_STD_WIDTH;
        y = 19.5 * TMF_ADMINMENU_STD_HEIGHT;
        w = 7 * TMF_ADMINMENU_STD_WIDTH;
    };
};
