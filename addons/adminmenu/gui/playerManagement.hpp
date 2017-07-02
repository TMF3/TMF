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
		//onLBSelChanged = QUOTE([ctrlParent (param [0])] call FUNC(playerManagementFilter););
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		//font = "PuristaLight";
		font = "RobotoCondensed";
		x = "2.2 * (((safezoneW / safezoneH) min 1.2) / 40)";
		y = "0";
		w = "6 * (((safezoneW / safezoneH) min 1.2) / 40)";
		h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};
    class ComboFilterState: ComboFilterSide
	{
		idc = IDC_TMF_ADMINMENU_PMAN_FILTER_STATE;
		//onLBSelChanged = QUOTE([ctrlParent (param [0])] call FUNC(playerManagementFilter););
		x = "8.3 * (((safezoneW / safezoneH) min 1.2) / 40)";
		w = "5 * (((safezoneW / safezoneH) min 1.2) / 40)";
	};
    class ButtonFilterReset: GVAR(RscButtonMenu)
	{
		idc = IDC_TMF_ADMINMENU_PMAN_FILTER_RESET;
		text = "Reset";
		onButtonClick = QUOTE([ARR_2(ctrlParent (param [0]),true)] call FUNC(playerManagementFilter););
		x = "13.4 * (((safezoneW / safezoneH) min 1.2) / 40)";
		y = "0";
		w = "2.5 * (((safezoneW / safezoneH) min 1.2) / 40)";
	};
	class ButtonRefresh: GVAR(RscButtonMenu)
	{
		idc = IDC_TMF_ADMINMENU_PMAN_REFRESH;
		text = "Refresh";
		onButtonClick = QUOTE(_this call FUNC(playerManagementButton););
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
	class GroupList: RscControlsGroup 
	{
		idc = IDC_TMF_ADMINMENU_PMAN_GROUPLIST;
		x = "0";
		y = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
		w = TMF_ADMINMENU_PMAN_W_LISTGROUP;
		h = TMF_ADMINMENU_PMAN_H_LISTGROUP;

		class Controls
		{
			class ListPlayers: RscListBox
			{
				idc = IDC_TMF_ADMINMENU_PMAN_LIST;
				style = 32 + 16; // LB_MULTI + ST_MULTI
				onLBSelChanged = QUOTE(_this call FUNC(playerManagementListSelChange););
				
				sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
				sizeEx2 = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
				rowHeight = 0.97 * TMF_ADMINMENU_STD_HEIGHT;
				colorBackground[] = {0, 0, 0, 0};
				shadow = 0;
				itemSpacing = 0.001;

				x = TMF_ADMINMENU_PMAN_X_LIST;
				y = 0;
				w = TMF_ADMINMENU_PMAN_W_LIST;
				h = TMF_ADMINMENU_PMAN_H_LISTGROUP;
			};
		};
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
		onButtonClick = "systemChat 'Button: Teleport';";
		y = "7.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
	};
    class ButtonMessage: ButtonSelectAll
	{
		idc = IDC_TMF_ADMINMENU_PMAN_MESSAGE;
		text = "Message";
		onButtonClick = "systemChat 'Button: Message';";
		y = "9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
	};
    class ButtonAssignGear: ButtonSelectAll
	{
		idc = IDC_TMF_ADMINMENU_PMAN_ASSIGNGEAR;
		text = "Assign Gear";
		onButtonClick = "systemChat 'Button: Assign Gear';";
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
		onButtonClick = "systemChat 'Button: Heal';";
		y = "12.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
	};
    class ButtonKick: ButtonSelectAll
	{
		idc = IDC_TMF_ADMINMENU_PMAN_KICK;
		text = "Kick";
		onButtonClick = "systemChat 'Button: Kick';";
		y = "13.4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
	};
    class ButtonRunCode: ButtonSelectAll
	{
		idc = IDC_TMF_ADMINMENU_PMAN_RUNCODE;
		text = "Run Code On";
		onButtonClick = "systemChat 'Button: Run Code On';";
		y = "14.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
	};
    class ButtonGrantZeus: ButtonSelectAll
	{
		idc = IDC_TMF_ADMINMENU_PMAN_GRANTZEUS;
		text = "Grant Zeus";
		onButtonClick = "systemChat 'Button: Grant Zeus';";
		y = "15.6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
	};
    class ButtonACRE2Languages: ButtonSelectAll
	{
		idc = IDC_TMF_ADMINMENU_PMAN_ACRELANGUAGES;
		text = "ACRE2 Languages";
		onButtonClick = "systemChat 'Button: ACRE2 Languages';";
		y = "16.7 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
	};
};