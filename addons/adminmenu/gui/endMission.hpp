class Controls 
{
	class LabelEndings: RscText
	{
		idc = -1;
		text = "Available Endings";
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		
		x = "0";
		y = "0";
		w = "37.8 * (((safezoneW / safezoneH) min 1.2) / 40)";
		h = "1 *((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};

	class ListEndings: RscListBox
	{
		tooltip = "These endings are present in the mission";
		
		idc = 56301;
		x = "0";
		y = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
		w = "37.8 * (((safezoneW / safezoneH) min 1.2) / 40)";
		h = "18.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		
		/*colorBackground[] = {0,0,0,0.5};
		colorSelectBackground[] = {0,0,0,0.7};
		colorSelectBackground2[] = {0.1,0.1,0.1,0.7};*/
	};

	class ButtonEndMission: RscButtonMenu
	{
		idc = 56302;
		text = "End Mission";
		onButtonClick = "systemChat 'Button: End Mission';";
		
		x = "0";
		y = "19.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		w = "6.25 * (((safezoneW / safezoneH) min 1.2) / 40)";
		h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};

	class CheckboxExportAAR: RscCheckBox
	{
		idc = 56303;
		onCheckBoxesSelChanged = "systemChat format ['Checkbox ExportAAR: %1', _this];";
		x = "6.45 * (((safezoneW / safezoneH) min 1.2) / 40)";
		y = "19.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		w = "1 * (((safezoneW / safezoneH) min 1.2) / 40)";
		h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};

	class LabelExportAAR: LabelEndings
	{
		idc = -1;
		text = "Export AAR";
		x = "7.45 * (((safezoneW / safezoneH) min 1.2) / 40)";
		y = "19.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		w = "6.25 * (((safezoneW / safezoneH) min 1.2) / 40)";
		h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};

	class ButtonActivateHunt: RscButtonMenu
	{
		idc = 56304;
		text = "Activate AI Hunt";
		onButtonClick = "systemChat 'Button: Activate AI Hunt';";
		
		x = "29.8 * (((safezoneW / safezoneH) min 1.2) / 40)";
		y = "19.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		w = "8 * (((safezoneW / safezoneH) min 1.2) / 40)";
		h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};
};