class GVAR(vehicleAttackModule) : Module_F
{
    // Standard object definitions
    scope = 2; // Editor visibility; 2 will show it in the menu, 1 will hide it.
    displayName = "Vehicle AI attack"; // Name displayed in the menu

    category = "Teamwork";
    icon = "\x\tmf\addons\common\UI\logo_tmf_small_ca.paa";
    // Name of function triggered once conditions are met
    function = QFUNC(vehicleAttackInit);
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
        //TODO prepare initVehicleAttack similar to huntInit
        //init = "if (isServer) then {[_this select 0] call tmf_AI_fnc_huntInit;}; _this call bis_fnc_moduleInit;";
    };
    
    class Arguments: ArgumentsBaseUnits
    {
        // Module specific arguments
        class Range
        {
            displayName = "Radius"; // Argument label
            description = "How far can be vehicle waypoint set after attack (10 to 120m)."; // Tooltip description
            typeName = "NUMBER"; // Value type, can be "NUMBER", "STRING" or "BOOL"
            defaultValue = "20";
        };
    };
    class ModuleDescription: ModuleDescription {
        description = "Better vehicle AI behaviour after under attack."; // Short description, will be formatted as structured text
    };
};