class Controls
{
    // Shortcuts
    class LabelShortcuts: RscText
	{
		text = "Shortcuts";
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
        //colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"};
		x = "0";
		y = "0";
		w = "7 * (((safezoneW / safezoneH) min 1.2) / 40)";
		h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};
    class ButtonDebugConsole: GVAR(RscButtonMenu)
	{
		idc = IDC_TMF_ADMINMENU_DASH_DEBUGCON;
		text = "Debug Console";
		onButtonClick = "systemChat 'Button: Debug Console';";
		x = "0";
		y = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
		w = "7 * (((safezoneW / safezoneH) min 1.2) / 40)";
	};
    class ButtonClaimZeus: ButtonDebugConsole
	{
		idc = IDC_TMF_ADMINMENU_DASH_CLAIMZEUS;
		text = "Claim Zeus";
		onButtonClick = "systemChat 'Button: Claim Zeus';";
		y = "2.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
	};
    class ButtonCamera: ButtonDebugConsole
	{
		idc = IDC_TMF_ADMINMENU_DASH_CAMERA;
		text = "Camera";
		onButtonClick = "systemChat 'Button: Camera';";
		y = "3.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
	};
    class ButtonArsenal: ButtonDebugConsole
	{
		idc = IDC_TMF_ADMINMENU_DASH_ARSENAL;
		text = "Arsenal";
		onButtonClick = "systemChat 'Button: Arsenal';";
		y = "4.4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
	};

    // Safestart
    class LabelSafestart: LabelShortcuts
	{
		text = "Safestart";
		y = "5.7 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
	};
    /*class ButtonSafestartToggle: ButtonDebugConsole
	{
		idc = IDC_TMF_ADMINMENU_DASH_SAFESTART;
		text = "Toggle";
		onButtonClick = "systemChat 'Button: Toggle Safestart';";
		y = "6.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
	};*/
	class CheckboxSafestartEnabled: RscCheckBox
	{
		idc = IDC_TMF_ADMINMENU_DASH_SAFESTART;
		onCheckedChanged = "systemChat format ['Checkbox Safestart: %1', _this];";
		x = "0.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
		y = "6.6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		w = "1 * (((safezoneW / safezoneH) min 1.2) / 40)";
		h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};
	class LabelSafestartEnabled: LabelShortcuts
	{
		idc = -1;
		text = "Enabled";
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		colorText[] = {0.8, 0.8, 0.8, 1};
		x = "0.9 * (((safezoneW / safezoneH) min 1.2) / 40)";
		y = "6.6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		w = "5.8 * (((safezoneW / safezoneH) min 1.2) / 40)";
	};

	// Current admin (voted or logged in)
	/*class TitleCurrentAdmin: TitleShortcuts
	{
		text = "Current Admin";
		y = "8.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
	};
	class TextfieldCurrentAdmin: RscEdit
	{
		idc = IDC_TMF_ADMINMENU_DASH_CURRADMIN;
		colorDisabled[] = {0.8, 0.8, 0.8, 1};
		text = "";
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		y = "9.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
		w = "7 * (((safezoneW / safezoneH) min 1.2) / 40)";
		h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};*/

	// Units stats table
	#include "dashboard_table.hpp"

	class LabelInformation: RscText
	{
		text = "General Information";
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
        x = "7 * (((safezoneW / safezoneH) min 1.2) / 40) + 1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		y = "8.7 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
		w = "7 * (((safezoneW / safezoneH) min 1.2) / 40)";
		h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};
	class StatsLabel_VirtualCurators: RscText
	{
		text = "Virtual Zeuses";
		colorBackground[] = {1, 1, 1, 0.2};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
        x = "7 * (((safezoneW / safezoneH) min 1.2) / 40) + 1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		y = "9.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
		w = "4.5 * (((safezoneW / safezoneH) min 1.2) / 40)";
		h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};
	class StatsValue_VirtualCurators: StatsLabel_VirtualCurators
	{
		idc = IDC_TMF_ADMINMENU_DASH_VIRTUALS;
		text = "0";
		colorBackground[] = {0.5, 0.5, 0.5, 0.1};
        x = "11.6 * (((safezoneW / safezoneH) min 1.2) / 40) + 1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		w = "8.8 * (((safezoneW / safezoneH) min 1.2) / 40)";
	};
	class StatsLabel_CurrentAdmin: StatsLabel_VirtualCurators
	{
		text = "Current Admin";
		y = "10.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
	};
	class StatsValue_CurrentAdmin: StatsValue_VirtualCurators
	{
		idc = IDC_TMF_ADMINMENU_DASH_CURRADMIN;
		text = "no data";
		y = "10.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
	};
	class StatsLabel_MissionRuntime: StatsLabel_VirtualCurators
	{
		text = "Mission Runtime";
		y = "12 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
	};
	class StatsValue_MissionRuntime: StatsValue_VirtualCurators
	{
		idc = IDC_TMF_ADMINMENU_DASH_RUNTIME;
		text = "18m 37s";
		y = "12 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
	};
};