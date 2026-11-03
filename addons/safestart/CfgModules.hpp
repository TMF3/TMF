#include "script_component.hpp"

class CfgVehicles {
    class Logic;
    class Module_F: Logic {
        class AttributesBase
        {
            class Default;
            class ModuleDescription;    // Module description
        };
        class ModuleDescription {
        };
    };
    class GVAR(module) : Module_F {
        scope = 2;
        displayName = "Safe Start";
        icon = "\x\tmf\addons\common\UI\logo_tmf_small_ca.paa";
        category = "Teamwork";
        function = QFUNC(moduleInit);
        functionPriority = 1;
        isGlobal = 0;
        isTriggerActivated = 1;
        isDisposable = 1;
        is3DEN = 0;

        // Module attributes
        class Attributes: AttributesBase {
            class Duration: Default {
                property = QGVAR(module_duration);
                control = "SliderTime";
                displayName = "Duration";
                tooltip = "How long will safestart last?";
                typeName = "NUMBER";
                defaultValue = "120";
            };
            class ModuleDescription: ModuleDescription {};
        };

        // Module description. Must inherit from base class, otherwise pre-defined entities won't be available
        class ModuleDescription: ModuleDescription {
            description = "Enables safestart globally.<br/>May be synchronized to a serverside trigger.<br/>Set to 0 for infinite safestart.";
            sync[] = {"EmptyDetector"};
        };
    };
};
