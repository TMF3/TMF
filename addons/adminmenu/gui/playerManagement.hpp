class Controls
{
    class LabelFilter: RscText
    {
        text = "Filter:";
        sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";

        x = "0";
        y = "0";
        w = "2.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
        h = "1 *((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    };
    class ComboFilterSide: RscCombo
    {
        idc = IDC_TMF_ADMINMENU_PMAN_FILTER_SIDE;
        sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
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
        onButtonClick = QUOTE([ARR_2(ctrlParent (param [0]),true)] call FUNC(playerManagement_filter););
        x = "13.4 * (((safezoneW / safezoneH) min 1.2) / 40)";
        y = "0";
        w = "2.5 * (((safezoneW / safezoneH) min 1.2) / 40)";
    };
    class ButtonRefresh: GVAR(RscButtonMenu)
    {
        idc = IDC_TMF_ADMINMENU_PMAN_REFRESH;
        text = "Refresh";
        onButtonClick = QUOTE(_this call FUNC(playerManagement_button););
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

        sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
        sizeEx2 = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
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
        colorBackground[] = {0,0,0,0};
        itemBackground[] = {1,1,1,0.2};
        itemSpacing = 0;

        tooltip = "tooltip test";

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
        sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";

        x = "30.9 * (((safezoneW / safezoneH) min 1.2) / 40)";
        y = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
        w = "6.9 * (((safezoneW / safezoneH) min 1.2) / 40)";
        h = "1 *((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    };
    class ButtonSelectAll: ButtonFilterReset
    {
        idc = IDC_TMF_ADMINMENU_PMAN_SEL_ALL;
        text = "All";
        onButtonClick = "systemChat 'Button: Select All';";
        x = "30.9 * (((safezoneW / safezoneH) min 1.2) / 40)";
        y = "2.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
        w = "6.9 * (((safezoneW / safezoneH) min 1.2) / 40)";
    };
    class ButtonSelectByGroup: ButtonSelectAll
    {
        idc = IDC_TMF_ADMINMENU_PMAN_SEL_GROUP;
        text = "By Group";
        onButtonClick = "systemChat 'Button: Select by Group';";
        y = "3.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
    };
    class ButtonSelectByRole: ButtonSelectAll
    {
        idc = IDC_TMF_ADMINMENU_PMAN_SEL_ROLE;
        text = "By Role";
        onButtonClick = "systemChat 'Button: Select by Role';";
        y = "4.4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
    };
    class ButtonSelectByLoadout: ButtonSelectAll
    {
        idc = IDC_TMF_ADMINMENU_PMAN_SEL_LOADOUT;
        text = "By Loadout";
        onButtonClick = "systemChat 'Button: Select by Loadout';";
        y = "5.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
    };

    class LabelWithSelected: RscText
    {
        idc = -1;
        text = "With Selected...";
        sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";

        x = "30.9 * (((safezoneW / safezoneH) min 1.2) / 40)";
        y = "6.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
        w = "6.9 * (((safezoneW / safezoneH) min 1.2) / 40)";
        h = "1 *((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    };
    class ButtonTeleport: ButtonSelectAll
    {
        idc = IDC_TMF_ADMINMENU_PMAN_TELEPORT;
        text = "Teleport";
        onButtonClick = QUOTE([ARR_3(QUOTE(QFUNC(modal_teleport)),ctrlText (_this select 0),true)] call FUNC(modal););
        y = "7.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
    };
    class ButtonMessage: ButtonSelectAll
    {
        idc = IDC_TMF_ADMINMENU_PMAN_MESSAGE;
        text = "Message";
        onButtonClick = QUOTE([ARR_2(QUOTE(QFUNC(modal_message)),ctrlText (_this select 0))] call FUNC(modal););
        y = "9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
    };
    class ButtonAssignGear: ButtonSelectAll
    {
        idc = IDC_TMF_ADMINMENU_PMAN_ASSIGNGEAR;
        text = "Assign Gear";
        onButtonClick = QUOTE([ARR_2(QUOTE(QFUNC(modal_assignGear)),ctrlText (_this select 0))] call FUNC(modal););
        y = "10.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
    };
    class ButtonAssignRadio: ButtonSelectAll
    {
        idc = IDC_TMF_ADMINMENU_PMAN_ASSIGNRADIO;
        text = "Assign Radio";
        onButtonClick = "systemChat 'Button: Assign Radio';";
        y = "11.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
    };
    class ButtonHeal: ButtonSelectAll
    {
        idc = IDC_TMF_ADMINMENU_PMAN_HEAL;
        text = "Heal";
        onButtonClick = QUOTE([ARR_3(QUOTE(QFUNC(utility_heal)),ctrlText (_this select 0),true)] call FUNC(utility););
        y = "12.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
    };
    class ButtonKick: ButtonSelectAll
    {
        idc = IDC_TMF_ADMINMENU_PMAN_KICK;
        text = "Kick";
        onButtonClick = "";
        y = "13.4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
    };
    class ButtonRunCode: ButtonSelectAll
    {
        idc = IDC_TMF_ADMINMENU_PMAN_RUNCODE;
        text = "Run Code On";
        onButtonClick = QUOTE([ARR_2(QUOTE(QFUNC(modal_runCode)),ctrlText (_this select 0))] call FUNC(modal););
        y = "14.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
    };
    class ButtonGrantZeus: ButtonSelectAll
    {
        idc = IDC_TMF_ADMINMENU_PMAN_GRANTZEUS;
        text = "Grant Zeus";
        onButtonClick = QUOTE([ARR_2(QUOTE(QFUNC(utility_grantZeus)),ctrlText (_this select 0))] call FUNC(utility););
        y = "15.6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
    };
    class ButtonACRE2Languages: ButtonSelectAll
    {
        idc = IDC_TMF_ADMINMENU_PMAN_ACRELANGUAGES;
        text = "ACRE2 Languages";
        onButtonClick = QUOTE([ARR_2(QUOTE(QFUNC(modal_ACRE2Languages)),ctrlText (_this select 0))] call FUNC(modal););
        y = "16.7 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
    };
    class ButtonSteamProfile: ButtonSelectAll
    {
        idc = IDC_TMF_ADMINMENU_PMAN_STEAM;
        text = "Steam Profile";
        onButtonClick = QUOTE([ARR_2(QUOTE(QFUNC(modal_steamProfile)),ctrlText (_this select 0))] call FUNC(modal););
        y = "17.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
    };
    class ButtonQuickRespawn: ButtonSelectAll
    {
        idc = IDC_TMF_ADMINMENU_PMAN_QRESPAWN;
        text = "Quick Respawn";
        onButtonClick = QUOTE([ARR_2(QUOTE(QFUNC(utility_quickRespawn)),ctrlText (_this select 0))] call FUNC(utility););
        y = "18.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
    };
};
