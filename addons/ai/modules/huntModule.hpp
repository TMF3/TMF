class GVAR(huntModule) : Module_F
{
    // Standard object definitions
    scope = 2; // Editor visibility; 2 will show it in the menu, 1 will hide it.
    displayName = "AI Hunt"; // Name displayed in the menu

    category = "Teamwork";
    icon = "\x\tmf\addons\common\UI\logo_tmf_small_ca.paa";
    // Name of function triggered once conditions are met
    function = QFUNC(hunt);
    // Execution priority, modules with lower number are executed first. 0 is used when the attribute is undefined
    functionPriority = 0;
    // 0 for server only execution, 1 for global execution, 2 for persistent global execution
    isGlobal = 0;
    // 1 for module waiting until all synced triggers are activated
    isTriggerActivated = 1;
    // 1 if modules is to be disabled once it's activated (i.e., repeated trigger activation won't work)
    isDisposable = 0; // broken in EDEN;

    // Menu displayed when the module is placed or double-clicked on by Zeus


    class EventHandlers {
        init = "if (isServer) then {[_this select 0] call tmf_AI_fnc_huntInit;}; _this call bis_fnc_moduleInit;";
    };
    
    class Arguments: ArgumentsBaseUnits
    {
        // Module specific arguments
        class Hunters
        {
            displayName = "Hunters"; // Argument label
            description = "Hunters are the units that will attack."; // Tooltip description
            typeName = "NUMBER"; // Value type, can be "NUMBER", "STRING" or "BOOL"
            class values
            {
                class Objects {
                    name = "Synchronized units only";
                    value = -1;
                    default = 1;
                };
                class SideB {
                    name = "All BLUFOR AI.";
                    value = 1;
                };
                class SideO {
                    name = "All OPFOR AI.";
                    value = 0;
                };
                class SideI {
                    name = "All INDFOR AI.";
                    value = 2;
                };
            };
        };
        class TargetSide
        {
            displayName = "Target"; // Argument label
            description = "Which team should the hunters target."; // Tooltip description
            typeName = "NUMBER"; // Value type, can be "NUMBER", "STRING" or "BOOL"
            class values
            {
                class SideB {
                    name = "BLUFOR";
                    value = 1;
                    default = 1;
                };
                class SideO {
                    name = "OPFOR";
                    value = 0;
                };
                class SideI {
                    name = "INDFOR";
                    value = 2;
                };
            };
        };
        class Range
        {
            displayName = "Radius"; // Argument label
            description = "How far can valid targets be from this module (50 to 5000m)."; // Tooltip description
            typeName = "NUMBER"; // Value type, can be "NUMBER", "STRING" or "BOOL"
            defaultValue = "100";
        };
    };
    class ModuleDescription: ModuleDescription {
        description = "Short module description"; // Short description, will be formatted as structured text
    };
};