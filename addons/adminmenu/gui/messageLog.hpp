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

    class ButtonCopySelected: GVAR(RscButtonMenu)
    {
        idc = IDC_TMF_ADMINMENU_MSGS_COPY;
        text = "COPY SELECTED";
        onButtonClick = QUOTE(_this call FUNC(messageLog_copy));
        tooltip = "Copies selected message to clipboard. Only available as server.";
        colorBackground[] = {0, 0, 0, 1};
        x = 0 * TMF_ADMINMENU_STD_WIDTH;
        y = 19.5 * TMF_ADMINMENU_STD_HEIGHT;
        w = 7 * TMF_ADMINMENU_STD_WIDTH;
    };

    class ButtonCopyAll: GVAR(RscButtonMenu)
    {
        idc = IDC_TMF_ADMINMENU_MSGS_COPYALL;
        text = "COPY ALL";
        tooltip = "Copies all logged messages to clipboard. Only available as server.";
        onButtonClick = QUOTE(_this call FUNC(messageLog_copyAll));
        colorBackground[] = {0, 0, 0, 1};
        x = 7.1 * TMF_ADMINMENU_STD_WIDTH;
        y = 19.5 * TMF_ADMINMENU_STD_HEIGHT;
        w = 7 * TMF_ADMINMENU_STD_WIDTH;
    };

    class ButtonPrintToRPT: GVAR(RscButtonMenu)
    {
        idc = IDC_TMF_ADMINMENU_MSGS_COPYALL;
        text = "PRINT TO RPT";
        tooltip = "Prints current log to RPT";
        onButtonClick = QUOTE(_this call FUNC(printLogToRPT));
        colorBackground[] = {0, 0, 0, 1};
        x = 14.2 * TMF_ADMINMENU_STD_WIDTH;
        y = 19.5 * TMF_ADMINMENU_STD_HEIGHT;
        w = 7 * TMF_ADMINMENU_STD_WIDTH;
    };
};
