class GVARMAIN(RscAttributeFaction): RscControlsGroupNoScrollbars {
    onSetFocus = QUOTE([ARR_3(_this,'GVARMAIN(RscAttributeFaction)','ADDON')] call (uinamespace getvariable 'BIS_fnc_initCuratorAttribute'));
    idc = IDC_RSCATTRIBUTEFACTION_RSCATTRIBUTEFACTION;
    x = 7 * GUI_GRID_W + GUI_GRID_X;
    y = 10 * GUI_GRID_H + GUI_GRID_Y;
    w = 26 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
    class controls {
        class Title: RscText {
            idc = IDC_RSCATTRIBUTEFACTION_TITLE;
            text = "Faction";
            x = 0 * GUI_GRID_W;
            y = 0 * GUI_GRID_H;
            w = 10 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;
            colorBackground[] = GUI_TEXT_SHADOW;
        };
        class Faction: RscCombo {
            font = GUI_FONT_MONO;
            idc = IDC_RSCATTRIBUTEFACTION_COMBO;
            x = 10 * GUI_GRID_W;
            y = 0 * GUI_GRID_H;
            w = 16 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;
            sizeEx = GUI_TEXT_SIZE_SMALL;
        };
    };
};
