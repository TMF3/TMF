class Controls
{
    // Shortcuts
    class TitleShortcuts: RscText
	{
		text = "Shortcuts";
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
        colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"};
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
		y = "5.6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
	};
    class TextfieldSafestartMinutes: RscEdit
    {
        idc = 56205;
        text = "3";
        sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
        autocomplete = "";
        onMouseZChanged = "systemChat format ['Textfield Safestart onMouseZChanged: %1', _this];";
        onChar = "systemChat format ['Textfield Safestart onChar: %1', _this];";
        onIMEChar = "systemChat format ['Textfield Safestart onIMEChar: %1', _this];";
        onIMEComposition = "systemChat format ['Textfield Safestart onIMEComposition: %1', _this];";
        x = "0";
		y = "6.733 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
        w = "1.3 * (((safezoneW / safezoneH) min 1.2) / 40)";
		h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    };
    class LabelSafestartMinutes: RscText
	{
		text = "minutes";
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
        x = "1.3 * (((safezoneW / safezoneH) min 1.2) / 40)";
		y = "6.7 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
        w = "2.75 * (((safezoneW / safezoneH) min 1.2) / 40)";
		h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};
    class ButtonSafestartSet: ButtonDebugConsole
	{
		idc = 56206;
		text = "Set";
		onButtonClick = "systemChat format ['Button: Set Safestart | Textfield: %1', ctrlText ((ctrlParentControlsGroup (_this select 0)) controlsGroupCtrl 56205)];";
        x = "4.55 * (((safezoneW / safezoneH) min 1.2) / 40)";
		y = "6.7 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
        w = "2.45 * (((safezoneW / safezoneH) min 1.2) / 40)";
	};
    class ButtonSafestartCancel: ButtonDebugConsole
	{
		idc = 56207;
		text = "End Safestart";
		onButtonClick = "systemChat 'Button: Cancel Safestart';";
		y = "7.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
	};

	// Current logged-in admin
	class TitleCurrentAdmin: TitleShortcuts
	{
		text = "Current Admin";
		y = "9.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
	};
	class LabelCurrentAdmin: RscText
	{
		idc = 56208;
		text = "no data";
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
        x = "0";
		y = "10.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
		w = "7 * (((safezoneW / safezoneH) min 1.2) / 40)";
		h = "1 *((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};
};