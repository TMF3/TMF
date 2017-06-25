class Controls 
{
	class CheckboxUseMissionEnding: RscCheckBox
	{
		idc = IDC_TMF_ADMINMENU_ENDM_FROMMISSION;
		onCheckedChanged = QUOTE(systemChat format [ARR_2(QUOTE(QUOTE(Checkbox UseMissionEnding: %1)), _this)]; [ARR_2(ctrlParent (param [0]), 1 - (param [1]))] call FUNC(endMissionOccluder););
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
		y = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
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
		onCheckedChanged = QUOTE(systemChat format [ARR_2(QUOTE(QUOTE(Checkbox UseSideSpecificEnding: %1)), _this)]; [ARR_2(ctrlParent (param [0]), param [1])] call FUNC(endMissionOccluder););
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
		x = "24.9 * (((safezoneW / safezoneH) min 1.2) / 40)";
		y = "1.0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		w = "1.3 * (((safezoneW / safezoneH) min 1.2) / 40)";
		h = "1.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};
	class LabelSide_Blufor: RscText
	{
		idc = -1;
		text = "BLUFOR";
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		x = "25.9 * (((safezoneW / safezoneH) min 1.2) / 40)";
		y = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		w = "11.6 * (((safezoneW / safezoneH) min 1.2) / 40)";
		h = "1 *((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};
	class EndingSide_Blufor: RscToolbox
	{
		idc = IDC_TMF_ADMINMENU_ENDM_BLUFOR;
		onToolBoxSelChanged = "systemChat format ['blufor onToolBoxSelChanged: %1', _this];";
		
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		rows = 1;
		columns = 2;
		strings[] = {"Defeat", "Victory"};
		values[] = {0, 1};

		color[] = {0.4, 0.4, 1, 0.25};
		colorText[] = {1, 1, 1, 1};
		colorSelect[] = {0.4, 0.4, 1, 0.75};
		colorTextSelect[] = {1, 1, 1, 1};
		colorDisable[] = {1, 1, 0, 0.75};
		colorTextDisable[] = {0, 0, 0, 1};
		colorSelectedBg[] = {1, 1, 1, 0.2};
		colorBackground[] = {0.5, 0.5, 0.5, 0.1};

		x = "25.2 * (((safezoneW / safezoneH) min 1.2) / 40)";
		y = "2.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		w = "12.6 * (((safezoneW / safezoneH) min 1.2) / 40)";
		h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};

	class IconSide_Opfor: IconSide_Blufor
	{
		colorText[] = {"(profilenamespace getvariable ['Map_OPFOR_R',1])", "(profilenamespace getvariable ['Map_OPFOR_G',0])", "(profilenamespace getvariable ['Map_OPFOR_B',0])", 0.8};
		y = "3.4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};
	class LabelSide_Opfor: LabelSide_Blufor
	{
		text = "OPFOR";
		y = "3.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};
	class EndingSide_Opfor: EndingSide_Blufor
	{
		idc = IDC_TMF_ADMINMENU_ENDM_OPFOR;
		onToolBoxSelChanged = "systemChat format ['opfor onToolBoxSelChanged: %1', _this];";
		y = "4.6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};

	class IconSide_Indep: IconSide_Blufor
	{
		colorText[] = {"(profilenamespace getvariable ['Map_Independent_R',0])", "(profilenamespace getvariable ['Map_Independent_G',1])", "(profilenamespace getvariable ['Map_Independent_B',0])", 0.8};
		y = "5.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};
	class LabelSide_Indep: LabelSide_Blufor
	{
		text = "Independent";
		y = "5.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};
	class EndingSide_Indep: EndingSide_Blufor
	{
		idc = IDC_TMF_ADMINMENU_ENDM_INDEP;
		onToolBoxSelChanged = "systemChat format ['indep onToolBoxSelChanged: %1', _this];";
		y = "7.0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};

	class IconSide_Civilian: IconSide_Blufor
	{
		colorText[] = {"(profilenamespace getvariable ['Map_Civilian_R',0.5])", "(profilenamespace getvariable ['Map_Civilian_G',0])", "(profilenamespace getvariable ['Map_Civilian_B',0.5])", 0.8};
		y = "8.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};
	class LabelSide_Civilian: LabelSide_Blufor
	{
		text = "Civilian";
		y = "8.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};
	class EndingSide_Civilian: EndingSide_Blufor
	{
		idc = IDC_TMF_ADMINMENU_ENDM_CIVILIAN;
		onToolBoxSelChanged = "systemChat format ['civ onToolBoxSelChanged: %1', _this];";
		y = "9.4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
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

	class OccluderLeft: RscText
	{
		idc = IDC_TMF_ADMINMENU_ENDM_OCCLUDER_L;
		text = "Using Side-Specific Ending";
		colorBackground[] = {0, 0, 0, 0.75};
		style = "0x02";
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		x = "0";
		y = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		w = "24.2 * (((safezoneW / safezoneH) min 1.2) / 40)";
		h = "18.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};
	class OccluderRight: OccluderLeft
	{
		idc = IDC_TMF_ADMINMENU_ENDM_OCCLUDER_R;
		text = "Using Ending from Mission";
		x = "25.15 * (((safezoneW / safezoneH) min 1.2) / 40)";
		y = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		w = "12.65 * (((safezoneW / safezoneH) min 1.2) / 40)";
		h = "10.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};

	delete Toolbox;

	/*class Toolbox: RscToolbox
	{
		idc = IDC_TMF_ADMINMENU_ENDM_TOOLBOX;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";

		rows = 1;
		columns = 2;
		strings[] = {"Defeat", "Victory"};
		values[] = {0, 1};

		color[] = {0.4, 0.4, 1, 0.25};
		colorText[] = {1, 1, 1, 1};
		colorSelect[] = {0.4, 0.4, 1, 0.75};
		colorTextSelect[] = {1, 1, 1, 1};

		colorDisable[] = {1, 1, 0, 0.75};
		colorTextDisable[] = {0, 0, 0, 1};
		colorSelectedBg[] = {1, 1, 1, 0.2};
		colorBackground[] = {0.5, 0.5, 0.5, 0.1};

		onToolBoxSelChanged = "systemChat format ['Toolbox onToolBoxSelChanged: %1', _this];";

		x = "25.2 * (((safezoneW / safezoneH) min 1.2) / 40)";
		y = "12.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		w = "12.6 * (((safezoneW / safezoneH) min 1.2) / 40)";
		h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};*/
};