class GVARMAIN(RscAttributeLoadout): RscControlsGroupNoScrollbars {
    onSetFocus = QUOTE([ARR_3(_this,'GVARMAIN(RscAttributeLoadout)','ADDON')] call (uinamespace getvariable 'BIS_fnc_initCuratorAttribute'));
    idc = IDC_RSCATTRIBUTELOADOUT_RSCATTRIBUTELOADOUT;
    x = QUOTE(7 * GUI_GRID_W + GUI_GRID_X);
    y = QUOTE(10 * GUI_GRID_H + GUI_GRID_Y);
    w = QUOTE(26 * GUI_GRID_W);
    h = QUOTE(1 * GUI_GRID_H);
    class controls {
        class Title: RscText {
            idc = IDC_RSCATTRIBUTELOADOUT_TITLE;
            text = "Loadout";
            x = QUOTE(0 * GUI_GRID_W);
            y = QUOTE(0 * GUI_GRID_H);
            w = QUOTE(10 * GUI_GRID_W);
            h = QUOTE(1 * GUI_GRID_H);
            colorBackground[] = GUI_TEXT_SHADOW;
        };
        class Loadout: RscCombo {
            font = QUOTE(GUI_FONT_MONO);
            idc = IDC_RSCATTRIBUTELOADOUT_COMBO;
            x = QUOTE(10 * GUI_GRID_W);
            y = QUOTE(0 * GUI_GRID_H);
            w = QUOTE(16 * GUI_GRID_W);
            h = QUOTE(1 * GUI_GRID_H);
            sizeEx = QUOTE(GUI_TEXT_SIZE_SMALL);
        };
    };
};
