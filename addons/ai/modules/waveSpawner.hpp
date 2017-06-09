class GVAR(wavespawn) : Module_F {
    // Standard object definitions
    scope = 2; // Editor visibility; 2 will show it in the menu, 1 will hide it.
    displayName = "Wave Spawner"; // Name displayed in the menu

    category = "Teamwork";
    icon = "\x\tmf\addons\common\UI\logo_tmf_small_ca.paa";
    // Name of function triggered once conditions are met
    function = QFUNC(waveInit);
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
        init = "if(isServer && !is3DEN) then {[{_this call tmf_AI_fnc_waveInit;}, [_this select 0,[],false]] call CBA_fnc_execNextFrame;};_this call bis_fnc_moduleInit;";
    };

    class Arguments: ArgumentsBaseUnits {
        // Module specific arguments
        class Delay {
            displayName = "Execution delay";
            description = "The time in seconds to wait before spawning the first wave";
            typeName = "NUMBER";
            defaultValue = "0";
        }
        class Waves {
            displayName = "Number of waves"; // Argument label
            description = ""; // Tooltip description
            typeName = "NUMBER"; // Value type, can be "NUMBER", "STRING" or "BOOL"
            defaultValue = "1";
        };
        class Time {
            displayName = "Time between waves"; // Argument label
            description = "In seconds."; // Tooltip description
            typeName = "NUMBER"; // Value type, can be "NUMBER", "STRING" or "BOOL"
            defaultValue = "10";
        };
        class WhenDead {
            displayName = "Previous wave must be dead"; // Argument label
            description = "Well should they?"; // Tooltip description
            typeName = "bool"; // Value type, can be "NUMBER", "STRING" or "BOOL"
            defaultValue = "false";
        }
    };
    class ModuleDescription: ModuleDescription {};
};
