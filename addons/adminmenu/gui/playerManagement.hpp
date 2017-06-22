class Controls 
{
	class LabelFilter: RscText
	{
		text = "Filter:";
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		
		x = "0";
		y = "0";
		w = "2.2 * (((safezoneW / safezoneH) min 1.2) / 40)";
		h = "1 *((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};
    class ComboFilterSide: RscCombo
	{
		idc = IDC_TMF_ADMINMENU_PMAN_FILTER_SIDE;
		onMouseButtonClick = "systemChat 'Mouse Button Click: ComboFilterSide';";
		
		x = "2.3 * (((safezoneW / safezoneH) min 1.2) / 40)";
		y = "0";
		w = "8 * (((safezoneW / safezoneH) min 1.2) / 40)";
		h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};
    class ComboFilterState: RscCombo
	{
		idc = IDC_TMF_ADMINMENU_PMAN_FILTER_STATE;
		onMouseButtonClick = "systemChat 'Mouse Button Click: ComboFilterState';";
		
		x = "10.4 * (((safezoneW / safezoneH) min 1.2) / 40)";
		y = "0";
		w = "8 * (((safezoneW / safezoneH) min 1.2) / 40)";
		h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};
    class ButtonFilterReset: RscButtonMenu
	{
		idc = IDC_TMF_ADMINMENU_PMAN_FILTER_RESET;
		text = "Reset";
		onButtonClick = "systemChat 'Button: Reset Filter';";
		
		x = "18.5 * (((safezoneW / safezoneH) min 1.2) / 40)";
		y = "0";
		w = "3.35 * (((safezoneW / safezoneH) min 1.2) / 40)";
		h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};

    //class ListPlayers: RscListNBox // apparently doesnt show any background
    class ListPlayers: RscListBox
	{
		idc = IDC_TMF_ADMINMENU_PMAN_LIST;
        //style = 32;
		tooltip = "Select several players with SHIFT or CTRL.";
        onLBSelChanged = "systemChat 'LB Sel Changed: ListPlayers';";
        colorBackground[] = {0, 0, 0, 0.3};
        /*drawSideArrows = 0;
        idcLeft = -1;
        idcRight = -1;
        disableOverflow = 1;*/

		x = "0";
		y = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
		w = "30.8 * (((safezoneW / safezoneH) min 1.2) / 40)";
		h = "19.4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};

	/*
	* Right-hand side vertical menu
	*/

    class LabelSelect: RscText
	{
		text = "Select...";
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";

        //colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"};
		
		x = "30.9 * (((safezoneW / safezoneH) min 1.2) / 40)";
		y = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
		w = "6.9 * (((safezoneW / safezoneH) min 1.2) / 40)";
		h = "1 *((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};
    class ButtonSelectAll: RscButtonMenu
	{
		idc = IDC_TMF_ADMINMENU_PMAN_SEL_ALL;
		text = "All";
		onButtonClick = "systemChat 'Button: Select All';";
		
		x = "30.9 * (((safezoneW / safezoneH) min 1.2) / 40)";
		y = "2.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
		w = "6.9 * (((safezoneW / safezoneH) min 1.2) / 40)";
		h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};
    class ButtonSelectByRole: RscButtonMenu
	{
		idc = IDC_TMF_ADMINMENU_PMAN_SEL_ROLE;
		text = "By Role";
		onButtonClick = "systemChat 'Button: Select by Role';";
		
		x = "30.9 * (((safezoneW / safezoneH) min 1.2) / 40)";
		y = "3.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
		w = "6.9 * (((safezoneW / safezoneH) min 1.2) / 40)";
		h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};
    class ButtonSelectByLoadout: RscButtonMenu
	{
		idc = IDC_TMF_ADMINMENU_PMAN_SEL_LOADOUT;
		text = "By Loadout";
		onButtonClick = "systemChat 'Button: Select by Loadout';";
		
		x = "30.9 * (((safezoneW / safezoneH) min 1.2) / 40)";
		y = "4.4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
		w = "6.9 * (((safezoneW / safezoneH) min 1.2) / 40)";
		h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};

	class LabelWithSelected: RscText
	{
		idc = -1;
		text = "With Selected...";
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";

        //colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"};
		
		x = "30.9 * (((safezoneW / safezoneH) min 1.2) / 40)";
		y = "5.7 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
		w = "6.9 * (((safezoneW / safezoneH) min 1.2) / 40)";
		h = "1 *((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};
    class ButtonTeleport: RscButtonMenu
	{
		idc = IDC_TMF_ADMINMENU_PMAN_TELEPORT;
		text = "Teleport";
		onButtonClick = "systemChat 'Button: Teleport';";
		
		x = "30.9 * (((safezoneW / safezoneH) min 1.2) / 40)";
		y = "6.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
		w = "6.9 * (((safezoneW / safezoneH) min 1.2) / 40)";
		h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};
    class ButtonMessage: RscButtonMenu
	{
		idc = IDC_TMF_ADMINMENU_PMAN_MESSAGE;
		text = "Message";
		onButtonClick = "systemChat 'Button: Message';";
		
		x = "30.9 * (((safezoneW / safezoneH) min 1.2) / 40)";
		y = "7.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
		w = "6.9 * (((safezoneW / safezoneH) min 1.2) / 40)";
		h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};
    class ButtonAssignGear: RscButtonMenu
	{
		idc = IDC_TMF_ADMINMENU_PMAN_ASSIGNGEAR;
		text = "Assign Gear";
		onButtonClick = "systemChat 'Button: Assign Gear';";
		
		x = "30.9 * (((safezoneW / safezoneH) min 1.2) / 40)";
		y = "9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
		w = "6.9 * (((safezoneW / safezoneH) min 1.2) / 40)";
		h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};
    class ButtonAssignRadio: RscButtonMenu
	{
		idc = IDC_TMF_ADMINMENU_PMAN_ASSIGNRADIO;
		text = "Assign Radio";
		onButtonClick = "systemChat 'Button: Assign Radio';";
		
		x = "30.9 * (((safezoneW / safezoneH) min 1.2) / 40)";
		y = "10.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
		w = "6.9 * (((safezoneW / safezoneH) min 1.2) / 40)";
		h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};
    class ButtonHeal: RscButtonMenu
	{
		idc = IDC_TMF_ADMINMENU_PMAN_HEAL;
		text = "Heal";
		onButtonClick = "systemChat 'Button: Heal';";
		
		x = "30.9 * (((safezoneW / safezoneH) min 1.2) / 40)";
		y = "11.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
		w = "6.9 * (((safezoneW / safezoneH) min 1.2) / 40)";
		h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};
    class ButtonKick: RscButtonMenu
	{
		idc = IDC_TMF_ADMINMENU_PMAN_KICK;
		text = "Kick";
		onButtonClick = "systemChat 'Button: Kick';";
		
		x = "30.9 * (((safezoneW / safezoneH) min 1.2) / 40)";
		y = "12.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
		w = "6.9 * (((safezoneW / safezoneH) min 1.2) / 40)";
		h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};
    class ButtonRunCode: RscButtonMenu
	{
		idc = IDC_TMF_ADMINMENU_PMAN_RUNCODE;
		text = "Run Code On";
		onButtonClick = "systemChat 'Button: Run Code On';";
		
		x = "30.9 * (((safezoneW / safezoneH) min 1.2) / 40)";
		y = "13.4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
		w = "6.9 * (((safezoneW / safezoneH) min 1.2) / 40)";
		h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};
};