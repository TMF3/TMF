class cfgFunctions {
    class ADDON {
        class COMPONENT {
            file = QPATHTOF(functions);
            class addBackpackItems;
            class addItems;
            class assignGear;
            class cacheAssignGear;
            class loadAssignGear;
            class initNamespace;
            class linkItems;
            class loadFactions;
            class loadFactionCategories;
            class loadRoles;
            class replaceEquipment;
            class replacePrimaryWeapon;
            class replaceSecondaryWeapon;
            class replaceSidearmWeapon;
            class gearSelector;
            class helper;
            class overrideProfileItems;
            class saveRole;
            class setFace;
            class setGoggles;
            class setInsignia;
            class setUnitTrait;
            class onEdenMessageRecieved;
            class onEdenMissionChange;
        };
        class DOUBLES(COMPONENT,gui) {
            file = QPATHTOF(gui);
            class gui_gearSelector_init;
            class gui_gearSelector_loadFactions;
            class gui_gearSelector_loadCategories;
            class gui_gearSelector_loadRoles;
            class gui_gearSelector_random;
            class gui_gearSelector_submit;
        }
    };
};
