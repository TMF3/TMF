class cfgFunctions {
    class ADDON {
        class COMPONENT {
            file = QPATHTO_FOLDER(functions);
            class addBackpackItems;
            class addItems;
            class assignGear;
            class linkItems;
            class loadFactions;
            class loadFactionCategories;
            class loadRoles;
            class replaceEquipment;
            class replacePrimaryWeapon;
            class replaceSecondaryWeapon;
            class replaceSidearmWeapon;
            class chat_loadout;
            class gearSelector;
            class helper;
            class saveRole;
            class setFace;
            class setInsignia;
            class onEdenMessageRecieved;
            class onEdenMissionChange;
        };
        class DOUBLES(COMPONENT,gui) {
            file = QPATHTO_FOLDER(gui);
            class gui_gearSelector_init;
            class gui_gearSelector_loadFactions;
            class gui_gearSelector_loadCategories;
            class gui_gearSelector_loadRoles;
            class gui_gearSelector_random;
            class gui_gearSelector_submit;
        }
    };
};
