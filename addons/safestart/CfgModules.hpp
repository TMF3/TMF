#include "script_component.hpp"

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
        // Standard object definitions
        scope = 2; // Editor visibility; 2 will show it in the menu, 1 will hide it.
        displayName = "Safe Start"; // Name displayed in the menu
        icon = "\x\tmf\addons\common\UI\logo_tmf_small_ca.paa"; // Map icon. Delete this entry to use the default icon
        category = "Teamwork";
        // Name of function triggered once conditions are met
        function = "TMF_safestart_fnc_init";
        // Execution priority, modules with lower number are executed first. 0 is used when the attribute is undefined
        functionPriority = 1;
        // 0 for server only execution, 1 for global execution, 2 for persistent global execution
        isGlobal = 0;
        // 1 for module waiting until all synced triggers are activated
        isTriggerActivated = 1;
        // 1 if modules is to be disabled once it's activated (i.e., repeated trigger activation won't work)
        isDisposable = 0;


        // Menu displayed when the module is placed or double-clicked on by Zeus


        // Module arguments
        class Arguments: ArgumentsBaseUnits
        {
            // Arguments shared by specific module type (have to be mentioned in order to be placed on top)
            class TMFUnits
            {
                description = "";
                displayName = "Apply to";
                typeName = "NUMBER";
                class values
                {
                    class Everyone {
                        name = "All units";
                        value = -1;
                        default = 1;
                    };
                    class Objects {
                        name = "Synchronized units only";
                        value = 0;
                    };
                    class ObjectsAndGroups {
                        name = "Groups of synchronized units";
                        value = 1;
                    };
                    class Side {
                        name = "Every unit on the units side";
                        value = 2;
                    };
                };
            };
            // Module specific arguments
            class Duration
              {
                displayName = "Duration (seconds)"; // Argument label
                description = "How long will safestart last?"; // Tooltip description
                typeName = "NUMBER"; // Value type, can be "NUMBER", "STRING" or "BOOL"
                defaultValue = "120";
            };
        };

        // Module description. Must inherit from base class, otherwise pre-defined entities won't be available
        class ModuleDescription: ModuleDescription
        {
            description = "Short module description"; // Short description, will be formatted as structured text
            sync[] = {"Men"}; // Array of synced entities (can contain base classes)
            class unit
            {
                description = "Any unit";
                displayName = "Any unit"; // Custom name
                icon = "iconMan"; // Custom icon (can be file path or CfgVehicleIcons entry)
                side = 1; // Custom side (will determine icon color)
            };
        };
    };
};
