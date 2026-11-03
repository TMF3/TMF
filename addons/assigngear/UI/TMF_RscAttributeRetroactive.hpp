class GVARMAIN(RscAttributeRetroactive): RscControlsGroupNoScrollbars {
    onSetFocus = QUOTE([ARR_3(_this,'GVARMAIN(RscAttributeRetroactive)','ADDON')] call (uinamespace getvariable 'BIS_fnc_initCuratorAttribute'));
    idc = IDC_RSCATTRIBUTERETROACTIVE_RSCATTRIBUTERETROACTIVE;
    x = QUOTE(7 * GUI_GRID_W + GUI_GRID_CENTER_X);
    y = QUOTE(10 * GUI_GRID_H + GUI_GRID_CENTER_Y);
    w = QUOTE(26 * GUI_GRID_W);
    h = QUOTE(1 * GUI_GRID_H);
    class controls {
        class Title: RscText {
            idc = IDC_RSCATTRIBUTERETROACTIVE_TITLE;
            text = "Apply Retroactively";
            x = QUOTE(0 * GUI_GRID_W);
            y = QUOTE(0 * GUI_GRID_H);
            w = QUOTE(10 * GUI_GRID_W);
            h = QUOTE(1 * GUI_GRID_H);
            colorBackground[] = GUI_TEXT_SHADOW;
        };
        class Background: RscText {
            style = 2;
            idc = IDC_RSCATTRIBUTERETROACTIVE_BCG;
            x = QUOTE(10 * GUI_GRID_W);
            y = QUOTE(0 * GUI_GRID_H);
            w = QUOTE(16 * GUI_GRID_W);
            h = QUOTE(1 * GUI_GRID_H);
            colorText[] = {1,1,1,0.5};
            colorBackground[] = {1,1,1,0.1};
        };
        class Value: RscToolboxButton {
            rows = 1;
            columns = 2;
            strings[] = {"$STR_enabled","$STR_disabled"};
            idc = IDC_RSCATTRIBUTERETROACTIVE_TOOLBOX;
            x = QUOTE(10 * GUI_GRID_W);
            y = QUOTE(0 * GUI_GRID_H);
            w = QUOTE(16 * GUI_GRID_W);
            h = QUOTE(1 * GUI_GRID_H);
        };
    };
};
