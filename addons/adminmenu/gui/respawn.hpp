class Controls
{
    class respawnMenuPlayersText: RscText
    {
        idc = IDC_TMF_ADMINMENU_RESP_SPECTATORTEXT;
        text = "Players in Spectator: 0";

        sizeEx = GUI_TEXT_SIZE_SMALL;

        x = 0;
        y = 0;
        w = TMF_ADMINMENU_RESP_W_COL1;
        h = GUI_GRID_H;
    };
    class spectatorListBox: RscListBox
    {
        idc = IDC_TMF_ADMINMENU_RESP_SPECTATORLIST;

        sizeEx = GUI_TEXT_SIZE_SMALL;
        sizeEx2 = GUI_TEXT_SIZE_SMALL;
        //rowHeight = 0.97 * GUI_GRID_H;
        //rowHeight = GUI_GRID_H;
        //colorBackground[] = {0, 0, 0, 1};
        //shadow = 0;
        //itemSpacing = 0.05;

        pictureColor[] = {1,1,1,1}; // Picture color
        pictureColorSelect[] = {1,1,1,1}; // Selected picture color
        pictureColorDisabled[] = {1,1,1,0.5}; // Disabled picture color

        rowHeight = 1 * GUI_GRID_H;
        colorText[] = {1,1,1,1};
        // colorBackground[] = {0,0,0,0};
        itemBackground[] = {1,1,1,0.2};
        itemSpacing = 0;

        tooltip = "tooltip test";

        x = 0;
        y = 1.1 * GUI_GRID_H + GUI_GRID_CENTER_Y;
        w = TMF_ADMINMENU_RESP_W_COL1;
        h = 0.308 * safezoneH;
    };

    class respawnMenuAddButton: GVAR(RscButtonMenu)
    {
        idc = IDC_TMF_ADMINMENU_RESP_ADDBUTTON;
        text = "Add";
        x = TMF_ADMINMENU_RESP_X_COL2;
        y = 1.1 * GUI_GRID_H + GUI_GRID_CENTER_Y;
        w = TMF_ADMINMENU_RESP_W_COL2;
        h = GUI_GRID_H;
        onButtonClick=QUOTE((ctrlParent (param [0])) call FUNC(respawn_addAction));
    };
    class respawnMenuRemoveButton: GVAR(RscButtonMenu)
    {
        idc = IDC_TMF_ADMINMENU_RESP_REMOVEBUTTON;
        text = "Remove";
        x = TMF_ADMINMENU_RESP_X_COL2;
        y = 2.2 * GUI_GRID_H + GUI_GRID_CENTER_Y;
        w = TMF_ADMINMENU_RESP_W_COL2;
        h = GUI_GRID_H;
        onButtonClick=QUOTE((ctrlParent (param [0])) call FUNC(respawn_removeAction));
    };
    class respawnMenuRscComboRole: RscCombo
    {
        idc = IDC_TMF_ADMINMENU_RESP_ROLECOMBO;
        text = "Role";

        sizeEx = GUI_TEXT_SIZE_SMALL;
        font = GUI_FONT_NORMAL;

        x = TMF_ADMINMENU_RESP_X_COL2;
        y = 3.3 * GUI_GRID_H + GUI_GRID_CENTER_Y;
        w = TMF_ADMINMENU_RESP_W_COL2;
        h = GUI_GRID_H;
    };
    class RankText: RscText
    {
        idc = -1;
        text = "Unit rank:";

        sizeEx = GUI_TEXT_SIZE_SMALL;

        x = TMF_ADMINMENU_RESP_X_COL2;
        y = 4.4 * GUI_GRID_H + GUI_GRID_CENTER_Y;
        w = TMF_ADMINMENU_RESP_W_COL2;
        h = GUI_GRID_H;
    };

    class RankSelector: RscToolbox
    {
        idc = IDC_TMF_ADMINMENU_RESP_RANK;

        style = ST_CENTER + ST_PICTURE + ST_KEEP_ASPECT_RATIO;
        sizeEx = GUI_TEXT_SIZE_SMALL;
        rows = 2;
        columns = 4;
        strings[]=
        {
            "\a3\Ui_f\data\GUI\Cfg\Ranks\private_gs.paa",
            "\a3\Ui_f\data\GUI\Cfg\Ranks\corporal_gs.paa",
            "\a3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa",
            "\a3\Ui_f\data\GUI\Cfg\Ranks\lieutenant_gs.paa",
            "\a3\Ui_f\data\GUI\Cfg\Ranks\captain_gs.paa",
            "\a3\Ui_f\data\GUI\Cfg\Ranks\major_gs.paa",
            "\a3\Ui_f\data\GUI\Cfg\Ranks\colonel_gs.paa"
        };
        tooltips[]=
        {
            "Private",
            "Corporal",
            "Sergeant",
            "Lieutenant",
            "Captain",
            "Major",
            "Colonel"
        };
        values[]={0,1,2,3,4,5,6};
        onToolBoxSelChanged = QUOTE(GVAR(respawn_rank) = param [1]);
        color[] = {0.4, 0.4, 1, 0.25};
        colorText[] = {1, 1, 1, 1};
        colorSelect[] = {0.4, 0.4, 1, 0.75};
        colorTextSelect[] = {1, 1, 1, 1};
        colorDisable[] = {1, 1, 0, 0.75};
        colorTextDisable[] = {0, 0, 0, 1};
        colorSelectedBg[] = {1, 1, 1, 0.2};
        colorBackground[] = {0.5, 0.5, 0.5, 0.1};

        x = TMF_ADMINMENU_RESP_X_COL2;
        y = 5.5 * GUI_GRID_H + GUI_GRID_CENTER_Y;
        w = TMF_ADMINMENU_RESP_W_COL2;
        h = 2 * GUI_GRID_H;
    };

    class respawnMenuVOIP: GVAR(RscButtonMenu)
    {
        idc = IDC_TMF_ADMINMENU_RESP_SPECTATORVOIP;
        text = "Toggle Spectator VOIP";
        x = TMF_ADMINMENU_RESP_X_COL3;
        y = 0;
        w = TMF_ADMINMENU_RESP_W_COL3;
        h = GUI_GRID_H;
        tooltip = "Toggles the spectator channel for you (ACRE/TFAR), so that you can talk to dead players if alive.";
        onButtonClick = QUOTE((ctrlParent (param [0])) call FUNC(respawn_toggleSpectatorVOIP));
    };
    class groupListBox: RscListBox
    {
        idc = IDC_TMF_ADMINMENU_RESP_GROUPLIST;

        sizeEx = GUI_TEXT_SIZE_SMALL;
        sizeEx2 = GUI_TEXT_SIZE_SMALL;
        //rowHeight = 0.97 * GUI_GRID_H;
        //rowHeight = GUI_GRID_H;
        //colorBackground[] = {0, 0, 0, 1};
        //shadow = 0;
        //itemSpacing = 0.05;

        pictureColor[] = {1,1,1,1}; // Picture color
        pictureColorSelect[] = {1,1,1,1}; // Selected picture color
        pictureColorDisabled[] = {1,1,1,0.5}; // Disabled picture color

        rowHeight = 1 * GUI_GRID_H;
        colorText[] = {1,1,1,1};
        // colorBackground[] = {0,0,0,0};
        itemBackground[] = {1,1,1,0.2};
        itemSpacing = 0;

        tooltip = "tooltip test";

        x = TMF_ADMINMENU_RESP_X_COL3;
        y = 1.1 * GUI_GRID_H + GUI_GRID_CENTER_Y;
        w = TMF_ADMINMENU_RESP_W_COL3;
        h = 0.308 * safezoneH;
    };

    class respawnGroupDetailsText: RscText
    {
        idc = -1;
        text = "Group Details:";

        sizeEx = GUI_TEXT_SIZE_SMALL;

        x = TMF_ADMINMENU_RESP_X_COL4;
        y = 1.1 * GUI_GRID_H + GUI_GRID_CENTER_Y;
        w = TMF_ADMINMENU_RESP_W_COL1;
        h = GUI_GRID_H;
    };
    class respawnMenuGroupNameText: RscEdit
    {
        idc = IDC_TMF_ADMINMENU_RESP_GROUPNAME;
        text = "INSERT_GROUP_NAME";

        colorBackground[] = {0.5, 0.5, 0.5, 0.1};
        colorBorder[] = {1, 1, 1, 0.33};
        sizeEx = GUI_TEXT_SIZE_SMALL;

        x = TMF_ADMINMENU_RESP_X_COL4;
        y = 2.2 * GUI_GRID_H + GUI_GRID_CENTER_Y;
        w = TMF_ADMINMENU_RESP_W_COL4;
        h = GUI_GRID_H;
    };
    class respawnMenuFactionCategoryCombo: RscCombo
    {
        idc = IDC_TMF_ADMINMENU_RESP_FACTIONCATEGORY;
        text = "FactionCategory"; /*Formerly side */

        sizeEx = GUI_TEXT_SIZE_SMALL;
        font = GUI_FONT_NORMAL;

        x = TMF_ADMINMENU_RESP_X_COL4;
        y = 3.3 * GUI_GRID_H + GUI_GRID_CENTER_Y;
        w = TMF_ADMINMENU_RESP_W_COL4;
        h = GUI_GRID_H;
    };
    class respawnMenuFactionCombo: RscCombo
    {
        idc = IDC_TMF_ADMINMENU_RESP_FACTION;
        text = "Faction";

        sizeEx = GUI_TEXT_SIZE_SMALL;
        font = GUI_FONT_NORMAL;

        x = TMF_ADMINMENU_RESP_X_COL4;
        y = 4.4 * GUI_GRID_H + GUI_GRID_CENTER_Y;
        w = TMF_ADMINMENU_RESP_W_COL4;
        h = GUI_GRID_H;
    };
    class respawnMenuSideCombo: RscCombo
    {
        idc = IDC_TMF_ADMINMENU_RESP_SIDE;
        text = "Side";

        sizeEx = GUI_TEXT_SIZE_SMALL;
        font = GUI_FONT_NORMAL;

        x = TMF_ADMINMENU_RESP_X_COL4;
        y = 5.5 * GUI_GRID_H + GUI_GRID_CENTER_Y;
        w = TMF_ADMINMENU_RESP_W_COL4;
        h = GUI_GRID_H;
    };

    class respawnMenuSpawnMarkerText: RscText
    {
        idc = -1;
        text = "Spawn with ORBAT marker?";

        sizeEx = GUI_TEXT_SIZE_SMALL;

        x = TMF_ADMINMENU_RESP_X_COL4;
        y = 7.7 * GUI_GRID_H + GUI_GRID_CENTER_Y;
        w = TMF_ADMINMENU_RESP_W_COL4;
        h = GUI_GRID_H;
    };
    class respawnMenuGroupMarkerCheckbox: RscCheckBox
    {
        idc = IDC_TMF_ADMINMENU_RESP_GROUPMARKERCHECKBOX;
        text = "Give group marker";
        x = TMF_ADMINMENU_RESP_X_COL4 + (7 * GUI_GRID_W);
        y = 7.7 * GUI_GRID_H + GUI_GRID_CENTER_Y;
        w = (1 * GUI_GRID_W);
        h = GUI_GRID_H;
        //action = "['respawnMenuToggleGroupCheckbox'] spawn tmf_respawn_fnc_handleRespawnUI";
    };
    class respawnMenuMarkerName: RscEdit
    {
        idc = IDC_TMF_ADMINMENU_RESP_GROUPMARKERNAME;
        text = "INSERT_MARKER_NAME";

        // colorBackground[] = {0.5, 0.5, 0.5, 0.1};
        // colorBorder[] = {1, 1, 1, 0.33};
        sizeEx = GUI_TEXT_SIZE_SMALL;

        x = TMF_ADMINMENU_RESP_X_COL4;
        y = 8.8 * GUI_GRID_H + GUI_GRID_CENTER_Y;
        w = TMF_ADMINMENU_RESP_W_COL4;
        h = GUI_GRID_H;
    };


        //Marker combo boxs
    class MarkerTypeCombo: RscCombo
    {
        idc = IDC_TMF_ADMINMENU_RESP_MARKERTYPE;
        text = "Side";

        sizeEx = GUI_TEXT_SIZE_SMALL;
        font = GUI_FONT_NORMAL;


        x = TMF_ADMINMENU_RESP_X_COL4;
        y = 9.9 * GUI_GRID_H + GUI_GRID_CENTER_Y;
        w = TMF_ADMINMENU_RESP_W_COL4;
        h = GUI_GRID_H;
    };
    class MarkerColourCombo: RscCombo
    {
        idc = IDC_TMF_ADMINMENU_RESP_MARKERCOLOUR;
        text = "Side";

        sizeEx = GUI_TEXT_SIZE_SMALL;
        font = GUI_FONT_NORMAL;

        x = TMF_ADMINMENU_RESP_X_COL4;
        y = 11 * GUI_GRID_H + GUI_GRID_CENTER_Y;
        w = TMF_ADMINMENU_RESP_W_COL4;
        h = GUI_GRID_H;
    };

    class respawnMenuSpawnButton: GVAR(RscButtonMenu)
    {
        idc = IDC_TMF_ADMINMENU_RESP_SPAWNBUTTON;
        text = "Spawn Group";
        x = TMF_ADMINMENU_RESP_X_COL4;
        y = 19 * GUI_GRID_H + GUI_GRID_CENTER_Y;
        w = TMF_ADMINMENU_RESP_W_COL4;
        h = GUI_GRID_H;

        onButtonClick=QUOTE((ctrlParent (param [0])) call FUNC(respawn_respawnButton));
    };



    // class respawnMenuCloseButton: GVAR(RscButtonMenu)
    // {
        // idc = 26904;
        // text = "Close";
        // x = 0.716563 * safezoneW + safezoneX;
        // y = 0.3196 * safezoneH + safezoneY;
        // w = 0.0309375 * safezoneW;
        // h = 0.022 * safezoneH;
        // action = "closeDialog 26893";
    // };

    // class respawnMenuChangeRoleButton: GVAR(RscButtonMenu)
    // {
        // idc = 1603;
        // text = "Cycle Role";
        // x = 0.684594 * safezoneW + safezoneX;
        // y = 0.445 * safezoneH + safezoneY;
        // w = 0.0567187 * safezoneW;
        // h = 0.055 * safezoneH;
        // action="['respawnMenuChangeRoleAction'] spawn tmf_respawn_fnc_handleRespawnUI";
    // };
    // class respawnMenuChangeRankButton: GVAR(RscButtonMenu)
    // {
        // idc = 1604;
        // text = "Cycle Rank";
        // x = 0.684594 * safezoneW + safezoneX;
        // y = 0.544 * safezoneH + safezoneY;
        // w = 0.0567187 * safezoneW;
        // h = 0.055 * safezoneH;
        // action="['respawnMenuChangeRankAction'] spawn tmf_respawn_fnc_handleRespawnUI";
    // };
};
