

class CfgVehicles
{
    class Logic;
    class Module_F: Logic
    {
        class ArgumentsBaseUnits
        {
            class Units;
        };
        class ModuleDescription
        {
            class AnyBrain;
        };
    };
    class GVAR(module) : Module_F
    {
        scope = 2;
        displayName = "Spectator: Show Objective";
        category = "Teamwork";
        icon = "\x\tmf\addons\common\UI\logo_tmf_small_ca.paa";
        function = QFUNC(objectiveModule);
        functionPriority = 0;
        isGlobal = 2;
        isTriggerActivated = 1;
        isDisposable = 0; // broken in EDEN;
        class Arguments: ArgumentsBaseUnits
        {
            class Icon
            {
                displayName = "Icon (.paa)";
                description = "Path to ICON";
                typeName = "STRING";
                defaultValue = "\A3\ui_f\data\map\markers\nato\b_unknown.paa";
            };
            class Text
            {
                displayName = "Text";
                description = "";
                typeName = "STRING";
                defaultValue = "Objective Alpha";
            };
            class Color
            {
                displayName = "Color";
                description = "[Red,Green,Blue,Alpha]";
                typeName = "STRING";
                defaultValue = "[1,0,0,1]";
            };
        };
        class ModuleDescription: ModuleDescription
        {
            description = "Short module description";
            sync[] = {"Men"};
            class unit
            {
                description = "Any unit";
                displayName = "Any unit";
                icon = "iconMan";
                side = 1;
            };
        };
    };

    class VirtualMan_F;
    class GVAR(unit) : VirtualMan_F {
        author = ADDON;
        displayName = "TMF Spectator";
        scope = 2;
        scopeCurator = 1;
        scopeArsenal = 1;
        delete ACE_SelfActions;
        delete ACE_Actions;
    };
};
