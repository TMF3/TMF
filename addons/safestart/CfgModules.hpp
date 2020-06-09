#include "script_component.hpp"

class CfgVehicles {
    class Logic;
    class Module_F: Logic {
        class AttributesBase
		{
			class Default;
			class Edit;					// Default edit box (i.e., text input field)
			class Combo;				// Default combo box (i.e., drop-down menu)
			class Checkbox;				// Default checkbox (returned value is Bool)
			class CheckboxNumber;		// Default checkbox (returned value is Number)
			class ModuleDescription;	// Module description
			class Units;				// Selection of units on which the module is applied
		};
        class ModuleDescription {
            class AnyBrain;
        };
    };
    class GVAR(module) : Module_F {
        scope = 2;
        displayName = "Safe Start";
        icon = "\x\tmf\addons\common\UI\logo_tmf_small_ca.paa";
        category = "Teamwork";
        function = QFUNC(moduleInit);
        functionPriority = 1;
        isGlobal = false;
        isTriggerActivated = true;
        isDisposable = true;
        is3DEN = false;

        // Module attributes
        class Attributes: AttributesBase {
            class Duration: Edit {
                property = QGVAR(duration);
                displayName = "Duration (seconds)";
                tooltip = "How long will safestart last?";
                typeName = "NUMBER";
                defaultValue = "120";
            };
            class ModuleDescription: ModuleDescription {};
        };

        // Module description. Must inherit from base class, otherwise pre-defined entities won't be available
        class ModuleDescription: ModuleDescription {
            description = "Enables safestart globally.<br/>May be synchronized to a serverside trigger.";
            sync[] = {"EmptyDetector"};
        };
    };
};
