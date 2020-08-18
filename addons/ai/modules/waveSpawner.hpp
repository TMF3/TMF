class GVAR(wavespawn) : Module_F {
    // Standard object definitions
    scope = 2; // Editor visibility; 2 will show it in the menu, 1 will hide it.
    displayName = "Wave Spawner"; // Name displayed in the menu

    category = "Teamwork";
    icon = QPATHTOEF(common,UI\logo_tmf_small_ca.paa);
    // Name of function triggered once conditions are met
    function = QFUNC(waveInit);
    functionPriority = 10;
    isGlobal = false;
    isTriggerActivated = true;
    isDisposable = true;

    class EventHandlers: EventHandlers {
        init = "if(isServer && !is3DEN) then {[{_this call tmf_AI_fnc_waveInit;}, [_this select 0,[],false]] call CBA_fnc_execNextFrame;};_this call bis_fnc_moduleInit;";
    };

    class Attributes: AttributesBase {
        class Layers: Edit {
            property = QGVAR(wavespawn_Layers);
            displayName = "Mission layers";
            tooltip = "3DEN layers linked to this wavespawner. Format: ""Layer 1"", ""Layer 2"", ""etc""";
        };
        class Delay: Default {
            property = QGVAR(wavespawn_Delay);
            displayName = "Execution delay";
            tooltip = "The time in seconds to wait before spawning the first wave";
            control = "SliderTime";
            typeName = "NUMBER";
            defaultValue = 0;
        };
        class Waves: Default {
            displayName = "Number of waves";
            property = QGVAR(wavespawn_Waves);
            control = "EditShort";
            expression = "_this setVariable ['Waves',parseNumber _value,true];";
            typeName = "NUMBER";
            defaultValue = "1";
        };
        class Time: Default {
            property = QGVAR(wavespawn_Time);
            displayName = "Time between waves";
            control = "SliderTime";
            typeName = "NUMBER";
            defaultValue = 300;
        };
        class WhenDead: Checkbox {
            property = QGVAR(wavespawn_WhenDead);
            displayName = "Previous wave must be dead";
            tooltip = "Well should they?";
            typeName = "BOOL";
            defaultValue = "false";
        };
        class ModuleDescription: ModuleDescription {};
    };
    class ModuleDescription: ModuleDescription {
        description = "Caches and deletes synced units for spawning later, either when triggered or after time delay.<br/>Spawns units directly on headless clients if synchronized to them.";
    };
};
