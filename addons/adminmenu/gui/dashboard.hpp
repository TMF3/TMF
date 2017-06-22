class Controls
{


	/*

	grön titel bg bort
	flytta current admin text till låst rscedit?

	*/











    // Shortcuts
    class TitleShortcuts: RscText
	{
		text = "Shortcuts";
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
        //colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"};
		x = "0";
		y = "0";
		w = "7 * (((safezoneW / safezoneH) min 1.2) / 40)";
		h = "1 *((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};
    class ButtonDebugConsole: RscButtonMenu
	{
		idc = 56201;
		text = "Debug Console";
		onButtonClick = "systemChat 'Button: Debug Console';";
		x = "0";
		y = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
		w = "7 * (((safezoneW / safezoneH) min 1.2) / 40)";
		h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};
    class ButtonClaimZeus: ButtonDebugConsole
	{
		idc = 56202;
		text = "Claim Zeus";
		y = "2.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
		onButtonClick = "systemChat 'Button: Claim Zeus';";
	};
    class ButtonCamera: ButtonDebugConsole
	{
		idc = 56203;
		text = "Camera";
		onButtonClick = "systemChat 'Button: Camera';";
		y = "3.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
	};
    class ButtonArsenal: ButtonDebugConsole
	{
		idc = 56204;
		text = "Arsenal";
		onButtonClick = "systemChat 'Button: Arsenal';";
		y = "4.4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
	};

    // Safestart
    class TitleSafestart: TitleShortcuts
	{
		text = "Safestart";
		y = "5.7 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
	};
    class ButtonSafestartToggle: ButtonDebugConsole
	{
		idc = 56206;
		text = "Toggle";
		onButtonClick = "systemChat 'Button: Toggle Safestart';";
		y = "6.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
	};

	// Current logged-in admin
	class TitleCurrentAdmin: TitleShortcuts
	{
		text = "Current Admin";
		y = "8.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
	};
	class TextfieldCurrentAdmin: RscEdit
	{
		idc = 56207;
		colorDisabled[] = {0.8, 0.8, 0.8, 1};
		text = "";
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
        x = "0";
		y = "9.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
		w = "7 * (((safezoneW / safezoneH) min 1.2) / 40)";
		h = "1 *((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};
};