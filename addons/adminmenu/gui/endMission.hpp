class Controls
{
    class CheckboxUseMissionEnding: RscCheckBox
    {
        idc = IDC_TMF_ADMINMENU_ENDM_FROMMISSION;
        onCheckedChanged = QUOTE([ARR_2(ctrlParent (param [0]), ctrlIDC (param [0]))] call FUNC(endMission_occluder););
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
        sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
        x = "0";
        y = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
        w = "24.2 * (((safezoneW / safezoneH) min 1.2) / 40)";
        h = "14 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    };
    class ButtonEndMission: GVAR(RscButtonMenu)
    {
        idc = IDC_TMF_ADMINMENU_ENDM_ENDMISSION;
        text = "End Mission";
        colorBackground[] = {0.8,0.27,0.133,1};
        onButtonClick = QUOTE((ctrlParent (param [0])) call FUNC(endMission_commit));
        x = "32.3 * (((safezoneW / safezoneH) min 1.2) / 40)";
        y = "19.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
        w = "5.5 * (((safezoneW / safezoneH) min 1.2) / 40)";
    };
    class CheckboxExportAAR: CheckboxUseMissionEnding
    {
        idc = IDC_TMF_ADMINMENU_ENDM_EXPORTAAR;
        x = "32.3 * (((safezoneW / safezoneH) min 1.2) / 40)";
        y = "18.4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    };
    class LabelExportAAR: LabelEndings
    {
        idc = -1;
        text = "Export AAR";
        sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
        colorText[] = {0.8, 0.8, 0.8, 1};
        x = "33.3 * (((safezoneW / safezoneH) min 1.2) / 40)";
        y = "18.4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
        w = "4.5 * (((safezoneW / safezoneH) min 1.2) / 40)";
    };
    class ButtonActivateHunt: GVAR(RscButtonMenu)
    {
        idc = IDC_TMF_ADMINMENU_ENDM_ACTIVATEHUNT;
        text = "Activate AI Hunt";
        onButtonClick = "";
        colorBackground[] = {0, 0, 0, 1};
        x = "25.2 * (((safezoneW / safezoneH) min 1.2) / 40)";
        y = "19.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
        w = "7 * (((safezoneW / safezoneH) min 1.2) / 40)";
    };

    class CheckboxUseSideSpecificEnding: CheckboxUseMissionEnding
    {
        idc = IDC_TMF_ADMINMENU_ENDM_SIDESPECIFIC;
        onCheckedChanged = QUOTE([ARR_2(ctrlParent (param [0]), ctrlIDC (param [0]))] call FUNC(endMission_occluder););
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
        y = "9.4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    };

    class CheckboxEndingSideDraw: CheckboxUseMissionEnding
    {
        idc = IDC_TMF_ADMINMENU_ENDM_SIDEDRAW;
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

    class CheckboxUseCustomEnding: CheckboxUseMissionEnding
    {
        idc = IDC_TMF_ADMINMENU_ENDM_CUSTOM;
        onCheckedChanged = QUOTE([ARR_2(ctrlParent (param [0]), ctrlIDC (param [0]))] call FUNC(endMission_occluder););
        y = "16.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    };
    class LabelCustomEnding: LabelEndings
    {
        text = "Use Custom Ending";
        y = "16.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    };
    class LabelCustomEndingTitle: LabelExportAAR
    {
        text = "Title";
        x = "0";
        y = "17.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
        w = "2.4 * (((safezoneW / safezoneH) min 1.2) / 40)";
        h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    };
    class TextfieldCustomEndingTitle: RscEdit
    {
        idc = IDC_TMF_ADMINMENU_ENDM_CUSTOM_TITLE;
        colorBackground[] = {0.5, 0.5, 0.5, 0.1};
        colorBorder[] = {1, 1, 1, 0.33};
        sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
        x = "2.4 * (((safezoneW / safezoneH) min 1.2) / 40)";
        y = "17.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
        w = "10.9 * (((safezoneW / safezoneH) min 1.2) / 40)";
        h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    };
    class LabelCustomEndingSubtext: LabelCustomEndingTitle
    {
        text = "Subtext";
        y = "18.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    };
    class TextfieldCustomEndingSubtext: TextfieldCustomEndingTitle
    {
        idc = IDC_TMF_ADMINMENU_ENDM_CUSTOM_SUBTEXT;
        y = "18.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    };
    class CheckboxCustomEndingVictory: CheckboxUseMissionEnding
    {
        idc = IDC_TMF_ADMINMENU_ENDM_CUSTOM_ISVICTORY;
        x = "0";
        y = "19.4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    };
    class LabelCustomEndingVictory: LabelExportAAR
    {
        text = "Mission is a Victory (determines music played)";
        x = "1 * (((safezoneW / safezoneH) min 1.2) / 40)";
        y = "19.4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
        w = "23.2 * (((safezoneW / safezoneH) min 1.2) / 40)";
    };

    class OccluderLeftUp: RscText
    {
        idc = IDC_TMF_ADMINMENU_ENDM_OCCLUDER_LU;
        colorBackground[] = {0, 0, 0, 0.75};
        style = "0x02";
        sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
        x = "0";
        y = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
        w = "24.2 * (((safezoneW / safezoneH) min 1.2) / 40)";
        h = "14 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    };
    class OccluderLeftDown: OccluderLeftUp
    {
        idc = IDC_TMF_ADMINMENU_ENDM_OCCLUDER_LD;
        y = "17.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
        w = "24.2 * (((safezoneW / safezoneH) min 1.2) / 40)";
        h = "3.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    };
    class OccluderRight: OccluderLeftUp
    {
        idc = IDC_TMF_ADMINMENU_ENDM_OCCLUDER_R;
        x = "25.15 * (((safezoneW / safezoneH) min 1.2) / 40)";
        y = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
        w = "12.65 * (((safezoneW / safezoneH) min 1.2) / 40)";
        h = "10.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    };
};
