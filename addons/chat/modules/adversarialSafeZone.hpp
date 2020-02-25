class GVAR(adversarialSafeZone) : Module_F
{
    scope = 2;
    displayName = "TMF Adversarial Safe Zone";
    category = "Teamwork";
    icon = "\x\tmf\addons\common\UI\logo_tmf_small_ca.paa";
    function = QEFUNC(ai,emptyFunction);
    // 0 for server only execution, 1 for global execution, 2 for persistent global execution
    isGlobal = 2;
    isTriggerActivated = 0;
    isDisposable = 0; // broken in EDEN;
    is3DEN = 1;

    class Attributes: AttributesBase {
        class ModuleDescription: ModuleDescription{};
    };

    class ModuleDescription: ModuleDescription {
        position = 0;
        direction = 0;
        duplicate = 1;

        description = "Defines area(s) that cannot be teleported into using #stage or teleport module.<br/>To define areas, synchronize TMF Area modules to this module.<br/>To define defenders, synchronize side logics to this module.";
        sync[] = { // Array of synced entities (can contain base classes)
            QEGVAR(ai,area),
            QEGVAR(ai,area_rectangle),
            "SideBLUFOR_F",
            "SideOPFOR_F",
            "SideResistance_F"
        };

        class EGVAR(ai,area) {
            position = 1;
            direction = 1;
            optional = 0;
            duplicate = 1;
        };
        class EGVAR(ai,area_rectangle) : EGVAR(ai,area) {};
        class SideBLUFOR_F {
            position = 0;
            direction = 0;
            optional = 1;
            duplicate = 0;
        };
        class SideOpfor_F : SideBLUFOR_F {};
        class SideResistance_F : SideBLUFOR_F{};
    };
};
