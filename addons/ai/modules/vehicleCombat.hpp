class GVAR(vehicleAttackModule) : Module_F
{
    // Standard object definitions
    scope = 2; // Editor visibility; 2 will show it in the menu, 1 will hide it.
    displayName = "Vehicle Combat AI"; // Name displayed in the menu

    category = "Teamwork";
    icon = "\x\tmf\addons\common\UI\logo_tmf_small_ca.paa";
    // Name of function triggered once conditions are met
    function = QFUNC(vehicleCombat);
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
        init = "_this call bis_fnc_moduleInit;";
    };
    
    class Arguments : ArgumentsBaseUnits
    {
        // Module specific arguments
        class Radius
        {
            displayName = "Radius";
            tooltip = "How far can be vehicle waypoint set in combat (20 to 1000m).";
            control = "Edit";
            property = "Radius";
            defaultValue = 20;
            expression = "_this setVariable ['%s',_value];";
            typeName = "NUMBER";
        };
        class Time
        {
            displayName = "Waypoint reload time";
            tooltip = "Time in seconds. Bigger increse server performance";
            control = "Edit";
            property = "Time";
            defaultValue = 20;
            expression = "_this setVariable ['%s',_value];";
            typeName = "NUMBER";
            
        };
    };
    class ModuleDescription: ModuleDescription {
        description = "Better combat behavior for vehicles.";
    };
};