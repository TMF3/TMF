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
        displayName = "Map-Click Teleport"; // Name displayed in the menu
        icon = "\x\tmf\addons\common\UI\logo_tmf_small_ca.paa"; // Map icon. Delete this entry to use the default icon
        category = "Teamwork";
        function = QFUNC(init);
        functionPriority = 1;
        isGlobal = 0;
        isTriggerActivated = 1;
        isDisposable = 0;
        class Arguments: ArgumentsBaseUnits
        {
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
                    }
                    class Side {
                        name = "Every unit on the units side";
                        value = 2;
                    };
                };
            };
            class TimeLimit
              {
                displayName = "Time limit (seconds)"; // Argument label
                description = "How long does the user have until the action disappears?"; // Tooltip description
                typeName = "NUMBER"; // Value type, can be "NUMBER", "STRING" or "BOOL"
                defaultValue = "120";
            };
            class Altitude
                {
                displayName = "Altitude"; // Argument label
                description = "What altitude the unit will teleport to."; // Tooltip description
                typeName = "NUMBER"; // Value type, can be "NUMBER", "STRING" or "BOOL"
                defaultValue = "0";
            };
            class Parachute
                {
                displayName = "Parachute"; // Argument label
                description = "Determines if the units gets a parachute."; // Tooltip description
                typeName = "BOOL"; // Value type, can be "NUMBER", "STRING" or "BOOL"
                defaultValue = "false";
            };
            class LeadersOnly
                {
                displayName = "Group Teleport"; // Argument label
                description = "Determines if everyone gets the action or just the leader"; // Tooltip description
                typeName = "BOOL"; // Value type, can be "NUMBER", "STRING" or "BOOL"
                defaultValue = "false";
            };
        };
    };
    class GVAR(deploy) : Module_F
    {
        // Standard object definitions
        scope = 2; // Editor visibility; 2 will show it in the menu, 1 will hide it.
        displayName = "Deploy in Parachute"; // Name displayed in the menu
        icon = "\x\tmf\addons\common\UI\logo_tmf_small_ca.paa"; // Map icon. Delete this entry to use the default icon
        category = "Teamwork";
        function = QFUNC(deployInit);
        functionPriority = 1;
        isGlobal = 0;
        isTriggerActivated = 1;
        isDisposable = 0;
        class Arguments: ArgumentsBaseUnits
        {
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
                    }
                    class Side {
                        name = "Every unit on the units side";
                        value = 2;
                    };
                };
            };
        };
    };
};
