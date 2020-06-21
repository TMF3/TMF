class Controls
{
    class Label: RscText
    {
        text = "Logs";
        sizeEx = TMF_ADMINMENU_STD_SIZEX;
        x = "0";
        y = "0";
        w = TMF_ADMINMENU_W_LABEL;
        h = TMF_ADMINMENU_H_LABEL;
    };

    class BackgroundMessagesList: RscText
    {
        x = "0";
        y = TMF_ADMINMENU_MSGS_Y_LIST;
        w = TMF_ADMINMENU_MSGS_W_LIST;
        h = TMF_ADMINMENU_MSGS_H_LIST;
        colorBackground[] = {1, 0, 0, 0.3};
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
        y = TMF_ADMINMENU_MSGS_Y_LIST;
        w = TMF_ADMINMENU_MSGS_W_LIST;
        h = TMF_ADMINMENU_MSGS_H_LIST;
    };
};
