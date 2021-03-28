class Controls {
    class LabelFilter: RscText {
        text = "Filter:";
        sizeEx = GUI_TEXT_SIZE_SMALL;
        x = 0;
        y = 0;
        w = 2.1 * GUI_GRID_W;
        h = 1 * GUI_GRID_H;
    };
    class ComboFilterSide: RscCombo {
        idc = IDC_TMF_ADMINMENU_PMAN_FILTER_SIDE;
        sizeEx = GUI_TEXT_SIZE_SMALL;
        font = GUI_FONT_NORMAL;
        x = 2.2 * GUI_GRID_W;
        y = 0;
        w = 6 * GUI_GRID_W;
        h = 1 * GUI_GRID_H;
    };
    class ComboFilterState: ComboFilterSide {
        idc = IDC_TMF_ADMINMENU_PMAN_FILTER_STATE;
        x = "8.3 * GUI_GRID_W";
        w = "5 * GUI_GRID_W";
    };
    class ButtonFilterReset: GVAR(RscButtonMenu) {
        idc = IDC_TMF_ADMINMENU_PMAN_FILTER_RESET;
        text = "Reset";
        x = 13.4 * GUI_GRID_W;
        y = 0;
        w = 2.5 * GUI_GRID_W;
    };
    class ButtonRefresh: GVAR(RscButtonMenu) {
        idc = IDC_TMF_ADMINMENU_PMAN_REFRESH;
        text = "Refresh";
        x = 26.9 * GUI_GRID_W;
        y = 0;
        w = 3 * GUI_GRID_W;
    };

    class BackgroundGroupList: RscText {
        x = 0;
        y = 1.1 * GUI_GRID_H + GUI_GRID_CENTER_Y;
        w = TMF_ADMINMENU_PMAN_W_LISTGROUP;
        h = TMF_ADMINMENU_PMAN_H_LISTGROUP;
        colorBackground[] = {0, 0, 0, 0.3};
        style = ST_CENTER;
    };

    class ListPlayers: RscListBox {
        idc = IDC_TMF_ADMINMENU_PMAN_LIST;
        style = LB_MULTI + ST_MULTI;
        onLBSelChanged = QUOTE(_this call FUNC(playerManagement_listSelChange););
        sizeEx = GUI_TEXT_SIZE_SMALL;
        sizeEx2 = GUI_TEXT_SIZE_SMALL;
        pictureColor[] = {1,1,1,1}; // Picture color
        pictureColorSelect[] = {1,1,1,1}; // Selected picture color
        pictureColorDisabled[] = {1,1,1,0.5}; // Disabled picture color
        rowHeight = 1 * GUI_GRID_H;
        colorText[] = {1,1,1,1};
        colorBackground[] = {0,0,0,0};
        itemBackground[] = {1,1,1,0.2};
        itemSpacing = 0;
        x = 0;
        y = 1.1 * GUI_GRID_H + GUI_GRID_CENTER_Y;
        w = TMF_ADMINMENU_PMAN_W_LISTGROUP;
        h = TMF_ADMINMENU_PMAN_H_LISTGROUP;
    };

    /*
    * Right-hand side vertical menu
    */
    class LabelSelect: RscText {
        text = "Select...";
        sizeEx = GUI_TEXT_SIZE_SMALL;
        x = 30.9 * GUI_GRID_W;
        y = 0;
        w = 6.9 * GUI_GRID_W;
        h = 1 * GUI_GRID_H;
    };
    class ButtonSelectAll: ButtonFilterReset {
        idc = IDC_TMF_ADMINMENU_PMAN_SEL_ALL;
        text = "All";
        x = 30.9 * GUI_GRID_W;
        y = 1.1 * GUI_GRID_H + GUI_GRID_CENTER_Y;
        w = 6.9 * GUI_GRID_W;
    };
    class ButtonSelectNone: ButtonSelectAll {
        idc = IDC_TMF_ADMINMENU_PMAN_SEL_NONE;
        text = "None";
        y = 2.2 * GUI_GRID_H + GUI_GRID_CENTER_Y;
    };
    class ButtonSelectInvert: ButtonSelectAll {
        idc = IDC_TMF_ADMINMENU_PMAN_SEL_INVERT;
        text = "Invert";
        y = 3.3 * GUI_GRID_H + GUI_GRID_CENTER_Y;
    };

    class LabelWithSelected: RscText
    {
        idc = -1;
        text = "With Selected...";
        sizeEx = GUI_TEXT_SIZE_SMALL;
        x = 30.9 * GUI_GRID_W;
        y = 4.4 * GUI_GRID_H + GUI_GRID_CENTER_Y;
        w = 6.9 * GUI_GRID_W;
        h = 1 * GUI_GRID_H;
    };

    class ButtonACRE2Languages: ButtonSelectAll
    {
        idc = IDC_TMF_ADMINMENU_PMAN_ACRELANGUAGES;
        text = "ACRE2 Languages";
        onButtonClick = QUOTE([ARR_2(QUOTE(QFUNC(modal_ACRE2Languages)),ctrlText (_this select 0))] call FUNC(modal););
        y = 5.5 * GUI_GRID_H + GUI_GRID_CENTER_Y;
    };
    class ButtonACRE2Radios: ButtonSelectAll
    {
        idc = IDC_TMF_ADMINMENU_PMAN_ACRERADIOS;
        text = "ACRE2 Radios";
        onButtonClick = QUOTE([ARR_2(QUOTE(QFUNC(modal_ACRE2Radios)),ctrlText (_this select 0))] call FUNC(modal););
        y = 6.6 * GUI_GRID_H + GUI_GRID_CENTER_Y;
    };
    class ButtonAssignGear: ButtonSelectAll
    {
        idc = IDC_TMF_ADMINMENU_PMAN_ASSIGNGEAR;
        text = "Assign Gear";
        onButtonClick = QUOTE([ARR_2(QUOTE(QFUNC(modal_assignGear)),ctrlText (_this select 0))] call FUNC(modal););
        y = 7.7 * GUI_GRID_H + GUI_GRID_CENTER_Y;
    };
    class ButtonAssignTraits: ButtonSelectAll
    {
        idc = IDC_TMF_ADMINMENU_PMAN_ASSIGNTRAITS;
        text = "Assign Traits";
        onButtonClick = QUOTE([ARR_2(QUOTE(QFUNC(modal_assignTraits)),ctrlText (_this select 0))] call FUNC(modal););
        y = 8.8 * GUI_GRID_H + GUI_GRID_CENTER_Y;
    };
    class ButtonGrantZeus: ButtonSelectAll
    {
        idc = IDC_TMF_ADMINMENU_PMAN_GRANTZEUS;
        text = "Grant Zeus";
        onButtonClick = QUOTE([ARR_2(QUOTE(QFUNC(utility_grantZeus)),ctrlText (_this select 0))] call FUNC(utility););
        y = 9.9 * GUI_GRID_H + GUI_GRID_CENTER_Y;
    };
    class ButtonHeal: ButtonSelectAll
    {
        idc = IDC_TMF_ADMINMENU_PMAN_HEAL;
        text = "Heal";
        onButtonClick = QUOTE([ARR_3(QUOTE(QFUNC(utility_heal)),ctrlText (_this select 0),True)] call FUNC(utility););
        y = 11 * GUI_GRID_H + GUI_GRID_CENTER_Y;
    };
    class ButtonMessage: ButtonSelectAll
    {
        idc = IDC_TMF_ADMINMENU_PMAN_MESSAGE;
        text = "Message";
        onButtonClick = QUOTE([ARR_2(QUOTE(QFUNC(modal_message)),ctrlText (_this select 0))] call FUNC(modal););
        y = 12.1 * GUI_GRID_H + GUI_GRID_CENTER_Y;
    };
    class ButtonQuickRespawn: ButtonSelectAll
    {
        idc = IDC_TMF_ADMINMENU_PMAN_QRESPAWN;
        text = "Quick Respawn";
        onButtonClick = QUOTE([ARR_2(QUOTE(QFUNC(utility_quickRespawn)),ctrlText (_this select 0))] call FUNC(utility););
        y = 13.2 * GUI_GRID_H + GUI_GRID_CENTER_Y;
    };
    class ButtonRunCode: ButtonSelectAll
    {
        idc = IDC_TMF_ADMINMENU_PMAN_RUNCODE;
        text = "Run Code On";
        onButtonClick = QUOTE([ARR_2(QUOTE(QFUNC(modal_runCode)),ctrlText (_this select 0))] call FUNC(modal););
        y = 14.3 * GUI_GRID_H + GUI_GRID_CENTER_Y;
    };
    class ButtonSteamProfile: ButtonSelectAll
    {
        idc = IDC_TMF_ADMINMENU_PMAN_STEAM;
        text = "Steam Profile";
        onButtonClick = QUOTE([ARR_2(QUOTE(QFUNC(modal_steamProfile)),ctrlText (_this select 0))] call FUNC(modal););
        y = 15.4 * GUI_GRID_H + GUI_GRID_CENTER_Y;
    };
    class ButtonTeleport: ButtonSelectAll
    {
        idc = IDC_TMF_ADMINMENU_PMAN_TELEPORT;
        text = "Teleport";
        onButtonClick = QUOTE([ARR_3(QUOTE(QFUNC(modal_teleport)),ctrlText (_this select 0),True)] call FUNC(modal););
        y = 16.5 * GUI_GRID_H + GUI_GRID_CENTER_Y;
    };
};
