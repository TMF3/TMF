class Controls
{
    class LabelFilter: RscText
    {
        text = "Logs";
        sizeEx = TMF_ADMINMENU_STD_SIZEX;
        x = "0";
        y = "0";
        w = TMF_ADMINMENU_W_LABEL;
        h = TMF_ADMINMENU_H_LABEL;
    };

    class BackgroundGroupList: RscText
    {
        x = "0";
        y = TMF_ADMINMENU_MSGS_Y_LIST;
        w = TMF_ADMINMENU_MSGS_W_LIST;
        h = TMF_ADMINMENU_MSGS_H_LIST;
        colorBackground[] = {1, 0, 0, 0.3};
        style = "0x02";
    };

    class ListPlayers: RscListBox
    {
        idc = IDC_TMF_ADMINMENU_MSGS_LIST;
        style = 32 + 16; // LB_MULTI + ST_MULTI
        sizeEx = TMF_ADMINMENU_STD_SIZEX;
        sizeEx2 = TMF_ADMINMENU_STD_SIZEX;
        pictureColor[] = {1,1,1,1}; // Picture color
        pictureColorSelect[] = {1,1,1,1}; // Selected picture color
        pictureColorDisabled[] = {1,1,1,0.5}; // Disabled picture color
        rowHeight = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
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
