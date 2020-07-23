class GVAR(aiGearModule) : Module_F {
    scope = 2;
    scopeCurator = 2;
    displayName = "AI Gear Macro";

    category = "Teamwork";
    icon = QPATHTOEF(common,ui\logo_tmf_small_ca.paa);
    function = QFUNC(moduleAIGear);
    functionPriority = 1;
    isGlobal = true;
    isTriggerActivated = false;
    isDisposable = false;
    is3DEN = false;
    curatorInfoType = QGVARMAIN(RscDisplayAttributesModuleAIGear);

    class Attributes: AttributesBase {
        class Faction: Default {
            property = QGVAR(DOUBLES(module,faction));
            displayName = "Affected faction";
            control = QGVARMAIN(DOUBLES(aigear,faction));
            typeName = "STRING";
        };
        class Loadout: Default {
            property = QGVAR(loadout);
            displayName = "Loadout";
            control = QGVARMAIN(loadout);
            typeName = "STRING";
        };
        class Retroactive: Checkbox {
            property = QGVAR(DOUBLES(module,retroactive));
            displayName = "Apply retroactively";
            typeName = "BOOL";
            defaultValue = "false";
        };
        class ModuleDescription: ModuleDescription{};
    };
    class ModuleDescription: ModuleDescription {
        description = "Bulk assigns gear to AI units.<br/>Loadouts must follow standard config structure.";
    };
};
