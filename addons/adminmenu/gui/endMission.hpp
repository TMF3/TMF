class Controls
{
    class CheckboxUseMissionEnding: RscCheckBox
    {
        idc = IDC_TMF_ADMINMENU_ENDM_FROMMISSION;
        onCheckedChanged = QUOTE([ARR_2(ctrlParent (param [0]), ctrlIDC (param [0]))] call FUNC(endMission_occluder););
        x = 0;
        y = 0;
        w = 1 * GUI_GRID_W;
        h = 1 * GUI_GRID_H;
    };
    class LabelEndings: RscText
    {
        idc = -1;
        text = "Use Ending from Mission";
        sizeEx = GUI_TEXT_SIZE_SMALL;
        x = 1.0 * GUI_GRID_W;
        y = 0;
        w = 23.2 * GUI_GRID_W;
        h = 1.0 * GUI_GRID_H;
    };
    class ListEndings: RscListBox
    {
        idc = IDC_TMF_ADMINMENU_ENDM_LIST;
        tooltip = "These endings are present in the mission";
        sizeEx = GUI_TEXT_SIZE_SMALL;
        x = 0;
        y = 1.1 * GUI_GRID_H;
        w = 24.2 * GUI_GRID_W;
        h = 12.9 * GUI_GRID_H;
    };
    class CheckboxMissionEndingDefeat: CheckboxUseMissionEnding
    {
        idc = IDC_TMF_ADMINMENU_ENDM_FROMMISSION_ISDEFEAT;
        onCheckedChanged = "";
        x = 0;
        y = 14 * GUI_GRID_H;
    };
    class LabelMissionEndingDefeat: LabelEndings
    {
        text = "Mission is a Defeat (determines music played)";
        colorText[] = {0.8, 0.8, 0.8, 1};
        x = 1 * GUI_GRID_W;
        y = 14 * GUI_GRID_H;
        w = 23.2 * GUI_GRID_W;
    };

    class ButtonEndMission: GVAR(RscButtonMenu)
    {
        idc = IDC_TMF_ADMINMENU_ENDM_ENDMISSION;
        text = "End Mission";
        colorBackground[] = {0.8,0.27,0.133,1};
        onButtonClick = QUOTE((ctrlParent (param [0])) call FUNC(endMission_commit));
        x = 32.3 * GUI_GRID_W;
        y = 19.5 * GUI_GRID_H;
        w = 5.5 * GUI_GRID_W;
    };
    class CheckboxExportAAR: CheckboxUseMissionEnding
    {
        idc = IDC_TMF_ADMINMENU_ENDM_EXPORTAAR;
        onCheckedChanged = "";
        x = 32.3 * GUI_GRID_W;
        y = 18.4 * GUI_GRID_H;
    };
    class LabelExportAAR: LabelEndings
    {
        idc = -1;
        text = "Export AAR";
        sizeEx = GUI_TEXT_SIZE_SMALL;
        colorText[] = {0.8, 0.8, 0.8, 1};
        x = 33.3 * GUI_GRID_W;
        y = 18.4 * GUI_GRID_H;
        w = 4.5 * GUI_GRID_W;
    };
    class ButtonActivateHunt: GVAR(RscButtonMenu)
    {
        idc = IDC_TMF_ADMINMENU_ENDM_ACTIVATEHUNT;
        text = "Activate AI Hunt";
        onButtonClick = QUOTE([] call FUNC(endMission_hunt));
        colorBackground[] = {0, 0, 0, 1};
        x = 25.2 * GUI_GRID_W;
        y = 19.5 * GUI_GRID_H;
        w = 7 * GUI_GRID_W;
    };

    class CheckboxUseSideSpecificEnding: CheckboxUseMissionEnding
    {
        idc = IDC_TMF_ADMINMENU_ENDM_SIDESPECIFIC;
        onCheckedChanged = QUOTE([ARR_2(ctrlParent (param [0]), ctrlIDC (param [0]))] call FUNC(endMission_occluder););
        x = 25.2 * GUI_GRID_W;
    };
    class LabelEndingsGenericSide: LabelEndings
    {
        text = "Use Side-Specific Endings";
        x = 26.2 * GUI_GRID_W;
        w = 11.6 * GUI_GRID_W;
    };

    class IconSide_Blufor: RscPicture
    {
        style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;
        text = flag_west;
        colorText[] = Map_BLUFOR_RGBA;
        sizeEx = GUI_TEXT_SIZE_SMALL;
        x = 24.9 * GUI_GRID_W;
        y = 1.0 * GUI_GRID_H;
        w = 1.3 * GUI_GRID_W;
        h = 1.3 * GUI_GRID_H;
    };
    class LabelSide_Blufor: RscText
    {
        idc = -1;
        text = "BLUFOR";
        sizeEx = GUI_TEXT_SIZE_SMALL;
        x = 25.9 * GUI_GRID_W;
        y = 1.1 * GUI_GRID_H;
        w = 11.6 * GUI_GRID_W;
        h = 1 * GUI_GRID_H;
    };
    class EndingSide_Blufor: RscToolbox
    {
        idc = IDC_TMF_ADMINMENU_ENDM_BLUFOR;
        onToolBoxSelChanged = QUOTE(GVAR(DOUBLES(ending,blufor)) = param [1];);

        sizeEx = GUI_TEXT_SIZE_SMALL;
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

        x = 25.2 * GUI_GRID_W;
        y = 2.2 * GUI_GRID_H;
        w = 12.6 * GUI_GRID_W;
        h = 1 * GUI_GRID_H;
    };

    class IconSide_Opfor: IconSide_Blufor
    {
        text = flag_east;
        colorText[] = Map_OPFOR_RGBA;
        y = 3.4 * GUI_GRID_H;
    };
    class LabelSide_Opfor: LabelSide_Blufor
    {
        text = "OPFOR";
        y = 3.5 * GUI_GRID_H;
    };
    class EndingSide_Opfor: EndingSide_Blufor
    {
        idc = IDC_TMF_ADMINMENU_ENDM_OPFOR;
        onToolBoxSelChanged = QUOTE(GVAR(DOUBLES(ending,opfor)) = param [1];);
        y = 4.6 * GUI_GRID_H;
    };

    class IconSide_Indep: IconSide_Blufor
    {
        text = flag_guer;
        colorText[] = Map_Independent_RGBA;
        y = 5.8 * GUI_GRID_H;
    };
    class LabelSide_Indep: LabelSide_Blufor
    {
        text = "Independent";
        y = 5.9 * GUI_GRID_H;
    };
    class EndingSide_Indep: EndingSide_Blufor
    {
        idc = IDC_TMF_ADMINMENU_ENDM_INDEP;
        onToolBoxSelChanged = QUOTE(GVAR(DOUBLES(ending,resistance)) = param [1];);
        y = 7.0 * GUI_GRID_H;
    };

    class IconSide_Civilian: IconSide_Blufor
    {
        text = flag_civl;
        colorText[] = Map_Civilian_RGBA;
        y = 8.2 * GUI_GRID_H;
    };
    class LabelSide_Civilian: LabelSide_Blufor
    {
        text = "Civilian";
        y = 8.3 * GUI_GRID_H;
    };
    class EndingSide_Civilian: EndingSide_Blufor
    {
        idc = IDC_TMF_ADMINMENU_ENDM_CIVILIAN;
        onToolBoxSelChanged = QUOTE(GVAR(DOUBLES(ending,civilian)) = param [1];);
        y = 9.4 * GUI_GRID_H;
    };

    class CheckboxEndingSideDraw: CheckboxUseMissionEnding
    {
        idc = IDC_TMF_ADMINMENU_ENDM_SIDEDRAW;
        onCheckedChanged = "";
        x = 25.2 * GUI_GRID_W;
        y = 11.0 * GUI_GRID_H;
    };
    class LabelEndingSideDraw: LabelExportAAR
    {
        text = "Mission is a Draw (ignores above options)";
        x = 26.2 * GUI_GRID_W;
        y = 11.0 * GUI_GRID_H;
        w = 11.6 * GUI_GRID_W;
    };

    class CheckboxUseCustomEnding: CheckboxUseMissionEnding
    {
        idc = IDC_TMF_ADMINMENU_ENDM_CUSTOM;
        onCheckedChanged = QUOTE([ARR_2(ctrlParent (param [0]), ctrlIDC (param [0]))] call FUNC(endMission_occluder););
        y = 16.1 * GUI_GRID_H;
    };
    class LabelCustomEnding: LabelEndings
    {
        text = "Use Custom Ending";
        y = 16.1 * GUI_GRID_H;
    };
    class LabelCustomEndingTitle: LabelExportAAR
    {
        text = "Title";
        x = 0;
        y = 17.2 * GUI_GRID_H;
        w = 2.4 * GUI_GRID_W;
        h = 1 * GUI_GRID_H;
    };
    class TextfieldCustomEndingTitle: RscEdit
    {
        idc = IDC_TMF_ADMINMENU_ENDM_CUSTOM_TITLE;
        colorBackground[] = {0.5, 0.5, 0.5, 0.1};
        colorBorder[] = {1, 1, 1, 0.33};
        sizeEx = GUI_TEXT_SIZE_SMALL;
        x = 2.4 * GUI_GRID_W;
        y = 17.2 * GUI_GRID_H;
        w = 10.9 * GUI_GRID_W;
        h = 1 * GUI_GRID_H;
    };
    class LabelCustomEndingSubtext: LabelCustomEndingTitle
    {
        text = "Subtext";
        y = 18.3 * GUI_GRID_H;
    };
    class TextfieldCustomEndingSubtext: TextfieldCustomEndingTitle
    {
        idc = IDC_TMF_ADMINMENU_ENDM_CUSTOM_SUBTEXT;
        y = 18.3 * GUI_GRID_H;
    };
    class CheckboxCustomEndingDefeat: CheckboxUseMissionEnding
    {
        idc = IDC_TMF_ADMINMENU_ENDM_CUSTOM_ISDEFEAT;
        onCheckedChanged = "";
        x = 0;
        y = 19.4 * GUI_GRID_H;
    };
    class LabelCustomEndingDefeat: LabelExportAAR
    {
        text = "Mission is a Defeat (determines music played)";
        x = 1 * GUI_GRID_W;
        y = 19.4 * GUI_GRID_H;
        w = 23.2 * GUI_GRID_W;
    };

    class OccluderLeftUp: RscText
    {
        idc = IDC_TMF_ADMINMENU_ENDM_OCCLUDER_LU;
        colorBackground[] = {0, 0, 0, 0.75};
        style = ST_CENTER;
        sizeEx = GUI_TEXT_SIZE_SMALL;
        x = 0;
        y = 1.1 * GUI_GRID_H;
        w = 24.2 * GUI_GRID_W;
        h = 14 * GUI_GRID_H;
    };
    class OccluderLeftDown: OccluderLeftUp
    {
        idc = IDC_TMF_ADMINMENU_ENDM_OCCLUDER_LD;
        y = 17.2 * GUI_GRID_H;
        w = 24.2 * GUI_GRID_W;
        h = 3.2 * GUI_GRID_H;
    };
    class OccluderRight: OccluderLeftUp
    {
        idc = IDC_TMF_ADMINMENU_ENDM_OCCLUDER_R;
        x = 25.15 * GUI_GRID_W;
        y = 1.1 * GUI_GRID_H;
        w = 12.65 * GUI_GRID_W;
        h = 10.9 * GUI_GRID_H;
    };
};
