class Controls
{
    class LabelFilter: RscText
    {
        text = "Filter:";
        sizeEx = TMF_ADMINMENU_STD_SIZEX;
        x = "0";
        y = "0";
        w = "2.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
        h = "1 *((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    };
    class ComboFilterSide: RscCombo
    {
        idc = IDC_TMF_ADMINMENU_PMAN_FILTER_SIDE;
        sizeEx = TMF_ADMINMENU_STD_SIZEX;
        font = "RobotoCondensed";
        x = "2.2 * (((safezoneW / safezoneH) min 1.2) / 40)";
        y = "0";
        w = "6 * (((safezoneW / safezoneH) min 1.2) / 40)";
        h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    };
    class ComboFilterState: ComboFilterSide
    {
        idc = IDC_TMF_ADMINMENU_PMAN_FILTER_STATE;
        x = "8.3 * (((safezoneW / safezoneH) min 1.2) / 40)";
        w = "5 * (((safezoneW / safezoneH) min 1.2) / 40)";
    };
    class ButtonFilterReset: GVAR(RscButtonMenu)
    {
        idc = IDC_TMF_ADMINMENU_PMAN_FILTER_RESET;
        text = "Reset";
        x = "13.4 * (((safezoneW / safezoneH) min 1.2) / 40)";
        y = "0";
        w = "2.5 * (((safezoneW / safezoneH) min 1.2) / 40)";
    };
    class ButtonRefresh: GVAR(RscButtonMenu)
    {
        idc = IDC_TMF_ADMINMENU_PMAN_REFRESH;
        text = "Refresh";
        x = "26.9 * (((safezoneW / safezoneH) min 1.2) / 40)";
        y = "0";
        w = "3 * (((safezoneW / safezoneH) min 1.2) / 40)";
    };

    class BackgroundGroupList: RscText
    {
        x = "0";
        y = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
        w = TMF_ADMINMENU_PMAN_W_LISTGROUP;
        h = TMF_ADMINMENU_PMAN_H_LISTGROUP;
        colorBackground[] = {0, 0, 0, 0.3};
        style = "0x02";
    };

    class ListPlayers: RscListBox
    {
        idc = IDC_TMF_ADMINMENU_PMAN_LIST;
        style = 32 + 16; // LB_MULTI + ST_MULTI
        onLBSelChanged = QUOTE(_this call FUNC(playerManagement_listSelChange););
        sizeEx = TMF_ADMINMENU_STD_SIZEX;
        sizeEx2 = TMF_ADMINMENU_STD_SIZEX;
        pictureColor[] = {1,1,1,1}; // Picture color
        pictureColorSelect[] = {1,1,1,1}; // Selected picture color
        pictureColorDisabled[] = {1,1,1,0.5}; // Disabled picture color
        rowHeight = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
        colorText[] = {1,1,1,1};
        colorBackground[] = {0,0,0,0};
        itemBackground[] = {1,1,1,0.2};
        itemSpacing = 0;
        x = 0;
        y = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
        w = TMF_ADMINMENU_PMAN_W_LISTGROUP;
        h = TMF_ADMINMENU_PMAN_H_LISTGROUP;
    };

    /*
    * Right-hand side vertical menu
    */
    class LabelSelect: RscText
    {
        text = "Select...";
        sizeEx = TMF_ADMINMENU_STD_SIZEX;
        x = "30.9 * (((safezoneW / safezoneH) min 1.2) / 40)";
        y = "0";
        w = "6.9 * (((safezoneW / safezoneH) min 1.2) / 40)";
        h = "1 *((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    };
    class ButtonSelectAll: ButtonFilterReset
    {
        idc = IDC_TMF_ADMINMENU_PMAN_SEL_ALL;
        text = "All";
        x = "30.9 * (((safezoneW / safezoneH) min 1.2) / 40)";
        y = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
        w = "6.9 * (((safezoneW / safezoneH) min 1.2) / 40)";
    };
    class ButtonSelectNone: ButtonSelectAll
    {
        idc = IDC_TMF_ADMINMENU_PMAN_SEL_NONE;
        text = "None";
        y = "2.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
    };
    class ButtonSelectInvert: ButtonSelectAll
    {
        idc = IDC_TMF_ADMINMENU_PMAN_SEL_INVERT;
        text = "Invert";
        y = "3.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
    };

    class LabelWithSelected: RscText
    {
        idc = -1;
        text = "With Selected...";
        sizeEx = TMF_ADMINMENU_STD_SIZEX;
        x = "30.9 * (((safezoneW / safezoneH) min 1.2) / 40)";
        y = "4.4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
        w = "6.9 * (((safezoneW / safezoneH) min 1.2) / 40)";
        h = "1 *((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    };
    
    class ButtonACRE2Languages: ButtonSelectAll
    {
        idc = IDC_TMF_ADMINMENU_PMAN_ACRELANGUAGES;
        text = "ACRE2 Languages";
        onButtonClick = QUOTE([ARR_2(QUOTE(QFUNC(modal_ACRE2Languages)),ctrlText (_this select 0))] call FUNC(modal););
        y = "5.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
    };
    class ButtonACRE2Radios: ButtonSelectAll
    {
        idc = IDC_TMF_ADMINMENU_PMAN_ACRERADIOS;
        text = "ACRE2 Radios";
        onButtonClick = QUOTE([ARR_2(QUOTE(QFUNC(modal_ACRE2Radios)),ctrlText (_this select 0))] call FUNC(modal););
        y = "6.6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
    };
    class ButtonAssignGear: ButtonSelectAll
    {
        idc = IDC_TMF_ADMINMENU_PMAN_ASSIGNGEAR;
        text = "Assign Gear";
        onButtonClick = QUOTE([ARR_2(QUOTE(QFUNC(modal_assignGear)),ctrlText (_this select 0))] call FUNC(modal););
        y = "7.7 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
    };
    class ButtonAssignTraits: ButtonSelectAll
    {
        idc = IDC_TMF_ADMINMENU_PMAN_ASSIGNTRAITS;
        text = "Assign Traits";
        onButtonClick = QUOTE([ARR_2(QUOTE(QFUNC(modal_assignTraits)),ctrlText (_this select 0))] call FUNC(modal););
        y = "8.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
    };
    class ButtonGrantZeus: ButtonSelectAll
    {
        idc = IDC_TMF_ADMINMENU_PMAN_GRANTZEUS;
        text = "Grant Zeus";
        onButtonClick = QUOTE([ARR_2(QUOTE(QFUNC(utility_grantZeus)),ctrlText (_this select 0))] call FUNC(utility););
        y = "9.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
    };
    class ButtonHeal: ButtonSelectAll
    {
        idc = IDC_TMF_ADMINMENU_PMAN_HEAL;
        text = "Heal";
        onButtonClick = QUOTE([ARR_3(QUOTE(QFUNC(utility_heal)),ctrlText (_this select 0),true)] call FUNC(utility););
        y = "11 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
    };
    class ButtonMessage: ButtonSelectAll
    {
        idc = IDC_TMF_ADMINMENU_PMAN_MESSAGE;
        text = "Message";
        onButtonClick = QUOTE([ARR_2(QUOTE(QFUNC(modal_message)),ctrlText (_this select 0))] call FUNC(modal););
        y = "12.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
    };
    class ButtonQuickRespawn: ButtonSelectAll
    {
        idc = IDC_TMF_ADMINMENU_PMAN_QRESPAWN;
        text = "Quick Respawn";
        onButtonClick = QUOTE([ARR_2(QUOTE(QFUNC(utility_quickRespawn)),ctrlText (_this select 0))] call FUNC(utility););
        y = "13.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
    };
    class ButtonRunCode: ButtonSelectAll
    {
        idc = IDC_TMF_ADMINMENU_PMAN_RUNCODE;
        text = "Run Code On";
        onButtonClick = QUOTE([ARR_2(QUOTE(QFUNC(modal_runCode)),ctrlText (_this select 0))] call FUNC(modal););
        y = "14.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
    };
    class ButtonSteamProfile: ButtonSelectAll
    {
        idc = IDC_TMF_ADMINMENU_PMAN_STEAM;
        text = "Steam Profile";
        onButtonClick = QUOTE([ARR_2(QUOTE(QFUNC(modal_steamProfile)),ctrlText (_this select 0))] call FUNC(modal););
        y = "15.4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
    };
    class ButtonTeleport: ButtonSelectAll
    {
        idc = IDC_TMF_ADMINMENU_PMAN_TELEPORT;
        text = "Teleport";
        onButtonClick = QUOTE([ARR_3(QUOTE(QFUNC(modal_teleport)),ctrlText (_this select 0),true)] call FUNC(modal););
        y = "16.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
    };
};
