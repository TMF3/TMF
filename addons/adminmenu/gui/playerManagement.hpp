class Controls 
{
	class LabelFilter: RscText
	{
		text = "Filter";
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";

        colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])", "0.2"};
		
		x = "0";
		y = "0";
		w = "4 * (((safezoneW / safezoneH) min 1.2) / 40)";
		h = "1 *((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};
    class ComboFilterSide: RscCombo
	{
		idc = 56302;
		onMouseButtonClick = "systemChat 'Mouse Button Click: ComboFilterSide';";
		
		x = "4.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
		y = "0";
		w = "6.25 * (((safezoneW / safezoneH) min 1.2) / 40)";
		h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};
    class ComboFilterState: RscCombo
	{
		idc = 56302;
		onMouseButtonClick = "systemChat 'Mouse Button Click: ComboFilterState';";
		
		x = "10.45 * (((safezoneW / safezoneH) min 1.2) / 40)";
		y = "0";
		w = "6.25 * (((safezoneW / safezoneH) min 1.2) / 40)";
		h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};
    class ButtonFilterReset: RscButtonMenu
	{
		idc = 56303;
		text = "Reset";
		onButtonClick = "systemChat 'Button: Reset Filter';";
		
		x = "16.80 * (((safezoneW / safezoneH) min 1.2) / 40)";
		y = "0";
		w = "5.25 * (((safezoneW / safezoneH) min 1.2) / 40)";
		h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};
    class ListPlayers: RscListNBox
	{
		idc = 56304;
        style = 32;
		tooltip = "Select several players with SHIFT or CTRL.";
        drawSideArrows = 0;
        idcLeft = -1;
        idcRight = -1;
        disableOverflow = 1;

        onLBSelChanged = "systemChat 'LB Sel Changed: ListPlayers';";

		x = "0";
		y = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
		w = "30.8 * (((safezoneW / safezoneH) min 1.2) / 40)";
		h = "19.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};

    class LabelSelectBy: RscText
	{
		text = "Select...";
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";

        colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])", "0.2"};
		
		x = "30.9 * (((safezoneW / safezoneH) min 1.2) / 40)";
		y = "0";
		w = "7 * (((safezoneW / safezoneH) min 1.2) / 40)";
		h = "1 *((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};
    class ButtonSelectAll: RscButtonMenu
	{
		idc = 56305;
		text = "All";
		onButtonClick = "systemChat 'Button: Select All';";
		
		x = "30.9 * (((safezoneW / safezoneH) min 1.2) / 40)";
		y = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
		w = "7 * (((safezoneW / safezoneH) min 1.2) / 40)";
		h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};
    class ButtonSelectByRole: RscButtonMenu
	{
		idc = 56306;
		text = "Role";
		onButtonClick = "systemChat 'Button: Select by Role';";
		
		x = "30.9 * (((safezoneW / safezoneH) min 1.2) / 40)";
		y = "2.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
		w = "7 * (((safezoneW / safezoneH) min 1.2) / 40)";
		h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};
    class ButtonSelectByLoadout: RscButtonMenu
	{
		idc = 56307;
		text = "Loadout";
		onButtonClick = "systemChat 'Button: Select by Loadout';";
		
		x = "30.9 * (((safezoneW / safezoneH) min 1.2) / 40)";
		y = "3.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
		w = "7 * (((safezoneW / safezoneH) min 1.2) / 40)";
		h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};
};

class ControlsBackground
{
    class HorizontalLine: RscText
    {
        colorBackground[] = {"1", "1", "1", "0.8"};
        x = "30.9 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX + (safezoneW - ((safezoneW / safezoneH) min 1.2))/2)";
        y = "4.4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
        w = "7 * (((safezoneW / safezoneH) min 1.2) / 40)";
        h = "0.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    };
};