class GVAR(aiGear) : Module_F {
    scope = 2;
    displayName = "AI Gear";

    category = "Teamwork";
    icon = QPATHTOEF(common,ui\logo_tmf_small_ca.paa);
    function = QFUNC(moduleAIGear);
    functionPriority = 1;
    isGlobal = 2; // Persistent global execution
    isTriggerActivated = false;
    isDisposable = false;

    class Attributes: AttributesBase {
        class Faction: Default {
            property = QGVAR(DOUBLES(module,faction));
            displayName = "Affected faction";
            control = QGVAR(DOUBLES(aigear,faction));
            typeName = "STRING";
            defaultValue = """OPF_F""";
        };
        class Loadout: Default {
            property = QGVAR(loadout);
            displayName = "Loadout";
            control = QGVAR(loadout);
            typeName = "STRING";
            defaultValue = "0";
        };
        class Retroactive: Checkbox {
            property = QGVAR(DOUBLES(module,retroactive));
            displayName = "Apply retroactively";
            defaultValue = "false";
        };
        class ModuleDescription: ModuleDescription{};
    };
    class ModuleDescription: ModuleDescription {
        description = "Bulk assigns gear to AI units.<br/>Gear given depends on unit loadout.<br/>Depends on standard loadout class structure.";
    };
};
