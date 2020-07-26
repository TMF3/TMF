class GVAR(aiGearModule) : Module_F {
    scope = 2;
    scopeCurator = 2;
    displayName = "AI Gear Macro";

    category = "Teamwork";
    icon = QPATHTOEF(common,ui\logo_tmf_small_ca.paa);
    function = QFUNC(moduleAIGear);
    functionPriority = 1;
    isGlobal = false;
    isTriggerActivated = false;
    isDisposable = true;
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
            defaultValue = 0;
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
        description = "Bulk assigns gear to AI units.<br/>Used roles are defined in (configFile >> ""TMF_AIGear""), which can be overwritten via missionConfigFile.<br/>See wiki for example.";
    };
};
