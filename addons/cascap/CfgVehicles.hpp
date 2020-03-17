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
        displayName = "Casualty Cap"; // Name displayed in the menu
        icon = "\x\tmf\addons\common\UI\logo_tmf_small_ca.paa"; // Map icon. Delete this entry to use the default icon
        category = "Teamwork";
        function = QFUNC(init);
        functionPriority = 1;
        isGlobal = 0;
        isTriggerActivated = 1;
        isDisposable = 0;
        class Arguments: ArgumentsBaseUnits
        {// Arguments shared by specific module type (have to be mentioned in order to be placed on top)
            class TMFUnits
            {
                displayName = "Apply to";
                description = "Ratio of units still alive that will trigger the casCap. 0.5 means that casCap would trigger when 50% of the watchlist is dead.";
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
            class PlayersOnly
                {
                displayName = "Only players"; // Argument label
                description = "Determines if only players and playable units should be taken into consideration."; // Tooltip description
                typeName = "BOOL"; // Value type, can be "NUMBER", "STRING" or "BOOL"
                defaultValue = "false";
            };
            class Ratio
              {
                displayName = "Ratio (0-1)"; // Argument label
                description = "Ratio of units still alive that will trigger the casCap. 0.25 means that casCap would trigger when 75% of the watchlist is dead."; // Tooltip description
                typeName = "NUMBER"; // Value type, can be "NUMBER", "STRING" or "BOOL"
                defaultValue = "0.8";
            };
            class Code
              {
                displayName = "Code";
                description = "Code that executes when the module fires. Executes serverside.";
                typeName = "STRING";
                defaultValue = " "; // Default text filled in the input box
                // When no 'values' are defined, input box is displayed instead of listbox
            };
        };
    };
};
