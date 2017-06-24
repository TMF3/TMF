class Controls 
{
	class CheckboxUseMissionEnding: RscCheckBox
	{
		idc = IDC_TMF_ADMINMENU_ENDM_FROMMISSION;
		onCheckedChanged = "systemChat format ['Checkbox UseMissionEnding: %1', _this];";
		x = "0";
		y = "0";
		w = "1 * (((safezoneW / safezoneH) min 1.2) / 40)";
		h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};
	class LabelEndings: RscText
	{
		idc = -1;
		text = "Use Ending from Mission";
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		x = "1.0 * (((safezoneW / safezoneH) min 1.2) / 40)";
		y = "0";
		w = "23.2 * (((safezoneW / safezoneH) min 1.2) / 40)";
		h = "1 *((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};
	class ListEndings: RscListBox
	{
		idc = IDC_TMF_ADMINMENU_ENDM_LIST;
		tooltip = "These endings are present in the mission";
		x = "0";
		y = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
		w = "24.2 * (((safezoneW / safezoneH) min 1.2) / 40)";
		h = "18.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};
	class ButtonEndMission: GVAR(RscButtonMenu)
	{
		idc = IDC_TMF_ADMINMENU_ENDM_ENDMISSION;
		text = "End Mission";
		onButtonClick = "systemChat 'Button: End Mission';";
		x = "0";
		y = "19.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		w = "5.25 * (((safezoneW / safezoneH) min 1.2) / 40)";
	};
	class CheckboxExportAAR: CheckboxUseMissionEnding
	{
		idc = IDC_TMF_ADMINMENU_ENDM_EXPORTAAR;
		onCheckedChanged = "systemChat format ['Checkbox ExportAAR: %1', _this];";
		x = "5.45 * (((safezoneW / safezoneH) min 1.2) / 40)";
		y = "19.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};
	class LabelExportAAR: LabelEndings
	{
		idc = -1;
		text = "Export AAR";
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		colorText[] = {0.8, 0.8, 0.8, 1};
		x = "6.25 * (((safezoneW / safezoneH) min 1.2) / 40)";
		y = "19.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		w = "6.25 * (((safezoneW / safezoneH) min 1.2) / 40)";
	};
	class ButtonActivateHunt: ButtonEndMission
	{
		idc = IDC_TMF_ADMINMENU_ENDM_ACTIVATEHUNT;
		text = "Activate AI Hunt";
		onButtonClick = "systemChat 'Button: Activate AI Hunt';";
		x = "30.8 * (((safezoneW / safezoneH) min 1.2) / 40)";
		w = "7 * (((safezoneW / safezoneH) min 1.2) / 40)";
	};

	class CheckboxUseSideSpecificEnding: CheckboxUseMissionEnding
	{
		idc = IDC_TMF_ADMINMENU_ENDM_SIDESPECIFIC;
		onCheckedChanged = "systemChat format ['Checkbox UseSideSpecificEnding: %1', _this];";
		x = "25.2 * (((safezoneW / safezoneH) min 1.2) / 40)";
	};
	class LabelEndingsGenericSide: LabelEndings
	{
		text = "Use Side-Specific Endings";
		x = "26.2 * (((safezoneW / safezoneH) min 1.2) / 40)";
		w = "11.6 * (((safezoneW / safezoneH) min 1.2) / 40)";
	};
	class IconSide_Blufor: RscPicture
	{
		style = 48 + 2048; // picture + keep aspect ratio
		text = "\a3\ui_f\data\GUI\Rsc\RscDisplayMultiplayerSetup\flag_indep_ca.paa";
		colorText[] = {"(profilenamespace getvariable ['Map_BLUFOR_R',0])", "(profilenamespace getvariable ['Map_BLUFOR_G',0])", "(profilenamespace getvariable ['Map_BLUFOR_B',1])", 0.8};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		x = "23.9 * (((safezoneW / safezoneH) min 1.2) / 40) + 1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		y = "1.0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
		w = "1.3 * (((safezoneW / safezoneH) min 1.2) / 40)";
		h = "1.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};
	class LabelSide_Blufor: RscText
	{
		idc = -1;
		text = "BLUFOR";
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		x = "26.2 * (((safezoneW / safezoneH) min 1.2) / 40)";
		y = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
		w = "11.6 * (((safezoneW / safezoneH) min 1.2) / 40)";
		h = "1 *((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};
	class EndingSide_Blufor: RscCombo
	{
		idc = IDC_TMF_ADMINMENU_ENDM_BLUFOR;
		onMouseButtonClick = "systemChat 'Mouse Button Click: EndingSide_Blufor';";
		x = "25.2 * (((safezoneW / safezoneH) min 1.2) / 40)";
		y = "2.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
		w = "12.6 * (((safezoneW / safezoneH) min 1.2) / 40)";
		h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};

	class IconSide_Opfor: IconSide_Blufor
	{
		colorText[] = {"(profilenamespace getvariable ['Map_OPFOR_R',1])", "(profilenamespace getvariable ['Map_OPFOR_G',0])", "(profilenamespace getvariable ['Map_OPFOR_B',0])", 0.8};
		y = "3.4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
	};
	class LabelSide_Opfor: LabelSide_Blufor
	{
		text = "OPFOR";
		y = "3.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
	};
	class EndingSide_Opfor: EndingSide_Blufor
	{
		idc = IDC_TMF_ADMINMENU_ENDM_OPFOR;
		onMouseButtonClick = "systemChat 'Mouse Button Click: EndingSide_Opfor';";
		y = "4.6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
	};

	class IconSide_Indep: IconSide_Blufor
	{
		colorText[] = {"(profilenamespace getvariable ['Map_Independent_R',0])", "(profilenamespace getvariable ['Map_Independent_G',1])", "(profilenamespace getvariable ['Map_Independent_B',0])", 0.8};
		y = "5.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
	};
	class LabelSide_Indep: LabelSide_Blufor
	{
		text = "Independent";
		y = "5.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
	};
	class EndingSide_Indep: EndingSide_Blufor
	{
		idc = IDC_TMF_ADMINMENU_ENDM_INDEP;
		onMouseButtonClick = "systemChat 'Mouse Button Click: EndingSide_Indep';";
		y = "7.0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
	};

	class IconSide_Civilian: IconSide_Blufor
	{
		colorText[] = {"(profilenamespace getvariable ['Map_Civilian_R',0.5])", "(profilenamespace getvariable ['Map_Civilian_G',0])", "(profilenamespace getvariable ['Map_Civilian_B',0.5])", 0.8};
		y = "8.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
	};
	class LabelSide_Civilian: LabelSide_Blufor
	{
		text = "Civilian";
		y = "8.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
	};
	class EndingSide_Civilian: EndingSide_Blufor
	{
		idc = IDC_TMF_ADMINMENU_ENDM_CIVILIAN;
		onMouseButtonClick = "systemChat 'Mouse Button Click: EndingSide_Civilian';";
		y = "9.4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
	};

	class CheckboxEndingSideDraw: CheckboxUseMissionEnding
	{
		idc = IDC_TMF_ADMINMENU_ENDM_SIDEDRAW;
		onCheckedChanged = "systemChat format ['Checkbox EndingSideDraw: %1', _this];";
		x = "25.2 * (((safezoneW / safezoneH) min 1.2) / 40)";
		y = "11.0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};
	class LabelEndingSideDraw: LabelExportAAR
	{
		text = "Mission is a Draw (ignores above options)";
		x = "26.2 * (((safezoneW / safezoneH) min 1.2) / 40)";
		y = "11.0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		w = "11.6 * (((safezoneW / safezoneH) min 1.2) / 40)";
	};
};