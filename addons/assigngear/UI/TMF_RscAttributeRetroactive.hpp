class GVARMAIN(RscAttributeRetroactive): RscControlsGroupNoScrollbars {
    onSetFocus = QUOTE([ARR_3(_this,'GVARMAIN(RscAttributeRetroactive)','ADDON')] call (uinamespace getvariable 'BIS_fnc_initCuratorAttribute'));
    idc = IDC_RSCATTRIBUTERETROACTIVE_RSCATTRIBUTERETROACTIVE;
    x = 7 * GUI_GRID_W + GUI_GRID_CENTER_X;
    y = 10 * GUI_GRID_H + GUI_GRID_CENTER_Y;
    w = 26 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
    class controls {
        class Title: RscText {
            idc = IDC_RSCATTRIBUTERETROACTIVE_TITLE;
            text = "Apply Retroactively";
            x = 0 * GUI_GRID_W;
            y = 0 * GUI_GRID_H;
            w = 10 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;
            colorBackground[] = GUI_TEXT_SHADOW;
        };
        class Background: RscText {
            style = 2;
            idc = IDC_RSCATTRIBUTERETROACTIVE_BCG;
            x = 10 * GUI_GRID_W;
            y = 0 * GUI_GRID_H;
            w = 16 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;
            colorText[] = {1,1,1,0.5};
            colorBackground[] = {1,1,1,0.1};
        };
        class Value: RscToolboxButton {
            rows = 1;
            columns = 2;
            strings[] = {$STR_enabled,$STR_disabled};
            idc = IDC_RSCATTRIBUTERETROACTIVE_TOOLBOX;
            x = 10 * GUI_GRID_W;
            y = 0 * GUI_GRID_H;
            w = 16 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;
        };
    };
};
