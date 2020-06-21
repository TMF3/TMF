class Controls
{
    class respawnMenuPlayersText: RscText
    {
        idc = IDC_TMF_ADMINMENU_RESP_SPECTATORTEXT;
        text = "Players in Spectator: 0";
        
        sizeEx = TMF_ADMINMENU_STD_SIZEX;
        
        x = 0;
        y = 0;
        w = TMF_ADMINMENU_RESP_W_COL1;
        h = TMF_ADMINMENU_STD_HEIGHT;
    };
    class spectatorListBox: RscListBox
    {
        idc = IDC_TMF_ADMINMENU_RESP_SPECTATORLIST;
        
        sizeEx = TMF_ADMINMENU_STD_SIZEX;
        sizeEx2 = TMF_ADMINMENU_STD_SIZEX;
        //rowHeight = 0.97 * TMF_ADMINMENU_STD_HEIGHT;
        //rowHeight = TMF_ADMINMENU_STD_HEIGHT;
        //colorBackground[] = {0, 0, 0, 1};
        //shadow = 0;
        //itemSpacing = 0.05;

        pictureColor[] = {1,1,1,1}; // Picture color
        pictureColorSelect[] = {1,1,1,1}; // Selected picture color
        pictureColorDisabled[] = {1,1,1,0.5}; // Disabled picture color

        rowHeight = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
        colorText[] = {1,1,1,1};
        // colorBackground[] = {0,0,0,0};
        itemBackground[] = {1,1,1,0.2};
        itemSpacing = 0;

        tooltip = "tooltip test";
        
        x = "0";
        y = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
        w = TMF_ADMINMENU_RESP_W_COL1;
        h = 0.308 * safezoneH;
    };

    class respawnMenuAddButton: GVAR(RscButtonMenu)
    {
        idc = IDC_TMF_ADMINMENU_RESP_ADDBUTTON;
        text = "Add";
        x = TMF_ADMINMENU_RESP_X_COL2;
        y = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
        w = TMF_ADMINMENU_RESP_W_COL2;
        h = TMF_ADMINMENU_STD_HEIGHT;
        onButtonClick=QUOTE((ctrlParent (param [0])) call FUNC(respawn_addAction));
    };
    class respawnMenuRemoveButton: GVAR(RscButtonMenu)
    {
        idc = IDC_TMF_ADMINMENU_RESP_REMOVEBUTTON;
        text = "Remove";
        x = TMF_ADMINMENU_RESP_X_COL2;
        y = "2.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
        w = TMF_ADMINMENU_RESP_W_COL2;
        h = TMF_ADMINMENU_STD_HEIGHT;
        onButtonClick=QUOTE((ctrlParent (param [0])) call FUNC(respawn_removeAction));
    };
    class respawnMenuRscComboRole: RscCombo
    {
        idc = IDC_TMF_ADMINMENU_RESP_ROLECOMBO;
        text = "Role";
        
        sizeEx = TMF_ADMINMENU_STD_SIZEX;
        font = "RobotoCondensed";
        
        x = TMF_ADMINMENU_RESP_X_COL2;
        y = "3.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
        w = TMF_ADMINMENU_RESP_W_COL2;
        h = TMF_ADMINMENU_STD_HEIGHT;
    };
    class RankText: RscText
    {
        idc = -1;
        text = "Unit rank:";
        
        sizeEx = TMF_ADMINMENU_STD_SIZEX;
        
        x = TMF_ADMINMENU_RESP_X_COL2;
        y = "4.4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
        w = TMF_ADMINMENU_RESP_W_COL2;
        h = TMF_ADMINMENU_STD_HEIGHT;
    };
    
    class RankSelector: RscToolbox
    {
        idc = IDC_TMF_ADMINMENU_RESP_RANK;
        
        style="0x02 + 0x30 + 0x800";
        sizeEx = TMF_ADMINMENU_STD_SIZEX;
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
        y = "5.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
        w = TMF_ADMINMENU_RESP_W_COL2;
        h = 2*TMF_ADMINMENU_STD_HEIGHT;
    };

    class respawnMenuVOIP: GVAR(RscButtonMenu)
    {
        idc = IDC_TMF_ADMINMENU_RESP_SPECTATORVOIP;
        text = "Toggle Spectator VOIP";
        x = TMF_ADMINMENU_RESP_X_COL3;
        y = "0";
        w = TMF_ADMINMENU_RESP_W_COL3;
        h = TMF_ADMINMENU_STD_HEIGHT;
        tooltip = "Toggles the spectator channel for you (ACRE/TFAR), so that you can talk to dead players if alive.";
        onButtonClick = QUOTE((ctrlParent (param [0])) call FUNC(respawn_toggleSpectatorVOIP));
    };
    class groupListBox: RscListBox
    {
        idc = IDC_TMF_ADMINMENU_RESP_GROUPLIST;

        sizeEx = TMF_ADMINMENU_STD_SIZEX;
        sizeEx2 = TMF_ADMINMENU_STD_SIZEX;
        //rowHeight = 0.97 * TMF_ADMINMENU_STD_HEIGHT;
        //rowHeight = TMF_ADMINMENU_STD_HEIGHT;
        //colorBackground[] = {0, 0, 0, 1};
        //shadow = 0;
        //itemSpacing = 0.05;

        pictureColor[] = {1,1,1,1}; // Picture color
        pictureColorSelect[] = {1,1,1,1}; // Selected picture color
        pictureColorDisabled[] = {1,1,1,0.5}; // Disabled picture color

        rowHeight = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
        colorText[] = {1,1,1,1};
        // colorBackground[] = {0,0,0,0};
        itemBackground[] = {1,1,1,0.2};
        itemSpacing = 0;

        tooltip = "tooltip test";

        x = TMF_ADMINMENU_RESP_X_COL3;
        y = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
        w = TMF_ADMINMENU_RESP_W_COL3;
        h = 0.308 * safezoneH;
    };

    class respawnGroupDetailsText: RscText
    {
        idc = -1;
        text = "Group Details:";
        
        sizeEx = TMF_ADMINMENU_STD_SIZEX;
        
        x = TMF_ADMINMENU_RESP_X_COL4;
        y = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
        w = TMF_ADMINMENU_RESP_W_COL1;
        h = TMF_ADMINMENU_STD_HEIGHT;
    };
    class respawnMenuGroupNameText: RscEdit
    {
        idc = IDC_TMF_ADMINMENU_RESP_GROUPNAME;
        text = "INSERT_GROUP_NAME";
        
        colorBackground[] = {0.5, 0.5, 0.5, 0.1};
        colorBorder[] = {1, 1, 1, 0.33};
        sizeEx = TMF_ADMINMENU_STD_SIZEX;
        
        x = TMF_ADMINMENU_RESP_X_COL4;
        y = "2.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
        w = TMF_ADMINMENU_RESP_W_COL4;
        h = TMF_ADMINMENU_STD_HEIGHT;
    };
    class respawnMenuFactionCategoryCombo: RscCombo
    {
        idc = IDC_TMF_ADMINMENU_RESP_FACTIONCATEGORY;
        text = "FactionCategory"; /*Formerly side */
        
        sizeEx = TMF_ADMINMENU_STD_SIZEX;
        font = "RobotoCondensed";
        
        x = TMF_ADMINMENU_RESP_X_COL4;
        y = "3.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
        w = TMF_ADMINMENU_RESP_W_COL4;
        h = TMF_ADMINMENU_STD_HEIGHT;
    };
    class respawnMenuFactionCombo: RscCombo
    {
        idc = IDC_TMF_ADMINMENU_RESP_FACTION;
        text = "Faction";
        
        sizeEx = TMF_ADMINMENU_STD_SIZEX;
        font = "RobotoCondensed";
        
        x = TMF_ADMINMENU_RESP_X_COL4;
        y = "4.4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
        w = TMF_ADMINMENU_RESP_W_COL4;
        h = TMF_ADMINMENU_STD_HEIGHT;
    };
    class respawnMenuSideCombo: RscCombo
    {
        idc = IDC_TMF_ADMINMENU_RESP_SIDE;
        text = "Side";
        
        sizeEx = TMF_ADMINMENU_STD_SIZEX;
        font = "RobotoCondensed";
        
        x = TMF_ADMINMENU_RESP_X_COL4;
        y = "5.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
        w = TMF_ADMINMENU_RESP_W_COL4;
        h = TMF_ADMINMENU_STD_HEIGHT;
    };
    
    class respawnMenuSpawnMarkerText: RscText
    {
        idc = -1;
        text = "Spawn with ORBAT marker?";
        
        sizeEx = TMF_ADMINMENU_STD_SIZEX;
        
        x = TMF_ADMINMENU_RESP_X_COL4;
        y = "7.7 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
        w = TMF_ADMINMENU_RESP_W_COL4;
        h = TMF_ADMINMENU_STD_HEIGHT;
    };
    class respawnMenuGroupMarkerCheckbox: RscCheckBox
    {
        idc = IDC_TMF_ADMINMENU_RESP_GROUPMARKERCHECKBOX;
        text = "Give group marker";
        x = TMF_ADMINMENU_RESP_X_COL4 + (7 * (((safezoneW / safezoneH) min 1.2) / 40));
        y = "7.7 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
        w = (1 * (((safezoneW / safezoneH) min 1.2) / 40));
        h = TMF_ADMINMENU_STD_HEIGHT;
        //action = "['respawnMenuToggleGroupCheckbox'] spawn tmf_respawn_fnc_handleRespawnUI";
    };
    class respawnMenuMarkerName: RscEdit
    {
        idc = IDC_TMF_ADMINMENU_RESP_GROUPMARKERNAME;
        text = "INSERT_MARKER_NAME";
        
        // colorBackground[] = {0.5, 0.5, 0.5, 0.1};
        // colorBorder[] = {1, 1, 1, 0.33};
        sizeEx = TMF_ADMINMENU_STD_SIZEX;
        
        x = TMF_ADMINMENU_RESP_X_COL4;
        y = "8.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
        w = TMF_ADMINMENU_RESP_W_COL4;
        h = TMF_ADMINMENU_STD_HEIGHT;
    };
    
    
        //Marker combo boxs
    class MarkerTypeCombo: RscCombo
    {
        idc = IDC_TMF_ADMINMENU_RESP_MARKERTYPE;
        text = "Side";
        
        sizeEx = TMF_ADMINMENU_STD_SIZEX;
        font = "RobotoCondensed";
        
        
        x = TMF_ADMINMENU_RESP_X_COL4;
        y = "9.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
        w = TMF_ADMINMENU_RESP_W_COL4;
        h = TMF_ADMINMENU_STD_HEIGHT;
    };
    class MarkerColourCombo: RscCombo
    {
        idc = IDC_TMF_ADMINMENU_RESP_MARKERCOLOUR;
        text = "Side";
        
        sizeEx = TMF_ADMINMENU_STD_SIZEX;
        font = "RobotoCondensed";
        
        x = TMF_ADMINMENU_RESP_X_COL4;
        y = "11 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
        w = TMF_ADMINMENU_RESP_W_COL4;
        h = TMF_ADMINMENU_STD_HEIGHT;
    };
    
    class respawnMenuSpawnButton: GVAR(RscButtonMenu)
    {
        idc = IDC_TMF_ADMINMENU_RESP_SPAWNBUTTON;
        text = "Spawn Group";
        x = TMF_ADMINMENU_RESP_X_COL4;
        y = "19 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
        w = TMF_ADMINMENU_RESP_W_COL4;
        h = TMF_ADMINMENU_STD_HEIGHT;
        
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
