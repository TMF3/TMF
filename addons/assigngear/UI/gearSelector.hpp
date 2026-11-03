class GVAR(RscGearSelector) : RscStandardDisplay {
    idd = IDD_RSCGEARSELECTOR;
    onLoad = QUOTE(uiNamespace setVariable [ARR_2(QQGVAR(gear_display), _this select 0)]; _this call FUNC(gui_gearSelector_init););
    onUnload = QUOTE(uiNamespace setVariable [ARR_2(QQGVAR(gear_display), displayNull)];);

    class controls {
        class Title : RscTitle {
            text = "TMF Loadout Jukebox";

            x = QUOTE(CENTER_X - 25 * GRID_W);
            y = QUOTE(CENTER_Y - GRID_H * 15);
            w = QUOTE(50 * GRID_W);
            h = QUOTE(SIZE_M * GRID_H);
            sizeEx = SIZEEX_PURISTA(SIZEEX_M);
        };
        class TitleIcon : RscPicture {
            text = QPATHTOEF(common,UI\logo_tmf_small_ca.paa);

            x = QUOTE(CENTER_X - 30 * GRID_W);
            y = QUOTE(CENTER_Y - GRID_H * 15);
            w = QUOTE(SIZE_M * GRID_W);
            h = QUOTE(SIZE_M * GRID_H);

        };
        class CategoryLabel : RscText {
            text = "Category:";

            x = QUOTE(CENTER_X - 30 * GRID_W);
            y = QUOTE(CENTER_Y - GRID_H * 9);
            w = QUOTE(60 * GRID_W);
            h = QUOTE(SIZE_S * GRID_H);
            sizeEx = SIZEEX_PURISTA(SIZEEX_S);
        };
        class Category : RscCombo {
            idc = IDC_RSCGEARSELECTOR_CATEGORY;

            x = QUOTE(CENTER_X - 28 * GRID_W);
            y = QUOTE(CENTER_Y - GRID_H * 5);
            w = QUOTE(56 * GRID_W);
            h = QUOTE(SIZE_S * GRID_H);
            sizeEx = SIZEEX_PURISTA(SIZEEX_S);

            onLBSelChanged = QUOTE( \
                params [ARR_2('_ctrl', '_selectedIndex')]; \
                [ARR_2(ctrlParent _ctrl, _selectedIndex)] call FUNC(gui_gearSelector_loadFactions); \
                false \
            );
        };
        class FactionLabel : RscText {
            text = "Faction:";

            x = QUOTE(CENTER_X - 30 * GRID_W);
            y = QUOTE(CENTER_Y - GRID_H * 1);
            w = QUOTE(60 * GRID_W);
            h = QUOTE(SIZE_S * GRID_H);
            sizeEx = SIZEEX_PURISTA(SIZEEX_S);
        };
        class Faction : RscCombo {
            idc = IDC_RSCGEARSELECTOR_FACTION;

            x = QUOTE(CENTER_X - 28 * GRID_W);
            y = QUOTE(CENTER_Y + GRID_H * 3);
            w = QUOTE(56 * GRID_W);
            h = QUOTE(SIZE_S * GRID_H);
            sizeEx = SIZEEX_PURISTA(SIZEEX_S);

            onLBSelChanged = QUOTE( \
                params [ARR_2('_ctrl', '_selectedIndex')]; \
                [ARR_2(ctrlParent _ctrl, _selectedIndex)] call FUNC(gui_gearSelector_loadRoles); \
                false \
            );
        };
        class RoleLabel : RscText{
            text = "Role:";

            x = QUOTE(CENTER_X - 30 * GRID_W);
            y = QUOTE(CENTER_Y + GRID_H * 7);
            w = QUOTE(60 * GRID_W);
            h = QUOTE(SIZE_S * GRID_H);
            sizeEx = SIZEEX_PURISTA(SIZEEX_S);
        };
        class Role : RscCombo{
            idc = IDC_RSCGEARSELECTOR_ROLE;

            x = QUOTE(CENTER_X - 28 * GRID_W);
            y = QUOTE(CENTER_Y + GRID_H * 11);
            w = QUOTE(56 * GRID_W);
            h = QUOTE(SIZE_S * GRID_H);
            sizeEx = SIZEEX_PURISTA(SIZEEX_S);
        };

        class ButtonCancel : RscButtonMenuCancel {
            x = QUOTE(CENTER_X - 30 * GRID_W);
            y = QUOTE(CENTER_Y + GRID_H * 17);
            w = QUOTE((59 / 3) * GRID_W);
            h = QUOTE(SIZE_M * GRID_H);
            sizeEx = SIZEEX_PURISTA(SIZEEX_S);
        };
        class ButtonRandom : RscButtonMenu {
            text = "Random";
            idc = IDC_RSCGEARSELECTOR_RANDOM;

            onButtonClick = QUOTE( \
                params ['_ctrl']; \
                [(ctrlParent _ctrl)] call FUNC(gui_gearSelector_random); \
            );

            x = QUOTE(CENTER_X - ((59 / 3) * GRID_W) / 2);
            y = QUOTE(CENTER_Y + GRID_H * 17);
            w = QUOTE((59 / 3) * GRID_W);
            h = QUOTE(SIZE_M * GRID_H);
            sizeEx = SIZEEX_PURISTA(SIZEEX_S);
        };
        class ButtonOK : RscButtonMenuOK {
            idc = IDC_RSCGEARSELECTOR_SUBMIT;

            onButtonClick = QUOTE( \
                params ['_ctrl']; \
                [(ctrlParent _ctrl)] call FUNC(gui_gearSelector_submit); \
            );

            x = QUOTE(CENTER_X + (GRID_W * 0.5) + ((59 / 3) * GRID_W) / 2);
            y = QUOTE(CENTER_Y + GRID_H * 17);
            w = QUOTE((59 / 3) * GRID_W);
            h = QUOTE(SIZE_M * GRID_H);
            sizeEx = SIZEEX_PURISTA(SIZEEX_S);
        };
    };
    class controlsBackground {
        class TitleBackground : RscBackgroundGUITop {
            x = QUOTE(CENTER_X - 30 * GRID_W);
            y = QUOTE(CENTER_Y - GRID_H * 15);
            w = QUOTE(60 * GRID_W);
            h = QUOTE(SIZE_M * GRID_H);

            colorBackground[] = {COLOR_ACTIVE_RGBA};

            backgroundType = 1;
        };
        class Background : RscBackgroundGUI {
            x = QUOTE(CENTER_X - 30 * GRID_W);
            y = QUOTE(CENTER_Y - GRID_H * 9.5);
            w = QUOTE(60 * GRID_W);
            h = QUOTE(26 * GRID_H);
        };
    };
};
