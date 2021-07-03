class GVARMAIN(RscAttributeLoadout): RscControlsGroupNoScrollbars {
    onSetFocus = QUOTE([ARR_3(_this,'GVARMAIN(RscAttributeLoadout)','ADDON')] call (uinamespace getvariable 'BIS_fnc_initCuratorAttribute'));
    idc = IDC_RSCATTRIBUTELOADOUT_RSCATTRIBUTELOADOUT;
    x = 7 * GUI_GRID_W + GUI_GRID_X;
    y = 10 * GUI_GRID_H + GUI_GRID_Y;
    w = 26 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
    class controls {
        class Title: RscText {
            idc = IDC_RSCATTRIBUTELOADOUT_TITLE;
            text = "Loadout";
            x = 0 * GUI_GRID_W;
            y = 0 * GUI_GRID_H;
            w = 10 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;
            colorBackground[] = GUI_TEXT_SHADOW;
        };
        class Loadout: RscCombo {
            font = GUI_FONT_MONO;
            idc = IDC_RSCATTRIBUTELOADOUT_COMBO;
            x = 10 * GUI_GRID_W;
            y = 0 * GUI_GRID_H;
            w = 16 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;
            sizeEx = GUI_TEXT_SIZE_SMALL;
        };
    };
};
